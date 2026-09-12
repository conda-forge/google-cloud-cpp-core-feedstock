@echo on
setlocal EnableDelayedExpansion

:: CMake does not like paths with \ characters
set LIBRARY_PREFIX="%LIBRARY_PREFIX:\=/%"

cmake -GNinja ^
    -S tests -B .build/quickstart ^
    -DCMAKE_CXX_STANDARD=17 ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_MODULE_PATH="%LIBRARY_PREFIX%/lib/cmake"
if %ERRORLEVEL% neq 0 exit 1

cmake --build .build/quickstart --config Release
if %ERRORLEVEL% neq 0 exit 1

if "%target_platform%" == "win-arm64" (
    .build\quickstart\quickstart.exe
    if errorlevel 1 exit /b 1
    dumpbin /headers .build\quickstart\quickstart.exe | findstr /I /C:"AA64 machine (ARM64)"
    if errorlevel 1 exit /b 1
)
