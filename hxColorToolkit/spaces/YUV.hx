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

	//http://en.wikipedia.org/wiki/YUV
	//http://www.fourcc.org/fccyvrgb.php
	
	
	
	class YUV implements IColor {
		
		private var _color:Int;
		public var color(getColor, setColor) : Int;
		public var u(getU, setU) : Float;
		public var v(getV, setV) : Float;
		public var y(getY, setY) : Float;
		var _y:Float;
		var _u:Float;
		var _v:Float;
		
		private function getColor():Int{ return this._color; }
		private function setColor(value:Int):Int{
			this._color=value;
			var yuv:YUV = this.generateYUVFromColor(value);
			this._y=yuv.y;
			this._u=yuv.u;
			this._v=yuv.v;
			return value;
		}
		
		private function getY():Float{ return this._y; }
		private function setY(value:Float):Float{
			this._y=value;
			this._color=this.generateColorFromYUV(this._y, this._u, this._v);
			return value;
		}
		
		private function getU():Float{ return this._u; }
		private function setU(value:Float):Float{
			this._u=value;
			this._color=this.generateColorFromYUV(this._y, this._u, this._v);
			return value;
		}
		
		private function getV():Float{ return this._v; }
		private function setV(value:Float):Float{
			this._v=value;
			this._color=this.generateColorFromYUV(this._y, this._u, this._v);
			return value;
		}
		
		public function new(?y:Float=0, ?u:Float=0, ?v:Float=0)
		{
			
			_y=y;
			_u=u;
			_v=v;
			_color=generateColorFromYUV(y,u,v);
		}
		
		public function clone():IColor { return new YUV(_y, _u, _v); }
		
		/* @private */
		function generateColorFromYUV(y:Float, u:Float, v:Float):Int
		{
			var r = Math.max(0, Math.min(y+1.402*(v-128), 255));
			var g = Math.max(0, Math.min(y-0.344*(u-128)-0.714*(v-128), 255));
			var b = Math.max(0, Math.min(y+1.772*(u-128), 255));
			
			return Math.round(r) << 16 | Math.round(g) << 8 | Math.round(b);
		}
		
		/* @private */
		function generateYUVFromColor(color:Int):YUV
		{
			var r:Float = (color >> 16 & 0xFF);
			var g:Float = (color >> 8 & 0xFF);
			var b:Float = (color & 0xFF);
			return new YUV(0.299*r + 0.587*g + 0.114*b, r*-0.169 + g*-0.331 + b*0.499 + 128, r*0.499 + g*-0.418 + b*-0.0813 + 128);
		}

	}
