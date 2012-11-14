package 
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Freelancer
	 */
	public class Main extends Sprite
	{
		public static const HOT_SPOT_HIT : String = "HOT_SPOT_HIT";
		private static const HOT_SPOT_DELAY : Number = 1800;
		private var intro_pills : Intro_Pills;
		private var all_timeline : TimelineLite;
		private var pulling_arrow : Pulling_Arrow;
		private var pull_mc : Pull_728_MC;
		private var move_forward_txt : Move_Forward_728_MC;
		private var bg : Background_728_MC;
		private var next_frame : Number;
		private var email : Email;
		private var stage_right : Number = 550;
		private var stage_left : Number = -800;
		private var advice : Advice;
		private var heart : Heart;
		private var move_forward : Move_Forward;
		private var pause_timer : Timer;
		private var pills_final : Pills_Final;
		private var take_control_scroller : Take_Control_Scroller;
		private var clickTag1 : String;

		[SWF(width="728", height="90", backgroundColor="#FFFFFF")]
		public function Main()
		{
			get_flash_vars();
			create_hot_spots();
			crete_display_objects();
			init_display_objects();
			create_timeline();
			add_event_listeners();

			begin();

			next_frame = 0;

			pause_timer = new Timer(HOT_SPOT_DELAY, 1);
			pause_timer.addEventListener(TimerEvent.TIMER, resume_timeline);
		}

		private function get_flash_vars() : void
		{
			clickTag1 = String(root.loaderInfo.parameters.clickTag1);
		}

		private function add_event_listeners() : void
		{
			pills_final.mc.addEventListener(MouseEvent.CLICK, check_click_tag);

			pulling_arrow.addEventListener(Pulling_Arrow.ARROW_TRIGGERED, next_stage);
			take_control_scroller.mc.addEventListener(MouseEvent.MOUSE_DOWN, stop_timeline_play);

			email.addEventListener(Main.HOT_SPOT_HIT, update_next_frame);
			advice.addEventListener(Main.HOT_SPOT_HIT, update_next_frame);
			heart.addEventListener(Main.HOT_SPOT_HIT, update_next_frame);

			stage.addEventListener(Event.ENTER_FRAME, update_progress);
		}

		private function check_click_tag(event : MouseEvent) : void
		{
			trace(this + " @ " + 'check_click_tag' + ' event: ' + (event));
//			var url : URLRequest = new URLRequest(clickTag1);
//			navigateToURL(url, "_blank");
		}

		private function stop_timeline_play(event : MouseEvent) : void
		{
			take_control_scroller.mc.removeEventListener(MouseEvent.MOUSE_DOWN, stop_timeline_play);
			stage.removeEventListener(Event.ENTER_FRAME, update_progress);

			stage.addEventListener(MouseEvent.MOUSE_MOVE, update_timeline_progress);
			stage.addEventListener(MouseEvent.MOUSE_UP, resume_timeline_play);
			all_timeline.stop();
		}

		private function update_timeline_progress(event : MouseEvent) : void
		{
			var target_time : Number = take_control_scroller.progress * all_timeline.totalDuration;
			all_timeline.gotoAndStop(target_time);
		}

		private function update_progress(event : Event) : void
		{
			set_take_control_handle(all_timeline.currentProgress);
		}

		private function resume_timeline_play(event : MouseEvent) : void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, update_timeline_progress);
			stage.removeEventListener(MouseEvent.MOUSE_UP, resume_timeline_play);

			take_control_scroller.mc.addEventListener(MouseEvent.MOUSE_DOWN, stop_timeline_play);
			stage.addEventListener(Event.ENTER_FRAME, update_progress);
			all_timeline.play();
		}

		private function update_next_frame(event : Event) : void
		{
			switch(event.currentTarget)
			{
				case email:
					next_frame = 1;
					break;
				case advice:
					next_frame = 2;
					break;
				case heart:
					next_frame = 3;
					break;
				default:
			}
		}

		private function next_stage(event : Event) : void
		{
			all_timeline.gotoAndPlay(next_frame);
		}

		private function create_hot_spots() : void
		{
			intro_pills = new Intro_Pills(new Pills_Intro_728_MC(), new Pulse(Ring_MC));
			pulling_arrow = new Pulling_Arrow(new Yellow_Arrow_728());
			email = new Email(new Email_728_MC(), new Pulse(Ring_MC), new Green_Dot_MC());

			advice = new Advice(new Advice_728_MC(), new Pulse(Ring_MC), new Green_Dot_MC());
			heart = new Heart(new Heart_728_MC(), new Pulse(Ring_MC), new Green_Dot_MC());
			move_forward = new Move_Forward(new Move_Forward_Blue_728_MC(), new Pulse(Ring_MC), new Yellow_Dot_MC());
			pills_final = new Pills_Final(new Pills_Final_728_MC());
			take_control_scroller = new Take_Control_Scroller(new Take_Control_728_MC());
		}

		private function crete_display_objects() : void
		{
			bg = new Background_728_MC();
			addChild(bg);

			pull_mc = new Pull_728_MC();
			pull_mc.text.alpha = 0;
			pull_mc.x = 125;
			pull_mc.y = 60;

			move_forward_txt = new Move_Forward_728_MC();
			move_forward_txt.y = 35.05;
			move_forward_txt.x = 481;
			move_forward_txt.alpha = 0;

			pulling_arrow.mc.x = -230;
			pulling_arrow.mc.y = 72;

			email.mc.x = stage_right + 200;
			email.mc.alpha = 0;
			advice.mc.x = stage_right + 200;
			heart.mc.x = stage_right + 200;
			move_forward.mc.x = stage_right + 200;
			move_forward.mc.alpha = 0;
			move_forward.mc.y = 70;

			take_control_scroller.mc.x = 645;
			take_control_scroller.mc.y = 17.95;
			take_control_scroller.mc.alpha = 0;

			addChild(pull_mc);
			addChild(move_forward_txt);
			addChild(intro_pills.mc);
			addChild(email.mc);
			addChild(advice.mc);
			addChild(heart.mc);
			addChild(move_forward.mc);
			addChild(take_control_scroller.mc);
			addChild(pulling_arrow.mc);
			addChild(pills_final.mc);
		}

		private function init_display_objects() : void
		{
			intro_pills.mc.chemo_txt_mc.alpha = 0;
			intro_pills.mc.pills_mc.alpha = 0;
		}

		private function create_timeline() : void
		{
			all_timeline = new TimelineLite();
			all_timeline.stop();
			all_timeline.appendMultiple([TweenLite.to(pull_mc, .5, {alpha:0}), TweenLite.to(advice.mc, 1, {x:stage_right}), TweenLite.to(email.mc, 1, {onComplete:do_pause, alpha:1, x:0}), TweenLite.to(intro_pills.mc, 1, {x:stage_left}), TweenLite.to(move_forward_txt, 1, {x:stage_left})]);
			all_timeline.appendMultiple([TweenLite.to(advice.mc, 1, {x:0}), TweenLite.to(heart.mc, 1, {x:stage_right}), TweenLite.to(email.mc, 1, {onComplete:do_pause, x:stage_left})]);
			all_timeline.appendMultiple([TweenLite.to(heart.mc, 1, {x:0}), TweenLite.to(move_forward.mc, 1, {x:700}), TweenLite.to(advice.mc, 1, {onComplete:do_pause, x:stage_left})]);
			all_timeline.appendMultiple([TweenLite.to(move_forward.mc, 1, {x:135}), TweenLite.to(heart.mc, 1, {x:stage_left})]);
			all_timeline.append(TweenLite.to(move_forward.yellow_dot, .25, {alpha:0}));
			all_timeline.append(TweenLite.to(move_forward.mc.mc1, .6, {alpha:1, scaleX:1, scaleY:1, ease:Back.easeOut}), .4);
			all_timeline.append(TweenLite.to(move_forward.mc.mc2, .6, {alpha:1, scaleX:1, scaleY:1, ease:Back.easeOut}), -.55);
			all_timeline.append(TweenLite.to(move_forward.mc.mc3, .6, {alpha:1, scaleX:1, scaleY:1, ease:Back.easeOut}), -.55);
			all_timeline.append(TweenLite.to(move_forward.mc.mc4, .6, {alpha:1, scaleX:1, scaleY:1, ease:Back.easeOut}), -.55);
			all_timeline.append(TweenLite.to(move_forward.mc.mc5, .6, {alpha:1, scaleX:1, scaleY:1, ease:Back.easeOut}), -.55);
			all_timeline.append(TweenLite.to(move_forward.mc.mc6, .6, {alpha:1, scaleX:1, scaleY:1, ease:Back.easeOut}), -.55);
			all_timeline.append(TweenLite.to(move_forward.mc.mc7, .6, {alpha:1, scaleX:1, scaleY:1, ease:Back.easeOut}), -.55);
			all_timeline.append(TweenLite.to(move_forward.mc.mc8, .6, {alpha:1, scaleX:1, scaleY:1, ease:Back.easeOut}), -.55);
			all_timeline.append(TweenLite.to(move_forward.mc.mc9, .6, {alpha:1, scaleX:1, scaleY:1, ease:Back.easeOut}), -.55);
			all_timeline.append(TweenLite.to(move_forward.mc.mc10, .6, {alpha:1, scaleX:1, scaleY:1, ease:Back.easeOut}), -.55);
			all_timeline.append(TweenLite.to(move_forward.mc.mc11, .6, {alpha:1, scaleX:1, scaleY:1, ease:Back.easeOut}), -.55);
			all_timeline.appendMultiple([TweenLite.to(pulling_arrow.mc, .7, {y:21}), TweenLite.to(move_forward.mc, .7, {y:21})]);
			all_timeline.append(TweenLite.to(pills_final.mc.top_copy_mc, .5, {alpha:1}));
			all_timeline.append(TweenLite.to(pills_final.mc.art_mc, .5, {alpha:1}), -.4);
			all_timeline.append(TweenLite.to(pills_final.mc.bottom_copy_mc, .5, {alpha:1}), -.4);
			all_timeline.append(TweenLite.to(pills_final.mc.emails_mc, .5, {alpha:1}), -.5);
			all_timeline.append(TweenLite.to(pills_final.mc.arrrow_mc, .5, {alpha:1}), -.4);
			all_timeline.append(TweenLite.delayedCall(-.75, show_take_control));
		}

		private function show_take_control() : void
		{
			TweenLite.to(take_control_scroller.mc, .5, {alpha:1});
			take_control_scroller.set_handle_pos(1);
		}

		private function begin() : void
		{
			var intro_timeline : TimelineLite = new TimelineLite({onComplete:function():void
			{
				do_pause();
			}});
			intro_timeline.append(TweenLite.to(intro_pills.mc.chemo_txt_mc, .5, {alpha:1}));
			intro_timeline.append(TweenLite.to(intro_pills.mc.pills_mc, .5, {alpha:1}), -.35);
			intro_timeline.appendMultiple([TweenLite.to(pulling_arrow.mc, .75, {x:-100, ease:Back.easeOut}), TweenLite.to(move_forward_txt, .75, {alpha:1, ease:Back.easeOut})]);
			intro_timeline.append(TweenLite.to(pull_mc.arrow_left, .25, {x:0.7, y:14.8}));
			intro_timeline.append(TweenLite.to(pull_mc.arrow_right, .25, {x:7.9, y:7.9}), -.1);
			intro_timeline.append(TweenLite.to(pull_mc.arrow_base, .25, {x:9, y:12.4}), -.1);
			intro_timeline.appendMultiple([TweenLite.to(pull_mc.text, .25, {alpha:1})]);
		}

		private function do_pause() : void
		{
			all_timeline.pause();
			pause_timer.start();
			move_forward.mc.alpha = 1;
		}

		private function resume_timeline(event : TimerEvent) : void
		{
			all_timeline.play();
		}

		private function set_take_control_handle(currentProgress : Number) : void
		{
			take_control_scroller.set_handle_pos(currentProgress);
		}
	}
}
