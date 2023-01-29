# Macro Pad - Sweet 16

### Row 1

| Open w/ VSCode = F13 | Extract Files | Archive Files | F16??? |
| -------------------- | ------------- | ------------- | ------ |
| F13                  | F14           | F15           |        |
|                      | 7zip command  | 7zip command  |        |

### Row 2

| Color Picker        | Screen Ruler        | Always On Top      | Mouse Pointer Crosshairs |
| ------------------- | ------------------- | ------------------ | ------------------------ |
| Windows + Shift + C | Windows + Shift + M | Windows + Ctrl + T | Windows + Alt + P        |

### Row 3

| Snipping Tool       | Export to PNG  | Open w/Inkscape     | Video On/Off        |
| ------------------- | -------------- | ------------------- | ------------------- |
| Windows + Shift + S | F17            | F18                 | Windows + Shift + O |
|                     | Magick command | Inkscape.exe [file] |                     |

### Row 4

| Volume Down | Volume Up | Mute/Unmute Mic     | Switch Audio Input |
| ----------- | --------- | ------------------- | ------------------ |
| KC_VOLD     | KC_VOLU   | Windows + Shift + A | F19                |
|             |           |                     |                    |

## Commands

### Convert C code to JSON:

qmk c2json -km=1upkeyboards/sweet16/v1/keymaps/ivan -kb=1upkeyboards/sweet16/v1 -o ./keymap.json keymap.c

## Instructions

- With ***QMK MSYS***, use the *keymap.json* to generate the HEX file that's to be flashed the macropad. 
  - Once you have the HEX file, use ***QMK Toolbox*** with the macropad connected and hit the Reset switch on the macropad.
  - You'll notice with QMK Toolbox that it's flashing based on the output.