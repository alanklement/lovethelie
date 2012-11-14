package {
	import com.greensock.TweenLite;

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class Compcard_View {
		private var view : MovieClip;
		private var preview_holder_mc : MovieClip;
		private var download_button : MovieClip;
		private var load_way_btn : Compcard_Btn;
		private var card_download_progress : MovieClip;
		private var load_marilyn_btn : Compcard_Btn;
		private var load_anc_btn : Compcard_Btn;
		private var load_select_btn : Compcard_Btn;
		private var previews_loader : SimpleBulkLoader;
		private var load_anc_preview : Loader;
		private var load_marilyn_preview : Loader;
		private var load_select_preview : Loader;
		private var load_way_preview : Loader;
		private var selected_compcard_pdf_url : String;
		private var load_model_btn : Compcard_Btn;
		private var load_model_preview : Loader;

		public function Compcard_View(view_mc : MovieClip) {
			create_references(view_mc);
			set_display_list_properties();
			create_compcard_buttons();
			preload_compcard_previews();
		}

		private function create_references(view_mc : MovieClip) : void {
			view = MovieClip(view_mc.getChildByName("compcardViewMC"));
			preview_holder_mc = MovieClip(view.getChildByName("previewHolderMC"));
			card_download_progress = MovieClip(view.getChildByName("compcardDownloadMC"));
			download_button = MovieClip(view.getChildByName("downloadMC"));
		}

		private function set_display_list_properties() : void {
			view.alpha = 0;
			view.visible = false;

			card_download_progress.alpha = 0;
			card_download_progress.visible = false;

			download_button. alpha = .7;
			download_button.buttonMode = true;
		}

		private function create_compcard_buttons() : void {
			load_way_btn = new Compcard_Btn(MovieClip(view.getChildByName("load_way_btn")), './compcard/way.pdf');
			load_marilyn_btn = new Compcard_Btn(MovieClip(view.getChildByName("load_marilyn_btn")), './compcard/marilyn.pdf');
			load_anc_btn = new Compcard_Btn(MovieClip(view.getChildByName("load_anc_btn")), './compcard/anc.pdf');
			load_select_btn = new Compcard_Btn(MovieClip(view.getChildByName("load_select_btn")), './compcard/select.pdf');
			load_model_btn = new Compcard_Btn(MovieClip(view.getChildByName("load_model_btn")), './compcard/model.pdf');
		}

		private function preload_compcard_previews() : void {
			previews_loader = new SimpleBulkLoader();
			previews_loader.addItem('./images/anc.jpg', './images/anc.jpg');
			previews_loader.addItem('./images/marilyn.jpg', './images/marilyn.jpg');
			previews_loader.addItem('./images/select.jpg', './images/select.jpg');
			previews_loader.addItem('./images/way2.jpg', './images/way2.jpg');
			previews_loader.addItem('./images/model.jpg', './images/model.jpg');
			previews_loader.loadAllItems(allItemsLoadedCallback);
		}

		private function allItemsLoadedCallback() : void {
			load_anc_preview = previews_loader.getLoader('./images/anc.jpg');
			load_marilyn_preview = previews_loader.getLoader('./images/marilyn.jpg');
			load_select_preview = previews_loader.getLoader('./images/select.jpg');
			load_way_preview = previews_loader.getLoader('./images/way2.jpg');
			load_model_preview = previews_loader.getLoader('./images/model.jpg');

			add_previews_to_compcards();
			adjust_x_pos_of_previews();
			add_previews_to_holder();
			add_event_listeners();
		}

		private function add_previews_to_compcards() : void {
			load_way_btn.preview_img = load_way_preview;
			load_marilyn_btn.preview_img = load_marilyn_preview;
			load_select_btn.preview_img = load_select_preview;
			load_anc_btn.preview_img = load_anc_preview;
			load_model_btn.preview_img = load_model_preview;
		}

		private function adjust_x_pos_of_previews() : void {
			var center_of_holder : Number = preview_holder_mc.width * .5;

			load_anc_preview.x = center_of_holder - load_anc_preview.width * .5;
			load_marilyn_preview.x = center_of_holder - load_marilyn_preview.width * .5;
			load_select_preview.x = center_of_holder - load_select_preview.width * .5;
			load_way_preview.x = center_of_holder - load_way_preview.width * .5;
			load_model_preview.x = center_of_holder - load_model_preview.width * .5;
		}

		private function add_previews_to_holder() : void {
			preview_holder_mc.addChild(load_anc_preview);
			preview_holder_mc.addChild(load_marilyn_preview);
			preview_holder_mc.addChild(load_select_preview);
			preview_holder_mc.addChild(load_way_preview);
			preview_holder_mc.addChild(load_model_preview);
		}

		private function add_event_listeners() : void {
			download_button.addEventListener(MouseEvent.ROLL_OVER, brighten);
			download_button.addEventListener(MouseEvent.ROLL_OUT, darken);
			download_button.addEventListener(MouseEvent.CLICK, downLoadCompcard);

			load_way_btn.addEventListener(MouseEvent.CLICK, prepare_selected_compcard);
			load_marilyn_btn.addEventListener(MouseEvent.CLICK, prepare_selected_compcard);
			load_anc_btn.addEventListener(MouseEvent.CLICK, prepare_selected_compcard);
			load_select_btn.addEventListener(MouseEvent.CLICK, prepare_selected_compcard);
			load_model_btn.addEventListener(MouseEvent.CLICK, prepare_selected_compcard);
		}

		private function prepare_selected_compcard(event : MouseEvent) : void {
			var selected_compcard_btn : Compcard_Btn = Compcard_Btn(event.target);
			selected_compcard_pdf_url = selected_compcard_btn.compcard_link;

			turn_off_all_buttons();

			selected_compcard_btn.turn_on();
		}

		private function turn_off_all_buttons() : void {
			load_way_btn.turn_off();
			load_marilyn_btn.turn_off();
			load_anc_btn.turn_off();
			load_select_btn.turn_off();
			load_model_btn.turn_off();
		}

		private function darken(event : MouseEvent) : void {
			TweenLite.to(download_button, .25, {alpha:.7});
		}

		private function brighten(event : MouseEvent) : void {
			TweenLite.to(download_button, .25, {alpha:1});
		}

		public function enable() : void {
			TweenLite.to(view, .5, {autoAlpha:1});
			enable_buttons();
			load_way_btn.turn_on();
			selected_compcard_pdf_url = load_way_btn.compcard_link;
		}

		private function enable_buttons() : void {
			if (load_anc_btn) {
				load_anc_btn.enable();
				load_marilyn_btn.enable();
				load_select_btn.enable();
				load_way_btn.enable();
				load_model_btn.enable();
			}
		}

		public function disable() : void {
			TweenLite.to(view, .5, {autoAlpha:0});
			turn_off_all_buttons();
			diable_buttons();
		}

		private function diable_buttons() : void {
			load_anc_btn.disable();
			load_marilyn_btn.disable();
			load_select_btn.disable();
			load_way_btn.disable();
			load_model_btn.disable();
		}

		private function downLoadCompcard(event : MouseEvent) : void {
			var url : URLRequest = new URLRequest(selected_compcard_pdf_url);
			navigateToURL(url, "_blank");
		}
	}
}
