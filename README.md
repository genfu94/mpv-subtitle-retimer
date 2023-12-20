# MPV Subtitle Retimer

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

A Lua script for the **mpv** media player designed to quickly retime subtitles.

Forked from [douglasrocha/lua-subtitles](https://github.com/douglasrocha/lua-subtitles).

## Features

- Quickly adjust the timing of delayed subtitles starting from a specific point in the video.
- Invoke the script in mpv with the designated hotkey (default: `Ctrl + R`) to shift subtitles back, ensuring the next subtitle matches the current time. Previous subtitles will remain unaltered.

## Installation

1. Copy the contents of the `src` folder to your mpv scripts directory under a folder named `subretimer`.

   Example in a Linux environment:
    ```
    |-- ~/.config/mpv/scripts/subretimer
    |   |-- file.lua
    |   |-- main.lua
    |   |-- regex.lua
    |   |-- subtitle.lua
    |   |-- time.lua
    ```

2. Add the key binding to the config file (`input.conf`) located inside your mpv scripts directory. Example
    ```
    [...]
    Ctrl+r  script-binding subretimer-apply
    [...]
    ```


## Usage

1. Play a video in mpv.
2. Press the designated hotkey (default: `Ctrl + R`) to retime subtitles. The original .srt file will be overwritten with the new timing.

## Notes

1. The script currently supports only .srt files and will not work with other subtitle formats (such as .ass).
2. The .srt file opened in the video needs to be external and not embedded in the video file (such as .mkv files).

