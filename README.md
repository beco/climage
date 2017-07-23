# ClImage toolset
A toolset to work with images from CLI

## Tools

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

This wrapper works over the ImageMagick limitations of being able to sum _only_ two images at a time.

### `serialize`

#### use case
You have a big stock of images that you need to upload, so you need to watermark them and want to be able to refer to each one uniquely by your clients. This script allows you to uniquely and sequentially sign (watermark) your images with a code and increasing numbers, resulting watermark will be a text at the bottom left corner like:

> Alberto Alcocer for ComiCon | code: cc0371


#### usage

```
$> bash serialize.sh -d /path/to/originals \
  -c series_code \
  -t "text to sign with" -i N
```

Where flags are:
- `t` – text to be signed with in the photo
- `i` - starting number for the series
- `d` - directory hosting the **original** files, images there won't be modified, but a new directory `./signed` will be created
- `c` - code for the series

**All flags are mandatory.**

original|processed
:-------|:----|
![](http://b3co.com/wp-content/uploads/2017/07/IMG_9336.jpg) | ![](http://b3co.com/wp-content/uploads/2017/07/b3co-0136_IMG_9336.jpg)
filename: path/`IMG_9336.jpg` | filename: path/`signed/b3co-0136_IMG_9336.jpg`
|**note** that the resulting filename is formed by s\_`number`\_`original_filename`

## Dependencies

This toolset only wraps some commands from the [imagemagick](http://imagemagick.org) toolset, so it is totally worthless without it (`convert` and `identify` are the main commands), so it is **absolutely required** to have installed this package.

### installation
