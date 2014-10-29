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
	import flash.errors.IllegalOperationError;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	/**
	 *	Foundation of all Property List Elements 
	 * @author dai
	 * @modifier xophiix
	 */		
	class PlistElement extends Proxy
	{
		private var x:XML;
		private var data:*;
		
		public function PlistElement(o:*)
		{
			if (o is XML) {
				this.x = o;
			} else {
				this.data = o;	
			}			
		}
		
		override flash_proxy function getProperty(name:*):* 
		{
			var data:* = this.object;
			if (data !== undefined)
			{
				return data[name];
			}
			
			return null;
		}

		override flash_proxy function callProperty(name:*, ... rest):*
		{
			var data:* = this.object;
			if(rest.length<1)
			{
				return data[name]();
			}
			
			return data[name](rest);
		}
		
		public function set xml(x:XML):void
		{
			this.x = x;
			this.data= this.object;
		}
		
		public function get xml():XML
		{
			if (!this.x && this.data !== undefined) {
				this.x = dataToXml();
			}
			
			return this.x;
		}
		
		public function get object():* {
			if (this.data == undefined && this.x) {
				this.data = xmlToData();
			}
			
			return this.data;
		}

		protected function xmlToData():* {
			throw new IllegalOperationError("must implement this method");
		}
		
		protected function dataToXml():XML {
			throw new IllegalOperationError("must implement this method");	
		}
	}
}