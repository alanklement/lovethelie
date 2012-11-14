package {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;

	public class ExternalSwfSkinLoader implements DisposableBootstrap {
		private var skinsLoadedCallback : Function;
		private var swfLoader : Loader;

		public function ExternalSwfSkinLoader(skinURL : String, skinsLoadedCallback : Function) {
			this.skinsLoadedCallback = skinsLoadedCallback;
			loadSkinSwf(skinURL);
		}

		private function loadSkinSwf(skinURL : String) : void {
			swfLoader = new Loader();
			swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, getSwfApplicationDomain, false, 0, true);
			swfLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, failSilently);
			swfLoader.load(new URLRequest(skinURL));
		}

		private function getSwfApplicationDomain(event : Event) : void {
			var swfDomain : ApplicationDomain = ApplicationDomain(swfLoader.contentLoaderInfo.applicationDomain);
			skinsLoadedCallback(swfDomain);
		}

		private function failSilently(event : IOErrorEvent) : void {
		}

		public function dispose() : void {
			swfLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, getSwfApplicationDomain);
			swfLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, failSilently);
			skinsLoadedCallback = null;
			swfLoader = null;
		}
	}
}
