import hxColorToolkit.ColorToolkit;
import hxColorToolkit.spaces.CMYK;
import hxColorToolkit.spaces.Gray;
import hxColorToolkit.spaces.HSB;
import hxColorToolkit.spaces.HSL;
import hxColorToolkit.spaces.Lab;
import hxColorToolkit.spaces.RGB;
import hxColorToolkit.spaces.XYZ;
import hxColorToolkit.spaces.YUV;
import hxColorToolkit.spaces.Hex;
import hxColorToolkit.CssColor;

using hxColorToolkit.ColorToolkit;

import utest.*;
import utest.ui.*;

class Test {
	public function new():Void {}
	
	public function testCMYK():Void {
		var cmyk = ColorToolkit.toCMYK(0xFFCC33);
		Assert.equals(0, Math.round(cmyk.cyan));
		Assert.equals(20, Math.round(cmyk.magenta));
		Assert.equals(80, Math.round(cmyk.yellow));
		Assert.equals(0, Math.round(cmyk.black));
		Assert.equals(0xFFCC33,cmyk.getColor());
		
		cmyk = new CMYK(0,20,80,0);
		Assert.equals(0xFFCC33,cmyk.getColor());
	}

	public function testGray():Void {
		var g = ColorToolkit.toGray(0xFFCC33);
		Assert.equals(0.0,ColorToolkit.toHSB(g.getColor()).saturation);
		
		g = ColorToolkit.toGray(0x333333);
		Assert.equals(0x33,Std.int(g.gray));
		Assert.equals(0x333333,new Gray(0x33).getColor());
	}

	public function testHSB():Void {
		var hsb = ColorToolkit.toHSB(0xFFCC33);
		Assert.equals(45,Math.round(hsb.hue));
		Assert.equals(80,Math.round(hsb.saturation));
		Assert.equals(100,Math.round(hsb.brightness));
		Assert.equals(0xFFCC33,hsb.getColor());

		hsb = new HSB(45,80,100);
		Assert.equals(0xFFCC33,hsb.getColor());
	}

	public function testHSL():Void {
		var hsl = ColorToolkit.toHSL(0xFFCC33);
		Assert.equals(45,cast hsl.hue);
		Assert.equals(100,cast hsl.saturation);
		Assert.equals(60,cast hsl.lightness);
		Assert.equals(0xFFCC33,hsl.getColor());

		hsl = new HSL(45,100,60);
		Assert.equals(0xFFCC33,hsl.getColor());
	}

	public function testLab():Void {
		var lab = ColorToolkit.toLab(0xFFCC33);
		Assert.equals(84,Math.round(lab.lightness));
		Assert.equals(5,Math.round(lab.a));
		Assert.equals(76,Math.round(lab.b));
		Assert.equals(0xFFCC33,lab.getColor());

		lab = new Lab(lab.lightness,lab.a,lab.b);
		Assert.equals(0xFFCC33,lab.getColor());
	}

	public function testXYZ():Void {
		var xyz = ColorToolkit.toXYZ(0xFFCC33);
		Assert.equals(0xFFCC33,xyz.getColor());

		//should test its x,y,z values but I cannot find reference...

		xyz = new XYZ(xyz.x,xyz.y,xyz.z);
		Assert.equals(0xFFCC33,xyz.getColor());
	}

	public function testRGB():Void {
		var rgb = ColorToolkit.toRGB(0xFFCC33);
		Assert.equals(0xFF,cast rgb.red);
		Assert.equals(0xCC,cast rgb.green);
		Assert.equals(0x33,cast rgb.blue);
		Assert.equals(0xFFCC33,rgb.getColor());

		rgb = new RGB(0x11,0x22,0x33);
		Assert.equals(0x11,cast rgb.red);
		Assert.equals(0x22,cast rgb.green);
		Assert.equals(0x33,cast rgb.blue);
		Assert.equals(0x112233,rgb.getColor());
	}

	public function testYUV():Void {
		var yuv = ColorToolkit.toYUV(0xFFCC33);
		Assert.equals(0xFFCC33,yuv.getColor());

		//should test its y,u,v values but I cannot find reference...

		yuv = new YUV(yuv.y,yuv.u,yuv.v);
		Assert.equals(0xFFCC33,yuv.getColor());
	}

