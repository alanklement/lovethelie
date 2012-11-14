package {
	import com.greensock.TweenLite;

	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class GalleryView extends EventDispatcher {
		private var view : MovieClip;
		private var thumbNav : ThumbNav;
		private var imageHolder : Sprite;
		private var lastLoadedImage : String;
		private var frameMC : MovieClip;

		public function GalleryView(view : MovieClip) {
			this.view = view;
			createReferences();
		}

		private function createReferences() : void {
			frameMC = MovieClip(view.getChildByName("frameMC"));
			createBigImageHolder();
		}

		private function createBigImageHolder() : void {
			imageHolder = new Sprite();
			view.addChild(imageHolder);

			createThumbNavigation();
		}

		private function createThumbNavigation() : void {
			thumbNav = new ThumbNav(view);
			thumbNav.addEventListener(ThumbNav.THUMB_CLICKED, loadBigImage);
		}

		public function disable() : void {
			thumbNav.disable();
			fadeOutOldContent();
			imageHolder.mouseEnabled = false;
			imageHolder.mouseChildren = false;
		}

		public function loadGallery(galleryVOs : Array) : void {
			thumbNav.changeThumbs(galleryVOs);
			// this is bad - but it works.
			thumbNav.selectedGalleryVO = galleryVOs[0];
			loadImage();
		}

		private function loadBigImage(event : Event) : void {
			if (lastLoadedImage != thumbNav.selectedGalleryVO.source) {
				lastLoadedImage = thumbNav.selectedGalleryVO.source;
				loadImage();
			}
		}

		private function loadImage() : void {
			PreloadManager.getInstance().show_preloader();
			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, addImageToHolder);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, failLoadSilently);
			loader.load(new URLRequest(thumbNav.selectedGalleryVO.source));
		}

		private function addImageToHolder(event : Event) : void {
			PreloadManager.getInstance().hide_preloader();
			var image : DisplayObject = DisplayObject(LoaderInfo(event.target).content);
			image.alpha = 0;

			fadeOutOldContent();
			TweenLite.to(image, .5, {alpha:1});
			image.x = (view.stage.stageWidth * .5) - (image.width * .5);
			image.y = frameMC.y + 10;
			imageHolder.addChild(image);
		}

		private function fadeOutOldContent() : void {
			for (var i : int = 0;i < imageHolder.numChildren;i++) {
				var oldContent : DisplayObject = imageHolder.getChildAt(i);
				TweenLite.to(oldContent, .5, {alpha:0, onComplete:removeObject});
			}
		}

		private function removeObject() : void {
			for (var i : int = 0;i < imageHolder.numChildren - 1;i++) {
				imageHolder.removeChildAt(i);
			}
		}

		private function failLoadSilently(event : IOErrorEvent) : void {
		}
	}
}

