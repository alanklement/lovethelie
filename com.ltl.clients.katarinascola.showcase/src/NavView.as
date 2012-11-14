package {
	import gs.TweenLite;
	import gs.TweenGroup;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	public class NavView extends EventDispatcher implements UIView {
		public static const LOAD_FASHION_SECTION : String = "LOAD_FASHION_SECTION";
		public static const LOAD_BEAUTY_SECTION : String = "LOAD_BEAUTY_SECTION";
		public static const LOAD_COVER_SECTION : String = "LOAD_COVER_SECTION";
		public static const LOAD_HOME_SECTION : String = "LOAD_HOME_SECTION";
		public static const LOAD_AGENCIES_SECTION : String = "LOAD_AGENCIES_SECTION";
		public static const LOAD_COMPCARD_SECTION : String = "LOAD_COMPCARD_SECTION";
		public static const LOAD_VIDEO_SECTION : String = "LOAD_VIDEO_SECTION";
		private var fashionBtn : SimpleButton;
		private var videosBtn : SimpleButton;
		private var beautyBtn : SimpleButton;
		private var homeBtn : SimpleButton;
		private var compcardBtn : SimpleButton;
		private var coversBtn : SimpleButton;
		private var agenciesBtn : SimpleButton;
		private var navButtons : Array;
		private var clickedButton : SimpleButton;

		public function NavView(viewMC : MovieClip) {
			createReferencesToObjectsOnStage(viewMC);
		}

		public function set_nav_for_agencies() : void {
			clickedButton = agenciesBtn;
			dis_able_all_btns();
			enableAllBtns();
		}

		public function set_nav_for_home() : void {
			clickedButton = homeBtn;
			dis_able_all_btns();
			enableAllBtns();
		}

		public function set_nav_for_compcard() : void {
			clickedButton = compcardBtn;
			dis_able_all_btns();
			enableAllBtns();
		}

		public function set_nav_for_video() : void {
			clickedButton = videosBtn;
			dis_able_all_btns();
			enableAllBtns();
		}

		public function enable() : void {
			enableAllBtns();
		}

		public function disable() : void {
			dis_able_all_btns();
		}

		private function createReferencesToObjectsOnStage(viewMC : MovieClip) : void {
			homeBtn = new SimpleButton(MovieClip(viewMC.getChildByName("homeMC")), new Event(NavView.LOAD_HOME_SECTION));
			fashionBtn = new SimpleButton(MovieClip(viewMC.getChildByName("fashionMC")), new Event(NavView.LOAD_FASHION_SECTION));
			beautyBtn = new SimpleButton(MovieClip(viewMC.getChildByName("beautyMC")), new Event(NavView.LOAD_BEAUTY_SECTION));
			coversBtn = new SimpleButton(MovieClip(viewMC.getChildByName("coversMC")), new Event(NavView.LOAD_COVER_SECTION));
			videosBtn = new SimpleButton(MovieClip(viewMC.getChildByName("videosMC")), new Event(NavView.LOAD_VIDEO_SECTION));
			compcardBtn = new SimpleButton(MovieClip(viewMC.getChildByName("compcardMC")), new Event(NavView.LOAD_COMPCARD_SECTION));
			agenciesBtn = new SimpleButton(MovieClip(viewMC.getChildByName("agenciesMC")), new Event(NavView.LOAD_AGENCIES_SECTION));

			navButtons = [fashionBtn, videosBtn, beautyBtn, homeBtn, compcardBtn, coversBtn, agenciesBtn];
			addEventListernes();
		}

		private function addEventListernes() : void {
			homeBtn.addEventListener(MouseEvent.CLICK, notifyNavItemClicked);
			fashionBtn.addEventListener(MouseEvent.CLICK, notifyNavItemClicked);
			beautyBtn.addEventListener(MouseEvent.CLICK, notifyNavItemClicked);
			coversBtn.addEventListener(MouseEvent.CLICK, notifyNavItemClicked);
			agenciesBtn.addEventListener(MouseEvent.CLICK, notifyNavItemClicked);
			compcardBtn.addEventListener(MouseEvent.CLICK, notifyNavItemClicked);
			videosBtn.addEventListener(MouseEvent.CLICK, notifyNavItemClicked);
		}

		private function notifyNavItemClicked(event : MouseEvent) : void {
			clickedButton = SimpleButton(event.currentTarget);
			dispatchEvent(clickedButton.eventToReDispatch);
		}

		private function enableAllBtns() : void {
			for each (var btn : SimpleButton in navButtons) {
				if (btn != clickedButton) {
					btn.enable();
				}
			}
		}

		private function dis_able_all_btns() : void {
			for each (var btn : SimpleButton in navButtons) {
				btn.disable();
			}
		}

		public function animateIn() : void {
			var tweenGroup : TweenGroup = new TweenGroup();
			tweenGroup.push(new TweenLite(homeBtn.mc, .5, {alpha:.5}));
			tweenGroup.push(new TweenLite(fashionBtn.mc, .5, {alpha:.5}));
			tweenGroup.push(new TweenLite(beautyBtn.mc, .5, {alpha:.5}));
			tweenGroup.push(new TweenLite(coversBtn.mc, .5, {alpha:.5}));
			tweenGroup.push(new TweenLite(videosBtn.mc, .5, {alpha:.5}));
			tweenGroup.push(new TweenLite(agenciesBtn.mc, .5, {alpha:.5}));
			tweenGroup.push(new TweenLite(compcardBtn.mc, .5, {alpha:.5}));
			tweenGroup.align = TweenGroup.ALIGN_START;
			tweenGroup.stagger = .15;
		}

		public function animateOut() : void {
		}
	}
}
