import hxColorToolkit.ColorToolkit;
import hxColorToolkit.spaces.CMYK;
import hxColorToolkit.spaces.Gray;
import hxColorToolkit.spaces.HSB;
import hxColorToolkit.spaces.HSL;
import hxColorToolkit.spaces.Lab;
import hxColorToolkit.spaces.ARGB;
import hxColorToolkit.spaces.RGB;
import hxColorToolkit.spaces.XYZ;
import hxColorToolkit.spaces.YUV;
import hxColorToolkit.spaces.Hex;
import hxColorToolkit.CssColor;

using hxColorToolkit.ColorToolkit;

import haxe.unit.*;

class Test extends TestCase{
	public function testCMYK():Void {
		var cmyk = ColorToolkit.toCMYK(0xFFCC33);
		this.assertEquals(0, Math.round(cmyk.cyan));
		this.assertEquals(20, Math.round(cmyk.magenta));
		this.assertEquals(80, Math.round(cmyk.yellow));
		this.assertEquals(0, Math.round(cmyk.black));
		this.assertEquals(0xFFCC33,cmyk.getColor());
		
		cmyk = new CMYK(0,20,80,0);
		this.assertEquals(0xFFCC33,cmyk.getColor());
	}

	public function testGray():Void {
		var g = ColorToolkit.toGray(0xFFCC33);
		this.assertEquals(0.0,ColorToolkit.toHSB(g.getColor()).saturation);
		
		g = ColorToolkit.toGray(0x333333);
		this.assertEquals(0x33,Std.int(g.gray));
		this.assertEquals(0x333333,new Gray(0x33).getColor());
	}

	public function testHSB():Void {
		var hsb = ColorToolkit.toHSB(0xFFCC33);
		this.assertEquals(45,Math.round(hsb.hue));
		this.assertEquals(80,Math.round(hsb.saturation));
		this.assertEquals(100,Math.round(hsb.brightness));
		this.assertEquals(0xFFCC33,hsb.getColor());

		hsb = new HSB(45,80,100);
		this.assertEquals(0xFFCC33,hsb.getColor());
	}

	public function testHSL():Void {
		var hsl = ColorToolkit.toHSL(0xFFCC33);
		this.assertEquals(45,cast hsl.hue);
		this.assertEquals(100,cast hsl.saturation);
		this.assertEquals(60,cast hsl.lightness);
		this.assertEquals(0xFFCC33,hsl.getColor());

		hsl = new HSL(45,100,60);
		this.assertEquals(0xFFCC33,hsl.getColor());
	}

	public function testLab():Void {
		var lab = ColorToolkit.toLab(0xFFCC33);
		this.assertEquals(84,Math.round(lab.lightness));
		this.assertEquals(5,Math.round(lab.a));
		this.assertEquals(76,Math.round(lab.b));
		this.assertEquals(0xFFCC33,lab.getColor());

		lab = new Lab(lab.lightness,lab.a,lab.b);
		this.assertEquals(0xFFCC33,lab.getColor());
	}

	public function testXYZ():Void {
		var xyz = ColorToolkit.toXYZ(0xFFCC33);
		this.assertEquals(0xFFCC33,xyz.getColor());

		//should test its x,y,z values but I cannot find reference...

		xyz = new XYZ(xyz.x,xyz.y,xyz.z);
		this.assertEquals(0xFFCC33,xyz.getColor());
	}

	public function testRGB():Void {
		var rgb = ColorToolkit.toRGB(0xFFCC33);
		this.assertEquals(0xFF,cast rgb.red);
		this.assertEquals(0xCC,cast rgb.green);
		this.assertEquals(0x33,cast rgb.blue);
		this.assertEquals(0xFFCC33,rgb.getColor());

		rgb = ColorToolkit.toRGB(0xCCFFCC33);
		this.assertEquals(0xFF,cast rgb.red);
		this.assertEquals(0xCC,cast rgb.green);
		this.assertEquals(0x33,cast rgb.blue);
		this.assertEquals(0xFFCC33,rgb.getColor());

		rgb = new RGB(0x11,0x22,0x33);
		this.assertEquals(0x11,cast rgb.red);
		this.assertEquals(0x22,cast rgb.green);
		this.assertEquals(0x33,cast rgb.blue);
		this.assertEquals(0x112233,rgb.getColor());
	}

	public function testARGB():Void {
		var argb = new ARGB(0xCC,0x11,0x22,0x33);
		this.assertEquals(0xCC,cast argb.alpha);
		this.assertEquals(0x11,cast argb.red);
		this.assertEquals(0x22,cast argb.green);
		this.assertEquals(0x33,cast argb.blue);
		this.assertEquals(0xCC112233,argb.getColor());

		argb = new ARGB().setColor(0xCC112233);
		this.assertEquals(0xCC,cast argb.alpha);
		this.assertEquals(0x11,cast argb.red);
		this.assertEquals(0x22,cast argb.green);
		this.assertEquals(0x33,cast argb.blue);

		argb = new ARGB().setColor(0x112233);
		this.assertEquals(0x00,cast argb.alpha);
		this.assertEquals(0x11,cast argb.red);
		this.assertEquals(0x22,cast argb.green);
		this.assertEquals(0x33,cast argb.blue);
	}

