#!/bin/bash

SCRIPT_NAME=$(basename $0)
DATE=$(date | tr ' ' _)
TEMP_DIR=$(mktemp -d /tmp/${SCRIPT_NAME%%.*}.$$.XXXXX)
IMG_SEQ_DIR="Image-Sequence-${DATE}"

# DEFAULT VALUES 
REVERSE=False
IFR=10 # INPUT FRAME RATE
OFR=30 # OUTPUT FRAME RATE

usage () {
	cat <<- _EOF_
	Usage: $SCRIPT_NAME -i infile.ora [OPTION]...

	    -i infile.ora, --input infile.ora
	
	    -o DIR, --output DIR
	        Set the ouput directory to DIR (default is the directory containing the Open Raster file)

	    -ifr N, --input-frame-rate N
	        Set the input frame rate to N (default is 10)

	    -ofr N, --output-frame-rate N
	        Set the output frame rate to N (default is 30)

	    -r, --reverse
	        Reverse the Image Stream

	    -h, --help
	        Display this help and exit

	_EOF_
}

if [[ -z "$1" ]]; then
	usage >&2
	exit 1
fi

while [[ -n $1 ]]; do
	case $1 in
		-h | --help )		usage
					exit
					;;
		-i | --input )		shift
					ORA=$1 # The Open Raster Archive file
					;;
		-r | --reverse )	REVERSE=True
					;;
		-ifr | --input-frame-rate )	shift
						IFR=$1
						;;
		-ofr | --output-frame-rate )	shift
						OFR=$1
						;;
		-o | --output )		shift
					OUTPUT_DIR=$1
					;;
		* )			usage >&2
					exit 1
					;;
	esac
	shift
done

if [[ -z "$OUTPUT_DIR" ]]; then
	OUTPUT_DIR=$(dirname "$ORA") # If output directory isn't specified, output to the same directory as the ora
fi

OUTPUT_PATH=$OUTPUT_DIR/$IMG_SEQ_DIR
mkdir -p "$OUTPUT_PATH"

unzip -j "$ORA" 'data/*.png' -d "$TEMP_DIR"
cd "$TEMP_DIR"

if [[ $REVERSE == "True" ]]; then 
	cat $(ls -r) | ffmpeg -f image2pipe -framerate $IFR -i - -r $OFR "$OUTPUT_PATH"/Image-%05d.png
else
	ffmpeg -framerate $IFR -pattern_type glob -i '*.png' -r $OFR "$OUTPUT_PATH"/Image-%05d.png
fi

echo "Done! The Image Sequence has been exported to: $OUTPUT_DIR"
