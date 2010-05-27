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

/*
import hxColorToolkit.schemes.Analogous;
import hxColorToolkit.schemes.ColorList;
import hxColorToolkit.schemes.Complementary;
import hxColorToolkit.schemes.Compound;
import hxColorToolkit.schemes.FlippedCompound;
import hxColorToolkit.schemes.Monochrome;
import hxColorToolkit.schemes.SplitComplementary;
import hxColorToolkit.schemes.Tetrad;
import hxColorToolkit.schemes.Triad;
*/

import hxColorToolkit.spaces.IColor;
import hxColorToolkit.spaces.CMYK;
import hxColorToolkit.spaces.Gray;
import hxColorToolkit.spaces.HSB;
import hxColorToolkit.spaces.HSL;
import hxColorToolkit.spaces.Lab;
import hxColorToolkit.spaces.RGB;
import hxColorToolkit.spaces.XYZ;
import hxColorToolkit.spaces.YUV;

class ColorToolkit {	
	static private var rybWheel: Array<Array<Int>> = [[0, 0], [15, 8], [30, 17], [45, 26], [60, 34], [75, 41], [90, 48], [105, 54], [120, 60], [135, 81], [150, 103], [165, 123], [180, 138], [195, 155], [210, 171], [225, 187], [240, 204], [255, 219], [270, 234], [285, 251], [300, 267], [315, 282], [330, 298], [345, 329], [360, 0]];
	
	inline public static function setColorOpaque(color:Int):Int { return 0xff000000 | (color & 0xffffff); }
	
	inline public static function desaturate(color:Int):Int { return toGray(color).getColor(); }

	inline public static function getComplement(color:Int):Int { return rybRotate(color, 180); }
	
	public static function shiftBrighteness(color:Int, degree:Float):Int 
	{
		var col:HSB = new HSB();
		col.setColor(color);
		
		col.brightness+=degree;
		
		return col.getColor();
	}
	
	public static function shiftSaturation(color:Int, degree:Float):Int
	{
		var col:HSB = new HSB();
		col.setColor(color);
		
		col.saturation+=degree;
		
		return col.getColor();
	}
	
	public static function shiftHue(color:Int, degree:Float):Int
	{
		var col:HSB = new HSB();
		col.setColor(color);
		
		col.hue+=degree;
		
		return col.getColor();
	}
	
	inline static public function toLab(color:Int):Lab
	{
		var lab:Lab = new Lab();
		lab.setColor(color);
		return lab;
	}
	
	inline static public function toGray(color:Int):Gray
	{
		var g:Gray = new Gray();
		g.setColor(color);
		return g;
	}
	
	inline static public function toRGB(color:Int):RGB
	{
		var rgb:RGB = new RGB();
		rgb.setColor(color);
		return rgb;
	}
	
	inline static public function toHSB(color:Int):HSB
	{
		var hsb:HSB = new HSB();
		hsb.setColor(color);
		return hsb;
	}
	
	inline static public function toHSL(color:Int):HSL
	{
		var h:HSL = new HSL();
		h.setColor(color);
		return h;
	}
	
	inline static public function toCMYK(color:Int):CMYK
	{
		var cmyk:CMYK = new CMYK();
		cmyk.setColor(color);
		return cmyk;
	}
	
	inline static public function toXYZ(color:Int):XYZ
	{
		var xyz:XYZ = new XYZ();
		xyz.setColor(color);
		return xyz;
	}
	
	inline static public function toYUV(color:Int):YUV
	{
		var yuv:YUV = new YUV();
		yuv.setColor(color);
		return yuv;
	}
/*
	inline static public function getAnalogousScheme(color:Int, ?angle:Float=10, ?contrast:Float=25):Array<Int> {
		return new Analogous<Color>(new Color(color),angle,contrast).getColors().toIntArray();
	}

	inline static public function getComplementaryScheme(color:Int):Array<Int> {
		return new Complementary<Color>(new Color(color)).getColors().toIntArray();
	}

	inline static public function getCompoundScheme(color:Int):Array<Int> {
		return new Compound<Color>(new Color(color)).getColors().toIntArray();
	}

	inline static public function getFlippedCompoundScheme(color:Int):Array<Int> {
		return new FlippedCompound<Color>(new Color(color)).getColors().toIntArray();
	}

	inline static public function getMonochromeScheme(color:Int):Array<Int> {
		return new Monochrome<Color>(new Color(color)).getColors().toIntArray();
	}

	inline static public function getSplitComplementaryScheme(color:Int):Array<Int> {
		return new SplitComplementary<Color>(new Color(color)).getColors().toIntArray();
	}

	inline static public function getTetradScheme(color:Int, ?angle:Float=90):Array<Int> {
		return new Tetrad<Color>(new Color(color),angle).getColors().toIntArray();
	}

	inline static public function getTriadScheme(color:Int, ?angle:Float=120):Array<Int> {
		return new Triad<Color>(new Color(color),angle).getColors().toIntArray();
	}
	
	*/
	public static function rybRotate(color:Int, angle:Float):Int 
	{			
		var hsb:HSB = new HSB();
		hsb.setColor(color);
		
		var a: Float = 0;
		for (i in 0...rybWheel.length) {
			var x0: Int = rybWheel[i][0];
			var y0: Int = rybWheel[i][1];
       
			var x1: Int = rybWheel[i + 1][0];
			var y1: Int = rybWheel[i + 1][1];
			if(y1 < y0)  y1 += 360;
			if(y0 <= hsb.hue && hsb.hue <= y1) {
				a = 1.0 * x0 + (x1 - x0) * (hsb.hue - y0) / (y1 - y0);
				break;
			}
		}
		
		a = (a + (angle % 360));
		if(a < 0)  a = 360 + a;
		if (a > 360)  a = a - 360;
		a = a % 360;
		
		var newHue: Float = 0;
		for (k in 0...rybWheel.length) {
			var xx0: Int = rybWheel[k][0];
			var yy0: Int = rybWheel[k][1];
       
			var xx1: Int = rybWheel[k + 1][0];
			var yy1: Int = rybWheel[k + 1][1];
			if (yy1 < yy0) yy1 += 360;
			if (xx0 <= a && a <= xx1) {
				newHue = 1.0 * yy0 + (yy1 - yy0) * (a - xx0) / (xx1 - xx0);
				break;
			}
		}
		newHue = newHue % 360;
		hsb.hue=newHue;
		
		return hsb.getColor();
	}	
}
