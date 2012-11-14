package {
	import flash.events.EventDispatcher;

	import com.greensock.TweenLite;

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class Compcard_Btn extends EventDispatcher {
		private var mc : MovieClip;
		private var _preview_img : Loader;
		public var compcard_link : String;

		public function Compcard_Btn(mc : MovieClip, compcard_link : String) {
			this.mc = mc;
			this.compcard_link = compcard_link;
		}

		public function turn_on() : void {
			brighten();
			remove_event_listener();
			mc.buttonMode = false;
			TweenLite.to(_preview_img, .25, {alpha:1});
		}

		public function turn_off() : void {
			darken(null);
			add_event_listener();
			mc.buttonMode = true;
			TweenLite.to(_preview_img, .25, {alpha:0});
		}

		public function enable() : void {
			add_event_listener();
			TweenLite.to(mc, .25, {alpha:.5});
			mc.mouseChildren = true;
			mc.buttonMode = true;
		}

		public function disable() : void {
			remove_event_listener();
			TweenLite.to(mc, .25, {alpha:0});
			mc.mouseChildren = false;
			mc.buttonMode = false;
		}

		private function brighten(event : MouseEvent = null) : void {
			TweenLite.to(mc, .25, {alpha:1});
		}

		private function darken(event : MouseEvent = null) : void {
			TweenLite.to(mc, .25, {alpha:.5});
		}

		private function add_event_listener() : void {
			mc.addEventListener(MouseEvent.ROLL_OVER, brighten);
			mc.addEventListener(MouseEvent.ROLL_OUT, darken);
			mc.addEventListener(MouseEvent.CLICK, notify_of_click);
		}

		private function remove_event_listener() : void {
			mc.removeEventListener(MouseEvent.ROLL_OVER, brighten);
			mc.removeEventListener(MouseEvent.ROLL_OUT, darken);
			mc.removeEventListener(MouseEvent.CLICK, notify_of_click);
		}

		private function notify_of_click(event : MouseEvent) : void {
			dispatchEvent(event.clone());
		}

		public function set preview_img(preview_img : Loader) : void {
			_preview_img = preview_img;
			_preview_img.alpha = 0;
		}

		public function get preview_img() : Loader {
			return _preview_img;
		}
	}
}
