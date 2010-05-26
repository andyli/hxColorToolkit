import hxColorToolkit.Color;
import hxColorToolkit.ColorUtil;
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
		var c = new Color(0xFFCC33);
		var cmyk = c.toCMYK();
		this.assertEquals(0, Math.round(cmyk.cyan));
		this.assertEquals(20, Math.round(cmyk.magenta));
		this.assertEquals(80, Math.round(cmyk.yellow));
		this.assertEquals(0, Math.round(cmyk.black));
		this.assertEquals(0xFFCC33,cmyk.color);
		
		cmyk = new CMYK(0,20,80,0);
		this.assertEquals(0xFFCC33,cmyk.color);
	}

	public function testGray():Void {
		var c = new Color(0xFFCC33);
		var g = c.toGray();
		this.assertEquals(0.0,new Color(g.color).toHSB().saturation);
		c = new Color(0x333333);
		g = c.toGray();
		this.assertEquals(0x33,cast g.gray);
		this.assertEquals(0x333333,new Gray(0x33).color);
	}

	public function testHSB():Void {
		var c = new Color(0xFFCC33);
		var hsb = c.toHSB();
		this.assertEquals(45,Math.round(hsb.hue));
		this.assertEquals(80,Math.round(hsb.saturation));
		this.assertEquals(100,Math.round(hsb.brightness));
		this.assertEquals(0xFFCC33,hsb.color);

		hsb = new HSB(45,80,100);
		this.assertEquals(0xFFCC33,hsb.color);
	}

	public function testHSL():Void {
		var c = new Color(0xFFCC33);
		var hsl = c.toHSL();
		this.assertEquals(45,cast hsl.hue);
		this.assertEquals(100,cast hsl.saturation);
		this.assertEquals(60,cast hsl.lightness);
		this.assertEquals(0xFFCC33,hsl.color);

		hsl = new HSL(45,100,60);
		this.assertEquals(0xFFCC33,hsl.color);
	}

	public function testLab():Void {
		var c = new Color(0xFFCC33);
		var lab = c.toLab();
		this.assertEquals(84,Math.round(lab.lightness));
		this.assertEquals(5,Math.round(lab.a));
		this.assertEquals(76,Math.round(lab.b));
		this.assertEquals(0xFFCC33,lab.color);

		lab = new Lab(lab.lightness,lab.a,lab.b);
		this.assertEquals(0xFFCC33,lab.color);
	}

	public function testXYZ():Void {
		var c = new Color(0xFFCC33);
		var xyz = c.toXYZ();
		this.assertEquals(0xFFCC33,xyz.color);

		//should test its x,y,z values but I cannot find reference...

		xyz = new XYZ(xyz.x,xyz.y,xyz.z);
		this.assertEquals(0xFFCC33,xyz.color);
	}

	public function testRGB():Void {
		var c = new Color(0xFFCC33);
		var rgb = c.toRGB();
		this.assertEquals(0xFF,cast rgb.red);
		this.assertEquals(0xCC,cast rgb.green);
		this.assertEquals(0x33,cast rgb.blue);
		this.assertEquals(0xFFCC33,rgb.color);

		rgb = new RGB(0x11,0x22,0x33);
		this.assertEquals(0x11,cast rgb.red);
		this.assertEquals(0x22,cast rgb.green);
		this.assertEquals(0x33,cast rgb.blue);
		this.assertEquals(0x112233,rgb.color);
	}

	public function testYUV():Void {
		var c = new Color(0xFFCC33);
		var yuv = c.toYUV();
		this.assertEquals(0xFFCC33,yuv.color);

		//should test its y,u,v values but I cannot find reference...

		yuv = new YUV(yuv.y,yuv.u,yuv.v);
		this.assertEquals(0xFFCC33,yuv.color);
	}

	public function testUtil():Void {
		var c = 0x11DD33;
		this.assertEquals(c,ColorUtil.toCMYK(c).color);
		this.assertEquals(ColorUtil.desaturate(c),ColorUtil.toGray(c).color);
		this.assertEquals(c,ColorUtil.toHSB(c).color);
		this.assertEquals(c,ColorUtil.toHSL(c).color);
		this.assertEquals(c,ColorUtil.toLab(c).color);
		this.assertEquals(c,ColorUtil.toRGB(c).color);
		this.assertEquals(c,ColorUtil.toXYZ(c).color);
		this.assertEquals(c,ColorUtil.toYUV(c).color);

		this.assertEquals(0xFF112233,ColorUtil.setColorOpaque(0x112233));
	}

	static function main():Void {
		var runner = new haxe.unit.TestRunner();
		runner.add(new Test());
		runner.run();
	}
}
