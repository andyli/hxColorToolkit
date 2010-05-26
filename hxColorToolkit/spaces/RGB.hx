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

/**
 * @author      P.J. Onori
 * @version     1.0
 * @description Takes in red, green and blue color channels and converts it to its corresponding hexidecimal value.
 */

package hxColorToolkit.spaces;

	
	
	class RGB implements IColor {
		
		public var blue(getBlue, setBlue) : Float;
		private var _color:Int;
		public var color(getColor, setColor) : Int;
		public var green(getGreen, setGreen) : Float;
		public var red(getRed, setRed) : Float;
		
		/* @private */
		var _red:Float;
		var _green:Float;
		var _blue:Float;
		
		/**
		 * Red color channel
		 * @return Number (between 0 and 255)
		 * 
		 */	
		private function getRed():Float{ return this._red; }
		
		/**
		 * Red color channel
		 * @param value Number (between 0 and 255)
		 * 
		 */	
		private function setRed(value:Float):Float{
			value=Math.min(255, Math.max(value, 0));
			this._red=value;
			this._color=this.RGBToHex(this._red, this._green, this._blue);
			return value;
		}
		
		/**
		 * Green color channel
		 * @return Number (between 0 and 255)
		 * 
		 */	
		private function getGreen():Float{ return this._green; }
		
		/**
		 * Green color channel
		 * @param value Number (between 0 and 255)
		 * 
		 */	
		private function setGreen(value:Float):Float{
			value=Math.min(255, Math.max(value, 0));
			this._green=value;
			this._color=this.RGBToHex(this._red, this._green, this._blue);
			return value;
		}
		
		/**
		 * Blue color channel
		 * @return Number (between 0 and 255)
		 * 
		 */	
		private function getBlue():Float{ return this._blue; }
		
		/**
		 * Blue color channel
		 * @param value Number (between 0 and 255)
		 * 
		 */	
		private function setBlue(value:Float):Float{
			value=Math.min(255, Math.max(value, 0));
			this._blue=value;
			this._color=this.RGBToHex(this._red, this._green, this._blue);
			return value;
		}
		
		/**
		 * Hexidecimal RGB translation of color
		 * @return Hexidecimal color value
		 * 
		 */
		private function getColor():Int{ return this._color; }
		
		/**
		 * Hexidecimal RGB translation of color
		 * @param value Hexidecimal color value
		 * 
		 */	
		private function setColor(value:Int):Int{
			this._color=value;
			var rgb:RGB = this.hexToRGB(value);
			
			this._red = rgb.red;
			this._green = rgb.green;
			this._blue = rgb.blue; 
			return value;
		}
		
		/**
		 * 
		 * @param r Number (between 0 and 255)
		 * @param g Number (between 0 and 255)
		 * @param b Number (between 0 and 255)
		 * 
		 */		
		public function new(?r:Float=0, ?g:Float=0, ?b:Float=0)
		{
			
			this._red=Math.min(255, Math.max(r, 0));
			this._green=Math.min(255, Math.max(g, 0));
			this._blue=Math.min(255, Math.max(b, 0));
			this._color = this.RGBToHex(cast this._red, cast this._green, cast this._blue);
		}
		
		public function clone():IColor { return new RGB(_red, _green, _blue); }
		
		/* @private */
		function hexToRGB(color:Int):RGB 
		{
			return new RGB(color >> 16 & 0xFF, color >> 8 & 0xFF, color & 0xFF);
		}
		
		/* @private */
		function RGBToHex(r:Float, g:Float, b:Float):Int
		{
			var cR:Int = Math.round(r) << 16;
			var cG:Int = Math.round(g) << 8;
			var cB:Int = Math.round(b);
			
			return cR | cG | cB;
		}
	}
