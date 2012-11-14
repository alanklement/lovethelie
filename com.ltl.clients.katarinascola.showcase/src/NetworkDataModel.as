package {
	public interface NetworkDataModel {
		function loadVideoVOs(createVideoMenu : Function) : void;

		function loadCoverThumbs(notifyViewThumbsReady : Function) : void;

		function loadBeautyThumbs(notifyViewThumbsReady : Function) : void;

		function loadFashionThumbs(notifyViewImagesReady : Function) : void;

		function loadSkins(passSkinsToView : Function) : void;

		function loadBackGround(startView : Function) : void;

		function loadPreloadSwf(passPreloadSwfToView : Function) : void;

		function dispose() : void;
	}
}
