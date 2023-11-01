#!/bin/sh

while true; do
    vim-startuptime -vimpath nvim | head -n 30
    sleep 1
done
