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

	public function new():Void {
		super();

		schemes = [Analogous,Complementary,Compound,FlippedCompound,Monochrome,SplitComplementary,Tetrad,Triad];
		
		var schemeS = Arctic.makeTextChoiceBlocks(schemes.map(getClassName).array(),switchToScheme).blocks;
		schemeS.unshift(Arctic.makeText("Color schemes"));
		
		var gui = 
			Border( 5, 5,
				Frame( 2, 0x000000, 
					Background(0xDDDDDD, 
						Border( 10, 10,
							ColumnStack( [ 
								LineStack(schemeS)
							] )
						), 
					null, 10),
				10, null, 0, 0)
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

	private function switchToScheme(i:Int,s:String):Void {
	
	}

	static public function main():Void {
		Lib.current.addChild(new GraphicalTest());
	}
}
