import flash.Lib;
import flash.display.Sprite;

import hxColorToolkit.Color;

class GraphicalTest extends Sprite{
	public function new():Void {
		super();
	}

	static public function main():Void {
		Lib.current.addChild(new GraphicalTest());
	}
}
