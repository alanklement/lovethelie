package {
	[Bindable]
	public class Data_Model {
		import mx.managers.CursorManager;

		public var currentView : int = 0;
		public var uploadedImgURL : String;
		public var totalImgsToLoad : int;
		public var currentImgsLoaded : int;
		public static var image_url_prefix : String = "../images/";

		public function startCheck(count : int) : void {
			CursorManager.setBusyCursor();
			totalImgsToLoad = count;
		}

		public function updateLoadedStatus() : void {
			currentImgsLoaded++;
			trace(totalImgsToLoad, currentImgsLoaded);
			if (currentImgsLoaded == totalImgsToLoad) {
				CursorManager.removeBusyCursor();
			}
		}

		private static var _instance : Data_Model ;

		public static function getInstance() : Data_Model {
			if ( _instance == null ) {
				_instance = new Data_Model();
			}
			return _instance ;
		}

		public function Data_Model() {
			if ( _instance != null ) throw new Error("Error: Use getInstance() method");
			Data_Model._instance = this;
		}
	}
}