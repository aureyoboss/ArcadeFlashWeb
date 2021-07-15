![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb.png?raw=true)

🎮 **ArcadeFlashWeb** is a easy portable program to **play local/internet Flash games (SWF)**, **without installing Flash Player** (works despite the end of Flash). Logo created by **Hel Mic**.

💻 It works under **Windows 7**, **8**, **8.1** and **10**.

:tada: With **ArcadeFlashWeb** it's therefore possible to play Flash games in 2021!

👍 **Works with all Flash games!**

## Features
- Play SWF without installing Flash Player (on local and on internet).
- French and English languages.
- Versions **GUI** and **Command line** (perfect for Arcade Cabinet).
- Integrated file browser.
- Possibility to make a screenshot of the game.
- Possibility to play in fullscreen.
- Bezel, SCANLINES or CRT mods.
- Flash games save your progress, by default in "*C:\Users\Your Name Session\AppData\Local\ArcadeFlashWeb\QtWebEngine*" (you can specify your own save folder by command line).
- Read native dimensions of the Flash game and adapt this to the screen (you can also specify the dimensions by command line).
- Small mouse cursor (red dot) on game zone (on the Arcade Cabinet, this avoids connecting a mouse).
- Show date and time.
- Possibility to use [**AntiMicro**](https://github.com/AntiMicro/antimicro "AntiMicro's Homepage").

## RetroBat
**ArcadeFlashWeb** will be present in the future version of the software [**RetroBat**](https://www.retrobat.ovh/ "RetroBat"), retro gaming.

## How work
- GUI interface : **ArcadeFlashWeb.exe**
- Command line exemple (SWF on local) : **ArcadeFlashWeb.exe** *-source:"C:/Users/AureyoBoss/Downloads/phoenotopia.swf"*
- Command line (SWF on internet) : **ArcadeFlashWeb.exe** *-source:"https://www.diena.lt/sites/default/files/games/406479.swf"*

## Command line explanation
- **-source:** > *Specify the **path of the SWF** file (example : -source:"C:/Users/AureyoBoss/Downloads/phoenotopia.swf").*
- **-swfwidth:** > *Specify the **natural width** of the SWF file (example : -source:"C:/Users/AureyoBoss/Downloads/phoenotopia.swf" -swfwidth:900).*
- **-swfheight:** > *Specify the **natural height** of the SWF file (example : -source:"C:/Users/AureyoBoss/Downloads/phoenotopia.swf" -swfwidth:900 -swfheight:600).*
- **-savedataflash:** > *Specify the path to **save game data of the Flash** file (example : -savedataflash:"D:/RetroBat/Flash").*
- **-profilantimicro:** > *Specify the **profile** you want to use in **AntiMicro**. The profile must be present in **/ArcadeFlashWeb/antimicro/profiles** (example : -profilantimicro:arcadeflashweb.gamecontroller.amgp).*
- **-controleurantimicro:** > *Apply configuration file **AntiMicro** to a specific controller, indicate **GUID** of your controller.*
- **-screentype:** > *To simulate a CRT screen, specify **crt** (example : -screentype:crt). To simulate Scanlines, specify **scanlines** (example : -screentype:scanlines).*
- **-fullscreen** > *To lauch Flash game in fullscreen.*
- **-nodatetime** > *Remove date and time on the screen.*
- **-picturesfolder:** > *Specify the path to save **screenshots**, by default is « Pictures » folder (example : -picturesfolder:"D:/RetroBat/Screenshots").*
- **-?** or **-help** > *Show command line.*

## Shortcuts
* To quit, you can use « *ESC* ».
* To take a screenshort, you can use « *Ctrl+S* ».

## Antivirus - False positives
Some Antivirus, **Bitdefender/McAfee/Ad-Aware**, detects **ArcadeFlashWeb** like **Gen:Variant.Razy** or **Artemis**.

👉 **These are false positives**.

## Flash games
🕹 Somes Flash games are present in « *[**Games**](https://github.com/aureyoboss/ArcadeFlashWeb/tree/main/games "")* » folder.

## Download
⚠ To work it needs [**Visual C++ 2017 (x32)**](https://support.microsoft.com/fr-fr/topic/derniers-t%C3%A9l%C3%A9chargements-pris-en-charge-de-visual-c-2647da03-1eea-4433-9aff-95f26a218cc0 "").

📥 To download **ArcadeFlashWeb v1.0.2** go to « *[**Releases**](https://github.com/aureyoboss/ArcadeFlashWeb/releases/tag/v1.0.2 "")* » folder.

## Screenshots
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_01.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_02.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_03.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_04.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_05.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_06.jpg?raw=true)
![alt text](https://github.com/aureyoboss/ArcadeFlashWeb/blob/main/screenshots/ArcadeFlashWeb_07.jpg?raw=true)
