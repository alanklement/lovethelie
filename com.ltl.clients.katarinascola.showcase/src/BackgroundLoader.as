package {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class BackgroundLoader implements DisposableBootstrap {
		private var notifyBackgroundLoaded : Function;
		private var xmlLoader : DisposableBootstrap;
		private var imageLoader : Loader;
		private var backgroundUrlPrefix : String;

		public function BackgroundLoader(backgroundUrlPrefix : String, backGroundXmlUrl : String, notifyBackgroundLoaded : Function) {
			this.backgroundUrlPrefix = backgroundUrlPrefix;
			trace('BackgroundLoader', 'backgroundUrlPrefix: ' + (backgroundUrlPrefix));
			this.notifyBackgroundLoaded = notifyBackgroundLoaded;
			loadBackgroundXML(backGroundXmlUrl);
		}

		private function loadBackgroundXML(backGroundXML : String) : void {
			xmlLoader = new XMLLoader(backGroundXML, loadBackground);
		}

		private function loadBackground(xml : XML) : void {
			var backgroundUrl : String = backgroundUrlPrefix + xml.image[0].attribute("source");

			imageLoader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.INIT, passBackgroundToClient);
			imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, failSilently);
			imageLoader.load(new URLRequest(backgroundUrl));
		}

		private function passBackgroundToClient(event : Event) : void {
			notifyBackgroundLoaded(imageLoader);
		}

		private function failSilently(event : IOErrorEvent) : void {
		}

		public function dispose() : void {
			xmlLoader.dispose();
			xmlLoader = null;

			imageLoader.contentLoaderInfo.removeEventListener(Event.INIT, passBackgroundToClient);
			imageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, failSilently);
			// imageLoader = null;
		}
	}
}
