[![CD](https://github.com/humbertodias/pallete-generator/actions/workflows/cd.yml/badge.svg)](https://github.com/humbertodias/pallete-generator/actions/workflows/cd.yml)
[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/humbertodias/pallete-generator)
![GitHub all downloads](https://img.shields.io/github/downloads/humbertodias/pallete-generator/total)

# Palette Generator

This is an independent tool for generating palette files for the HAMOOPI fighting game engine.

## Building

### Requirements

**For SDL2 version (default):**
- CMake 3.10 or higher
- SDL2
- SDL2_image

### Build Instructions

**SDL2 version (default):**
```bash
make build
```

The executable `PALLETEGEN` will be created 

## Usage

1. Run the application:
   ```bash
   ./PALLETEGEN
   ```

2. Place your palette source images (pal0-pal8) in the `data/` directory as PNG files

3. Press **F1** to generate a new palette from the source images

4. Press **ESC** to exit

5. Press **Alt+Enter** to toggle fullscreen mode

## Input Files

The tool expects the following image files in the `data/` directory:

**SDL2 version:** Uses PNG format
- `pal0.png` through `pal8.png` - Source palette images

Each slot represents a color button:
- pal0: Light Punch (LP)
- pal1: Medium Punch (MP)
- pal2: Hard Punch (HP)
- pal3: Light Kick (LK)
- pal4: Medium Kick (MK)
- pal5: Hard Kick (HK)
- pal6: SELECT button
- pal7: START button
- pal8: HOLD button

## Output Files

The tool generates:
- `data/pallete.png` (SDL2 version) - The final compiled palette containing colors from all slots

## Technical Notes

- The SDL2 version uses hardware-accelerated rendering
- All image operations are done in 32-bit ARGB format
- The tool preserves the original Allegro-style API internally for easy conversion
- Magenta (255, 0, 255) is used as the transparent color key
