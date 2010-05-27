import flash.Lib;
import flash.display.Sprite;

import arctic.Arctic;
import arctic.ArcticBlock;
import arctic.ArcticView;
import arctic.ArcticMC;

import hxColorToolkit.ColorToolkit;
import hxColorToolkit.schemes.IColorScheme;
import hxColorToolkit.schemes.Analogous;
import hxColorToolkit.schemes.Complementary;
import hxColorToolkit.schemes.Compound;
import hxColorToolkit.schemes.FlippedCompound;
import hxColorToolkit.schemes.Monochrome;
import hxColorToolkit.schemes.SplitComplementary;
import hxColorToolkit.schemes.Tetrad;
import hxColorToolkit.schemes.Triad;
import hxColorToolkit.spaces.CMYK;
import hxColorToolkit.spaces.Gray;
import hxColorToolkit.spaces.HSB;
import hxColorToolkit.spaces.HSL;
import hxColorToolkit.spaces.Lab;
import hxColorToolkit.spaces.RGB;
import hxColorToolkit.spaces.XYZ;
import hxColorToolkit.spaces.YUV;
import hxColorToolkit.spaces.IColor;

using Lambda;

class GraphicalTest extends Sprite{
	public var schemes:Array<Dynamic>;
	public var arcticView:ArcticView;
	public var primaryColorBlock:MutableBlock;

	public function new():Void {
		super();

		schemes = [Analogous,Complementary,Compound,FlippedCompound,Monochrome,SplitComplementary,Tetrad,Triad];
		primaryColorBlock = new MutableBlock(Background(0x0000FF, Fixed(20,20)));
		var gui = 
			Border( 5, 5,
				Frame( 2, 0x000000, 
					Background(0xFFFFFF, 
						Border( 10, 10,
							LineStack( [ 
								Arctic.makeText("Primary color"),
								ColumnStack([
									Mutable(primaryColorBlock),
									TextInput("0000FF",50,20,changePrimaryColor,null,6,null,0xFFFFFF,true)
								]),
								Fixed(null,15),
								Arctic.makeText("Color schemes"),
								LineStack(
									Arctic.makeTextChoiceBlocks(schemes.map(getClassName).array(),switchToScheme).blocks
								),
								Fixed(null,15),
								Frame( 2, 0x000000,
									Arctic.makeSimpleButton("Run",run),
								10, 50, 0, 0)
							] )
						), 
					80, 10),
				10, 50, 0, 0)
			);

		arcticView = new ArcticView( Arctic.makeDragable(true,true,true,gui).block, ArcticMC.getCurrentClip() );
		arcticView.display(false);
		arcticView.onResize();
	}

	private function getClassName(c:Class<Dynamic>):String {
		var s = Type.getClassName(c);
		var dotPos = s.lastIndexOf(".");
		return (dotPos > -1) ? s.substr(dotPos+1) : s;
	}

	private function changePrimaryColor(s:String):Bool {
		s = s.toUpperCase();
		for (char in s.split("")) {
			if ("1234567890ABCDEF".indexOf(char) == -1) return false;
		}
		
		var color = Std.parseInt("0x"+s);
		primaryColorBlock.block = Background(color, Fixed(20,20));
		return true;
	}

	private function switchToScheme(i:Int,s:String):Void {
	
	}

	private function run():Void {
	
	}

	static public function main():Void {
		Lib.current.addChild(new GraphicalTest());
	}
}
