#!/bin/bash

#
# 05/jan/2016
#
# Igor Kelvin
# igorkelvin@gmail.com
# https://github.com/igorkelvin
#
# Small script to download and read 'man' pages as pdf.
# It is not much fail-safe and was designed for my own use, so it
# don't include options at all. Feel free to copy and modify as
# you with.
#
# Two things you may want to change if you want to use this:
# 1- 'LOCATION' variable to your desired save location.
# 2- 'PDF_VIEWER' variable to your favorite pdf viewer program,
#    or comment it if you just want to download.
#

if [[ $# -eq 0 || $# -gt 1 ]]; then
    echo    "Usage: "
    echo -e "  bash /path/to/man2pdf.sh 'manual_entry'"
    exit 1
fi

PDF_VIEWER="evince"
LOCATION="$HOME/Documents/man/"
OUTPUT="${LOCATION}$1.pdf"
TMP_FILE="__$1_tmp.ps"

if [ ! -d $LOCATION ]; then
  mkdir -p $LOCATION
fi

if [ -e $OUTPUT ]; then
  echo "Opening $OUTPUT"
  $PDF_VIEWER $OUTPUT
else
  man -t $1 > $TMP_FILE
  if [[ -e $TMP_FILE && -s $TMP_FILE ]]; then
    ps2pdf $TMP_FILE $OUTPUT
    rm $TMP_FILE
    echo "Opening $OUTPUT"
    $PDF_VIEWER $OUTPUT
  else
    echo "Failed"
    rm $TMP_FILE
    exit 1
  fi
fi