	public function testYUV():Void {
		var yuv = ColorToolkit.toYUV(0xFFCC33);
		this.assertEquals(0xFFCC33,yuv.getColor());

		//should test its y,u,v values but I cannot find reference...

		yuv = new YUV(yuv.y,yuv.u,yuv.v);
		this.assertEquals(0xFFCC33,yuv.getColor());
	}

	public function testUtil():Void {
		var c = 0xFFCC33;
		
		this.assertEquals(c,ColorToolkit.toCMYK(c).getColor());
		this.assertEquals(ColorToolkit.desaturate(c),ColorToolkit.toGray(c).getColor());
		this.assertEquals(c,ColorToolkit.toHSB(c).getColor());
		this.assertEquals(c,ColorToolkit.toHSL(c).getColor());
		this.assertEquals(c,ColorToolkit.toLab(c).getColor());
		this.assertEquals(c,ColorToolkit.toRGB(c).getColor());
		this.assertEquals(c,ColorToolkit.toXYZ(c).getColor());
		this.assertEquals(c,ColorToolkit.toYUV(c).getColor());

		this.assertEquals(0xFF112233,ColorToolkit.setColorOpaque(0x112233));
	}
	
	public function testInterpolate():Void {
		var c0 = new RGB(0, 0, 0);
		var c1 = new RGB(10, 20, 30);
		var ci = c0.interpolate(c1, 0.5);
		
		this.assertEquals(5.0, ci.red);
		this.assertEquals(10.0, ci.green);
		this.assertEquals(15.0, ci.blue);
		
		ci = c1.interpolate(c0, 0.5);
		
		this.assertEquals(5.0, ci.red);
		this.assertEquals(10.0, ci.green);
		this.assertEquals(15.0, ci.blue);
	}

	public function testSchemeShortCut():Void {	
		this.assertEquals(new RGB().toHex().getAnalogousScheme().intArray().join(","), 0x000000.getAnalogousScheme().intArray().join(","));
		this.assertEquals(new RGB().toHex().getComplementaryScheme().intArray().join(","), 0x000000.getComplementaryScheme().intArray().join(","));
		this.assertEquals(new RGB().toHex().getCompoundScheme().intArray().join(","), 0x000000.getCompoundScheme().intArray().join(","));
		this.assertEquals(new RGB().toHex().getFlippedCompoundScheme().intArray().join(","), 0x000000.getFlippedCompoundScheme().intArray().join(","));
		this.assertEquals(new RGB().toHex().getMonochromeScheme().intArray().join(","), 0x000000.getMonochromeScheme().intArray().join(","));
		this.assertEquals(new RGB().toHex().getSplitComplementaryScheme().intArray().join(","), 0x000000.getSplitComplementaryScheme().intArray().join(","));
		this.assertEquals(new RGB().toHex().getTetradScheme().intArray().join(","), 0x000000.getTetradScheme().intArray().join(","));
		this.assertEquals(new RGB().toHex().getTriadScheme().intArray().join(","), 0x000000.getTriadScheme().intArray().join(","));
	}

	public function testHex():Void {
		var hex = new Hex(0x112233);
		this.assertEquals(0x112233, hex.getColor());
		this.assertEquals(0x00, hex.alpha);
		this.assertEquals(0x11, hex.red);
		this.assertEquals(0x22, hex.green);
		this.assertEquals(0x33, hex.blue);

		hex.alpha = 1000;
		this.assertEquals(0xFF, hex.alpha);
		this.assertEquals(0xFF112233, hex.getColor());
		hex.alpha = -1000;
		this.assertEquals(0x00, hex.alpha);
		this.assertEquals(0x00112233, hex.getColor());
		hex.alpha = 0x00;

		hex.red = 1000;
		this.assertEquals(0xFF, hex.red);
		this.assertEquals(0xFF2233, hex.getColor());
		hex.red = -1000;
		this.assertEquals(0x00, hex.red);
		this.assertEquals(0x002233, hex.getColor());
		hex.red = 0x11;

		hex.green = 1000;
		this.assertEquals(0xFF, hex.green);
		this.assertEquals(0x11FF33, hex.getColor());
		hex.green = -1000;
		this.assertEquals(0x00, hex.green);
		this.assertEquals(0x110033, hex.getColor());
		hex.green = 0x22;

		hex.blue = 1000;
		this.assertEquals(0xFF, hex.blue);
		this.assertEquals(0x1122FF, hex.getColor());
		hex.blue = -1000;
		this.assertEquals(0x00, hex.blue);
		this.assertEquals(0x112200, hex.getColor());

		var hex = new Hex(0xFF112233);
		this.assertEquals(0xFF112233, hex.getColor());
		this.assertEquals(0xFF, hex.alpha);
		this.assertEquals(0x11, hex.red);
		this.assertEquals(0x22, hex.green);
		this.assertEquals(0x33, hex.blue);
	}

	static function main():Void {
		var test = new Test();
		var runner = new TestRunner();
		runner.add(test);
		
		#if js
		var printBuf = new StringBuf();
		TestRunner.print = printBuf.add;
		#end
		
		var success = runner.run();
		
		#if sys
		Sys.exit(success ? 0 : 1);
		#elseif js
		js.Browser.window.console.log(printBuf.toString());
		js.phantomjs.Phantom.exit(success ? 0 : 1);
		#end
	}
}