	public function testUtil():Void {
		var c = 0xFFCC33;
		
		Assert.equals(c,ColorToolkit.toCMYK(c).getColor());
		Assert.equals(ColorToolkit.desaturate(c),ColorToolkit.toGray(c).getColor());
		Assert.equals(c,ColorToolkit.toHSB(c).getColor());
		Assert.equals(c,ColorToolkit.toHSL(c).getColor());
		Assert.equals(c,ColorToolkit.toLab(c).getColor());
		Assert.equals(c,ColorToolkit.toRGB(c).getColor());
		Assert.equals(c,ColorToolkit.toXYZ(c).getColor());
		Assert.equals(c,ColorToolkit.toYUV(c).getColor());

		Assert.equals(0xFF112233,ColorToolkit.setColorOpaque(0x112233));
	}
	
	public function testInterpolate():Void {
		var c0 = new RGB(0, 0, 0);
		var c1 = new RGB(10, 20, 30);
		var ci = c0.interpolate(c1, 0.5);
		
		Assert.equals(5.0, ci.red);
		Assert.equals(10.0, ci.green);
		Assert.equals(15.0, ci.blue);
		
		ci = c1.interpolate(c0, 0.5);
		
		Assert.equals(5.0, ci.red);
		Assert.equals(10.0, ci.green);
		Assert.equals(15.0, ci.blue);
	}

	public function testSchemeShortCut():Void {	
		Assert.equals(new RGB().toHex().getAnalogousScheme().intArray().join(","), 0x000000.getAnalogousScheme().intArray().join(","));
		Assert.equals(new RGB().toHex().getComplementaryScheme().intArray().join(","), 0x000000.getComplementaryScheme().intArray().join(","));
		Assert.equals(new RGB().toHex().getCompoundScheme().intArray().join(","), 0x000000.getCompoundScheme().intArray().join(","));
		Assert.equals(new RGB().toHex().getFlippedCompoundScheme().intArray().join(","), 0x000000.getFlippedCompoundScheme().intArray().join(","));
		Assert.equals(new RGB().toHex().getMonochromeScheme().intArray().join(","), 0x000000.getMonochromeScheme().intArray().join(","));
		Assert.equals(new RGB().toHex().getSplitComplementaryScheme().intArray().join(","), 0x000000.getSplitComplementaryScheme().intArray().join(","));
		Assert.equals(new RGB().toHex().getTetradScheme().intArray().join(","), 0x000000.getTetradScheme().intArray().join(","));
		Assert.equals(new RGB().toHex().getTriadScheme().intArray().join(","), 0x000000.getTriadScheme().intArray().join(","));
	}

	public function testHex():Void {
		var hex = new Hex(0x112233);
		Assert.equals(0x112233, hex.getColor());
		Assert.equals(0x11, hex.red);
		Assert.equals(0x22, hex.green);
		Assert.equals(0x33, hex.blue);

		hex.red = 1000;
		Assert.equals(0xFF, hex.red);
		Assert.equals(0xFF2233, hex.getColor());
		hex.red = -1000;
		Assert.equals(0x00, hex.red);
		Assert.equals(0x002233, hex.getColor());
		hex.red = 0x11;

		hex.green = 1000;
		Assert.equals(0xFF, hex.green);
		Assert.equals(0x11FF33, hex.getColor());
		hex.green = -1000;
		Assert.equals(0x00, hex.green);
		Assert.equals(0x110033, hex.getColor());
		hex.green = 0x22;

		hex.blue = 1000;
		Assert.equals(0xFF, hex.blue);
		Assert.equals(0x1122FF, hex.getColor());
		hex.blue = -1000;
		Assert.equals(0x00, hex.blue);
		Assert.equals(0x112200, hex.getColor());
	}

	static function main():Void {		
		var runner = new Runner();
		runner.addCase(new Test());
		
		var report = Report.create(runner);
		
		#if sys
		runner.onProgress.add(function(o){
			if (o.done == o.totals) {
				Sys.exit(o.result.allOk() ? 0 : 1);
			}
		});
		#end
		
		runner.run();
	}
}
