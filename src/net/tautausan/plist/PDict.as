/*
 * Licensed under the MIT License
 * 
 * Copyright (c) 2008 Daisuke Yanagi
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package net.tautausan.plist
{
	import flash.utils.*;
	/**
	 *	Property List Dictionary 
	 * @author dai
	 * @modifier xophiix
	 */	
	dynamic public class PDict extends PlistElement
	{
		
		public function PDict(o:*)
		{
			super(o);
		}
		
		override protected function xmlToData():* {			
			var result:Object = new Object();
			var key:XML;
			var node:XML;
			
			for each(node in this.xml.*) {
				if (node.name()=="key") {
					key = node;
				} else {
					if (key) {
						result[key]=ParseUtils.valueFromXML(node);
					}
				}
			}
			
			return result;
		}
		
		override protected function dataToXml():XML {
			var result:XML = <dict></dict>;
			for (var key:String in this.object) {
				if (key == "loops") {
					trace("wtf");
				}
				
				result.appendChild(new XML("<key>" + key + "</key>"));
				result.appendChild(ParseUtils.valueToXML(this.object[key]));
			}
			
			return result;
		}
	}
}