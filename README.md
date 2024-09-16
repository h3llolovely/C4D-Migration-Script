# C4D-Migration-Script
Migrate your old C4D stuff to your new C4D place

---

**Instructions:**
1. Install new Cinema 4D version.
2. Run C4D Migration script __as Administrator__

**Currently Syncs:**
- Default C4D scene file ( if stored in **%appdata%\Maxon Cinema 4D [Version]_XXXXXXXX** )
- Aturtur scripts/plugin preferences
- Custom Global PopUp Menu
- Xpresso xgroups and xnodes
- Scripts
- Keyboard shortcuts
  - ***Correction:***
    - Migrated shortcuts are copied but do not load. **You will need to add a custom shortcut for C4D to make a new "Cinema 4D R25 (modified).res" file first.**
    - You will need to manually edit the new file ( **Cinema 4D R25 (modified).res** ): located in **%appdata%\Maxon Cinema 4D [Version]_XXXXXXXX\prefs\shortcuts**
    - From the old shortcuts file ( **Cinema 4D 2024 (modified).res** ): **Copy everything after** -- "PLUGIN_CMD_431000216	ALT+"W";"
    - In the new shortcuts file: **Paste after** -- "IDM_MODELING_SPLIT	OPTIONMODE	"U"~SHIFT+"P";"
- Custom layouts ( some older palettes may need to be replaced )
- All plugins stored in **%programfiles%\Maxon Cinema 4D [Version]\plugins** and **%appdata%\Maxon Cinema 4D [Version]_XXXXXXXX\plugins**
    - C4D_migration_v3.0.0 DOES NOT copy Redshift from **%programfiles%\Maxon Cinema 4D [Version]\plugins** )
    - You will need to update some plugins after migration, ( i.e. GSG Hub, GSG Studio connector, X-Particles ) to thier latest version.

**Currently Disabled:** *(Can be uncommented)*
- Browser .lib4d catalogs
- Commandline folder plugins symbolic link creation

**Limitations:**
- Does not transfer C4D in-app or plugin preferences *( i.e plugin / asset paths, navigation / timeline settings, etc... )*
- It is recommended to take screenshots of all C4D preferences from the previous version. You will have to manually apply them.

### Feel free to copy and modify to suite your needs.

---

Original script (v1) by James Lashmar
- https://www.linkedin.com/feed/update/urn:li:activity:7113126264814620672/
- https://www.dropbox.com/scl/fi/va9z5aib9xueexom46msi/C4D_migration.bat?rlkey=swwsvfye8nyezfhkw4yzl5o0i&dl=0
 
Modified (v2-3) by Jason Schwarz
- https://www.dropbox.com/scl/fo/larrs94wkujjqzmo6rogt/h?rlkey=jywh921tnp0oaa0grqn8ituuq&dl=0
- https://github.com/h3llolovely/C4D-Migration-Script

Change log:

1.0.0 (02.10.2023) 
- Initial release

2.0.0 (03.10.2023) 
- Added migrate new.c4d file to Program Files
- Added Migrate Aturtur Prefs
- Added Migrate xgroups and xnodes
- Added Prompt for Layout migration
- Added Block comment to skip SymLink creation for Commandline and TeamRender

2.0.1 (02.01.2024) 
- Removed migrate new.c4d from Program Files [Maxon removed option in 2024]
- Added ProgramFiles Xnodes
- Added AppData\MAXON copy shortcut to set install directories.
- Added Open migrated directories in File Explorer.

2.0.2 (04.18.2024)
- Added AppData/prefs/c4d_M_GLOBAL_POPUP.res

3.0.0 (09.10.2024)
- Mostly replaced Xcopy with Robocopy to exclude Redshift, Commented out Browser .lib4d section.
