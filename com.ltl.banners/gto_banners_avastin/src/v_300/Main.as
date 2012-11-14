package v_300
{
	import com.greensock.TimelineLite;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * @author Freelancer
	 */
	public class Main extends Sprite
	{
		private static const MENU_OFFSET : Number = 45;
		private static const NONE : String = 'none';
		private static const TIMER_DELAY : Number = 3000;
		private var all_mc : All_MC;
		private var choose_accordian : Accordian;
		private var share_accordian : Accordian;
		private var learn_accordian : Accordian;
		private var share_start : Number;
		private var learn_start : Number;
		private var copy : MovieClip;
		private var timed_functions : Array = [adjust_for_choose, adjust_for_share, adjust_for_learn, highlight_bottom];
		private var auto_play : Timer;
		private var is_auto_playing : Boolean;

		public function Main()
		{
			init_display_objects();
			create_accordians();
			record_properties();
			add_event_listeners();
			animate_in();
			begin_auto_timer();
		}

		private function animate_in() : void
		{
			var timeline : TimelineLite = new TimelineLite({onComplete:enable});
			timeline.append(new TweenLite(all_mc.mc_choose_accordian, .5, {alpha:1, x:-0.4}));
			timeline.append(new TweenLite(all_mc.mc_share_accordian, .5, {alpha:1, x:-0.4}), -.25);
			timeline.append(new TweenLite(all_mc.mc_learn_accordian, .5, {alpha:1, x:-0.4}), -.25);
		}

		private function enable() : void
		{
			this.mouseChildren = true;
			this.mouseEnabled = true;
		}

		private function begin_auto_timer() : void
		{
			auto_play = new Timer(TIMER_DELAY, 4);
			auto_play.addEventListener(TimerEvent.TIMER, advance_autoplay);
			auto_play.start();
			is_auto_playing = true;
		}

		private function advance_autoplay(event : TimerEvent) : void
		{
			var next_function : Function = timed_functions.shift();
			next_function.call();
		}

		private function init_display_objects() : void
		{
			all_mc = new All_MC();
			all_mc.x = 150;
			all_mc.y = 125;
			trace(all_mc.x);
			trace(all_mc.y);
			addChild(all_mc);

			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			all_mc.mc_choose_accordian.x = -150;
			all_mc.mc_learn_accordian.x = -150;
			all_mc.mc_share_accordian.x = -150;

			all_mc.mc_choose_accordian.alpha = 0;
			all_mc.mc_learn_accordian.alpha = 0;
			all_mc.mc_share_accordian.alpha = 0;

			copy = MovieClip(all_mc.getChildByName("mc_bottom_copy"));
			all_mc.mc_bottom_hit.buttonMode = true;
		}

		private function create_accordians() : void
		{
			choose_accordian = new Accordian(all_mc.mc_choose_accordian);
			share_accordian = new Accordian(all_mc.mc_share_accordian);
			learn_accordian = new Accordian(all_mc.mc_learn_accordian);
		}

		private function record_properties() : void
		{
			share_start = share_accordian.mc.y;
			learn_start = learn_accordian.mc.y;
		}

		private function add_event_listeners() : void
		{
			choose_accordian.addEventListener(MouseEvent.ROLL_OVER, adjust_for_choose);
			share_accordian.addEventListener(MouseEvent.ROLL_OVER, adjust_for_share);
			learn_accordian.addEventListener(MouseEvent.ROLL_OVER, adjust_for_learn);
			choose_accordian.addEventListener(MouseEvent.ROLL_OUT, close_all);
			share_accordian.addEventListener(MouseEvent.ROLL_OUT, close_all);
			learn_accordian.addEventListener(MouseEvent.ROLL_OUT, close_all);
			all_mc.mc_bottom_hit.addEventListener(MouseEvent.ROLL_OVER, highlight_bottom);
			all_mc.mc_bottom_hit.addEventListener(MouseEvent.ROLL_OUT, function(e : Event):void
			{
				new TweenLite(copy, .25, {tint:0x34A98D});
			});

			stage.addEventListener(MouseEvent.CLICK, click_tag);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stop_timer);
		}

		private function highlight_bottom(event : MouseEvent = null) : void
		{
			if(is_auto_playing)
			{
				learn_accordian.close();
			}
			new TweenLite(copy, .25, {tint:0xffffff});
		}

		private function stop_timer(event : MouseEvent) : void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stop_timer);
			is_auto_playing = false;
			auto_play.stop();
		}

		private function click_tag(event : MouseEvent) : void
		{
			var click_tag_url : String = this.stage.loaderInfo.parameters.clickTag ? this.stage.loaderInfo.parameters.clickTag : NONE;
			if(click_tag_url != NONE)
			{
				navigateToURL(new URLRequest(click_tag_url), "_blank");
			}
		}

		private function close_all(event : MouseEvent) : void
		{
			new TweenLite(share_accordian.mc, .25, {delay:.08, y:share_start, ease:Linear.easeNone});
			new TweenLite(learn_accordian.mc, .25, {delay:.08, y:learn_start, ease:Linear.easeNone});
		}

		private function adjust_for_learn(event : MouseEvent = null) : void
		{
			kill_and_close_tweens();
			if(is_auto_playing)
			{
				learn_accordian.open();
			}
			new TweenLite(share_accordian.mc, .25, {delay:.08, y:share_start, ease:Linear.easeNone});
			new TweenLite(learn_accordian.mc, .25, {delay:.08, y:learn_start, ease:Linear.easeNone});
		}

		private function adjust_for_share(event : MouseEvent = null) : void
		{
			kill_and_close_tweens();
			if(is_auto_playing)
			{
				share_accordian.open();
			}
			new TweenLite(share_accordian.mc, .25, {delay:.08, y:share_start, ease:Linear.easeNone});
			new TweenLite(learn_accordian.mc, .25, {delay:.08, y:learn_start + MENU_OFFSET});
		}

		private function adjust_for_choose(event : MouseEvent = null) : void
		{
			kill_and_close_tweens();
			if(is_auto_playing)
			{
				choose_accordian.open();
			}
			new TweenLite(share_accordian.mc, .25, {delay:.08, y:share_start + MENU_OFFSET});
			new TweenLite(learn_accordian.mc, .25, {delay:.08, y:learn_start + MENU_OFFSET});
		}

		private function kill_and_close_tweens() : void
		{
			choose_accordian.close();
			learn_accordian.close();
			share_accordian.close();
			TweenLite.killTweensOf(share_accordian.mc);
			TweenLite.killTweensOf(learn_accordian.mc);
		}
	}
}
