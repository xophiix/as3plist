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
	/**
	 *	Useful Utility for parsing data 
	 * @author dai
	 * 
	 */	
	public class ParseUtils
	{
		public function ParseUtils()
		{
		}
		
		
		static public function valueFromXML(node:XML):*
		{
			var val:*;
			var nodeName:String = node.name().toString();
			switch(nodeName)
			{
				case "array":
					val=new PArray(node);
					break;
				case "dict":
					val=new PDict(node);
					break;
				case "date":
					val=new PDate(node);
					break;
				case "string":
				case "data": 
					val=new PString(node);
					break;
				case "true": 
				case "false":
					val=new PBoolean(node);
					break;
				case "real":
				case "integer":
					val=new PNumber(node);
					break;
				default:					
					throw new Error("valueFromXML: unknown plist node type " + nodeName);
			}
			return val;
		}
		
		static public function valueToXML(val:*):XML 
		{
			var type:String = typeof(val);
			if (type == "object") {
				if (val is Array) {
					type = "array";
				} else if (val is Date) {
					type = "date";
				}
			} 
			
			var element:* = null;
			switch (type) {
				case "array":
					element=new PArray(val);
					break;
				case "object":
					element=new PDict(val);
					break;
				case "date":
					element=new PDate(val);
					break;
				case "string":
					element=new PString(val);
					break;
				case "boolean": 
					element=new PBoolean(val);
					break;
				case "number":				
					element=new PNumber(val);
					break;
				default:
					throw new Error("valueToXML: unknown value type " + type);					
			}
			
			return element.xml;
		}
	}
}