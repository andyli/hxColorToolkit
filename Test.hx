import hxColorToolkit.ColorToolkit;
import hxColorToolkit.spaces.CMYK;
import hxColorToolkit.spaces.Gray;
import hxColorToolkit.spaces.HSB;
import hxColorToolkit.spaces.HSL;
import hxColorToolkit.spaces.Lab;
import hxColorToolkit.spaces.RGB;
import hxColorToolkit.spaces.XYZ;
import hxColorToolkit.spaces.YUV;

class Test extends haxe.unit.TestCase{
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

		rgb = new RGB(0x11,0x22,0x33);
		this.assertEquals(0x11,cast rgb.red);
		this.assertEquals(0x22,cast rgb.green);
		this.assertEquals(0x33,cast rgb.blue);
		this.assertEquals(0x112233,rgb.getColor());
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

	static function main():Void {
		var runner = new haxe.unit.TestRunner();
		runner.add(new Test());
		runner.run();
	}
}
