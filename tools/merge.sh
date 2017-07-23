#!/bin/bash

############################################################
# Usage:
#   ./merge.sh DIRECTORY
#
# Where:
#   DIRECTORY - path to a folder where all images to be
#        blended are at.
#
# More info on command: http://www.imagemagick.org/Usage/compose/#lighten
#
# @beco – April 30, 2017
############################################################

type convert >/dev/null 2>&1 || {
  echo >&2 "I require convert but it's not installed.
  Check http://www.imagemagick.org/ for distributions.
  Aborting.";
  exit 1;
}
t=$(date +"%s")
mode="Lighten_Intensity"

pushd $1 > /dev/null
files=`ls *jpg`
i=0
for f in $files; do
  if ((i == 0)); then
    mv $f tmp.jpg
  else
    convert tmp.jpg $f -compose $mode -composite tmp.jpg
    past="tmp.jpg"
  fi
  i=$(($i + 1))
done
mv tmp.jpg output.jpg
popd > /dev/null
t=$((`date +"%s"` - $t ))
echo "Just merged $i photos in $t seconds"
echo "Queovo, photoshop?"
