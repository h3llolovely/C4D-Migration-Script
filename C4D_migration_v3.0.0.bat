@ECHO OFF

Title Cinema 4D Migration Script v2.0.2
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
:: 2.0.2 (04.18.2024) - Added AppData/prefs/c4d_M_GLOBAL_POPUP.res
:: 3.0.0 (09.10.2024) - Mostly replaced Xcopy with Robocopy to exclude Redshift, Commented out Browser .lib4d section.

echo ---- CINEMA 4D MIGRATION --- RUN AS ADMIN --- CLOSE WINDOW TO CANCEL ----
echo:

echo What release of C4D are you updating from? (i.e R26, 2023, 2024)
set /p prevInstallVer= - 
echo:

echo What is the unique install hash from your C4D %prevInstallVer% ' %appdata%\MAXON\Maxon Cinema 4D %prevInstallVer%_XXXXXXXX ' folder to migrate from? 
set /p prevInstallDir= - 
echo:

echo What release of C4D are you migrating to? (i.e. 2024, 2025 or TEST)
set /p installVer= - 
echo:

echo What is the unique install hash from your new C4D %installVer% ' %appdata%\MAXON\Maxon Cinema 4D %InstallVer%_XXXXXXXX ' folder?
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

echo Migrating C4D Default Scene file -- CHOOSE FILE OPTION.
if exist "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\new.c4d" (
    Robocopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%" "new.c4d" /NFL /NJH /NP /NC
) else (
    echo --> No default C4D file in AppData Folder.
)
echo:
echo:

echo Migrating Some User Preferences
echo:
echo Migrating Aturtur prefs folder.
echo:
if exist "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\prefs\aturtur" (
    Robocopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\prefs\aturtur" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\prefs\aturtur" /S /NFL /NJH /NP /NC 
) else (
    echo --> Aturtur Prefs do not exist.
)

echo:
echo:

echo Migrating Custom Global PopUp Menu -- CHOOSE FILE OPTION.
echo:
if exist "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\prefs\c4d_M_GLOBAL_POPUP.res" (
    Robocopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\prefs" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\prefs" "c4d_M_GLOBAL_POPUP.res" /NFL /NJH /NP /NC
) else (
    echo --> Custom Global PopUp Menu does not exist.
)

echo:
echo:

echo Migrating xpresso xgroups and xnodes
echo:
Robocopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\library\xgroup" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\library\xgroup" /S /NFL /NJH /NP /NC 
echo:
Robocopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\library\xnode" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\library\xnode" /S /NFL /NJH /NP /NC 
echo:
Robocopy "%programfiles%\Maxon Cinema 4D %prevInstallVer%\library\xnode" "%programfiles%\Maxon Cinema 4D %installVer%\library\xnode" /S /NFL /NJH /NP /NC /XF "System Presets.xgr"

echo:
echo:

echo Migrating scripts
echo:
Robocopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\library\scripts" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\library\scripts" /S /NFL /NJH /NP /NC 
echo:
Robocopy "%programfiles%\Maxon Cinema 4D %prevInstallVer%\library\scripts" "%programfiles%\Maxon Cinema 4D %installVer%\library\scripts" /S /NFL /NJH /NP /NC 

echo:
echo:

echo Migrating shortcuts -- Do you want to migrate custom shortcuts?
echo:
Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\prefs\shortcuts" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\prefs\shortcuts" /E /H /C /I /P

echo:
echo:

GOTO BlockComment_1
...skip this...

echo Migrating .lib4d catalogs
echo:
Robocopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\library\browser" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\library\browser" /S /NFL /NJH /NP /NC 

echo:
echo:

:BlockComment_1

echo Migrating layouts -- Do you want to copy your layouts?
Xcopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\library\layout" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\library\layout" /E /H /C /I /P

echo:
echo:

echo Migrating plugins -- Ignoring Redshift.
echo:
Robocopy "%appdata%\Maxon\Maxon Cinema 4D %prevInstallVer%_%prevInstallDir%\plugins" "%appdata%\Maxon\Maxon Cinema 4D %installVer%_%installDir%\plugins" /S /NFL /NJH /NP /NC 
echo:
Robocopy "%programfiles%\Maxon Cinema 4D %prevInstallVer%\plugins" "%programfiles%\Maxon Cinema 4D %installVer%\plugins" /S /NFL /NJH /NP /NC /XD "Redshift"

echo:
echo:

GOTO BlockComment_2
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

:BlockComment_2

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
