/*
Author: Andy Li (andy@onthewings.net)
Based on colortoolkit (http://code.google.com/p/colortoolkit/)
*/
 
package hxColorToolkit.spaces;

class Hex implements Color<Hex> {
	
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
		return 0xFFFFFF;
	}
	
	public function getColor():Int {
		return cast getValue(0);
	}

	public function setColor(color:Int):Void {
		setValue(0,color);
	}
	
	public function new(?color:Int = 0):Void {
		numOfChannels = 1;
		data = [];
		this.setColor(color);
	}
	
	public function clone() { return new Hex(getColor()); }

	private var data:Array<Float>;
}
