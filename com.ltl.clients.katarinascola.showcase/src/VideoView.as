package {
	import flash.events.MouseEvent;

	import com.greensock.TweenLite;

	import flash.display.MovieClip;
	import flash.events.Event;

	public class VideoView {
		private var dataModel : NetworkDataModel;
		private var player_controls : MovieClip;
		private var video_holder : MovieClip;
		// private var video_player : Video_Player;
		private var video_player_2 : Video_Player_2;
		private var video_holder_inner : MovieClip;
		private var buffer_hud : MovieClip;
		private var expressions_btn : SimpleButton;
		private var macy_btn : SimpleButton;
		private var pantene_btn : SimpleButton;
		private var pantene2_btn : SimpleButton;
		private var play_btn : SimpleButton;
		private var pause_btn : SimpleButton;
		private var replay_btn : SimpleButton;

		public function VideoView(dataModel : NetworkDataModel, view_mc : MovieClip) {
			this.dataModel = dataModel;
			extract_display_object_references(view_mc);
			set_display_object_properties();
			create_video_player();
			add_event_listeners();
		}

		private function extract_display_object_references(view_mc : MovieClip) : void {
			player_controls = MovieClip(view_mc.getChildByName("playerControlsMC"));
			video_holder = MovieClip(view_mc.getChildByName("videoHolderMC"));
			video_holder_inner = MovieClip(video_holder.getChildByName("videoHolderInnerMC"));
			buffer_hud = MovieClip(video_holder.getChildByName("bufferingMC"));

			expressions_btn = new SimpleButton(MovieClip(video_holder.getChildByName("expressions")), new Event(Event.ACTIVATE));
			macy_btn = new SimpleButton(MovieClip(video_holder.getChildByName("macy")), new Event(Event.ACTIVATE));
			pantene_btn = new SimpleButton(MovieClip(video_holder.getChildByName("pantene")), new Event(Event.ACTIVATE));
			pantene2_btn = new SimpleButton(MovieClip(video_holder.getChildByName("pantene2")), new Event(Event.ACTIVATE));

			play_btn = new SimpleButton(MovieClip(player_controls.getChildByName("playMC")), new Event(Event.ACTIVATE));
			pause_btn = new SimpleButton(MovieClip(player_controls.getChildByName("pauseMC")), new Event(Event.ACTIVATE));
			replay_btn = new SimpleButton(MovieClip(player_controls.getChildByName("replayMC")), new Event(Event.ACTIVATE));
		}

		private function set_display_object_properties() : void {
			player_controls.visible = false;
			video_holder.visible = false;
			buffer_hud.visible = false;

			player_controls.alpha = 0;
			video_holder.alpha = 0;
			buffer_hud.alpha = 0;

			expressions_btn.enable();
			macy_btn.enable();
			pantene_btn.enable();
			pantene2_btn.enable();

			play_btn.enable();
			pause_btn.enable();
			replay_btn.enable();

			expressions_btn.extra_data = "./../video/expressions.f4v";
			macy_btn.extra_data = "./../video/macy1.f4v";
			pantene_btn.extra_data = "./../video/pantene_english.f4v";
			pantene2_btn.extra_data = "./../video/pantene_arabic.f4v";
		}

		private function create_video_player() : void {
			video_player_2 = new Video_Player_2();
			video_holder_inner.addChild(video_player_2.view);

			play_btn.addEventListener(MouseEvent.CLICK, play_movie);
			pause_btn.addEventListener(MouseEvent.CLICK, pause_movie);
			replay_btn.addEventListener(MouseEvent.CLICK, replay_movie);
		}

		private function replay_movie(event : MouseEvent) : void {
			video_player_2.replay();
			video_player_2.resume();

			play_btn.enable();
			pause_btn.enable();
			replay_btn.disable();
		}

		private function pause_movie(event : MouseEvent) : void {
			video_player_2.pause();
			play_btn.enable();
			replay_btn.enable();
			pause_btn.disable();
		}

		private function play_movie(event : MouseEvent) : void {
			video_player_2.resume();
			play_btn.disable();
			pause_btn.enable();
			replay_btn.enable();
		}

		private function add_event_listeners() : void {
			video_player_2.addEventListener(Video_Player_2.SHOW_BUFFER, show_buffer);
			video_player_2.addEventListener(Video_Player_2.HIDE_BUFFER, hide_buffer);

			expressions_btn.addEventListener(MouseEvent.CLICK, change_video);
			macy_btn.addEventListener(MouseEvent.CLICK, change_video);
			pantene_btn.addEventListener(MouseEvent.CLICK, change_video);
			pantene2_btn.addEventListener(MouseEvent.CLICK, change_video);
		}

		private function change_video(event : MouseEvent) : void {
			var selected_btn : SimpleButton = SimpleButton(event.target);
			var url : String = selected_btn.extra_data;
			video_player_2.play_video(url);

			set_controls_to_play();
		}

		private function set_controls_to_play() : void {
			play_btn.disable();
			pause_btn.enable();
			replay_btn.enable();
		}

		private function hide_buffer(event : Event) : void {
			TweenLite.to(buffer_hud, .5, {autoAlpha:0});
			TweenLite.to(video_player_2.view, 1, {alpha:1, blurFilter:{blurX:0, blurY:0}});
		}

		private function show_buffer(event : Event) : void {
			TweenLite.to(buffer_hud, .2, {autoAlpha:1});
			TweenLite.to(video_player_2.view, 1, {alpha:.5, blurFilter:{blurX:10, blurY:10}});
		}

		public function disable() : void {
			TweenLite.to(player_controls, .25, {autoAlpha:0});
			TweenLite.to(video_holder, .25, {autoAlpha:0});
			video_player_2.kill_current_video();
		}

		public function enable() : void {
			TweenLite.to(player_controls, .25, {autoAlpha:1});
			TweenLite.to(video_holder, .25, {autoAlpha:1});

			begin_auto_play();
		}

		private function begin_auto_play() : void {
			TweenLite.to(video_player_2.view, 2, {alpha:.5, blurFilter:{blurX:10, blurY:10}});
			video_player_2.play_video("./../video/pantene_english.f4v");
			set_controls_to_play();
		}

		private function createVideoMenu(videoVOs : Array) : void {
		}
	}
}
