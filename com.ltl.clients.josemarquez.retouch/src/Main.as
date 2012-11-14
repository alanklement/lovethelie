package  
{
	import controllers.Application_Controller;
	import controllers.Network_Controller;

	import models.Data_Model;
	import models.Flash_Var_Model;

	import views.App_View;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.ApplicationDomain;

	public class Main extends Sprite
	{
		private var data_model : Data_Model = new Data_Model();
		private var net_work_controller : Network_Controller;
		private var view : App_View;
		private var controller : Application_Controller;
		private var flash_vars : Flash_Var_Model;
		private var bg : Gradient;
		private var view_art : MovieClip;

		public function Main()
		{
			init_properties();
			create_bg();	
			flash_vars = new Flash_Var_Model(this.stage.loaderInfo.parameters);
			data_model.flash_vars = flash_vars;
			net_work_controller = new Network_Controller(flash_vars, data_model);
			net_work_controller.skins_loaded.addOnce(skins_loaded);
			net_work_controller.load_skins();
		}

		private function create_bg() : void 
		{
			bg = new Gradient();
			bg.width = stage.stageWidth;
			bg.height = stage.stageHeight;
			addChild(bg);
		}

		private function init_properties() : void 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE, echo_size);
		}

		private function echo_size(event : Event) : void 
		{
			bg.width = stage.stageWidth;
			bg.height = stage.stageHeight;
			view_art.x = stage.stageWidth * .5;
			view_art.y = stage.stageHeight * .5;
		}

		public function skins_loaded(skins : ApplicationDomain) : void
		{
			var View_Art : Class = Class(skins.getDefinition("View"));			
			view_art = new View_Art();
			view_art.x = stage.stageWidth * .5;
			view_art.y = stage.stageHeight * .5;
			
			addChild(view_art);
			create_view(view_art);
		}

		private function create_view(view_art : MovieClip) : void 
		{
			view = new App_View(view_art);
			connect_view_and_controllers();
		}

		private function connect_view_and_controllers() : void 
		{
			data_model.network = net_work_controller;
			controller = new Application_Controller(net_work_controller, data_model, view);
			controller.start();
		}
	}
}
