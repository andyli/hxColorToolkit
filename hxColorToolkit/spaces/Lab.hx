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

class Lab implements IColor {

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
		return channel == 0 ? 0 : -128;
	}
	inline public function maxValue(channel:Int):Float {
		return channel == 0 ? 100 : 127;
	}

	inline public var lightness(getLightness, setLightness) : Float;
	inline public var a(getA, setA) : Float;
	inline public var b(getB, setB) : Float;
	
	public function getColor():Int{
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
		
		return xyz.getColor();
	}
	
	public function setColor(value:Int):Int{
		var xyz:XYZ = new XYZ();
		xyz.setColor(value);
		
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
		
		this.lightness = ( 116 * y ) - 16;
		this.a = 500 * ( x - y );
		this.b = 200 * ( y - z );
		
		return getColor();
	}
	
	private function getLightness():Float{
		return getValue(0);
	}
	
	private function setLightness(value:Float):Float{
		return setValue(0,value);
	}

	private function getA():Float{
		return getValue(1);
	}

	private function setA(value:Float):Float{
		return setValue(1,value);
	}
	
	private function getB():Float{
		return getValue(2);
	}
	
	private function setB(value:Float):Float{
		return setValue(2,value);
	}

	public function new(?lightness:Float=0, ?a:Float=0, ?b:Float=0)
	{
		numOfChannels = 3;
		data = [];
		this.lightness=lightness;
		this.a=a;
		this.b=b;
	}
	
	public function clone():IColor { return new Lab(lightness, a, b); }

	private var data:Array<Float>;

}
