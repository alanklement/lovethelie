package controllers 
{
	import flash.display.MovieClip;
	import flash.display.LoaderInfo;
	import org.osflash.signals.Signal;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	/**
	 * @author Alan
	 */
	public class Before_After_Loader 
	{
		public var images_loaded : Signal = new Signal(Bitmap, Bitmap);
		private var before_loader : Loader;
		private var after_loader : Loader;
		private var after_img : Bitmap;
		private var before_img : Bitmap;
		private var after_loaded : Boolean;
		private var before_loaded : Boolean;

		public function Before_After_Loader() 
		{
			before_loader = new Loader();
			after_loader = new Loader();
			before_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, catchError);			
			after_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, catchError);			
		}

		public function load_images(before_url : String, after_url : String) : void 
		{
			after_loaded = false;
			before_loaded = false;
			
			before_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onBeforeLoaded);
			before_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBeforeLoaded);				
			before_loader.load(new URLRequest(before_url));

			after_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onAfterLoaded);
			after_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onAfterLoaded);				
			after_loader.load(new URLRequest(after_url));
		}

		private function onAfterLoaded(event : Event) : void 
		{
			after_loaded = true;
			this.after_img = LoaderInfo(event.target).content as Bitmap;
			check_if_both_loaded();
		}

		private function onBeforeLoaded(event : Event) : void 
		{
			before_loaded = true;
			this.before_img = LoaderInfo(event.target).content as Bitmap;			
			check_if_both_loaded();
		}

		private function check_if_both_loaded() : void 
		{
			if(after_loaded && before_loaded)
			{
				images_loaded.dispatch(before_img, after_img);
			}
		}

		private function catchError(event : IOErrorEvent) : void 
		{
			trace(this, 'catchError', 'event: ', (event));
		}
	}
}
