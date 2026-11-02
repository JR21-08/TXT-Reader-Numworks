# TXT Reader for NumWorks

A TXT reader for the NumWorks calculator. This cleaned source version starts
straight in the reader; the periodic-table launcher, shortcut settings, and
associated unused assets have been removed.

## Install

1. Build the application using the NumWorks EADK toolchain (`make build`).
2. The generated application is `output/build/app_stripped.nwa`.
3. Upload the `.nwa` file and the `.txt` file to the calculator using
   <https://my.numworks.com/apps>.

## Controls

- Home: quit the application
- Up / Down: scroll one line
- Left / Right: scroll ten lines
- Type on the calculator keyboard: search in the text
- EXE: next search result
- Ans: previous search result
- Shift / Alpha: switch keyboard character modes

## Source

The reader's display, scrolling, and search logic is in `src/main.c`;
keyboard character mapping is in `src/keyboard.c` and `src/keyboard.h`.
