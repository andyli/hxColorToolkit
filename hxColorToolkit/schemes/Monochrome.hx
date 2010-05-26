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

	import hxColorToolkit.spaces.HSB;
	import hxColorToolkit.spaces.IColor;
	
	class Monochrome<C:IColor> extends ColorWheelScheme<C> {
		
		public function new(primaryColor:C)
		{
			super(primaryColor);
		}
		
		override function generate():Void
		{
			
			var _primaryHSB:HSB = new HSB();
			_primaryHSB.color=_primaryColor.color;
			
			var c1:HSB = new HSB();
			c1.color = _primaryColor.color;
			c1.brightness=wrap(_primaryHSB.brightness, 50, 20, 30);
			c1.saturation=wrap(_primaryHSB.saturation, 30, 10, 20);
			_colors.addColor(mutateFromPrimary(c1.color));
			
			var c2:HSB = new HSB();
			c2.color = _primaryColor.color;
			c2.brightness=wrap(_primaryHSB.brightness, 20, 20, 60);
			_colors.addColor(mutateFromPrimary(c2.color));

			var c3:HSB = new HSB();
			c3.color = _primaryColor.color;
			c3.brightness=Math.max(20, _primaryHSB.brightness + (100 - _primaryHSB.brightness ) * 0.2);
			c3.saturation=wrap(_primaryHSB.saturation, 30, 10, 30);
			_colors.addColor(mutateFromPrimary(c3.color));

			var c4:HSB = new HSB();
			c4.color = _primaryColor.color;
			c4.brightness=wrap(_primaryHSB.brightness, 50, 20, 30);
			_colors.addColor(mutateFromPrimary(c4.color));
		}

	}
