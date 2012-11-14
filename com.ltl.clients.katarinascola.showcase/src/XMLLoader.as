package {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class XMLLoader implements DisposableBootstrap {
		private var loadCompleteCallback : Function;
		private var loader : URLLoader;

		public function XMLLoader(xmlURL : String, loadCompleteCallback : Function) {
			this.loadCompleteCallback = loadCompleteCallback;

			loadXML(xmlURL);
		}

		private function loadXML(xmlURL : String) : void {
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, retreiveXMLFromLoader);
			loader.addEventListener(IOErrorEvent.IO_ERROR, catchLoadError);
			loader.load(new URLRequest(xmlURL));
		}

		private function retreiveXMLFromLoader(event : Event) : void {
			var xml : XML = XML(event.target.data);
			callLoaderCompleteCallback(xml);
		}

		private function callLoaderCompleteCallback(xml : XML) : void {
			loadCompleteCallback(xml);
		}

		private function catchLoadError(event : IOErrorEvent) : void {
			// fail silently
		}

		public function dispose() : void {
			// loadCompleteCallback = null;
			// loader = null;
		}
	}
}
