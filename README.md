# hxColorToolkit

[![Build Status](https://travis-ci.org/andyli/hxColorToolkit.svg?branch=master)](https://travis-ci.org/andyli/hxColorToolkit)

A Haxe library for color conversion and color scheme generation. 

It is based on [colortoolkit](http://code.google.com/p/colortoolkit/) with lots of bug fixs and enhancements.

## Usage

Install it from haxelib: `haxelib install hxColorToolkit`

```haxe
using hxColorToolkit.ColorToolkit;

var hexColor = 0x112233.toHex();
trace(hexColor.red); //0x11
trace(hexColor.green); //0x22
trace(hexColor.blue); //0x33

var hslColor = new hxColorToolkit.spaces.HSL(0, 100, 50); //construct a color in HSL space
trace(hslColor.getColor()); //0xFF0000 the hex color value
```

## Color spaces

They can be found inside the package `hxColorToolkit.spaces`. All of them implement the interface `hxColorToolkit.spaces.Color`.

* `CMYK` 4-channel [CMYK](http://en.wikipedia.org/wiki/CMYK_color_model) color space with each channel in [0,100].
* `Gray` A single channel gray-scale color in [0,255]. Any color given will be converted to gray-scale.
* `Hex` A simple wrapper of color value in hex(eg. `0xFFFFCCCC`). Its `alpha`, `red`, `green`, `blue` extract the corresponding value to `Int`.
* `HSB` 3-channel [HSB](http://en.wikipedia.org/wiki/HSL_and_HSV) color space with ranges [0,360), [0,100], [0,100].
* `HSL` 3-channel [HSL](http://en.wikipedia.org/wiki/HSL_and_HSV) color space with ranges [0,360), [0,100], [0,100].
* `Lab` 3-channel [Lab](http://en.wikipedia.org/wiki/Lab_color_space) color space with ranges [0,100], [-128,127], [-128,127].
* `RGB` Normal 3-channel [RGB](http://en.wikipedia.org/wiki/RGB_color_space) color space with each channel in [0,255]. Unlike `Hex`, its properties(`red`, `green`, `blue`) are stored as `Float` for precise calculation.
* `ARGB` 4-channel ARGB color space with each channel in [0,255]. It is a sub-class of `RGB` with an additional `alpha` value that defaults to 255.
* `XYZ` 3-channel [XYZ](http://en.wikipedia.org/wiki/CIE_1931_color_space) color space with ranges [0,95.047], [0,100], [0,108.883].
* `YUV` 3-channel [YUV](http://en.wikipedia.org/wiki/YUV) color space with each channel in [0,255].

All channel values are clamped to their possible min/max, except hue values of `HSB` and `HSL` are looped inside 0-360 (`color.hue = -10; trace(color.hue); //350`).

## Color schemes

Color scheme is basically a set of colors, constructed according to [color theory](http://en.wikipedia.org/wiki/Color_theory).

The classes can be found inside the package `hxColorToolkit.schemes`. All of them implement the interface `hxColorToolkit.schemes.ColorScheme`.

* `Analogous`
* `Complementary`
* `Compound`
* `FlippedCompound`
* `Monochrome`
* `SplitComplementary`
* `Tetrad`
* `Triad`

## License

### hxColorToolkit

```
The MIT License

Copyright (c) 2010-2016 Andy Li http://www.onthewings.net/

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

### colortoolkit

```
The MIT License

Copyright (c) 2009 P.J. Onori (pj@somerandomdude.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
