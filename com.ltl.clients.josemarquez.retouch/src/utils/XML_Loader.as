package utils
{
	import interfaces.Disposable;

	import org.osflash.signals.Signal;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class XML_Loader implements Disposable
	{
		public var load_complete : Signal = new Signal(XML,XML);
		private var loader : URLLoader = new URLLoader();
		private var objects_xml_url : String;
		private var fashion_xml : XML;
		private var objects_xml : XML;

		public function load_XML(fashion_xml_url : String,objects_xml_url : String) : void
		{
			this.objects_xml_url = objects_xml_url;
			load_fashion_xml(fashion_xml_url);
		}

		private function load_fashion_xml(fashion_xml_url : String) : void 
		{
			loader.addEventListener(Event.COMPLETE, retrieve_fashion_XML);
			loader.addEventListener(IOErrorEvent.IO_ERROR, catchLoadError);
			loader.load(new URLRequest(fashion_xml_url));	
		}

		private function retrieve_fashion_XML(event : Event) : void
		{
			loader.removeEventListener(Event.COMPLETE, retrieve_fashion_XML);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, catchLoadError);
			
			fashion_xml = XML(event.target.data);
			load_objects_xml();
		}

		private function load_objects_xml() : void 
		{
			loader.addEventListener(Event.COMPLETE, retrieve_beauty_XML);
			loader.addEventListener(IOErrorEvent.IO_ERROR, catchLoadError);
			loader.load(new URLRequest(objects_xml_url));	
		}

		private function retrieve_beauty_XML(event : Event) : void 
		{
			loader.removeEventListener(Event.COMPLETE, retrieve_fashion_XML);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, catchLoadError);
			
			objects_xml = XML(event.target.data);
			load_complete.dispatch(fashion_xml, objects_xml);
		}

		private function catchLoadError(event : IOErrorEvent) : void
		{
			// fail silently
		}

		public function dispose(event:Event = null) : void
		{
			load_complete.removeAll();
			fashion_xml = null;
			objects_xml = null;
			load_complete = null;
			loader = null;
		}
	}
}
