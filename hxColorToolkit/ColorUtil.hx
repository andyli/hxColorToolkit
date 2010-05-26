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

import hxColorToolkit.spaces.IColor;
import hxColorToolkit.spaces.CMYK;
import hxColorToolkit.spaces.Gray;
import hxColorToolkit.spaces.HSB;
import hxColorToolkit.spaces.HSL;
import hxColorToolkit.spaces.Lab;
import hxColorToolkit.spaces.RGB;
import hxColorToolkit.spaces.XYZ;
import hxColorToolkit.spaces.YUV;

class ColorUtil {	
	static private var rybWheel: Array<Array<Int>> = [[0, 0], [15, 8], [30, 17], [45, 26], [60, 34], [75, 41], [90, 48], [105, 54], [120, 60], [135, 81], [150, 103], [165, 123], [180, 138], [195, 155], [210, 171], [225, 187], [240, 204], [255, 219], [270, 234], [285, 251], [300, 267], [315, 282], [330, 298], [345, 329], [360, 0]];
	
	inline public static function setColorOpaque(color:Int):Int { return 0xff000000 | (color & 0xffffff); }
	
	inline public static function desaturate(color:Int):Int { return toGray(color).color; }

	inline public static function getComplement(color:Int):Int { return rybRotate(color, 180); }
	
	public static function shiftBrighteness(color:Int, degree:Float):Int 
	{
		var col:HSB = new HSB();
		col.color=color;
		
		col.brightness+=degree;
		
		return col.color;
	}
	
	public static function shiftSaturation(color:Int, degree:Float):Int
	{
		var col:HSB = new HSB();
		col.color=color;
		
		col.saturation+=degree;
		
		return col.color;
	}
	
	public static function shiftHue(color:Int, degree:Float):Int
	{
		var col:HSB = new HSB();
		col.color=color;
		
		col.hue+=degree;
		
		return col.color;
	}
	
	inline public static function toRGB(color:Int):RGB { return new Color(color).toRGB(); }
	inline public static function toCMYK(color:Int):CMYK { return new Color(color).toCMYK(); }
	inline public static function toHSB(color:Int):HSB { return new Color(color).toHSB(); }
	inline public static function toHSL(color:Int):HSL { return new Color(color).toHSL(); }
	inline public static function toGray(color:Int):Gray { return new Color(color).toGray(); }
	inline public static function toLab(color:Int):Lab { return new Color(color).toLab(); }
	inline public static function toXYZ(color:Int):XYZ { return new Color(color).toXYZ(); }
	inline public static function toYUV(color:Int):YUV { return new Color(color).toYUV(); }

	inline public function getAnalogousScheme(color:Int, ?angle:Float=10, ?contrast:Float=25):Array<Int> {
		return new Analogous<Color>(new Color(color),angle,contrast).colors.toIntArray();
	}

	inline public function getComplementaryScheme(color:Int):Array<Int> {
		return new Complementary<Color>(new Color(color)).colors.toIntArray();
	}

	inline public function getCompoundScheme(color:Int):Array<Int> {
		return new Compound<Color>(new Color(color)).colors.toIntArray();
	}

	inline public function getFlippedCompoundScheme(color:Int):Array<Int> {
		return new FlippedCompound<Color>(new Color(color)).colors.toIntArray();
	}

	inline public function getMonochromeScheme(color:Int):Array<Int> {
		return new Monochrome<Color>(new Color(color)).colors.toIntArray();
	}

	inline public function getSplitComplementaryScheme(color:Int):Array<Int> {
		return new SplitComplementary<Color>(new Color(color)).colors.toIntArray();
	}

	inline public function getTetradScheme(color:Int, ?angle:Float=90):Array<Int> {
		return new Tetrad<Color>(new Color(color),angle).colors.toIntArray();
	}

	inline public function getTriadScheme(color:Int, ?angle:Float=120):Array<Int> {
		return new Triad<Color>(new Color(color),angle).colors.toIntArray();
	}
	
	
	public static function rybRotate(color:Int, angle:Float):Int 
	{			
		var hsb:HSB = new HSB();
		hsb.color=color;
		
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
		
		return hsb.color;
	}	
}
