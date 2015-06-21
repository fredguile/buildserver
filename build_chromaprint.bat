echo "Building chromaprint"
set CHROMAPRINT_PATH=chromaprint-1.1

if %MACHINE_X86% (
  set PLATFORM=Win32
  set CMAKE_CONF="Visual Studio 12 2013"
) else (
  set PLATFORM=x64
  set CMAKE_CONF="Visual Studio 12 2013 Win64"
)

if %CONFIG_RELEASE% (
  set CONFIG=Release
) else (
  set CONFIG=Debug
)

REM NOTE(rryan): generated solution with
REM C:\mixxx\environments\prototype\build\chromaprint-1.1>cmake . -G "Visual Studio 12 2013" -DWITH_FFTW3=ON -DFFTW3_FFTW_LIBRARY=D:/Users/Frederic/Documents/QtProjects/buildserver/lib/libfftw-3.3.dll -DWITH_AVFFT=OFF -DBUILD_EXAMPLES=OFF

cd build\%CHROMAPRINT_PATH%
cmake -G %CMAKE_CONF% -DWITH_FFTW3=ON -DFFTW3_FFTW_LIBRARY=%LIB_DIR%\libfftw-3.3.lib -DWITH_AVFFT=OFF -DBUILD_EXAMPLES=OFF -DFFTW3_DIR=%INCLUDE_DIR% .
%MSBUILD% chromaprint.sln /p:Configuration=%CONFIG% /p:Platform=%PLATFORM% /t:chromaprint:Clean;chromaprint:Rebuild

copy src\%CONFIG%\chromaprint.lib %LIB_DIR%
copy src\%CONFIG%\chromaprint.dll %LIB_DIR%
copy src\%CONFIG%\chromaprint.pdb %LIB_DIR%
copy src\chromaprint.h %INCLUDE_DIR%

cd %ROOT_DIR%