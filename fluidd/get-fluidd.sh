#!/bin/bash

wget $(curl -s https://api.github.com/repositories/295836951/releases/latest | grep browser_download_url | cut -d'"' -f4)
unzip -o *.zip -d html  && printf "\nDone!\n\n"