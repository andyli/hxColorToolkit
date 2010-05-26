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

package hxColorToolkit.schemes;

	import hxColorToolkit.ColorUtil;
	import hxColorToolkit.spaces.HSB;
	import hxColorToolkit.spaces.IColor;
	
	class FlippedCompound<C:IColor> extends ColorWheelScheme<C> {
		
		public function new(primaryColor:C)
		{
			super(primaryColor);
		}
		
		override function generate():Void
		{
			var _primaryHSB:HSB = new HSB();
			_primaryHSB.color=_primaryColor.color;
			var d: Int = 1;
			
			var c1: HSB = new HSB();
			c1.color = ColorUtil.rybRotate(_primaryColor.color, 30 * -1);
			c1.brightness=wrap(_primaryHSB.brightness, 25, 60, 25);
			_colors.addColor(mutateFromPrimary(c1.color));

			var c2: HSB = new HSB();
			c2.color = ColorUtil.rybRotate(_primaryColor.color, 30 * -1);
			c2.brightness=wrap(_primaryHSB.brightness, 40, 10, 40);
			c2.saturation=wrap(_primaryHSB.saturation, 40, 20, 40);
			_colors.addColor(mutateFromPrimary(c2.color));
			
			var c3: HSB = new HSB();
			c3.color = ColorUtil.rybRotate(_primaryColor.color, 160 * -1);
			c3.brightness=Math.max(20, _primaryHSB.brightness);
			c3.saturation=wrap(_primaryHSB.saturation, 25, 10, 25);
			_colors.addColor(mutateFromPrimary(c3.color));
		
			var c4: HSB = new HSB();
			c4.color = ColorUtil.rybRotate(_primaryColor.color, 150 * -1);
			c4.brightness=wrap(_primaryHSB.brightness, 30, 60, 30);
			c4.saturation=wrap(_primaryHSB.saturation, 10, 80, 10);
			_colors.addColor(mutateFromPrimary(c4.color));
	
			var c5: HSB = new HSB();
			c5.color = ColorUtil.rybRotate(_primaryColor.color, 150 * -1);
			c5.brightness=wrap(_primaryHSB.brightness, 40, 20, 40);
			c5.saturation=wrap(_primaryHSB.saturation, 10, 80, 10);
			_colors.addColor(mutateFromPrimary(c5.color));
		}

	}
