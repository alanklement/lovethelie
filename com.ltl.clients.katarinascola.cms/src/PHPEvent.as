package {
	import flash.events.*;

	public class PHPEvent extends Event {
		public var data : Object;
		public static const BACKGROUNDS_LOAD_START : String = "BACKGROUND_LOAD_START";
		public static const LOAD_SECTIONS_START : String = "LOAD_SECTIONS_START";
		public static const IMAGES_LOADED : String = "IMAGES_LOADED";
		public static const LOAD_IMAGES_START : String = "LOAD_IMAGES_START";
		public static const SECTIONS_LOADED : String = "BOOKS_LOADED";
		public static const BACKGROUNDS_LOADED : String = "BACKGROUND_LOADED";

		public function PHPEvent(param1 : String, param2 : Object = null, param3 : Boolean = false, param4 : Boolean = false) {
			super(param1, param3, param4);
			this.data = param2;
			return;
		}

		// end function
		override public function clone() : Event {
			return new PHPEvent(type, this.data, bubbles, cancelable);
		}

		// end function
		override public function toString() : String {
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		// end function
	}
}
