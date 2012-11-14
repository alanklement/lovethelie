package {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class SwfLoader implements DisposableBootstrap {
		private var onCompleteCallback : Function;
		private var loader : Loader;

		public function SwfLoader(swfURL : String, onCompleteCallback : Function) {
			this.onCompleteCallback = onCompleteCallback;
			loadSwf(swfURL);
		}

		private function loadSwf(swfURL : String) : void {
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, extractSwfFromLoader);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, failSilently);
			loader.load(new URLRequest(swfURL));
		}

		private function extractSwfFromLoader(event : Event) : void {
			var swf : Sprite = loader.content as Sprite;
			executeCallback(swf);
		}

		private function executeCallback(swf : Sprite) : void {
			onCompleteCallback(swf);
		}

		private function failSilently(event : IOErrorEvent) : void {
		}

		public function dispose() : void {
			this.onCompleteCallback = null;
			loader.contentLoaderInfo.removeEventListener(Event.INIT, extractSwfFromLoader);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, failSilently);
		}
	}
}
