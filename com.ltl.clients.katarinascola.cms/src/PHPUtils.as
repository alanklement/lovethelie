package {
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

	import flash.events.*;
	import flash.net.*;

	public class PHPUtils extends EventDispatcher {
		private var _path : String = "";
		private var _backgrounds : XML;
		private var _sections : XML;
		private var _phpFile : String;
		private var _images : XML;
		private var _file : String = "gateway.php";
		private var _action : String;
		private var _urlLoader : URLLoader;

		public function PHPUtils(param1 : Boolean) : void {
			if (param1) {
				goLocal();
			} else {
				goLive();
			}
			_phpFile = _path + _file;
			return;
		}

		public static function deleteFromServer(param1 : String, param2 : String) : void {
			var file : * = param1;
			var phpService : * = param2;
			var phpVars : * = new URLVariables();
			phpVars.fileName = file;
			var service : * = new URLRequest(phpService);
			service.method = URLRequestMethod.POST;
			service.data = phpVars;
			try {
				sendToURL(service);
			} catch (event : Error) {
				Alert.show("Could not delete");
			}
			return;
		}

		// end function
		public static function saveChangesToXML(param1 : String, param2 : String, param3 : ArrayCollection) : void {
			var _loc_5 : String = null;
			var _loc_6 : XML = null;
			var _loc_7 : XML = null;
			var _loc_8 : int = 0;
			var _loc_9 : Object = null;
			var _loc_10 : String = null;
			var _loc_11 : XML = null;
			var _loc_4 : * = param1;

			if (param3.length == 0) {
				_loc_5 = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" + "<images>\n" + "</images>";
				_save(param2, _loc_4, _loc_5);
			} else {
				_loc_6 = <images/>;
				_loc_7 = <image/>;
				_loc_8 = 0;
				for each (_loc_9 in param3) {
					_loc_11 = _loc_7.copy();
					_loc_11.@id = _loc_8;
					_loc_11.@source = _loc_9.source;
					_loc_11.@thumbId = _loc_9.thumbSource;
					_loc_11.@thumbSource = _loc_9.thumbSource;
					_loc_6.appendChild(_loc_11);
					_loc_8++;
				}
				_loc_10 = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" + _loc_6.toString();
				_save(param2, param1, _loc_10);
			}
			return;
		}

		// end function
		private static function _save(param1 : String, param2 : String, param3 : String) : void {
			var _loc_4 : * = new URLLoader();
			var _loc_5 : * = new URLVariables();
			var _loc_6 : * = new URLRequest(param1);
			_loc_5.content = param3;
			_loc_5.fileName = param2;
			_loc_6.data = _loc_5;
			_loc_6.method = URLRequestMethod.POST;
			_loc_4.load(_loc_6);
			return;
		}

		private function _onBackgroundLoaded(event : Event) : void {
			var _loc_2 : * = URLLoader(event.target);
			var _loc_3 : * = new XML(_loc_2.data);
			_backgrounds = _loc_3;
			dispatchEvent(new PHPEvent(PHPEvent.BACKGROUNDS_LOADED));
			return;
		}

		// end function
		private function _onImagesLoaded(event : Event) : void {
			var _loc_2 : * = URLLoader(event.target);
			_images = new XML(_loc_2.data);
			dispatchEvent(new PHPEvent(PHPEvent.IMAGES_LOADED));
			return;
		}

		// end function
		public function get backgrounds() : XML {
			return _backgrounds;
		}

		// end function
		private function _onSectionsLoaded(event : Event) : void {
			var _loc_2 : * = URLLoader(event.target);
			var _loc_3 : * = new XML(_loc_2.data);
			_sections = _loc_3;
			dispatchEvent(new PHPEvent(PHPEvent.SECTIONS_LOADED));
			return;
		}

		// end function
		public function set path(param1 : String) : void {
			_path = param1;
			return;
		}

		// end function
		public function get books() : XML {
			return _sections;
		}

		// end function
		public function set action(param1 : String) : void {
			_action = param1;
			return;
		}

		// end function
		public function goLocal() : void {
			_path = "http://localhost.:80/php/";
			return;
		}

		// end function
		public function goLive() : void {
			_path = "./php/";
			return;
		}

		// end function
		public function get images() : XML {
			return _images;
		}

		// end function
		public function loadSections() : void {
			dispatchEvent(new PHPEvent(PHPEvent.LOAD_SECTIONS_START));
			var _loc_1 : String = "action=get_books";
			var _loc_2 : * = new URLRequest(_phpFile + createCacheBuster() + "&" + _loc_1);
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, _onSectionsLoaded);
			_urlLoader.load(_loc_2);
			return;
		}

		// end function
		public function set source(param1 : String) : void {
			_file = param1;
			return;
		}

		// end function
		public function loadImages(param1 : String) : void {
			var _loc_2 : * = "action=get_images&fileName=" + param1;
			var _loc_3 : * = new URLRequest(_phpFile + createCacheBuster() + "&" + _loc_2);
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, _onImagesLoaded);
			_urlLoader.load(_loc_3);
			dispatchEvent(new PHPEvent(PHPEvent.LOAD_IMAGES_START));
			return;
		}

		// end function
		public function loadBackgrounds() : void {
			dispatchEvent(new PHPEvent(PHPEvent.BACKGROUNDS_LOAD_START));
			var _loc_1 : String = "action=get_backgrounds";
			var _loc_2 : * = new URLRequest(_phpFile + createCacheBuster() + "&" + _loc_1);
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, _onBackgroundLoaded);
			_urlLoader.load(_loc_2);
			return;
		}

		// end function
		public static function objectToURLVariables(param1 : Object) : URLVariables {
			var _loc_3 : String = null;
			var _loc_2 : * = new URLVariables();
			for (_loc_3 in param1) {
				if (_loc_3 != null) {
					if (param1[_loc_3] is Array) {
						_loc_2[_loc_3] = param1[_loc_3];
						continue;
					}
					_loc_2[_loc_3] = param1[_loc_3].toString();
				}
			}
			return _loc_2;
		}

		// end function
		public static function createCacheBuster() : String {
			var _loc_1 : * = new Date();
			var _loc_2 : * = "?cb=" + _loc_1.getTime();
			return _loc_2;
		}
		// end function
	}
}
