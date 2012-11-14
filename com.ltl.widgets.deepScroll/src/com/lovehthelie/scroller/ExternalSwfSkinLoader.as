package com.lovehthelie.scroller
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;

	public class ExternalSwfSkinLoader extends EventDispatcher
	{
		public var skinsLoadedCallback : Function;
		private var _swfLoader : Loader;
		private var _swfDomain : ApplicationDomain;

		public function ExternalSwfSkinLoader(skinsLoadedCallback : Function,skinURL : String)
		{
			this.skinsLoadedCallback = skinsLoadedCallback;
			loadSkinSwf(skinURL);	
		}

		public function dispose() : void
		{
			_swfLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, getSwfApplicationDomain);
			_swfLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			skinsLoadedCallback = null;
			_swfLoader = null;
			_swfDomain = null;
		}

		private function loadSkinSwf(skinURL : String) : void
		{
			_swfLoader = new Loader();
			_swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, getSwfApplicationDomain, false, 0, true);
			_swfLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, dispatchProgress);
			_swfLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);			
			_swfLoader.load(new URLRequest(skinURL));
		}

		private function getSwfApplicationDomain(event : Event) : void
		{
			_swfDomain = ApplicationDomain(_swfLoader.contentLoaderInfo.applicationDomain); 
			doCompleteCallback();
		}

		private function doCompleteCallback() : void
		{

			skinsLoadedCallback(_swfDomain);
		}

		private function dispatchProgress(event : ProgressEvent) : void
		{
			dispatchEvent(event.clone());		
		}

		private function onLoadError(event : IOErrorEvent) : void
		{
			// implemented only in case of an error to prevent runtime debug error
		}		
	}
}
