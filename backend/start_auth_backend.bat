@echo off
REM Authentication Backend Quick Start Script

echo ========================================
echo TumorHeal Authentication Backend
echo ========================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed
    pause
    exit /b 1
)

echo [1/4] Python installed
python --version
echo.

REM Create/activate venv
if not exist "venv" (
    echo [2/4] Creating virtual environment...
    python -m venv venv
) else (
    echo [2/4] Virtual environment exists
)

call venv\Scripts\activate.bat
echo.

REM Install dependencies
echo [3/4] Installing dependencies...
pip install --quiet --upgrade pip
pip install --quiet -r requirements.txt
echo Dependencies installed!
echo.

REM Check .env
if not exist ".env" (
    echo [WARNING] .env file not found!
    copy .env.example .env
    echo.
    echo Please edit .env with your JWT secret key
    echo.
    pause
)

REM Start server
echo [4/4] Starting Authentication Server...
echo.
echo ========================================
echo Server: http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo ========================================
echo.
echo Press Ctrl+C to stop
echo.

python auth_backend.py

pause
