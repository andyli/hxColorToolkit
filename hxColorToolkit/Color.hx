 /*
Author: Andy Li (andy@onthewings.net)
Based on colortoolkit (http://code.google.com/p/colortoolkit/)
 
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
*/

package hxColorToolkit;

import hxColorToolkit.schemes.Analogous;
import hxColorToolkit.schemes.ColorList;
import hxColorToolkit.schemes.Complementary;
import hxColorToolkit.schemes.Compound;
import hxColorToolkit.schemes.FlippedCompound;
import hxColorToolkit.schemes.Monochrome;
import hxColorToolkit.schemes.SplitComplementary;
import hxColorToolkit.schemes.Tetrad;
import hxColorToolkit.schemes.Triad;
import hxColorToolkit.spaces.CMYK;
import hxColorToolkit.spaces.Gray;
import hxColorToolkit.spaces.HSB;
import hxColorToolkit.spaces.HSL;
import hxColorToolkit.spaces.Lab;
import hxColorToolkit.spaces.RGB;
import hxColorToolkit.spaces.XYZ;
import hxColorToolkit.spaces.YUV;
import hxColorToolkit.spaces.IColor;

class Color implements IColor {
	private var _color:Int;
	public var color(getColor, setColor) : Int;
	inline private function getColor():Int{ return _color; }
	inline private function setColor(value:Int):Int{
		_color=value;
		return value;
	}
	
	/**
	 * @param color Hexidecimal color value
	 */		
	public function new(_color:Int)
	{	
		color=_color;
	}

	inline public function toLab():Lab
	{
		var lab:Lab = new Lab();
		lab.color=_color;
		return lab;
	}
	
	inline public function toGray():Gray
	{
		var g:Gray = new Gray();
		g.convertHexToGrayscale(_color);
		return g;
	}
	
	inline public function toRGB():RGB
	{
		var rgb:RGB = new RGB();
		rgb.color = this._color;
		return rgb;
	}
	
	inline public function toHSB():HSB
	{
		var hsb:HSB = new HSB();
		hsb.color = this._color;
		return hsb;
	}
	
	inline public function toHSL():HSL
	{
		var h:HSL = new HSL();
		h.color=this._color;
		return h;
	}
	
	inline public function toCMYK():CMYK
	{
		var cmyk:CMYK = new CMYK();
		cmyk.color = this._color;
		return cmyk;
	}
	
	inline public function toXYZ():XYZ
	{
		var xyz:XYZ = new XYZ();
		xyz.color = this._color;
		return xyz;
	}
	
	inline public function toYUV():YUV
	{
		var yuv:YUV = new YUV();
		yuv.color = this._color;
		return yuv;
	}

	inline public function getAnalogousScheme(?angle:Float=10, ?contrast:Float=25):Analogous<Color> {
		return new Analogous<Color>(this,angle,contrast);
	}

	inline public function getComplementaryScheme():Complementary<Color> {
		return new Complementary<Color>(this);
	}

	inline public function getCompoundScheme():Compound<Color> {
		return new Compound<Color>(this);
	}

	inline public function getFlippedCompoundScheme():FlippedCompound<Color> {
		return new FlippedCompound<Color>(this);
	}

	inline public function getMonochromeScheme():Monochrome<Color> {
		return new Monochrome<Color>(this);
	}

	inline public function getSplitComplementaryScheme():SplitComplementary<Color> {
		return new SplitComplementary<Color>(this);
	}

	inline public function getTetradScheme(?angle:Float=90):Tetrad<Color> {
		return new Tetrad<Color>(this,angle);
	}

	inline public function getTriadScheme(?angle:Float=120):Triad<Color> {
		return new Triad<Color>(this,angle);
	}

	public function clone():IColor {
		return new Color(color);
	}
}
