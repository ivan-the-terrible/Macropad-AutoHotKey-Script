# Macro Pad - Sweet 16

### Row 1

| Open w/ VSCode = F13 | Extract Files | Archive Files | Mouse Highlighter   |
| -------------------- | ------------- | ------------- | ------------------- |
| F13                  | F14           | F15           | Windows + Shift + H |
|                      | 7zip command  | 7zip command  |                     |

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

The PNG and SVG have been formatted to a size that will fit underneath the keycaps should you print it out.

![Macro Pad Icons](https://github.com/ivan-the-terrible/Macropad-AutoHotKey-Script/blob/master/Macro%20Pad%20Icons.png)

## Instructions

- With ***QMK MSYS***, use the *keymap.json* to generate the HEX file that's to be flashed the macropad. 

***qmk json2c keymap.json -o keymap.c*** to convert *keymap.json* to *keymap.c* so you can compile.

***qmk compile*** command should work as the ***qmk config*** has defaults set to keymap and it'll spit out the HEX file in the qmk_firmware directory. Be sure to delete the existing HEX file.

- Once you have the HEX file, use ***QMK Toolbox*** with the macropad connected and hit the Reset switch on the macropad.
  - You'll notice with QMK Toolbox that it's flashing based on the output.
