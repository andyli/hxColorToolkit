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

import hxColorToolkit.ColorToolkit;
import hxColorToolkit.spaces.HSB;
import hxColorToolkit.spaces.IColor;

class Complementary<C:IColor> extends ColorWheelScheme<C> {
	
	
	
	public function new(primaryColor:C)
	{
		super(primaryColor);
	}
	
	override function generate():Void
	{
		
		var _primaryHSB:HSB = new HSB();
		_primaryHSB.color=_primaryColor.color;
		
		var contrasting: HSB = new HSB();
		contrasting.color=_primaryColor.color;
		if(_primaryHSB.brightness > 40) {
			contrasting.brightness=10 + _primaryHSB.brightness * 0.25;
		} else {
			contrasting.brightness=100 - _primaryHSB.brightness * 0.25;
		}
		_colors.addColor(mutateFromPrimary(contrasting.color));
		
		var supporting: HSB = new HSB();
		supporting.color=_primaryColor.color;
		
		supporting.brightness=30 + _primaryHSB.brightness;
		supporting.saturation=10 + _primaryHSB.saturation * 0.3;
		_colors.addColor(mutateFromPrimary(supporting.color));
		
		//complement
		var complement:HSB = new HSB();
		
		complement.color=ColorUtil.rybRotate(_primaryColor.color, 180);
		_colors.addColor(mutateFromPrimary(complement.color));
		
		var contrastingComplement:HSB = new HSB();
		contrastingComplement.color=complement.color;
				
		if(complement.brightness > 30) {
			contrastingComplement.brightness=10 + complement.brightness * 0.25;
		} else {
			contrastingComplement.brightness=100 - complement.brightness * 0.25;
		}
		_colors.addColor(mutateFromPrimary(contrastingComplement.color));
		
		var supportingComplement:HSB = new HSB();
		supportingComplement.color=complement.color;
		
		supportingComplement.brightness=30 + complement.brightness;
		supportingComplement.saturation=10 + complement.saturation * 0.3;
		_colors.addColor(mutateFromPrimary(supportingComplement.color));
		
	}

}
