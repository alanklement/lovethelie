package {
	import flash.events.Event;
	import flash.ui.Mouse;

	public class PreloadManager {
		private static var instance : PreloadManager;
		private static var allowInstantiation : Boolean;
		public var _preloader : Scola_Preloader;
		public var main : Main;

		public function show_preloader() : void {
			_preloader.addEventListener(Event.ENTER_FRAME, adjust_preloader_pos);
			Mouse.hide();
			_preloader.visible = true;
			main.mouseChildren = false;
			main.mouseEnabled = false;
		}

		public function hide_preloader() : void {
			_preloader.removeEventListener(Event.ENTER_FRAME, adjust_preloader_pos);
			Mouse.show();
			_preloader.visible = false;
			main.mouseChildren = true;
			main.mouseEnabled = true;
		}

		private function adjust_preloader_pos(event : Event) : void {
			_preloader.x = main.mouseX - 5;
			_preloader.y = main.mouseY - 5;
		}

		public static function getInstance() : PreloadManager {
			if (instance == null) {
				allowInstantiation = true;
				instance = new PreloadManager();
				allowInstantiation = false;
			}
			return instance;
		}

		public function SingletonDemo() : void {
			if (!allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");
			}
		}

		public function get preloader() : Scola_Preloader {
			return _preloader;
		}

		public function set preloader(preloader : Scola_Preloader) : void {
			_preloader = preloader;
			_preloader.visible = false;
		}
	}
}