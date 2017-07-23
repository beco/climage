# ClImage toolset
A toolset to work with images from CLI

## Tools

### `merge`

### `serialize`

#### use case
Imagine you have a big stock of images that you need to upload, so you need to watermark them and want to be able to refer to each one uniquely by your clients. This script allows you to uniquely and sequentially sign (watermark) your images with a code and increasing numbers, resulting watermark will be a text at the bottom left corner like:
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

## Dependencies

This toolset only wraps some commands from the [imagemagick](http://imagemagick.org) toolset, so it is totally worthless without it (specially `convert` and `identify` commands), so it is **absolutely required** to have installed this package.

### installation
