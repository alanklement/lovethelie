package com.lovehthelie.scroller 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author Alan
	 */
	public class XMLLoader 
	{
		private var loadCompleteCallback : Function;
		private var loader : URLLoader;
		private var xmlURL : String;

		public function XMLLoader(xmlURL : String, loadCompleteCallback : Function)
		{
			this.loadCompleteCallback = loadCompleteCallback;
			this.xmlURL = xmlURL;
			
			loadXML();
		}

		private function loadXML() : void
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, retreiveXMLFromLoader);
			loader.addEventListener(IOErrorEvent.IO_ERROR, catchLoadError);
			loader.load(new URLRequest(xmlURL));	
		}

		private function retreiveXMLFromLoader(event : Event) : void
		{
			var xml : XML = XML(event.target.data);
			callLoaderCompleteCallback(xml);
		}
		
		private function callLoaderCompleteCallback(xml:XML) : void
		{
			loadCompleteCallback(xml);	
		}

		private function dispose() : void
		{
			loader.removeEventListener(Event.COMPLETE, retreiveXMLFromLoader);
		}

		private function catchLoadError(event : IOErrorEvent) : void
		{
			// fail silently
		}
	}
}
