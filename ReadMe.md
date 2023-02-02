# Macro Pad - Sweet 16

![Finished Macro Pad](https://github.com/ivan-the-terrible/Macropad-AutoHotKey-Script/blob/master/Finished.jpg)

## Overview

By programming the [Sweet 16 Macro Pad Black from 1upkeyboards](https://1upkeyboards.com/shop/keyboard-kits/macro-pads/sweet-16-macro-pad-black/) with [QMK](https://github.com/qmk) and [AutoHotkey](https://www.autohotkey.com/), I get dedicated keys for [PowerToys](https://github.com/microsoft/PowerToys) and acting on selected files within File Explorer (open with VSCode and Inkscape, use the [7-zip console executable](https://www.7-zip.org/download.html) to extract and archive, and use [ImageMagick](https://github.com/ImageMagick/ImageMagick) to convert files to PNG).

The PNG and SVG you see here has been formatted to a size that will fit underneath the keycaps should you print it out.

![Macro Pad Icons](https://github.com/ivan-the-terrible/Macropad-AutoHotKey-Script/blob/master/Macro%20Pad%20Icons%20-%20Grid.svg)

### Row 1

| Open w/ VSCode | Extract Files | Archive Files | Mouse Highlighter   |
| -------------- | ------------- | ------------- | ------------------- |
| F13            | F14           | F15           | Windows + Shift + H |
|                | 7zip command  | 7zip command  |                     |

### Row 2

| Color Picker        | Screen Ruler        | Always On Top      | Mouse Pointer Crosshairs |
| ------------------- | ------------------- | ------------------ | ------------------------ |
| Windows + Shift + C | Windows + Shift + M | Windows + Ctrl + T | Windows + Alt + P        |

### Row 3

| Snipping Tool       | Export to PNG  | Open w/Inkscape     | Window Switcher  |
| ------------------- | -------------- | ------------------- | ---------------- |
| Windows + Shift + S | F17            | F18                 | Ctrl + Alt + Tab |
|                     | Magick command | Inkscape.exe [file] |                  |

### Row 4

| Volume Down | Volume Up | Task Manager       | Fancy Zones         |
| ----------- | --------- | ------------------ | ------------------- |
| KC_VOLD     | KC_VOLU   | Ctrl + Shift + ESC | Windows + Shift + ` |

## Instructions

### QMK

With [QMK MSYS](https://msys.qmk.fm/) locally or [QMK Configurator](https://config.qmk.fm/#/melgeek/mach80/rev1/LAYOUT_tkl_ansi) online, use the *keymap.json* to generate the HEX file that's to be flashed the macropad.

Once you have a HEX file, you can flash the macropad via [QMK Toolbox](https://github.com/qmk/qmk_toolbox)

### Some Specific Steps & Commands for *QMK MSYS*

***qmk compile*** command has many parameters, but if you use the ***qmk config***, as I have with the defaults set as seen below, it'll spit out the HEX file in the ***qmk_firmware*** directory by just running ***qmk compile***. Be sure to delete the existing HEX file if you make any changes within the keymap files as there seems to be some caching.

- compile.keyboard=1upkeyboards/sweet16/v1
  compile.keymap=1upkeyboards/sweet16/v1/keymaps/ivan
  - Be sure to create your own keymaps directory as I have

Within your ***keymaps*** directory for the 1upkeyboards/sweet16, ***qmk json2c keymap.json -o keymap.c*** to convert *keymap.json* to *keymap.c*. Now you can run ***qmk compile*** against that ***keymap.c*** file.

Once you have the HEX file, use [QMK Toolbox](https://github.com/qmk/qmk_toolbox) with the macropad connected and hit the Reset switch on the macropad.

- The output of the window will show you that it's flashing the microcontroller as it should.
- If you get "access denied" messages, keep hitting the reset button or replug the micro USB port and continue hitting reset. It's super annoying, but whatever.

Visit the [QMK Docs](https://docs.qmk.fm/#/) for more context and well documented instructions on this process.

### AutoHotKey

Initially, I found a really useful script to detect what items in an active File Explorer window are currently selected, but it was using AutoHotKey v1. I used [AHK-v2-script-converter](https://github.com/mmikeww/AHK-v2-script-converter) to port it to v2 and cleaned up the code. I included the original v1 script for historical sake.

Be sure to examine the script and update any program paths to fit your machine.

There is some neat stuff in there about Windows' COM objects too ;)
