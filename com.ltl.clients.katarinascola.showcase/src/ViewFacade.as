package {
	import gs.TweenLite;

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;

	public class ViewFacade extends Sprite {
		private var preloadSwf : Sprite;
		private var viewMC : MovieClip;
		private var navView : NavView;
		private var galleryView : GalleryView;
		private var agencyView : AgencyView;
		private var dataModel : NetworkDataModel;
		private var video_View : VideoView;
		private var compcard_view : Compcard_View;
		private var home_view : Home_View;

		public function ViewFacade(dataModel : NetworkDataModel) {
			this.dataModel = dataModel;
		}

		public function showSitePreload(preloadSwf : Sprite) : void {
			this.preloadSwf = preloadSwf;
			preloadSwf.visible = false;
			preloadSwf.alpha = 0;
			addChild(preloadSwf);

			TweenLite.to(preloadSwf, .5, {autoAlpha:1});
		}

		public function addSkin(skins : ApplicationDomain) : void {
			var View : Class = Class(skins.getDefinition("ViewFacadeMC"));
			viewMC = new View();
			viewMC.alpha = 0;
			viewMC.visible = false;
			addChild(viewMC);

			create_home_view();
			createAgencyView();
			createNavView();
			createGalleryView();
			createVideoView();
			create_compcard_view();
			enalbleNavView();
		}

		private function create_home_view() : void {
			home_view = new Home_View(viewMC);
		}

		private function createAgencyView() : void {
			agencyView = new AgencyView(viewMC);
		}

		private function createNavView() : void {
			navView = new NavView(viewMC);
			navView.addEventListener(NavView.LOAD_HOME_SECTION, passHomeEventToController);
			navView.addEventListener(NavView.LOAD_FASHION_SECTION, passGalleryEventToController);
			navView.addEventListener(NavView.LOAD_BEAUTY_SECTION, passGalleryEventToController);
			navView.addEventListener(NavView.LOAD_COVER_SECTION, passGalleryEventToController);
			navView.addEventListener(NavView.LOAD_VIDEO_SECTION, show_video_view);
			navView.addEventListener(NavView.LOAD_AGENCIES_SECTION, showAgenciesView);
			navView.addEventListener(NavView.LOAD_COMPCARD_SECTION, pass_compcard_event_to_controller);
		}

		private function createGalleryView() : void {
			galleryView = new GalleryView(viewMC);
			galleryView.disable();
		}

		private function createVideoView() : void {
			video_View = new VideoView(dataModel, viewMC);
		}

		private function create_compcard_view() : void {
			compcard_view = new Compcard_View(viewMC);
		}

		public function startSite(backgroundImg : Loader) : void {
			home_view.add_bg_image(backgroundImg);
			TweenLite.to(viewMC, 1, {autoAlpha:1, onComplete:removePreloaderSwf});
		}

		private function removePreloaderSwf() : void {
			removeChild(preloadSwf);
			preloadSwf = null;
		}

		private function enalbleNavView() : void {
			navView.animateIn();
		}

		private function showAgenciesView(event : Event) : void {
			home_view.disable();
			galleryView.disable();
			compcard_view.disable();
			video_View.disable();

			agencyView.enable();
			navView.set_nav_for_agencies();
		}

		private function show_video_view(event : Event) : void {
			home_view.disable();
			galleryView.disable();
			agencyView.disable();
			compcard_view.disable();

			video_View.enable();
			navView.set_nav_for_video();
		}

		private function passHomeEventToController(event : Event) : void {
			galleryView.disable();
			agencyView.disable();
			compcard_view.disable();
			video_View.disable();

			home_view.enable();
			navView.set_nav_for_home();
		}

		private function passGalleryEventToController(event : Event) : void {
			agencyView.disable();
			home_view.disable();
			compcard_view.disable();
			video_View.disable();

			dis_able_nav();
			dispatchEvent(event.clone());
		}

		private function pass_compcard_event_to_controller(event : Event) : void {
			galleryView.disable();
			agencyView.disable();
			home_view.disable();

			compcard_view.enable();
			video_View.disable();
			navView.set_nav_for_compcard();
			// dispatchEvent(event.clone());
		}

		public function loadGallery(galleryVOs : Array) : void {
			galleryView.loadGallery(galleryVOs);
			re_enable_nav();
		}

		private function dis_able_nav() : void {
			navView.disable();
		}

		private function re_enable_nav() : void {
			navView.enable();
		}
	}
}
