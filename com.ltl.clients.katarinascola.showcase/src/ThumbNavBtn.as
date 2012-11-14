package {
	import flash.events.EventDispatcher;

	import gs.TweenLite;

	import flash.events.MouseEvent;
	import flash.display.MovieClip;

	public class ThumbNavBtn extends EventDispatcher {
		public var mc : MovieClip;

		public function ThumbNavBtn(mc : MovieClip) {
			this.mc = mc;
			setProperties();
		}

		private function setProperties() : void {
			mc.buttonMode = true;
			addEventListeners();
		}

		private function addEventListeners() : void {
			mc.addEventListener(MouseEvent.ROLL_OVER, makeBiggerAndTint);
			mc.addEventListener(MouseEvent.ROLL_OUT, returnToIdle);
			mc.addEventListener(MouseEvent.CLICK, notrifyClick);
		}

		private function makeBiggerAndTint(event : MouseEvent) : void {
			TweenLite.to(mc, .25, {tint:0xC9C9C9});
		}

		private function returnToIdle(event : MouseEvent) : void {
			TweenLite.to(mc, .25, {tint:0x444444});
		}

		private function notrifyClick(event : MouseEvent) : void {
			dispatchEvent(event.clone());
		}
	}
}
