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

class CMYK implements Color<CMYK> {

	public var numOfChannels(default,null):Int;

	public function getValue(channel:Int):Float {
		return data[channel];
	}
	public function setValue(channel:Int,val:Float):Float {
		if (channel < 0 || channel >= numOfChannels) return Math.NaN;
		data[channel] = Math.min(maxValue(channel), Math.max(val, minValue(channel)));
		return val;
	}

	inline public function minValue(channel:Int):Float {
		return 0;
	}
	inline public function maxValue(channel:Int):Float {
		return 100;
	}

	/**
	 * Black color channel
	 * @return Number (between 0 and 100)
	 */
	inline public var black(getBlack, setBlack) : Float;

	/**
	 * Cyan color channel
	 * @return Number (between 0 and 100)
	 */
	inline public var cyan(getCyan, setCyan) : Float;

	/**
	 * Magenta color channel
	 * @return Number (between 0 and 100)
	 */
	inline public var magenta(getMagenta, setMagenta) : Float;

	/**
	 * Yellow color channel
	 * @return Number (between 0 and 100)
	 */
	inline public var yellow(getYellow, setYellow) : Float;
	
	
	private function getCyan():Float {
		return getValue(0);
	}
	
	private function setCyan(value:Float):Float {
		return setValue(0,value);
	}
	
	private function getMagenta():Float {
		return getValue(1);
	}
	
	private function setMagenta(value:Float):Float {
		return setValue(1,value);
	}
	
	private function getYellow():Float {
		return getValue(2);
	}
	
	private function setYellow(value:Float):Float {
		return setValue(2,value);
	}
	
	private function getBlack():Float {
		return getValue(3);
	}
	
	private function setBlack(value:Float):Float {
		return setValue(3,value);
	}
	
	public function toRGB():RGB {
		var cyan = Math.min(100, cyan + black);
		var magenta = Math.min(100, magenta + black);
		var yellow = Math.min(100, yellow + black);
		
		return new RGB((100 - cyan) * 2.55, (100 - magenta) * 2.55, (100 - yellow) * 2.55);
	}
	
	/**
	 * Hexidecimal RGB translation of CMYK color
	 * @return Hexidecimal color value
	 */		
	public function getColor():Int {
		return toRGB().getColor();
	}
	
	public function fromRGB(rgb:RGB):Void {
		var r = rgb.red;
		var g = rgb.green;
		var b = rgb.blue;
		
		
		var c:Float = 1 - ( r / 255 );
		var m:Float = 1 - ( g / 255 );
		var y:Float = 1 - ( b / 255 );
		var k:Float;
		var var_K:Float = 1;

		if ( c < var_K )   var_K = c;
		if ( m < var_K )   var_K = m;
		if ( y < var_K )   var_K = y;
		if ( var_K == 1 ) { //Black
			c = m = y = 0;
		}
		else {
			c = ( c - var_K ) / ( 1 - var_K ) *100;
			m = ( m - var_K ) / ( 1 - var_K ) *100;
			y = ( y - var_K ) / ( 1 - var_K ) *100;
		}
		k = var_K*100;

		this.cyan = c;
		this.magenta = m;
		this.yellow = y;
		this.black = k;
	}
	
	/**
	 * Hexidecimal RGB translation of CMYK color
	 * @param value Hexidecimal color value
	 */		
	public function setColor(color:Int):Void{
		fromRGB(new RGB(color >> 16 & 0xFF, color >> 8 & 0xFF, color & 0xFF));
	}
	
	/**
	 * @param cyan Number (between 0 and 100)
	 * @param magenta Number (between 0 and 100)
	 * @param yellow Number (between 0 and 100)
	 * @param black Number (between 0 and 100)
	 */		
	public function new(?cyan:Float=0, ?magenta:Float=0, ?yellow:Float=0, ?black:Float=0)
	{
		numOfChannels = 4;
		data = [];
		this.cyan = cyan;
		this.magenta = magenta;
		this.yellow = yellow;
		this.black = black;
	}
	
	public function clone() { return new CMYK(cyan, magenta, yellow, black); }

	private var data:Array<Float>;
}
