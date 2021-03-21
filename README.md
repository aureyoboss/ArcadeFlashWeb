# ArcadeFlashWeb (BETA)
🎮 **ArcadeFlashWeb** is a easy program to **play local/internet Flash Games (SWF)**, **without installing Flash Player** (works despite the end of Flash).

💻 It's work on **Windows 7**, **8**, **8.1** and **10**. To control the mouse cursor and click with a gamepad, it use [AntiMicro](https://github.com/AntiMicro/antimicro "AntiMicro's Homepage").

With **ArcadeFlashWeb** it is therefore possible to play Flash in 2021! :tada:

## Versions
- GUI (graphical user interface).
- Command line (perfect for Arcade Cabinet).

## Languages
- French.
- English.

## How work
- GUI interface : **ArcadeFlashWeb.exe**
- Command line exemple (SWF local) : **ArcadeFlashWeb.exe** *-source:C:/Users/AureyoBoss/Downloads/phoenotopia.swf -swfwidth:900 -swfheight:600 -savedataflash: -profilantimicro:ArcadeFlashWeb.gamecontroller.amgp -controleurantimicro: -profilpadtokey: -screentype:*
- Command line (SWF on internet) : **ArcadeFlashWeb.exe** *https://www.diena.lt/sites/default/files/games/406479.swf*

## Command line explanation
- **-source:** *Specify the path of the SWF file (example : -source:C:/Users/AureyoBoss/Downloads/phoenotopia.swf).*
- **-swfwidth:** *Specify the natural width of the SWF file.*
- **-swfheight:** *Specify the natural width of the SWF file.*
- **-savedataflash:** *Specify the path to save game data of the Flash file (example : -savedataflash:D:/RetroBat/Flash).*
- **-profilantimicro:** *Specify the profile you want to use in AntiMicro. The profile must be present in /ArcadeFlashWeb/antimicro/profiles.*
- **-controleurantimicro:** *Apply configuration file AntiMicro to a specific controller, indicate **GUID** of your controller.*
- **-profilpadtokey:** *Reserved command for **Pad2Key** (RetroBat).*
- **-screentype:** *To simulate a CRT screen, specify **crt**. To simulate Scanlines, specify **scanlines** (example : -screentype:crt).*

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
* [x] Automatically load a game profile from **AntiMicro** by Command line (you must create before your profile for each Flash games in AntiMicro). The software will close automatically **AntiMicro** when quit ArcadeFlashWeb.
* [x] Possibility to indicate in Command line the native resolution of a Flash (SWF) file.
* [x] Possibility to hide menu bar (auto hide after 5 seconds).
* [X] Read natural dimension of the Flash game and adapt this to the screen.
* [X] Add scanlines or CRT mode over the game screen with command line.
* [ ] Possibility of indicating a personalized directory (free in writing, without administrator rights), to save your Flash progress.
* [ ] See if it is technically possible to make the software compatible with PadToKey.
* [ ] Tests.
* [ ] Upload the software on Github.
* [ ] Code source on Github.

## Download
👉 To work, need [Visual C++ 2017 x32](https://support.microsoft.com/fr-fr/topic/derniers-t%C3%A9l%C3%A9chargements-pris-en-charge-de-visual-c-2647da03-1eea-4433-9aff-95f26a218cc0 "").

The project will be available again soon.

![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_01.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_02.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_03.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_04.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_05.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_06.jpg?raw=true)
