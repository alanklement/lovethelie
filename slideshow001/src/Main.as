package {
	import flash.display.MovieClip ;
	import flash.events.Event ;
	import flash.events.MouseEvent ;

	import slideshow.SlideShow ;
	import slideshow.SlideEvent ;

	public class Main extends MovieClip {
		private var _ss : SlideShow ;

		public function Main() {
			_ss = new SlideShow();
			_ss.addEventListener(SlideEvent.SLIDE_DATA_LOADED, _onSlidesReady) ;
			_ss.xml = '_xml/beauty.xml' ;
			_ss.holder = holder_mc ;
			_ss.init();

			next_btn.addEventListener(MouseEvent.MOUSE_DOWN, _nextImg) ;
			previous_btn.addEventListener(MouseEvent.MOUSE_DOWN, _prevImg) ;
			reload_btn.addEventListener(MouseEvent.MOUSE_DOWN, _reload) ;
			clean_btn.addEventListener(MouseEvent.MOUSE_DOWN, _cleanSS) ;
		}

		private function _cleanSS($evt : Event) : void {
			_ss.clean() ;
		}

		private function _onSlidesReady($evt : SlideEvent) : void {
			_ss.loadFirstSlide();
		}

		private function _nextImg($evt : MouseEvent) : void {
			_ss.nextSlide() ;
		}

		private function _prevImg($evt : MouseEvent) : void {
			_ss.previousSlide() ;
		}

		private function _reload($evt : MouseEvent) : void {
			_ss.xml = '_xml/fashion.xml' ;
			_ss.init();
		}
	}
}

