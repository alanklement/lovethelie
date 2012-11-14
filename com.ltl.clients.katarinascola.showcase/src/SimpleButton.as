package {
	import gs.TweenLite;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	public class SimpleButton extends EventDispatcher {
		public var extra_data : *;
		public var mc : MovieClip;
		public var eventToReDispatch : Event;
		private var btn : MovieClip;

		public function SimpleButton(mcOnStage : MovieClip, eventToDispatch : Event) {
			this.mc = mcOnStage;
			this.eventToReDispatch = eventToDispatch;
			initProperties();
		}

		private function initProperties() : void {
			mc.alpha = 0;
			btn = MovieClip(mc.getChildByName("btn"));
			btn.buttonMode = true;

			addEventListeners();
		}

		private function addEventListeners() : void {
			btn.addEventListener(MouseEvent.ROLL_OVER, makeBrighter);
			btn.addEventListener(MouseEvent.ROLL_OUT, makeDarker);
			btn.addEventListener(MouseEvent.CLICK, makeVeryDark);
		}

		public function enable() : void {
			addEventListeners();
			btn.buttonMode = true;
			TweenLite.to(mc, .25, {alpha:.5});
		}

		public function disable() : void {
			btn.removeEventListener(MouseEvent.ROLL_OVER, makeBrighter);
			btn.removeEventListener(MouseEvent.ROLL_OUT, makeDarker);
			btn.removeEventListener(MouseEvent.CLICK, makeVeryDark);
			btn.buttonMode = false;
			TweenLite.to(mc, .25, {alpha:.25});
		}

		private function makeDarker(event : MouseEvent) : void {
			TweenLite.to(mc, .25, {alpha:.5});
		}

		private function makeBrighter(event : MouseEvent) : void {
			TweenLite.to(mc, .25, {alpha:1});
		}

		private function makeVeryDark(event : MouseEvent) : void {
			dispatchEvent(event.clone());
			TweenLite.to(mc, .25, {alpha:.25});
		}
	}
}
