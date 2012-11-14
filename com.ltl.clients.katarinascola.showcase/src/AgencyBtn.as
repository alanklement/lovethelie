package {
	import com.greensock.TweenLite;

	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	public class AgencyBtn extends EventDispatcher {
		public var mc : MovieClip;
		public var url : String;
		private var outline : MovieClip;
		private var btnMC : MovieClip;

		public function AgencyBtn(mc : MovieClip, url : String) {
			this.url = url;
			this.mc = mc;
			getReferences();
		}

		private function getReferences() : void {
			outline = MovieClip(mc.getChildByName("outlineMC"));
			btnMC = MovieClip(mc.getChildByName("btnMC"));
			setProperties();
		}

		private function setProperties() : void {
			mc.alpha = 0;
			outline.alpha = 0;
			addEventListeners();
		}

		private function addEventListeners() : void {
			btnMC.addEventListener(MouseEvent.ROLL_OVER, showOutline);
			btnMC.addEventListener(MouseEvent.ROLL_OUT, hideOutline);
		}

		public function enable() : void {
			btnMC.addEventListener(MouseEvent.CLICK, linkToAgency);
			mc.mouseEnabled = true;
			mc.mouseChildren = true;
			mc.buttonMode = true;
		}

		public function disable() : void {
			mc.mouseEnabled = true;
			mc.mouseChildren = true;
			mc.buttonMode = false;
			btnMC.removeEventListener(MouseEvent.CLICK, linkToAgency);
		}

		private function showOutline(event : MouseEvent) : void {
			TweenLite.to(outline, .25, {alpha:1});
		}

		private function hideOutline(event : MouseEvent) : void {
			TweenLite.to(outline, .25, {alpha:0});
		}

		private function linkToAgency(event : MouseEvent) : void {
			dispatchEvent(event.clone());
		}
	}
}
