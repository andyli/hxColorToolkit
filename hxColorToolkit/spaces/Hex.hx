/*
Author: Andy Li (andy@onthewings.net)
Based on colortoolkit (http://code.google.com/p/colortoolkit/)
*/
 
package hxColorToolkit.spaces;

class Hex implements Color<Hex> {
	
	public var numOfChannels(default,null):Int;

	inline public function getValue(channel:Int):Float {
		return data;
	}
	inline public function setValue(channel:Int,val:Float):Float {
		data = Math.round(Math.min(maxValue(channel), Math.max(val, minValue(channel))));
		return val;
	}

	inline public function minValue(channel:Int):Float {
		return 0;
	}
	inline public function maxValue(channel:Int):Float {
		return 0xFFFFFF;
	}
	
	inline public function toRGB():RGB {
		return new RGB(data >> 16 & 0xFF, data >> 8 & 0xFF, data & 0xFF);
	}
	
	inline public function getColor():Int {
		return data;
	}
	
	public function fromRGB(rgb:RGB):Hex {
		data = rgb.getColor();
		return this;
	}

	inline public function setColor(color:Int):Hex {
		data = color;
		return this;
	}
	
	public function new(?color:Int = 0):Void {
		numOfChannels = 1;
		data = color;
	}
	
	public function clone() { return new Hex(data); }
	
	public function interpolate(target:Hex, ratio:Float = 0.5):Hex {
		return new Hex(toRGB().interpolate(target.toRGB(), ratio).getColor());
	}

	private var data:Int;
}
