package
{
	import com.greensock.TweenLite;
	import com.doubleclick.studio.expanding.ExpandingComponent;
	import com.doubleclick.studio.events.StudioEvent;
	import com.doubleclick.studio.Enabler;
	import com.doubleclick.studio.display.StudioLoader;

	import flash.display.MovieClip;
	import flash.net.URLRequest;

	public class Parent extends MovieClip
	{
		public var myLoader : StudioLoader = new StudioLoader();
		public var req : URLRequest = new URLRequest("new_collapsed.swf");
		public var expandChild : Object = new Object();
		public var collapsed_mc : MovieClip;
		public var bottom_legal_mc : MovieClip;
		public var mc_sis : MovieClip;

		public function Parent()
		{
			Enabler.init(stage);
			ExpandingComponent.addEventListener(StudioEvent.ON_MOVIE_LOADER_COMPLETE, registerChild);
			Enabler.addEventListener(StudioEvent.ON_EXIT, onExitHandler);
		}

		public function load_child():void
		{
			myLoader.load(req);
			collapsed_mc.addChild(myLoader);
		}

		public function registerChild(event : StudioEvent):void
		{
			expandChild = event.movieClipReference;
		}

		public function on_expand():void
		{
			TweenLite.to(bottom_legal_mc, .5, {y:600});
			collapsed_mc.visible = false;
			trace("I'm expanded!");
		}

		public function on_collapse():void
		{
			TweenLite.to(bottom_legal_mc, .5, {y:487.15});
			collapsed_mc.visible = true;
			trace("I'm collapsed!");
		}

		public function onExitHandler(event : StudioEvent):void
		{
			ExpandingComponent.collapse();
		}
	}
}