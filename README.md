# ArcadeFlashWeb
🎮 **ArcadeFlashWeb** is a easy program to **play local/internet Flash Games (SWF)**, **without installing Flash Player** (works despite the end of Flash).

💻 It's work on **Windows 7**, **8**, **8.1** and **10**. To control the mouse cursor and click with a gamepad, it use [AntiMicro](https://github.com/AntiMicro/antimicro "AntiMicro's Homepage").

With **ArcadeFlashWeb** it is therefore possible to play Flash in 2021! :tada:
Works on 100% Flash games ! 👍

## Versions
- GUI (graphical user interface).
- Command line (perfect for Arcade Cabinet).

## Languages
- French.
- English.

## How work
- GUI interface : **ArcadeFlashWeb.exe**
- Command line exemple (SWF on local) : **ArcadeFlashWeb.exe** *-source:"C:/Users/AureyoBoss/Downloads/phoenotopia.swf" -swfwidth:900 -swfheight:600*
- Command line (SWF on internet) : **ArcadeFlashWeb.exe** *-source:"https://www.diena.lt/sites/default/files/games/406479.swf"*

## Command line explanation
- **-source:** > *Specify the **path of the SWF** file (example : -source:"C:/Users/AureyoBoss/Downloads/phoenotopia.swf").*
- **-swfwidth:** > *Specify the **natural width** of the SWF file (example : -swfwidth:900).*
- **-swfheight:** > *Specify the **natural height** of the SWF file (example : -swfheight:600).*
- **-savedataflash:** > *Specify the path to **save game data of the Flash** file (example : -savedataflash:"D:/RetroBat/Flash").*
- **-profilantimicro:** > *Specify the **profile** you want to use in **AntiMicro**. The profile must be present in **/ArcadeFlashWeb/antimicro/profiles** (example : -profilantimicro:arcadeflashweb.gamecontroller.amgp).*
- **-controleurantimicro:** > *Apply configuration file **AntiMicro** to a specific controller, indicate **GUID** of your controller.*
- **-screentype:** > *To simulate a CRT screen, specify **crt** (example : -screentype:crt). To simulate Scanlines, specify **scanlines** (example : -screentype:scanlines).*
- **-fullscreen** > *To lauch Flash game in fullscreen.*
- **-nodatetime** > *Remove date and time on the screen.*
- **-picturesfolder:** > *Specify the path to save **screenshots** (default : « Pictures » folder). Example : -picturesfolder:"D:/RetroBat/Screenshots".*
- **-?** or **-help** > *Show command line.*

## ToDoList
* [x] Play SWF without installing Flash Player.
* [x] Create GUI interface.
* [X] French and english interface.
* [x] Run in fullscreen.
* [x] Play SWF and open internet adress with command line.
* [x] Create a file browser.
* [x] Add shortcuts in file browser (My documents, Downloads, Desktop, Home and Drive letter assignment).
* [x] Add hotkeys to quit the software (keyboard 'ESC').
* [x] If the Flash games can save your progress. The software saves your data in *C:\Users\Your Name Session\AppData\Local\ArcadeFlashWeb\QtWebEngine*.
* [X] Possibility of indicating a personalized directory (free in writing, without administrator rights), to save your Flash data progress.
* [x] Possibility to load a game profile from **AntiMicro** by Command line (you must create before your profile for each Flash games in AntiMicro). The software will close automatically **AntiMicro** when quit ArcadeFlashWeb.
* [x] Possibility to indicate in Command line the native resolution of a Flash (SWF) file.
* [x] Possibility to hide menu bar (auto hide after 5 seconds when load SWF file from a command line).
* [X] Read native dimension of the Flash game and adapt this to the screen.
* [X] Add scanlines or CRT mode over the game screen with command line and click icon on GUI.
* [X] Add a small mouse cursor (red dot) on game zone (on the Arcade Cabinet, this avoids connecting a mouse).
* [X] Command line work with **slash** or **backslash** (**f.caruso's** wish).
* [X] Add command line to start game in fullscreen « *-fullscreen* » (**f.caruso's** wish).
* [X] Show Bezel over Flash game (**f.caruso's** and **lorenzolamas** wish). You can turn it off.
* [X] Possibility to make a screenshot (**f.caruso's** wish) to **Pictures folder** and specify a folder by command line.
* [X] Tests.
* [ ] Upload the software on Github.
* [ ] Upload the code source on Github.

## Flash games
🕹 Somes Flash games are present in « *[Games](https://github.com/aureyoboss/ArcadeFlashWeb/tree/main/games "")* » folder.

## Download
⚠ To work, need [Visual C++ 2017 x32](https://support.microsoft.com/fr-fr/topic/derniers-t%C3%A9l%C3%A9chargements-pris-en-charge-de-visual-c-2647da03-1eea-4433-9aff-95f26a218cc0 "").

📥 To download **ArcadeFlashWeb** go to « *[Releases](https://github.com/aureyoboss/ArcadeFlashWeb/releases/tag/v1.0 "")* » folder.

![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_07.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_08.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_09.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_10.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_11.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_06.jpg?raw=true)
