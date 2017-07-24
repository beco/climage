# ClImage toolset
A toolset to work with images from CLI

## Tools

### `serialize`

#### use case
You have a big stock of images that you need to upload, so you need to **watermark them** and want to be able to **refer to each one uniquely** by your clients. This script allows you to uniquely and sequentially sign (watermark) as many images as you want with a _code_ and increasing numbers, with just **one command**. So for instance,

`$> serialize.sh -t "Alberto Alcocer for ComiCon" -c "cc" -i 300 -d images/`

would taka **all** the `jpg` files from `images/` and add a watermark in the bottom-left part of each image with something like:

> Alberto Alcocer for ComiCon | code: cc0371

Note that the part which says `code: cc0371` will say `code: cc0372` for the **next** image.


#### usage

```
$> bash serialize.sh -d /path/to/originals \
  -c series_code \
  -t "text to sign with" -i N
```

Where flags are:
- `t`: text to be signed with in the photo
- `i`: starting number for the series
- `d`: directory hosting the **original** files, images there won't be modified, but a new directory `./signed` will be created
- `c`: code for the series

**All flags are mandatory.**

Resulting images will have the **same dimensions** as the original files.

original|processed
:-------|:----|
![](http://b3co.com/wp-content/uploads/2017/07/IMG_9336.jpg) | ![](http://b3co.com/wp-content/uploads/2017/07/b3co-0136_IMG_9336.jpg)
filename: path/`IMG_9336.jpg` | filename: path/`signed/b3co-0136_IMG_9336.jpg`
**note** that the resulting filename is formed by `code`\_`original_filename`

All signed images will be stored in a subdirectory (to the `-d` directory) called `signed/`, this way you can grab all signed or not signed images at once without any trouble.

```
images/
|--signed/
|   |-- code0001_IMG_271.jpg
|   +-- code0002_IMG_396.jpg
|
|-- IMG_271.jpg
+-- IMG_396.jpg
```

### `merge`

#### use case
You have just taken a big amount of pictures in the highest possible quality, and you want to merge them by adding **only** the lighten sections,

##### option 1 – Photoshop (👎)

You can add each and every image as a layer and then flatten them using the _Lighten merge_.
- **PROS**: is what the industry uses
- **CONS**: with more than 5 images you need a supercomputer to just open it, and between opening and rendering may take a whole night

##### option 2 – `mege.sh` (👍)

You put the images in a specific directory and run `merge.sh`.
- **CONS**: it is not what the industry uses
- **PROS**: it takes about 20s to run over 120 26MP images #ftw #fuckPhotoshop

So, this process converts this 12 images (it may not be visible, but the stars are in different position in each photo, trust me in this one and then jump to the output after the table):

| | | | |
|-|-|-|-|
|![](http://b3co.com/wp-content/uploads/2017/07/IMG_9772.jpg)|![](http://b3co.com/wp-content/uploads/2017/07/IMG_9773.jpg)|![](http://b3co.com/wp-content/uploads/2017/07/IMG_9774.jpg)|![](http://b3co.com/wp-content/uploads/2017/07/IMG_9775.jpg)
|![](http://b3co.com/wp-content/uploads/2017/07/IMG_9776.jpg)|![](http://b3co.com/wp-content/uploads/2017/07/IMG_9777.jpg)|![](http://b3co.com/wp-content/uploads/2017/07/IMG_9778.jpg)|![](http://b3co.com/wp-content/uploads/2017/07/IMG_9779.jpg)
|![](http://b3co.com/wp-content/uploads/2017/07/IMG_9780.jpg)|![](http://b3co.com/wp-content/uploads/2017/07/IMG_9781.jpg)|![](http://b3co.com/wp-content/uploads/2017/07/IMG_9782.jpg)|![](http://b3co.com/wp-content/uploads/2017/07/IMG_9782.jpg)

Into:
![](http://b3co.com/wp-content/uploads/2017/07/output.jpg)


This wrapper works over the ImageMagick limitations of being able to sum _only_ two images at a time.

#### usage

`$> merge.sh DIR`

Where `DIR` is the path to the directory containing all images to merge. Resulting single image will be stored in `$DIR`/`output.jpg`

## Project Dependencies

This toolset only wraps some commands from the [imagemagick](http://imagemagick.org) toolset, so it is totally worthless without it (`convert` and `identify` are the main commands), so it is **absolutely required** to have installed this package.
