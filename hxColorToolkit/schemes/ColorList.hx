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

#if !cpp
import haxe.FastList;
#end

import hxColorToolkit.Color;
import hxColorToolkit.spaces.IColor;
import hxColorToolkit.spaces.RGB;
import hxColorToolkit.spaces.HSB;
import hxColorToolkit.spaces.CMYK;
import hxColorToolkit.spaces.Lab;
import hxColorToolkit.spaces.XYZ;
import hxColorToolkit.spaces.HSL;

using hxColorToolkit.ColorUtil;

class ColorList<C:IColor> {
	#if !cpp
	private var data:FastList<C>;
	#else
	private var data:List<C>;
	#end
	
	public function empty():Void
	{
		//while(!data.isEmpty()) data.pop();
		#if !cpp
		data = new FastList<C>();
		#else
		data = new List<C>();
		#end
	}
	
	public function new():Void {
		#if !cpp
		data = new FastList<C>();
		#else
		data = new List<C>();
		#end
	}

	public function iterator():Iterator<C> {
		return data.iterator();
	}

	public function addColor(color:C):Void {
		data.add(color);
	}

	public function removeColor(color:C):Void {
		data.remove(color);
	}
	
	public function toIntArray():Array<Int> {
		var ary = new Array<Int>();
		for (i in data) {
			ary.push(i.color);
		}
		return ary;
	}

	public function toRGB():ColorList<RGB>
	{
		var list = new ColorList<RGB>();
		var rgb:RGB = new RGB();
		for(i in data)
		{
			rgb.color = i.color;
			list.addColor(rgb.color.toRGB());
		}
		return list;
	}
	
	public function toHSB():ColorList<HSB>
	{
		var list = new ColorList<HSB>();
		var rgb:RGB = new RGB();
		for(i in data)
		{
			rgb.color = i.color;
			list.addColor(rgb.color.toHSB());
		}
		return list;
	}
	
	public function toCMYK():ColorList<CMYK>
	{
		var list = new ColorList<CMYK>();
		var rgb:RGB = new RGB();
		for(i in data)
		{
			rgb.color = i.color;
			list.addColor(rgb.color.toCMYK());
		}
		return list;
	}
	
	public function toColor():ColorList<Color>
	{
		var list = new ColorList<Color>();
		for(i in data)
		{
			list.addColor(new Color(i.color));
		}
		return list;
	}
	
	public function toLab():ColorList<Lab>
	{
		var list = new ColorList<Lab>();
		var rgb:RGB = new RGB();
		for(i in data)
		{
			rgb.color = i.color;
			list.addColor(rgb.color.toLab());
		}
		return list;
	}
	
	public function toXYZ():ColorList<XYZ>
	{
		var list = new ColorList<XYZ>();
		var rgb:RGB = new RGB();
		for(i in data)
		{
			rgb.color = i.color;
			list.addColor(rgb.color.toXYZ());
		}
		return list;
	}
	
	public function toHSL():ColorList<HSL>
	{
		var list = new ColorList<HSL>();
		var rgb:RGB = new RGB();
		for(i in data)
		{
			rgb.color = i.color;
			list.addColor(rgb.color.toHSL());
		}
		return list;
	}
	
}
