@echo off
echo ========================================
echo Meal Nutrition API - Quick Start
echo ========================================
echo.

REM Check if in correct directory
if not exist "app.py" (
    echo ERROR: app.py not found!
    echo Make sure you're running this from the nutrition_model folder
    pause
    exit /b 1
)

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat

echo.
echo ========================================
echo API Key Setup
echo ========================================
echo.
echo Please paste your API key below:
echo (It should start with sk-proj- or sk-)
echo.

set /p OPENAI_API_KEY="Enter API Key: "

if "%OPENAI_API_KEY%"=="" (
    echo.
    echo ERROR: No API key provided!
    echo Please run the script again and enter your key.
    pause
    exit /b 1
)

echo.
echo API key has been set!
echo.
echo ========================================
echo Starting Server...
echo ========================================
echo.
echo The server will start in 2 seconds...
echo.
timeout /t 2 /nobreak >nul

uvicorn app:app --reload --host 0.0.0.0 --port 8000

pause

