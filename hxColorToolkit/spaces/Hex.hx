/*
Author: Andy Li (andy@onthewings.net)
Based on colortoolkit (http://code.google.com/p/colortoolkit/)
*/
 
package hxColorToolkit.spaces;

class Hex implements Color {
	
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
		return new RGB(data >> 16, data >> 8 & 0xFF, data & 0xFF);
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

	public var red(getRed,setRed):Int;
	public var green(getGreen,setGreen):Int;
	public var blue(getBlue,setBlue):Int;

	inline private function getRed():Int {
		return data >> 16;
	}

	inline private function getGreen():Int {
		return data >> 8 & 0xFF;
	}

	inline private function getBlue():Int {
		return data & 0xFF;
	}

	private function setRed(v:Int):Int {
		data = 
			if (v <= 0) 
				data & 0x00FFFF;
			else if (v >= 255) 
				data | 0xFF0000;
			else 
				(data & 0x00FFFF) | (v << 16);
		return v;
	}

	private function setGreen(v:Int):Int {
		data = 
			if (v <= 0)
				data & 0xFF00FF;
			else if (v >= 255)
				data | 0x00FF00;
			else
				(data & 0xFF00FF) | (v << 8);
		return v;
	}

	private function setBlue(v:Int):Int {
		data = 
			if (v <= 0)
				data & 0xFFFF00;
			else if (v >= 255)
				data | 0x0000FF;
			else
				(data & 0xFFFF00) | v;
		return v;
	}
	
	public function new(?color:Int = 0):Void {
		numOfChannels = 1;
		data = color;
	}
	
	public function clone() { return new Hex(data); }
	
	public function interpolate(target:Color, ratio:Float = 0.5):Hex {
		var target:Hex = Std.is(target,Hex) ? cast target : new Hex().fromRGB(target.toRGB());
		return new Hex(toRGB().interpolate(target.toRGB(), ratio).getColor());
	}

	private var data:Int;
}
