import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;

import arctic.Arctic;
import arctic.ArcticBlock;
import arctic.ArcticView;
import arctic.ArcticMC;

import feffects.Tween;
import feffects.easing.Bounce;

import hxColorToolkit.ColorToolkit;
import hxColorToolkit.schemes.ColorScheme;
import hxColorToolkit.schemes.ColorWheelScheme;
import hxColorToolkit.schemes.Analogous;
import hxColorToolkit.schemes.Complementary;
import hxColorToolkit.schemes.Compound;
import hxColorToolkit.schemes.FlippedCompound;
import hxColorToolkit.schemes.Monochrome;
import hxColorToolkit.schemes.SplitComplementary;
import hxColorToolkit.schemes.Tetrad;
import hxColorToolkit.schemes.Triad;
import hxColorToolkit.spaces.Color;
import hxColorToolkit.spaces.CMYK;
import hxColorToolkit.spaces.Gray;
import hxColorToolkit.spaces.Hex;
import hxColorToolkit.spaces.HSB;
import hxColorToolkit.spaces.HSL;
import hxColorToolkit.spaces.Lab;
import hxColorToolkit.spaces.RGB;
import hxColorToolkit.spaces.XYZ;
import hxColorToolkit.spaces.YUV;

using Lambda;

class GraphicalTest extends Sprite{
	public var schemes:Array<Dynamic>;
	public var arcticView:ArcticView;
	public var primaryColorBlock:MutableBlock;
	public var fxLayer:Sprite;
	public var color:Int;
	public var scheme:ColorWheelScheme<Hex, Dynamic>;
	public var colors:Array<Int>;
	public var palette:Sprite;

	public function new():Void {
		super();
		
		if (stage == null) {
			addEventListener(Event.ADDED_TO_STAGE,init,false,0,true);
		} else {
			init();
		}
	}

	private function init(e:Event = null):Void {
		fxLayer = new Sprite();
		addChild(fxLayer);

		palette = new Sprite();
		palette.filters = [new flash.filters.GlowFilter(0xFFFFFF)];
		addChild(palette);

		color = 0x0000FF;

		schemes = [Analogous,Complementary,Compound,FlippedCompound,Monochrome,SplitComplementary,Tetrad,Triad];
		primaryColorBlock = new MutableBlock(Background(color, Fixed(20,20)));
		var gui = 
			Border( 5, 5,
				Frame( 2, 0x000000, 
					Background(0xFFFFFF, 
						Border( 10, 10,
							LineStack( [ 
								Arctic.makeText("Primary color"),
								ColumnStack([
									Mutable(primaryColorBlock),
									TextInput(StringTools.hex(color,6),50,20,changePrimaryColor,null,6,null,0xFFFFFF,true)
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

		arcticView = new ArcticView( Arctic.makeDragable(true,true,true,gui).block, this );
		arcticView.display(false);
		arcticView.onResize();

		switchToScheme(0);
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
		
		color = Std.parseInt("0x"+s);
		scheme.primaryColor = new Hex(color);
		generateColors();
		primaryColorBlock.block = Background(color, Fixed(20,20));
		return true;
	}

	private function switchToScheme(i:Int,?s:String/*dummy*/):Void {
		scheme = Type.createInstance(schemes[i],[new Hex(color)]);
		generateColors();
		//trace(colors.length);
	}

	private function generateColors():Void {
		colors = ColorToolkit.intArray(scheme);

		var g = palette.graphics;
		g.clear();
		var x = 0;
		var h = 15;
		for (c in colors) {
			g.beginFill(c,1);
			g.drawRect(x,0,h,h);
			g.endFill();
			x += h;
		}
		palette.x = stage.stageWidth*0.5 - palette.width*0.5;
		palette.y = stage.stageHeight*0.5 - palette.height*0.5;
	}

	private function run():Void {
		for (i in 0...200) {
			var cir = new Sprite();
			//cir.blendMode = flash.display.BlendMode.ADD;

			//circle center
			var x = Math.random()*stage.stageWidth;
			var y = Math.random()*stage.stageHeight;

			var radius = 10+Math.random()*100;
			
			var colors = colors;
			var alpha = 0.2+Math.random()*0.8;

			//tween radius
			var tw:Tween = new Tween(	0,
										radius,
										Std.int(Math.random()*2000),
										Bounce.easeInOut);

			var drawCir = 
				function(e:Float):Void {
					var g = cir.graphics;
					var c = colors[Std.int(Math.random()*colors.length)];
					g.clear();
					g.beginFill(c,alpha);
					g.drawCircle(x,y,e);
					g.endFill();
				};
			
			tw.setTweenHandlers(
				drawCir,
				function(e:Float){
					var twr = new Tween(	radius,
										0,
										tw.duration,
										Bounce.easeInOut);
					twr.setTweenHandlers(drawCir,function(e:Float) cir.parent.removeChild(cir));
					haxe.Timer.delay(twr.start,5000);
				}
			);
			
			haxe.Timer.delay(tw.start,Std.int(Math.random()*1000));

			fxLayer.addChild(cir);
		}
	}

	static public function main():Void {
		Lib.current.addChild(new GraphicalTest());
	}
}
