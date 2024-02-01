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

set /p prevInstallVer= What release of Cinema4D are you updating from? i.e. R23, 2023
echo:

set /p prevInstallDir= What is the unique install hash from your C4D AppData folder to migrate from?
echo:

set /p installVer= What release of Cinema4D migrating to? i.e. 2024 or TEST
echo:

set /p installDir= What is the unique install hash from your new C4D AppData folder?
echo:

echo Okay great thanks! Let's migrate!
echo:
pause

echo:
echo:
echo:

echo Migrating C4D Default Scene file
if exist "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\new.c4d" (
    Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\new.c4d" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\new.c4d" /E /H /C /I
) else (
    echo --> No default C4D file in AppData Folder.
)
echo:
echo:
if exist "%programfiles%\Maxon Cinema 4D %prevInstallVer%\new.c4d" (
    Xcopy "%programfiles%\Maxon Cinema 4D %prevInstallVer%\new.c4d" "%programfiles%\Maxon Cinema 4D %installVer%\new.c4d" /E /H /C /I
) else (
    echo --> No default C4D file in Program Files Folder.
)
echo:
echo:
echo:

echo Migrating Aturtur prefs folder :: Aturtur Plugins / Scripts preferences
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

echo Migrating layouts
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
pause
