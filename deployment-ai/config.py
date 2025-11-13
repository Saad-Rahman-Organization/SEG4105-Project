import os
from typing import List

class Settings:
    APP_NAME: str = "Meal Nutrition Analysis API"
    APP_VERSION: str = "1.0.0"
    APP_DESCRIPTION: str = "API for analyzing meal images and estimating calories and macros"
    
    HOST: str = os.getenv("HOST", "0.0.0.0")
    PORT: int = int(os.getenv("PORT", "8000"))
    
    API_KEY: str = os.getenv("OPENAI_API_KEY", "")
    MODEL: str = "gpt-4o"
    MAX_TOKENS: int = 1500
    TEMPERATURE: float = 0.2
    
    VALID_MEAL_TAGS: List[str] = ["Breakfast", "Lunch", "Dinner", "Snack"]
    SUPPORTED_IMAGE_FORMATS: List[str] = ["jpeg", "jpg", "png", "gif", "webp"]
    MAX_IMAGE_SIZE_MB: int = 10
    
    ALLOW_ORIGINS: List[str] = ["*"]
    ALLOW_CREDENTIALS: bool = True
    ALLOW_METHODS: List[str] = ["*"]
    ALLOW_HEADERS: List[str] = ["*"]
    
    @classmethod
    def validate(cls) -> bool:
        if not cls.API_KEY:
            return False
        return True
    
    @classmethod
    def get_config(cls) -> dict:
        return {
            "model": cls.MODEL,
            "max_tokens": cls.MAX_TOKENS,
            "temperature": cls.TEMPERATURE
        }

settings = Settings()


