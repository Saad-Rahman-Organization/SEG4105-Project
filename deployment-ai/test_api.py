import requests
import sys
import os

API_BASE_URL = "http://localhost:8000"

def test_health_check():
    print("Testing health check...")
    try:
        response = requests.get(f"{API_BASE_URL}/health")
        if response.status_code == 200:
            data = response.json()
            print(f"✓ Health check passed")
            print(f"  Status: {data['status']}")
            print(f"  API Configured: {data['api_configured']}")
            return data['api_configured']
        else:
            print(f"✗ Health check failed with status {response.status_code}")
            return False
    except Exception as e:
        print(f"✗ Health check failed: {str(e)}")
        return False

def test_root_endpoint():
    print("\nTesting root endpoint...")
    try:
        response = requests.get(f"{API_BASE_URL}/")
        if response.status_code == 200:
            data = response.json()
            print(f"✓ Root endpoint working")
            print(f"  API: {data['message']}")
            print(f"  Version: {data['version']}")
            return True
        else:
            print(f"✗ Root endpoint failed with status {response.status_code}")
            return False
    except Exception as e:
        print(f"✗ Root endpoint failed: {str(e)}")
        return False

def test_analyze_meal(image_path, meal_tag="Lunch"):
    print(f"\nTesting meal analysis with {meal_tag}...")
    
    if not os.path.exists(image_path):
        print(f"✗ Image file not found: {image_path}")
        print("  Please provide a valid image file path as argument")
        return False
    
    try:
        with open(image_path, 'rb') as image_file:
            files = {'image': image_file}
            data = {'meal_tag': meal_tag}
            
            response = requests.post(
                f"{API_BASE_URL}/api/analyze-meal",
                files=files,
                data=data
            )
            
            if response.status_code == 200:
                result = response.json()
                print(f"✓ Meal analysis successful")
                print(f"\n  Meal Tag: {result['meal_tag']}")
                print(f"  Timestamp: {result['timestamp']}")
                print(f"  Total Calories: {result['total_calories']} kcal")
                print(f"  Total Protein: {result['total_macros']['protein']}g")
                print(f"  Total Carbs: {result['total_macros']['carbohydrates']}g")
                print(f"  Total Fat: {result['total_macros']['fat']}g")
                print(f"  Confidence: {result['confidence_level']}")
                print(f"\n  Detected Foods:")
                for food in result['foods']:
                    print(f"    - {food['name']} ({food['portion_size']}): {food['calories']} kcal")
                if result.get('notes'):
                    print(f"\n  Notes: {result['notes']}")
                return True
            elif response.status_code == 500:
                error = response.json()
                print(f"✗ Analysis failed: {error['detail']}")
                if "API key not configured" in error['detail']:
                    print("\n  → API key not set")
                return False
            else:
                print(f"✗ Analysis failed with status {response.status_code}")
                print(f"  Response: {response.json()}")
                return False
                
    except Exception as e:
        print(f"✗ Analysis failed: {str(e)}")
        return False

def test_invalid_meal_tag(image_path):
    print("\nTesting invalid meal tag handling...")
    
    if not os.path.exists(image_path):
        print("✗ Skipping - no image file provided")
        return True
    
    try:
        with open(image_path, 'rb') as image_file:
            files = {'image': image_file}
            data = {'meal_tag': 'InvalidTag'}
            
            response = requests.post(
                f"{API_BASE_URL}/api/analyze-meal",
                files=files,
                data=data
            )
            
            if response.status_code == 400:
                print(f"✓ Invalid meal tag properly rejected")
                return True
            else:
                print(f"✗ Expected 400 status, got {response.status_code}")
                return False
                
    except Exception as e:
        print(f"✗ Test failed: {str(e)}")
        return False

def main():
    print("=" * 60)
    print("Meal Nutrition Analysis API - Test Suite")
    print("=" * 60)
    

    try:
        requests.get(API_BASE_URL, timeout=2)
    except requests.exceptions.ConnectionError:
        print(f"\n✗ Cannot connect to API server at {API_BASE_URL}")
        print("  Start server: python app.py")
        sys.exit(1)
    
    image_path = sys.argv[1] if len(sys.argv) > 1 else None
    results = []
    results.append(test_root_endpoint())
    results.append(test_health_check())
    
    if image_path:
        results.append(test_analyze_meal(image_path, "Breakfast"))
        results.append(test_invalid_meal_tag(image_path))
    else:
        print("\nSkipping image analysis tests")
        print("Run: python test_api.py path/to/meal_image.jpg")
    

    print("\n" + "=" * 60)
    print("Test Summary")
    print("=" * 60)
    passed = sum(results)
    total = len(results)
    print(f"Passed: {passed}/{total}")
    
    if passed == total:
        print("\n✓ All tests passed!")
    else:
        print(f"\n✗ {total - passed} test(s) failed")
    
    sys.exit(0 if passed == total else 1)

if __name__ == "__main__":
    main()


