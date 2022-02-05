#!/bin/bash
cat ./test.txt || yay -Syu --noconfirm && reboot
cat ./test.txt >> lot.txt
