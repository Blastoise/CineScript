![CineScript](https://socialify.git.ci/Blastoise/CineScript/image?description=1&descriptionEditable=CLI%20tool%20for%20streaming%2Fdownloading%20content.&font=Raleway&issues=1&language=1&owner=1&pattern=Signal&pulls=1&stargazers=1&theme=Dark)

# CineScript

[![forthebadge](https://forthebadge.com/images/badges/open-source.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/built-with-swag.svg)](https://forthebadge.com)
[![Bash Shell](https://img.shields.io/static/v1?label=MADE%20WITH&message=BASH&color=red&style=for-the-badge&logo=gnu-bash)](https://shields.io/)

CineScript is one stop solution for downloading/streaming content. It provides TUI(Terminal User Interface) which is completely written in bash. Currently, CineScript supports Linux, MacOS and WSL.

## ✨ Features

- 🎵 Download audio from Youtube Video.
- ▶️ Download Youtube Video
- 🎞️ Download Movie
- 📽️ Stream Movie
- 🎬 Download TV Series
- 🍿 Stream TV Series
- 📟 Interactive Terminal Interface which consists of:
  - Single Select Menu
  - Multi Select Menu
- 📺 Supports many Media Players
- ⟳ Automatic updates￻￻
- 🚀 Available for Linux, MacOS and WSL
- 🛠️ More features in development.

## Dependencies

- [NodeJS](https://nodejs.org/en/download/)
- [@ashutosh1729/web-torrent-cli](https://www.npmjs.com/package/@ashutosh1729/web-torrent-cli)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- [jq](https://github.com/stedolan/jq)
- [cURL](https://curl.se/)
- Any one of the following media players:
  - Apple TV
  - Google ChromeCast
  - DNLA
  - MPlayer
  - MPV
  - Celluloid
  - OMX
  - VLC
  - IINA
  - SMPlayer
  - XBMC

## Setup Instructions

- If you're a WSL user, you can use the following command and skip this section:

      curl -s 'https://gist.githubusercontent.com/Blastoise/c94b90b09ad3c4e9341ea7cc63eb3c81/raw/a7c79c6713ddb0ed329f7572324ae67d3133e170/cine-install.sh' | sudo bash

- First download and install **Node.js** and **npm**
- Then install **@ashutosh1729/web-torrent-cli** npm package globally using the following command:

        sudo npm i @ashutosh1729/web-torrent-cli -g

- Install **cuRL** and **jq** using your package manager(here assuming **Debian/Ubuntu**):

  1.  Installing cURL:

            sudo apt-get install curl

  2.  Installing jq:

            sudo apt-get install jq

- Then install **yt-dlp** using the following commands:

        sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
        sudo chmod a+rx /usr/local/bin/yt-dlp

- Then download **cine-script** file and move it to **_~/.local/bin_** with execute permission. To do so use the following command:

        curl -s 'https://raw.githubusercontent.com/Blastoise/CineScript/master/cine-script' -o ~/.local/bin/cine-script
        chmod +x ~/.local/bin/cine-script

## Usage

Using the script is fairly simple, just type the following command:

    cine-script

To update the script explicitly:

    cine-script -u

To set your favourite media player(Default is vlc):

    cine-script -p vlc

To see the complete usage of the script:

    cine-script -h

## 🤝 Contribute [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat)](http://makeapullrequest.com)

If you are interested in participating in joint development, PR and Forks are welcome!

## 📜 License

[GNU GENERAL PUBLIC LICENSE](LICENSE) Copyright (c) 2022 Ashutosh Kumar
