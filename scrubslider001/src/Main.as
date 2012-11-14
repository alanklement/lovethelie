package {
	import flash.display.MovieClip ;
	import flash.events.Event ;

	import com.bigspaceship.events.SliderEvent ;

	public class Main extends MovieClip {
		public function Main() {
			var scrollBar = new ScrubScroller(scroller_mc.box_mc, scroller_mc.bar_mc, this.stage) ;
			scrollBar.speed = 20 ;
			scrollBar.addEventListener(SliderEvent.UPDATE, _onUpdate)
		}

		private function _onUpdate($evt : SliderEvent) : void {
			target_mc.x += $evt.p ;
		}
	}
}
	