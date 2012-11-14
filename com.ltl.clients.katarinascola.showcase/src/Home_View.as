package {
	import com.greensock.TweenLite;

	import flash.display.Loader;
	import flash.display.MovieClip;

	public class Home_View {
		private var frame_mc : MovieClip;
		private var bg_image_holder_mc : MovieClip;
		private var homeNameTitleMC : MovieClip;

		public function Home_View(view : MovieClip) {
			create_references(view);
		}

		private function create_references(view : MovieClip) : void {
			frame_mc = MovieClip(view.getChildByName("frameMC"));
			bg_image_holder_mc = MovieClip(view.getChildByName("bgImageHolderMC"));
			homeNameTitleMC = MovieClip(view.getChildByName("homeNameTitleMC"));
		}

		public function add_bg_image(backgroundImg : Loader) : void {
			bg_image_holder_mc.addChild(backgroundImg);
		}

		public function enable() : void {
			TweenLite.to(frame_mc, .25, {alpha:1});
			TweenLite.to(bg_image_holder_mc, .25, {autoAlpha:1});
			TweenLite.to(homeNameTitleMC, .25, {autoAlpha:1});
		}

		public function disable() : void {
			TweenLite.to(frame_mc, .25, {alpha:0});
			TweenLite.to(bg_image_holder_mc, .25, {autoAlpha:0});
			TweenLite.to(homeNameTitleMC, .25, {autoAlpha:0});
		}
	}
}
