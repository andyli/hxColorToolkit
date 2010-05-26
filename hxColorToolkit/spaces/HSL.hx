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

		
	
	class HSL implements IColor {
		private var _color:Int;
		public var color(getColor, setColor) : Int;		
		public var hue(getHue, setHue) : Float;		
		public var lightness(getLightness, setLightness) : Float;		
		public var saturation(getSaturation, setSaturation) : Float;
		
		/* @private */
		var _hue:Float;
		var _saturation:Float;
		var _lightness:Float;
		
		
		/**
		 * Hue color value
		 * @return Number (between 0 and 360)
		 * 
		 */	
		private function getHue():Float{ return this._hue; }
		
		/**
		 * Hue color value
		 * @param value Number (between 0 and 360)
		 * 
		 */
		private function setHue(value:Float):Float{
			this._hue=Math.min(360, Math.max(value, 0));
			this._color=this.generateColorFromHSL(_hue, _saturation, _lightness);
			return value;
		}
		
		/**
		 * Saturation color value
		 * @return Number (between 0 and 100)
		 * 
		 */	
		private function getSaturation():Float{ return this._saturation; }
		
		/**
		 * Saturation color value
		 * @param value Number (between 0 and 100)
		 * 
		 */
		private function setSaturation(value:Float):Float{
			this._saturation=Math.min(100, Math.max(value, 0));
			this._color=this.generateColorFromHSL(_hue, _saturation, _lightness);
			return value;
		}
		
		/**
		 * Black color value
		 * @return Number (between 0 and 100)
		 * 
		 */	
		private function getLightness():Float{ return this._lightness; }
		
		/**
		 * Black color value
		 * @param value Number (between 0 and 100)
		 * 
		 */	
		private function setLightness(value:Float):Float{
			this._lightness=Math.min(100, Math.max(value, 0));
			this._color=this.generateColorFromHSL(_hue, _saturation, _lightness);
			return value;
		}
		
		/**
		 * Hexidecimal RGB translation of HSB color
		 * @return Hexidecimal color value
		 * 
		 */	
		private function getColor():Int{ return this._color; }
		
		/**
		 * Hexidecimal RGB translation of HSB color
		 * @param value Hexidecimal color value
		 * 
		 */		
		private function setColor(value:Int):Int{
			this._color=cast value;
			var hsl:HSL = this.generateColorFromHex(cast value);
			this._hue=hsl.hue;
			this._saturation=hsl.saturation;
			this._lightness=hsl.lightness;
			return value;
		}
		
		/**
		 * 
		 * @param hue (between 0 and 360)
		 * @param saturation (between 0 and 100)
		 * @param black (between 0 and 100)
		 * 
		 */		
		public function new(?hue:Float=0, ?saturation:Float=0, ?lightness:Float=0)
		{
			
			this._hue=Math.min(360, Math.max(hue, 0));
			this._saturation=Math.min(100, Math.max(saturation, 0));
			this._lightness=Math.min(100, Math.max(lightness, 0));
			this._color = this.generateColorFromHSL(_hue, _saturation, _lightness);
		}
		
		public function clone():IColor { return new HSL(_hue, _saturation, _lightness); }
		
		/* @private */
		/*
		Thank you Michael Jackson
		http://www.mjijackson.com/2008/02/rgb-to-hsl-and-rgb-to-hsv-color-model-conversion-algorithms-in-javascript
		*/
		function generateColorFromHex(color:Int):HSL
		{
			var r:Float = color >> 16 & 0xFF;
			var g:Float = color >> 8 & 0xFF;
			var b:Float = color & 0xFF; 	
			
			r /= 255;
			g /= 255;
			b /= 255;
    		var max:Float = Math.max(r, Math.max(g, b));
    		var min:Float = Math.min(r, Math.min(g, b));
    		var h:Float, s:Float, l:Float;
    		
    		h=s=l=(max+min)/2;

		    if(max == min){
		        h = s = 0; 
		    }else{
		        var d:Float = max - min;
		        s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
		        switch(max){
		            case r: h = (g - b) / d + (g < b ? 6 : 0);
		            case g: h = (b - r) / d + 2;
		            case b: h = (r - g) / d + 4;
		        }
		        h /= 6;
		    }			
			
			h=Math.round(h*360);
			s=Math.round(s*100);
			l=Math.round(l*100);
			
			return new HSL(h, s, l);
		}	
		
		/* @private */
		/*
		Thank you Michael Jackson
		http://www.mjijackson.com/2008/02/rgb-to-hsl-and-rgb-to-hsv-color-model-conversion-algorithms-in-javascript
		*/
		function generateColorFromHSL(hue:Float, saturation:Float, lightness:Float):Int
		{
			hue/=360; 
			saturation/=100;
			lightness/=100;
			
			var r:Float, g:Float, b:Float;

		    if(saturation == 0){
		        r = g = b = lightness; // achromatic
		    }else{
		        var q = lightness < 0.5 ? lightness * (1 + saturation) : lightness + saturation - lightness * saturation;
		        var p = 2 * lightness - q;
		        r = hue2rgb(p, q, hue + 1/3);
		        g = hue2rgb(p, q, hue);
		        b = hue2rgb(p, q, hue - 1/3);
		    }
			
			return (Math.round(r*255) << 16 ^ Math.round(g*255) << 8 ^ Math.round(b*255));
		}

		function hue2rgb(p:Float, q:Float, t:Float):Float {
            if(t < 0) t += 1;
            if(t > 1) t -= 1;
            if(t < 1/6) return p + (q - p) * 6 * t;
            if(t < 1/2) return q;
            if(t < 2/3) return p + (q - p) * (2/3 - t) * 6;
           
            return p;
        }
	}
