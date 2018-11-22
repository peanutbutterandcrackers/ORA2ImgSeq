# ORA2ImgSeq
Extract an Image Sequence out of an Open Raster file (with some custumizations)

Usage:
```
$ ./ora2imgseq.sh -i infile.ora [OPTION]...

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
```
