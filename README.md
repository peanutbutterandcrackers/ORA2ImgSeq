# ORA2ImgSeq
Extract an Image Sequence out of an Open Raster file (with some customizations)

**Usage:**
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

## Use Cases:
This script was created because [OpenShot](https://www.openshot.org/) does not yet support GIFs (or WebPs).
However, it does support Image Sequences. Using this script, one can:
1. Open up a GIF (or a WebP) in [GIMP](https://www.gimp.org/)
2. Export it as an [Open Raster](https://en.wikipedia.org/wiki/OpenRaster) File by going to `File` > `Export As` > `asdf.ora`
3. And then use this script to generate image sequences in the desired frame-rate for input stream, and whatever frame-rate the current [OpenShot Profile](https://www.openshot.org/static/files/user-guide/profiles.html) dictates them to have for the output stream
4. And import the resulting Image Sequence into OpenShot (by answering `Yes` to the prompt to import the images as an Image Sequence when the first image of the sequence is being imported)

In Theory, this whole process is entirely lossless (because [PNG](https://en.wikipedia.org/wiki/Portable_Network_Graphics)s).
