package net.tautausan.plist
{
	import flash.utils.ByteArray;

	public class Xml2Bin
	{
		function Xml2Bin()
		{			
		}
		
		static private var _instance:Xml2Bin;
		
		static public function getBytes(xml:XML):ByteArray
		{
			if (!_instance) {
				_instance=new Xml2Bin();
			}
			
			return _instance.write(xml);
		}
		
		private function write(xml:XML):ByteArray {
			var result:ByteArray = new ByteArray;
			// TODO: xo			
			return result;
		}
	}
}