Output:

TR GS ~/Documents/0A01_Personal/1B02_Development/1C01_Local/1D00_Projects/NutriSnap/testing
$ python test_api.py
Sending POST request to http://flask-route-saadrahmanwarsi-dev.apps.rm2.thpm.p1.openshiftapps.com/api/analyze-meal with an embedded image and meal_tag...
Request failed with status code: 500
Response text:
{"detail":"Failed to parse response: Expecting value: line 1 column 1 (char 0)"}

TR GS ~/Documents/0A01_Personal/1B02_Development/1C01_Local/1D00_Projects/NutriSnap/testing
$ python test_api.py
Sending POST request to http://flask-route-saadrahmanwarsi-dev.apps.rm2.thpm.p1.openshiftapps.com/api/analyze-meal with the local image 'egg-salad.jpg' and meal_tag...
Request successful!
Response JSON:
{'meal_tag': 'Dinner', 'timestamp': '2025-11-20T18:37:30.616518', 'foods': [{'name': 'Whole Grain Bread', 'portion_size': '60g', 'calories': 160.0, 'macros': {'protein': '6g', 'carbohydrates': '28g', 'fat': '2.5g', 'fiber': '4g'}}, {'name': 'Egg Salad', 'portion_size': '100g', 'calories': 240.0, 'macros': {'protein': '10g', 'carbohydrates': '3g', 'fat': '20g', 'fiber': '0g'}}, {'name': 'Lettuce', 'portion_size': '10g', 'calories': 2.0, 'macros': {'protein': '0.2g', 'carbohydrates': '0.4g', 'fat': '0g', 'fiber': '0.3g'}}, {'name': 'Pretzels', 'portion_size': '30g', 'calories': 110.0, 'macros': {'protein': '2.5g', 'carbohydrates': '23g', 'fat': '0.8g', 'fiber': '1g'}}], 'ingredients_list': [{'name': 'Whole Grain Bread', 'portion_size': '60g'}, {'name': 'Egg Salad', 'portion_size': '100g'}, {'name': 'Lettuce', 'portion_size': '10g'}, {'name': 'Pretzels', 'portion_size': '30g'}], 'total_calories': 512.0, 'total_macros': {'protein': '18.7g', 'carbohydrates': '54.4g', 'fat': '23.3g', 'fiber': '5.3g'}, 'confidence_level': 'high', 'notes': 'Standard portion sizes and typical ingredients used for estimation.'}

TR GS ~/Documents/0A01_Personal/1B02_Development/1C01_Local/1D00_Projects/NutriSnap/testing
$