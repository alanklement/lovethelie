package {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;

	public class ApplicationController {
		private var dataModel : NetworkDataModel;
		private var viewFacade : ViewFacade;

		public function ApplicationController(dataModel : NetworkDataModel, viewFacade : ViewFacade) {
			this.dataModel = dataModel;
			this.viewFacade = viewFacade;
			addEventListeners();
		}

		private function addEventListeners() : void {
			viewFacade.addEventListener(NavView.LOAD_FASHION_SECTION, loadFashionThumbs);
			viewFacade.addEventListener(NavView.LOAD_BEAUTY_SECTION, loadBeautyThumbs);
			viewFacade.addEventListener(NavView.LOAD_COVER_SECTION, loadCoverThumbs);
		}

		private function loadCoverThumbs(event : Event) : void {
			dataModel.loadCoverThumbs(notifyViewThumbsReady);
		}

		private function loadBeautyThumbs(event : Event) : void {
			dataModel.loadBeautyThumbs(notifyViewThumbsReady);
		}

		private function loadFashionThumbs(event : Event) : void {
			dataModel.loadFashionThumbs(notifyViewThumbsReady);
		}

		private function notifyViewThumbsReady(galleryVOs : Array) : void {
			viewFacade.loadGallery(galleryVOs);
		}

		public function startSite() : void {
			dataModel.loadPreloadSwf(beginSiteLoad);
		}

		private function beginSiteLoad(preloadSwf : Sprite) : void {
			viewFacade.showSitePreload(preloadSwf);
			dataModel.loadSkins(passSkinsToView);
		}

		private function passSkinsToView(skins : ApplicationDomain) : void {
			viewFacade.addSkin(skins);
			dataModel.loadBackGround(startView);
		}

		private function startView(backgroundImg : Loader) : void {
			viewFacade.startSite(backgroundImg);
		}
	}
}
