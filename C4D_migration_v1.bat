@ECHO OFF

Title C4D Update Automation Script by James Lashmar

set /p prevInstallVer=What release of Cinema4D are you updating from?
echo:

set /p prevInstallDir= What is the unique install hash from your C4D AppData folder to migrate from?
echo:

set /p installVer= What release of Cinema4D are you using?
echo:

set /p installDir= What is the unique install hash from your new C4D AppData folder?
echo:

echo Okay great thanks! Let's migrate!
echo:
pause

echo:
echo:
echo:

echo migrate new.c4d file
Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\new.c4d" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\new.c4d" /E /H /C /I

echo:
echo:
echo:

echo migrate scripts
echo:
Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\library\scripts" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\library\scripts" /E /H /C /I
echo:
Xcopy "%programfiles%\Maxon Cinema 4D %prevInstallVer%\library\scripts" "%programfiles%\Maxon Cinema 4D %installVer%\library\scripts" /E /H /C /I

echo:
echo:

echo migrate shortcuts
echo:
Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\prefs\shortcuts" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\prefs\shortcuts" /E /H /C /I

echo:
echo:

echo migrate catalogs
echo:
Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\library\browser" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\library\browser" /E /H /C /I

echo:
echo:

echo migrate layouts
Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\library\layout" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\library\layout" /E /H /C /I

echo:
echo:

echo migrate plugins
echo:
Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\plugins" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\plugins" /E /H /C /I
echo:
Xcopy "%programfiles%\Maxon Cinema 4D %prevInstallVer%\plugins" "%programfiles%\Maxon Cinema 4D %installVer%\plugins" /E /H /C /I

echo:
echo:

echo commandline folder plugins symbolic link creation
echo:
:: create directory in case it hasn't launched yet
mkdir "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%_x\plugins"

echo:

mklink /j "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%_x\plugins\Greyscalegorilla" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\plugins\Greyscalegorilla"
echo:
mklink /j "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%_x\plugins\Motion Manager" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\plugins\Motion Manager"
echo:
mklink /j "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%_x\plugins\MSLiveLink" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\plugins\MSLiveLink"

echo:
echo:

echo teamrender folder plugins symbolic link creation
echo:
:: create directory in case it hasn't launched yet
mkdir "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%_c\plugins"

echo:

mklink /j "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%_c\plugins\Greyscalegorilla" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\plugins\Greyscalegorilla"
echo:
mklink /j "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%_c\plugins\Motion Manager" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\plugins\Motion Manager"
echo:
mklink /j "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%_c\plugins\MSLiveLink" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\plugins\MSLiveLink"

echo:
echo:
echo:

echo Okay we're all done!
echo:
pause
