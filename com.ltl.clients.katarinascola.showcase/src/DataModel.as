package {
	public class DataModel implements NetworkDataModel {
		private var backgroundXml : String;
		private var fashionXml : String;
		private var skinSwfUrl : String;
		private var preloadSwfUrl : String;
		private var largeImgDir : String;
		private var thumbImgDir : String;
		private var backgroundImgDir : String;
		private var swfLoader : DisposableBootstrap;
		private var backgroundLoader : BackgroundLoader;
		private var externalSkinLoader : DisposableBootstrap;
		private var notifyViewImagesReady : Function;
		private var imageGalleryLoader : ImageGalleryLoader;
		private var beautyXml : String;
		private var coversXml : String;
		private var videosXml : String;
		private var videoVOBuilder : VideoVOBuilder;
		private var videoDir : String;

		public function DataModel(flashVars : Object) {
			extractFlashVars(flashVars);
		}

		private function extractFlashVars(flashVars : Object) : void {
			skinSwfUrl = String(flashVars["skinSwf"]);
			preloadSwfUrl = String(flashVars["preloadSwf"]);
			largeImgDir = String(flashVars["largeImgDir"]);
			thumbImgDir = String(flashVars["thumbImgDir"]);
			videoDir = String(flashVars["videoDir"]);
			backgroundImgDir = String(flashVars["backgroundImgDir"]);
			backgroundXml = String(flashVars["backgroundXml"]);
			fashionXml = String(flashVars["fashionXml"]);
			beautyXml = String(flashVars["beautyXml"]);
			coversXml = String(flashVars["coversXml"]);
			videosXml = String(flashVars["videosXml"]);

			createGalleryLoaders();
		}

		private function createGalleryLoaders() : void {
			imageGalleryLoader = new ImageGalleryLoader();
		}

		public function loadPreloadSwf(preloadSwfReady : Function) : void {
			swfLoader = new SwfLoader(preloadSwfUrl, preloadSwfReady);
		}

		public function loadSkins(passSkinsToView : Function) : void {
			externalSkinLoader = new ExternalSwfSkinLoader(skinSwfUrl, passSkinsToView);
		}

		public function loadBackGround(notifyBackgroundLoaded : Function) : void {
			backgroundLoader = new BackgroundLoader(backgroundImgDir, backgroundXml, notifyBackgroundLoaded);
		}

		public function loadFashionThumbs(notifyControllerThumbsReady : Function) : void {
			imageGalleryLoader.loadGallery(largeImgDir, thumbImgDir, fashionXml, notifyControllerThumbsReady);
		}

		public function loadBeautyThumbs(notifyControllerThumbsReady : Function) : void {
			imageGalleryLoader.loadGallery(largeImgDir, thumbImgDir, beautyXml, notifyControllerThumbsReady);
		}

		public function loadCoverThumbs(notifyControllerThumbsReady : Function) : void {
			imageGalleryLoader.loadGallery(largeImgDir, thumbImgDir, coversXml, notifyControllerThumbsReady);
		}

		public function loadVideoVOs(createVideoMenu : Function) : void {
			videoVOBuilder = new VideoVOBuilder(videoDir, videosXml, createVideoMenu);
		}

		public function dispose() : void {
			swfLoader.dispose();
			swfLoader = null;

			externalSkinLoader.dispose();
			externalSkinLoader = null;
		}
	}
}
