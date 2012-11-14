package  {
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.TweenPlugin;

	import flash.display.Sprite;

	public class Main extends Sprite 
	{
		private var dataModel : NetworkDataModel;
		private var viewFacade : ViewFacade;
		private var appController : ApplicationController;
		private var preloader : Scola_Preloader;
		private var preload_manager : PreloadManager;

		public function Main()
		{
			trace('Main: ' + (Main));
			getFlashVars();
			enable_plug_ins();
			connectDataModelToView();
			connectViewAndController();
			create_pre_loader();
		}

		private function getFlashVars() : void
		{
			var flashVars : Object = Object(this.stage.loaderInfo.parameters);
			dataModel = new DataModel(flashVars);
		}

		private function enable_plug_ins() : void
		{
			TweenPlugin.activate([BlurFilterPlugin, AutoAlphaPlugin]);
		}

		private function connectDataModelToView() : void
		{
			viewFacade = new ViewFacade(dataModel);
			addChild(viewFacade);
		}

		private function connectViewAndController() : void
		{
			appController = new ApplicationController(dataModel, viewFacade);
			appController.startSite();
		}		
		
		private function create_pre_loader() : void
		{
			preloader = new Scola_Preloader();
			preload_manager = PreloadManager.getInstance();
			preload_manager.preloader = preloader;
			preload_manager.main = this;
			preloader.scaleX = preloader.scaleY = 1.5;
			this.addChild(preloader);
		}
	}
}
