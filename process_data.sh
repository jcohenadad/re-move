#!/bin/bash
# Loop over all .nii.gz files in a directory and run a command on each
input_dir="${1:-.}"     # first argument, or the current directory if none is given
shopt -s nullglob       # skip the loop if there are no matches
for file in "$input_dir"/*.nii.gz; do
  base=$(basename "$file" .nii.gz)   # e.g. sub-01_T1w
  echo "Processing $base"
  sct_deepseg spinalcord -i "$file" -qc qc
  sct_deepseg spine -i "$file" -label-vert 1 -qc qc
  sct_deepseg rootlets -i "$file" -qc qc
done
