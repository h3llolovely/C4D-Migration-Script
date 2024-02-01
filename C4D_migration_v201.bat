@ECHO OFF

Title Cinema 4D Migration Script v2
:: -- RUN AS ADMINISTRATOR --
::
:: Original script by James Lashmar
:: -- https://www.linkedin.com/feed/update/urn:li:activity:7113126264814620672/
:: -- https://www.dropbox.com/scl/fi/va9z5aib9xueexom46msi/C4D_migration.bat?rlkey=swwsvfye8nyezfhkw4yzl5o0i&dl=0
:: 
:: Modified by Jason Schwarz
:: -- https://www.dropbox.com/scl/fo/larrs94wkujjqzmo6rogt/h?rlkey=jywh921tnp0oaa0grqn8ituuq&dl=0
::
:: Change log:
:: 1.0.0 (02.10.2023) - Initial release
:: 2.0.0 (03.10.2023) - Added migrate new.c4d file to Program Files, Added Migrate Aturtur Prefs, Added Migrate xgroups and xnodes, Added Prompt for Layout migration, Added Block comment to skip SymLink creation for Commandline and TeamRender.
:: 2.0.1 (02.01.2024) - Removed migrate new.c4d from Program Files [Maxon removed option in 2024], Added ProgramFiles Xnodes, Added %AppData%\MAXON shortcut to reference install directories, Added Open migrated directories in File Explorer.

echo ---- CINEMA 4D MIGRATION --- RUN AS ADMIN --- CLOSE WINDOW TO CANCEL ----
echo:

echo What release of C4D are you updating from? (R23, 2023, 2024) 
set /p prevInstallVer= - 
echo:

echo What is the unique install hash from your C4D %prevInstallVer% ' %appdata%\MAXON ' folder to migrate from? 
set /p prevInstallDir= - 
echo:

echo What release of C4D migrating to? (2024, 2025 or TEST) 
set /p installVer= - 
echo:

echo What is the unique install hash from your new C4D %installVer% ' %appdata%\MAXON ' folder? 
set /p installDir= - 
echo:

echo Kewl! Let's migrate!
echo:
echo Migrating from %programfiles%\Maxon Cinema 4D %prevInstallVer% - to - %programfiles%\Maxon Cinema 4D %InstallVer%
echo Migrating from %appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir% - to - %appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%
echo:
echo - CLOSE WINDOW TO CANCEL -
echo:
pause

echo:
echo:
echo:

echo Migrating C4D Default Scene file -- Choose File option.
if exist "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\new.c4d" (
    Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\new.c4d" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\new.c4d" /E /H /C /I
) else (
    echo --> No default C4D file in AppData Folder.
)
echo:
echo:

echo Migrating Aturtur prefs folder
echo:
if exist "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\prefs\aturtur" (
    Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\prefs\aturtur" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\prefs\aturtur" /E /H /C /I
) else (
    echo --> Aturtur Prefs do not exist.
)

echo:
echo:

echo Migrating xpresso xgroups and xnodes
echo:
Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\library\xgroup" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\library\xgroup" /E /H /C /I
echo:
Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\library\xnode" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\library\xnode" /E /H /C /I
echo:
Xcopy "%programfiles%\Maxon Cinema 4D %prevInstallVer%\library\xnode" "%programfiles%\Maxon Cinema 4D %installVer%\library\xnode" /E /H /C /I /EXCLUDE:System Presets.xgr

echo:
echo:

echo Migrating scripts
echo:
Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\library\scripts" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\library\scripts" /E /H /C /I
echo:
Xcopy "%programfiles%\Maxon Cinema 4D %prevInstallVer%\library\scripts" "%programfiles%\Maxon Cinema 4D %installVer%\library\scripts" /E /H /C /I

echo:
echo:

echo Migrating shortcuts
echo:
Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\prefs\shortcuts" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\prefs\shortcuts" /E /H /C /I

echo:
echo:

echo Migrating .lib4d catalogs
echo:
Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\library\browser" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\library\browser" /E /H /C /I

echo:
echo:

echo Migrating layouts -- Do you want to copy your layouts?
Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\library\layout" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\library\layout" /E /H /C /I /P

echo:
echo:

echo Migrating plugins
echo:
Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\plugins" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\plugins" /E /H /C /I
echo:
Xcopy "%programfiles%\Maxon Cinema 4D %prevInstallVer%\plugins" "%programfiles%\Maxon Cinema 4D %installVer%\plugins" /E /H /C /I

echo:
echo:

GOTO BlockComment
...skip this...

echo Commandline folder plugins symbolic link creation
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

echo Teamrender folder plugins symbolic link creation
echo:
:: create directory in case it hasn't launched yet
mkdir "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%_c\plugins"

echo:

mklink /j "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%_c\plugins\Greyscalegorilla" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\plugins\Greyscalegorilla"
echo:
mklink /j "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%_c\plugins\Motion Manager" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\plugins\Motion Manager"
echo:
mklink /j "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%_c\plugins\MSLiveLink" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\plugins\MSLiveLink"

:BlockComment

echo:
echo:
echo:

echo Okay we're all done!
echo:

echo Opening Migrated Directories
@echo off
start %SystemRoot%\explorer.exe "%programfiles%\Maxon Cinema 4D %installVer%"
start %SystemRoot%\explorer.exe "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%"

echo:
echo:
echo:

pause
