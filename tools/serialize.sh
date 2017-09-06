#!/bin/bash

############################################################
# Usage:
#   ./serialize.sh [options]
#
# Where:
#   DIRECTORY - path to a folder where all images to be
#        blended are at.
#   OPTIONS –
#        -d directory – directory from where all the JPGs will be signed*
#        -t "text" – text to be watermarked
#        -c "code" – code to be used for the series
#        -i N – number where de serialize will start, if ommited, will start
#               at 1
#        -r N – size of largest side
#   OUTPUT
#        A directory under directory/signed will be created an all resulting
#        images will be stored.
#
#   EXAMPLE
#     > serialize.sh -d images -c "EX" -t "Alberto Alcocer for Panamericana" -i 120
#     will output signed images with the text
#     "Alberto Alcocer for Panamericana | code:EX0016"
#
#  If having problems with fonts, check https://stackoverflow.com/questions/24696433/why-font-list-is-empty-for-imagemagick
#
# @beco – July 20, 2017
############################################################

type convert >/dev/null 2>&1 || {
  echo >&2 "I require convert but it's not installed.
  Check http://www.imagemagick.org/ for distributions.
  Aborting.";
  exit 1;
}
t=$(date +"%s")

START=1
SIZE=600

while getopts ":t:c:i:d:r:" opt; do
  case $opt in
    c)
      CODE=$OPTARG
      ;;
    t)
      SIGN=$OPTARG
      ;;
    i)
      START=$OPTARG
      ;;
    d)
      DIR=$OPTARG
      ;;
    r)
      SIZE=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

TOTAL=`ls -l $DIR/*jpg | wc -l`

if [ ! -d $DIR ]
then
  echo "No such directory $DIR"
  exit 1
fi

printf -v SIG_BASE "   %s | code: %%s" "$SIGN"
printf "Signing %d images at $DIR:\n" $TOTAL

if [ ! -d $DIR/signed ]; then
  mkdir $DIR/signed
fi

printf "saving results in %s/signed\n" "$DIR"
i=$START
S=${#SIG_BASE}

pushd $DIR > /dev/null
printf -v SIZE "%sx%s" $SIZE $SIZE
SEP="_"
for f in *jpg; do
  D=`identify $f`
  W=`echo $D | sed 's/.* \([0-9]\{2,5\}\)x\([0-9]\{2,5\}\) .*/\1/'`
  H=`echo $D | sed 's/.* \([0-9]\{2,5\}\)x\([0-9]\{2,5\}\) .*/\2/'`
  B=$(($W > $H? $W:$H))
  P=$(((100/72)*($B/$S)))
  printf -v CODE_P "%s%04d" "$CODE" "$i"
  printf -v SIGN_P "$SIG_BASE" "$CODE_P"
  printf -v RES_FILE "signed/%s%s%s" "$CODE_P" "$SEP" "$f"
  convert $f -font Arial -pointsize $P \
          -draw "gravity southwest \
                 fill black text 0,12 '$SIGN_P' \
                 fill white text 1,11 '$SIGN_P' " \
          -resize $SIZE\> $RES_FILE
  echo " - $f: signed"
  i=$(($i + 1))
done

popd > /dev/null
