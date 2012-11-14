package {
	import com.greensock.TweenLite;

	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class AgencyView extends EventDispatcher {
		private var selectMC : AgencyBtn;
		private var ancMC : AgencyBtn;
		private var marilynMC : AgencyBtn;
		private var wayMC : AgencyBtn;
		private var view : MovieClip;

		public function AgencyView(view : MovieClip) {
			createReferecnes(view);
			addEventListeners();
		}

		private function createReferecnes(view : MovieClip) : void {
			this.view = view;
			selectMC = new AgencyBtn(MovieClip(view.getChildByName("selectMC")), 'http://www.selectmodel.com');
			ancMC = new AgencyBtn(MovieClip(view.getChildByName("ancMC")), 'http://www.model-management.de/');
			marilynMC = new AgencyBtn(MovieClip(view.getChildByName("marilynMC")), 'http://www.marilynagency.com');
			wayMC = new AgencyBtn(MovieClip(view.getChildByName("wayMC")), 'http://www.waymodel.com.br');
		}

		private function addEventListeners() : void {
			selectMC.addEventListener(MouseEvent.CLICK, linkToAgency);
			ancMC.addEventListener(MouseEvent.CLICK, linkToAgency);
			marilynMC.addEventListener(MouseEvent.CLICK, linkToAgency);
			wayMC.addEventListener(MouseEvent.CLICK, linkToAgency);
		}

		public function enable() : void {
			TweenLite.to(marilynMC.mc, .5, {alpha:1})
			,
			TweenLite.to(wayMC.mc, .5, {alpha:1})
			,
			TweenLite.to(ancMC.mc, .5, {alpha:1})
			,
			TweenLite.to(selectMC.mc, .5, {alpha:1});

			selectMC.enable();
			ancMC.enable();
			marilynMC.enable();
			wayMC.enable();
		}

		public function disable() : void {
			TweenLite.to(marilynMC.mc, .15, {alpha:0})
			,
			TweenLite.to(wayMC.mc, .15, {alpha:0})
			,
			TweenLite.to(ancMC.mc, .15, {alpha:0})
			,
			TweenLite.to(selectMC.mc, .15, {alpha:0});

			selectMC.disable();
			ancMC.disable();
			marilynMC.disable();
			wayMC.disable();
		}

		private function linkToAgency(event : MouseEvent) : void {
			var url : String = AgencyBtn(event.currentTarget).url;
			var request : URLRequest = new URLRequest(url);
			navigateToURL(request, '_blank');
			// second argument is target
		}
	}
}
