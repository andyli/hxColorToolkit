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

	

	class CMYK implements IColor {
		
		public var black(getBlack, setBlack) : Float;
		private var _color:Int;
		public var color(getColor, setColor) : Int;
		public var cyan(getCyan, setCyan) : Float;
		public var magenta(getMagenta, setMagenta) : Float;
		public var yellow(getYellow, setYellow) : Float;
		/* @private */
		var _cyan:Float;
		var _yellow:Float;
		var _magenta:Float;
		var _black:Float;
		
		/**
		 * Cyan color channel
		 * @return Number (between 0 and 100)
		 * 
		 */		
		private function getCyan():Float{ return this._cyan; }
		
		/**
		 * Cyan color channel
		 * @param value Number (between 0 and 100)
		 * 
		 */		
		private function setCyan(value:Float):Float{
			this._cyan=Math.min(100, Math.max(value, 0));
			this._color=this.generateColorsFromCMYK(this._cyan, this._magenta, this._yellow, this._black);
			return value;
		}
		
		/**
		 * Magenta color channel
		 * @return Number (between 0 and 100)
		 * 
		 */			
		private function getMagenta():Float{ return this._magenta; }
		
		/**
		 * Magenta color channel
		 * @param value Number (between 0 and 100)
		 * 
		 */	
		private function setMagenta(value:Float):Float{
			this._magenta=Math.min(100, Math.max(value, 0));
			this._color=this.generateColorsFromCMYK(this._cyan, this._magenta, this._yellow, this._black);
			return value;
		}
		
		/**
		 * Yellow color channel
		 * @return Number (between 0 and 100)
		 * 
		 */			
		private function getYellow():Float{ return this._yellow; }
		
		/**
		 * Yellow color channel
		 * @param value Number (between 0 and 100)
		 * 
		 */	
		private function setYellow(value:Float):Float{
			this._yellow=Math.min(100, Math.max(value, 0));
			this._color=this.generateColorsFromCMYK(this._cyan, this._magenta, this._yellow, this._black);
			return value;
		}
		
		/**
		 * Black color channel
		 * @return Number (between 0 and 100)
		 * 
		 */			
		private function getBlack():Float{ return this._black; }
		
		/**
		 * Black color channel
		 * @param value Number (between 0 and 100)
		 * 
		 */	
		private function setBlack(value:Float):Float{
			this._black=Math.min(100, Math.max(value, 0));
			this._color=this.generateColorsFromCMYK(this._cyan, this._magenta, this._yellow, this._black);
			return value;
		}
		
		/**
		 * Hexidecimal RGB translation of CMYK color
		 * @return Hexidecimal color value
		 * 
		 */		
		private function getColor():Int{ return this._color; }
		
		/**
		 * Hexidecimal RGB translation of CMYK color
		 * @param value Hexidecimal color value
		 * 
		 */		
		private function setColor(value:Int):Int{
			this._color=value;
			var cmyk:CMYK = this.generateColorsFromHex(value);
			this._cyan=cmyk.cyan;
			this._magenta=cmyk.magenta;
			this._yellow=cmyk.yellow;
			this._black=cmyk.black;
			return value;
		}
		
		/**
		 * 
		 * @param cyan Number (between 0 and 100)
		 * @param magenta Number (between 0 and 100)
		 * @param yellow Number (between 0 and 100)
		 * @param black Number (between 0 and 100)
		 * 
		 */		
		public function new(?cyan:Float=0, ?magenta:Float=0, ?yellow:Float=0, ?black:Float=0)
		{
			
			this._cyan=Math.min(100, Math.max(cyan, 0));
			this._magenta=Math.min(100, Math.max(magenta, 0));
			this._yellow=Math.min(100, Math.max(yellow, 0));
			this._black=Math.min(100, Math.max(black, 0));
			this._color=this.generateColorsFromCMYK(_cyan, _magenta, _yellow, _black);
		}
		
		public function clone():IColor { return new CMYK(_cyan, _magenta, _yellow, _black); }
		
		/* @private */
		function generateColorsFromHex(color:Int):CMYK
		{
			var r:Int = color >> 16 & 0xFF;
			var g:Int = color >> 8 & 0xFF;
			var b:Int = color & 0xFF; 
			
			
			var c:Float;
			var m:Float;
			var y:Float;
			var k:Float;
			var var_K:Float;
			
			 c = 1 - ( r / 255 );
			 m = 1 - ( g / 255 );
			 y = 1 - ( b / 255 );
			var_K = 1;
			
			if ( c < var_K )   var_K = c;
			if ( m < var_K )   var_K = m;
			if ( y < var_K )   var_K = y;
			if ( var_K == 1 ) { //Black
			   c = 0;
			   m = 0;
			   y = 0;
			}
			else {
			   c = ( c - var_K ) / ( 1 - var_K ) *100;
			   m = ( m - var_K ) / ( 1 - var_K ) *100;
			   y = ( y - var_K ) / ( 1 - var_K ) *100;
			}
			 k = var_K*100;
			 
			 
			 return new CMYK(c,m,y,k);
		}	
		
		/* @private */
		function generateColorsFromCMYK(cyan:Float, magenta:Float, yellow:Float, black:Float):Int
		{
			
			cyan = Math.min(100, cyan + black);
			magenta = Math.min(100, magenta + black);
			yellow = Math.min(100, yellow + black);
			
			var r:Int = Math.round((100-cyan)*(255/100));
			var g:Int = Math.round((100-magenta)*(255/100));
			var b:Int = Math.round((100-yellow)*(255/100));
			
			return (r << 16 ^ g << 8 ^ b);
		}
	}
