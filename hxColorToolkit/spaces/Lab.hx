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

//via http://www.adobe.com/cfusion/communityengine/index.cfm?event=showdetails&productId=2&postId=14227

//@see http://en.wikipedia.org/wiki/Lab_color_space

package hxColorToolkit.spaces;

	
	
	
	/**
	 * @author pj
	 */
	class Lab implements IColor {
		/* @private */
		
		public var a(getA, setA) : Float;
		public var b(getB, setB) : Float;
		private var _color:Int;
		public var color(getColor, setColor) : Int;
		public var lightness(getLightness, setLightness) : Float;
		/* @private */
		var _lightness:Float;
		var _a:Float;
		var _b:Float;
		
		private function getColor():Int{ return this._color; }
		private function setColor(value:Int):Int{
			this._color=value;
			var lab:Lab = generateLabFromHex(value);
			this._lightness=lab.lightness;
			this._a=lab.a;
			this._b=lab.b;

			return value;
		}

		private function getLightness():Float{ return this._lightness; }
		private function setLightness(value:Float):Float{
			this._lightness=value;
			this._color=this.generateColorFromLab(this._lightness, this._a, this._b);
			return value;
		}
		
		private function getA():Float{ return this._a; }
		private function setA(value:Float):Float{
			this._a=value;
			this._color=this.generateColorFromLab(this._lightness, this._a, this._b);
			return value;
		}
		
		private function getB():Float{ return this._b; }
		private function setB(value:Float):Float{
			this._b=value;
			this._color=this.generateColorFromLab(this._lightness, this._a, this._b);
			return value;
		}

		public function new(?lightness:Float=0, ?a:Float=0, ?b:Float=0)
		{
			
			this._lightness=lightness;
			this._a=a;
			this._b=b;
			this._color=generateColorFromLab(_lightness, _a, _b);
		}
		
		public function clone():IColor { return new Lab(_lightness, _a, _b); }
	
		/* @private */
		function generateColorFromLab(lightness:Float, a:Float, b:Float):Int
		{
			var REF_X:Float = 95.047; // Observer= 2°, Illuminant= D65
			var REF_Y:Float = 100.000; 
			var REF_Z:Float = 108.883; 
			
			var y:Float = (lightness + 16) / 116;
			var x:Float = a / 500 + y;
			var z:Float = y - b / 200;
			 
			if ( Math.pow( y , 3 ) > 0.008856 ) { y = Math.pow( y , 3 ); }
			else { y = ( y - 16 / 116 ) / 7.787; }
			if ( Math.pow( x , 3 ) > 0.008856 ) { x = Math.pow( x , 3 ); }
			else { x = ( x - 16 / 116 ) / 7.787; }
			if ( Math.pow( z , 3 ) > 0.008856 ) { z = Math.pow( z , 3 ); }
			else { z = ( z - 16 / 116 ) / 7.787; }
			 
			var xyz:XYZ = new XYZ(REF_X * x, REF_Y * y, REF_Z * z);
			
			return xyz.color;
		}
		
		/* @private */
		function generateLabFromHex(color:Int):Lab
		{
			var xyz:XYZ = new XYZ();
			xyz.color=color;
			
			var REF_X:Float = 95.047; // Observer= 2°, Illuminant= D65
			var REF_Y:Float = 100.000; 
			var REF_Z:Float = 108.883; 
			var x:Float = xyz.x / REF_X;   
			var y:Float = xyz.y / REF_Y;  
			var z:Float = xyz.z / REF_Z;  
			 
			if ( x > 0.008856 ) { x = Math.pow( x , 1/3 ); }
			else { x = ( 7.787 * x ) + ( 16/116 ); }
			if ( y > 0.008856 ) { y = Math.pow( y , 1/3 ); }
			else { y = ( 7.787 * y ) + ( 16/116 ); }
			if ( z > 0.008856 ) { z = Math.pow( z , 1/3 ); }
			else { z = ( 7.787 * z ) + ( 16/116 ); }			
			
			return new Lab(( 116 * y ) - 16, 500 * ( x - y ), 200 * ( y - z ));
		}
	}
