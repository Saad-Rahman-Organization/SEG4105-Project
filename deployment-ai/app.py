from fastapi import FastAPI, File, UploadFile, Form, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional, Literal
import base64
import os
from openai import OpenAI
from datetime import datetime
import json
from dotenv import load_dotenv
from enum import Enum

load_dotenv()

class MealTagEnum(str, Enum):
    breakfast = "Breakfast"
    lunch = "Lunch"
    dinner = "Dinner"
    snack = "Snack"
    custom = "Custom (type below)"

app = FastAPI(
    title="Meal Nutrition Analysis API",
    description="API for analyzing meal images and estimating calories and macros",
    version="1.0.0"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

class MacroNutrient(BaseModel):
    protein: str
    carbohydrates: str
    fat: str
    fiber: Optional[str] = None

class FoodItem(BaseModel):
    name: str
    portion_size: str
    calories: float
    macros: MacroNutrient

class IngredientSummary(BaseModel):
    name: str
    portion_size: str

class NutritionAnalysis(BaseModel):
    meal_tag: str
    timestamp: str
    foods: List[FoodItem]
    ingredients_list: List[IngredientSummary]
    total_calories: float
    total_macros: MacroNutrient
    confidence_level: str
    notes: Optional[str] = None

NUTRITION_ANALYSIS_PROMPT = """Analyze the meal and provide detailed nutritional breakdown.

Key requirements:
1. List each ingredient separately (never use dish names like "Chicken Curry" - break into "Chicken Thigh", "Curry Sauce", "Rice")
2. Specify meat cuts (use "Ribeye Steak" not "steak", "Chicken Breast" not "chicken")
3. Separate all visible sauces, creams, and toppings (sour cream, butter, dressing, gravy - each as own item)
4. For common dishes, include standard ingredients even if partially hidden

Calculation method for each ingredient:
- Estimate visible surface area
- Calculate volume (surface × depth, assuming uniformity)
- Convert to weight using food density
- Calculate calories and macros from weight
- Sum all ingredients for totals

Output as JSON:
{
    "foods": [
        {"name": "Ribeye Steak", "portion_size": "200g", "calories": 544, "macros": {"protein": "62g", "carbohydrates": "0g", "fat": "31g", "fiber": "0g"}},
        {"name": "Baked Potato", "portion_size": "173g", "calories": 161, "macros": {"protein": "4.3g", "carbohydrates": "37g", "fat": "0.2g", "fiber": "2.6g"}},
        {"name": "Sour Cream", "portion_size": "30g", "calories": 60, "macros": {"protein": "0.7g", "carbohydrates": "1.2g", "fat": "6g", "fiber": "0g"}},
        {"name": "Chives", "portion_size": "3g", "calories": 1, "macros": {"protein": "0.1g", "carbohydrates": "0.1g", "fat": "0g", "fiber": "0.1g"}}
    ],
    "ingredients_list": [
        {"name": "Ribeye Steak", "portion_size": "200g"},
        {"name": "Baked Potato", "portion_size": "173g"},
        {"name": "Sour Cream", "portion_size": "30g"},
        {"name": "Chives", "portion_size": "3g"}
    ],
    "total_calories": 766.0,
    "total_macros": {"protein": "67.1g", "carbohydrates": "37.3g", "fat": "37.2g", "fiber": "2.7g"},
    "confidence_level": "high",
    "notes": "Brief explanation"
}

Format notes:
- Macros use strings with "g" suffix
- ingredients_list mirrors foods array (name and portion only)
- Totals equal sum of individual items
- Do not include salt, pepper, or absorbed cooking oils

Return only the JSON."""

@app.get("/")
async def root():
    return {
        "message": "Meal Nutrition Analysis API",
        "version": "1.0.0",
        "endpoints": {
            "analyze": "/api/analyze-meal",
            "health": "/health",
            "docs": "/docs"
        }
    }

@app.get("/health")
async def health_check():
    api_key_set = bool(os.getenv("OPENAI_API_KEY"))
    return {
        "status": "healthy",
        "api_configured": api_key_set
    }

@app.post("/api/analyze-meal", response_model=NutritionAnalysis)
async def analyze_meal(
    image: UploadFile = File(..., description="Image file of the meal"),
    meal_tag: MealTagEnum = Form(..., description="Select a meal category from dropdown"),
    custom_meal_tag: Optional[str] = Form(None, description="Or type a custom meal category here (leave empty if using dropdown)")
):
    final_meal_tag = custom_meal_tag if custom_meal_tag else meal_tag.value
    
    if not os.getenv("OPENAI_API_KEY"):
        raise HTTPException(
            status_code=500,
            detail="API key not configured."
        )
    
    try:
        image_data = await image.read()
        base64_image = base64.b64encode(image_data).decode('utf-8')
        
        image_format = image.content_type.split('/')[-1] if image.content_type else 'jpeg'
        if image_format not in ['jpeg', 'jpg', 'png', 'gif', 'webp']:
            image_format = 'jpeg'
        
        response = client.chat.completions.create(
            model="gpt-4o",
            messages=[
                {
                    "role": "system",
                    "content": NUTRITION_ANALYSIS_PROMPT
                },
                {
                    "role": "user",
                    "content": [
                        {
                            "type": "text",
                            "text": f"Analyze this {final_meal_tag.lower()} meal."
                        },
                        {
                            "type": "image_url",
                            "image_url": {
                                "url": f"data:image/{image_format};base64,{base64_image}",
                                "detail": "high"
                            }
                        }
                    ]
                }
            ],
            max_tokens=1500,
            temperature=0.2
        )
        
        api_response = response.choices[0].message.content.strip()
        
        if api_response.startswith("```json"):
            api_response = api_response[7:]
        if api_response.startswith("```"):
            api_response = api_response[3:]
        if api_response.endswith("```"):
            api_response = api_response[:-3]
        api_response = api_response.strip()
        
        nutrition_data = json.loads(api_response)
        nutrition_data["meal_tag"] = final_meal_tag
        nutrition_data["timestamp"] = datetime.utcnow().isoformat()
        
        return NutritionAnalysis(**nutrition_data)
        
    except json.JSONDecodeError as e:
        raise HTTPException(
            status_code=500,
            detail=f"Failed to parse response: {str(e)}"
        )
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Error analyzing meal: {str(e)}"
        )

@app.post("/api/batch-analyze")
async def batch_analyze_meals(
    images: List[UploadFile] = File(...),
    meal_tags: str = Form(...)
):
    tags = [tag.strip() for tag in meal_tags.split(",")]
    
    if len(images) != len(tags):
        raise HTTPException(
            status_code=400,
            detail="Number of images must match number of meal tags"
        )
    
    results = []
    for image, tag in zip(images, tags):
        try:
            result = await analyze_meal(image=image, meal_tag=tag)
            results.append(result)
        except Exception as e:
            results.append({
                "error": str(e),
                "meal_tag": tag,
                "image_name": image.filename
            })
    
    return {"results": results}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)

