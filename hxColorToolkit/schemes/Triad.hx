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

package hxColorToolkit.schemes;

import hxColorToolkit.ColorToolkit;
import hxColorToolkit.spaces.HSB;
import hxColorToolkit.spaces.IColor;

class Triad<C:IColor> extends ColorWheelScheme<C> {
	
	public var angle(getAngle, setAngle) : Float;
	var _angle:Float;
	
	public function getAngle():Float{ return _angle; }
	public function setAngle(value:Float):Float{
		_colors = new ColorList<C>();
		_angle=value;
		generate();	
		return value;
	}
	
	public function new(primaryColor:C, ?angle:Float=120)
	{
		_angle=angle;
		super(primaryColor);
	}
	
	override function generate():Void
	{
		var c1:HSB = new HSB();
		c1.color = ColorUtil.rybRotate(_primaryColor.color, _angle);

		c1.brightness+=10;
		_colors.addColor(mutateFromPrimary(c1.color));	

		var c2:HSB = new HSB();
		c2.color = ColorUtil.rybRotate(_primaryColor.color, -_angle);
		
		c2.brightness+=10;
		_colors.addColor(mutateFromPrimary(c2.color));	
	}

}
