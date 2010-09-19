/*
Author: Andy Li (andy@onthewings.net)
Based on colortoolkit (http://code.google.com/p/colortoolkit/)
*/

package hxColorToolkit;

import hxColorToolkit.schemes.IColorScheme;
import hxColorToolkit.schemes.Analogous;
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
import hxColorToolkit.spaces.Hex;
import hxColorToolkit.spaces.HSB;
import hxColorToolkit.spaces.HSL;
import hxColorToolkit.spaces.Lab;
import hxColorToolkit.spaces.RGB;
import hxColorToolkit.spaces.XYZ;
import hxColorToolkit.spaces.YUV;

class ColorToolkit {	
	static private var rybWheel: Array<Array<Int>> = [[0, 0], [15, 8], [30, 17], [45, 26], [60, 34], [75, 41], [90, 48], [105, 54], [120, 60], [135, 81], [150, 103], [165, 123], [180, 138], [195, 155], [210, 171], [225, 187], [240, 204], [255, 219], [270, 234], [285, 251], [300, 267], [315, 282], [330, 298], [345, 329], [360, 0]];
	
	inline public static function setColorOpaque(color:Int, ?opaqueValue:Int = 0xff):Int { return (opaqueValue << 24) | (color & 0xffffff); }
	
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

	inline static public function getAnalogousScheme(color:Int, ?angle:Float=10, ?contrast:Float=25):Analogous<Hex> {
		return new Analogous<Hex>(new Hex(color),angle,contrast);
	}

	inline static public function getComplementaryScheme(color:Int):Complementary<Hex> {
		return new Complementary<Hex>(new Hex(color));
	}

	inline static public function getCompoundScheme(color:Int):Compound<Hex> {
		return new Compound<Hex>(new Hex(color));
	}

	inline static public function getFlippedCompoundScheme(color:Int):FlippedCompound<Hex> {
		return new FlippedCompound<Hex>(new Hex(color));
	}

	inline static public function getMonochromeScheme(color:Int):Monochrome<Hex> {
		return new Monochrome<Hex>(new Hex(color));
	}

	inline static public function getSplitComplementaryScheme(color:Int):SplitComplementary<Hex> {
		return new SplitComplementary<Hex>(new Hex(color));
	}

	inline static public function getTetradScheme(color:Int, ?angle:Float=90, ?alt:Bool = false):Tetrad<Hex> {
		return new Tetrad<Hex>(new Hex(color),angle,alt);
	}

	inline static public function getTriadScheme(color:Int, ?angle:Float=120):Triad<Hex> {
		return new Triad<Hex>(new Hex(color),angle);
	}
	
	
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

	static public function intArray(colors:IColorScheme<Dynamic>):Array<Int> {
		var a = [];
		for (c in colors) {
			a.push(c.getColor());
		}
		return a;
	}
}
