package  
{
	import flash.net.URLRequest;
	import flash.events.IEventDispatcher;
	import flash.events.Event;
	import flash.net.URLLoader;

	public class XMLLoader 
	{
		private var xmlFileURL : String;
		private var xmlLoadedCallack : Function;

		public function XMLLoader(xmlFileURL:String,xmlLoadedCallback:Function)
		{
			this.xmlFileURL = xmlFileURL;
			this. xmlLoadedCallack = xmlLoadedCallback;
			 
			loadXML();
		}
		
		private function loadXML() : void
		{
			var urlLoader : URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			urlLoader.load(new URLRequest(xmlFileURL));
		}

		private function xmlLoaded(event : Event) : void
		{
			IEventDispatcher(event.currentTarget).removeEventListener(event.type, xmlLoaded);
			var xml : XML = XML(event.target.data);
			
			passXMLBackXMLToClient(xml);
		}
		
		private function passXMLBackXMLToClient(xml:XML) : void
		{
			xmlLoadedCallack(xml);	
		}

		public function dispose() : void
		{
			xmlFileURL = null;
			xmlLoadedCallack = null;
		}
	}
}
