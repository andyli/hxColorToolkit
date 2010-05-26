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
 
package hxColorToolkit.spaces;

	
	
	class Gray implements IColor {
		
		public var color(getColor, setColor) : Int ;
		public var gray(getGray, setGray) : Float;
		
		/* @private */
		var _gray:Float;
		var _grayscale:Int;
		
		/**
		 * Single gray channel value (not the hexidecimal color)
		 * @return Number (between 0 and 255)
		 * 
		 */	
		private function getGray():Float{ return this._gray; }
		
		/**
		 * Single gray channel value (not the hexidecimal color)
		 * @param value Number between 0 and 255);
		 * 
		 */		
		private function setGray(value:Float):Float{
			value=Math.min(255, Math.max(value, 0));
			this._gray=value;
			this._grayscale=this.convertGrayValuetoHex(this._gray);
			return value;
		}
		
		/**
		 * Grayscale color value
		 * @return Hexidecimal grayscale color
		 * 
		 */	
		private function getColor():Int { return this._grayscale; }

		private function setColor(c:Int):Int {
			this.gray = convertHexToGrayscale(c);
			return this.color;
		}
		
		/**
		 * Single gray channel value (not the hexidecimal color)
		 * @param value Number between 0 and 255);
		 * 
		 */	
		public function new(?gray:Float=0){
			
			this.gray=gray;
			this._grayscale=this.convertGrayValuetoHex(gray);
		}
		
		public function clone():IColor { return new Gray(_gray); }
		
		/**
		 * Single gray channel value (not the hexidecimal color)
		 * @param value Hexidecimal color value to be converted to grayscale;
		 * @return Hexidecimal grayscale color
		 * 
		 */	
		public function convertHexToGrayscale(color:Int):Float
		{
			var r:Int;
			var g:Int;
			var b:Int;
			
			r= color >> 16 & 0xFF;
			g = color >> 8 & 0xFF;
			b = color & 0xFF; 	
			
			var gray = Std.int(0.3*r + 0.59*g + 0.11*b);
			this._gray=gray;
			this._grayscale=(gray << 16 ^ gray << 8 ^ gray);
			
			return (gray << 16 ^ gray << 8 ^ gray);
		}
		
		/* @private */
		function convertGrayValuetoHex(gray:Float):Int
		{
			var g = Std.int(gray);
			return ( g << 16 ^ g << 8 ^ g);
		}
		
	}
