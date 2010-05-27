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

class HSB implements IColor {

	public var numOfChannels(default,null):Int;

	public function getValue(channel:Int):Float {
		return data[channel];
	}
	public function setValue(channel:Int,val:Float):Float {
		if (channel < 0 || channel >= numOfChannels) return Math.NaN;
		data[channel] = Math.min(maxValue(channel), Math.max(val, minValue(channel)));
		return data[channel];
	}

	inline public function minValue(channel:Int):Float {
		return 0;
	}
	inline public function maxValue(channel:Int):Float {
		return channel == 0 ? 360 : 100;
	}

	/**
	 * Hue color value
	 * @return Number (between 0 and 360)
	 */	
	inline public var hue(getHue, setHue) : Float;

	/**
	 * Saturation color value
	 * @return Number (between 0 and 100)
	 */	
	inline public var saturation(getSaturation, setSaturation) : Float;

	/**
	 * Black color value
	 * @param value Number (between 0 and 100)
	 */	
	inline public var brightness(getBrightness, setBrightness) : Float;
	
	
	private function getHue():Float{
		return getValue(0);
	}

	private function setHue(value:Float):Float{
		return setValue(0,value);
	}
	
	private function getSaturation():Float{
		return getValue(1);
	}
	
	private function setSaturation(value:Float):Float{
		return setValue(1,value);
	}
	
	private function getBrightness():Float{
		return getValue(2);
	}
	
	private function setBrightness(value:Float):Float{
		return setValue(2,value);
	}
	
	/**
	 * Hexidecimal RGB translation of HSB color
	 * @return Hexidecimal color value
	 * 
	 */	
	public function getColor():Int {
		var hue = hue; 
		var saturation = saturation;
		var brightness = brightness;
		var r:Float = 0, g:Float = 0, b:Float = 0, i:Float, f:Float, p:Float, q:Float, t:Float;
		hue%=360;
		if(brightness==0) 
		{
			return 0;
		}
		saturation/=100;
		brightness/=100;
		hue/=60;
		i = Math.floor(hue);
		f = hue-i;
		p = brightness*(1-saturation);
		q = brightness*(1-(saturation*f));
		t = brightness*(1-(saturation*(1-f)));
		if (i==0) {r=brightness; g=t; b=p;}
		else if (i==1) {r=q; g=brightness; b=p;}
		else if (i==2) {r=p; g=brightness; b=t;}
		else if (i==3) {r=p; g=q; b=brightness;}
		else if (i==4) {r=t; g=p; b=brightness;}
		else if (i==5) {r=brightness; g=p; b=q;}

		return (Math.round(r*255) << 16 ^ Math.round(g*255) << 8 ^ Math.round(b*255));
	}
	
	/**
	 * Hexidecimal RGB translation of HSB color
	 * @param value Hexidecimal color value
	 * 
	 */		
	public function setColor(color:Int):Int{
		var tmp = generateColorFromHex(color);
		this.hue = tmp.hue;
		this.saturation = tmp.saturation;
		this.brightness = tmp.brightness;
		return getColor();
	}
	
	/**
	 * @param hue (between 0 and 360)
	 * @param saturation (between 0 and 100)
	 * @param black (between 0 and 100)
	 */		
	public function new(?hue:Float=0, ?saturation:Float=0, ?brightness:Float=0):Void {
		numOfChannels = 3;
		data = [];
		this.hue = hue;
		this.saturation = saturation;
		this.brightness = brightness;
	}

	public function clone():IColor { return new HSB(hue, saturation, brightness); }

	private var data:Array<Float>;


	private function generateColorFromHex(color:Int):HSB
		{
			var r:Float = color >> 16 & 0xFF;
			var g:Float = color >> 8 & 0xFF;
			var b:Float = color & 0xFF; 
			
			r/=255;
			g/=255;
			b/=255;
			
			var h:Float, s:Float, v:Float;
    		var min:Float, max:Float, delta:Float;

			min = Math.min( r, Math.min(g, b) );
			max = Math.max( r, Math.max(g, b) );
			
			v = max*100;

			delta = max - min;

			if( max != 0 )
			{
				s = (delta / max)*100;
			} else {
				s = 0;
				h = -1;
				
				return new HSB(h, s, v);
			}

			if(delta == 0) {
				return new HSB(0, s, v);
			}

			if( r == max )
			{
				h = ( g - b ) / delta;
			} else if( g == max ) {
				h = 2 + ( b - r ) / delta;
			} else {
				h = 4 + ( r - g ) / delta;
			}

			h *= 60;
			if( h < 0 ) h += 360;
			
			
			return new HSB(h, s, v);
		}
}
