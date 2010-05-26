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

import hxColorToolkit.spaces.IColor;

	class ColorWheelScheme<C:IColor> extends ColorScheme<C> {
		
		public var primaryColor(getPrimaryColor, setPrimaryColor) : C;
		var _primaryColor:C;
		
		private function getPrimaryColor():C{ return _primaryColor; }
		private function setPrimaryColor(value:C):C{
			_colors.empty();
			_primaryColor=value;
			_colors.addColor(_primaryColor);
			generate();	
			return value;
			
		}
		
		public function new(primaryColor:C)
		{
			super();
			this.primaryColor=primaryColor;
		}
		
		function generate():Void
		{
			throw 'Method must be called by child class';
		}
		
		inline private function wrap(x : Float, min : Float,threshold : Float, plus : Float) : Float {
			return ( x - min < threshold) ? x + plus : x - min;
		}

		private function mutateFromPrimary(newColor:Int):C {
			var r:C = untyped primaryColor.clone();
			r.color = newColor;
			return r;
		}

	}
