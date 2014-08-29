#!/bin/sh
#
# Use GIMP batch mode to convert xcf files to any output image GIMP supports
#
# Usage:
#   xcf2img.sh infile outfile
#
# If outfile not supplied, will save to png by default

infile="$1"
outfile="$2"

if [ -z "$outfile" ]; then
    outfile="`dirname "$infile"`/`basename "$infile" .xcf`.png"
fi

gimp -n -i -b - <<EOF

(let* (
      (image (car (gimp-file-load RUN-NONINTERACTIVE "$infile" "$infile")))
      (layer (car (gimp-image-merge-visible-layers image CLIP-TO-IMAGE)))
      )
  (gimp-file-save RUN-NONINTERACTIVE image layer "$outfile" "$outfile")
  (gimp-quit 0)
  )

EOF
