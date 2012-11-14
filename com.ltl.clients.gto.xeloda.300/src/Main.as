package 
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.Timer;

	/**
	 * @author Freelancer
	 */
	public class Main extends Sprite
	{
		public static const HOT_SPOT_HIT : String = "HOT_SPOT_HIT";
		private static const HOT_SPOT_DELAY : Number = 1800;
		private var intro_pills : Intro_Pills;
		private var email : Email;
		private var advice : Advice;
		private var heart : Heart;
		private var pills_final : Pills_Final;
		private var stage_left : Number = -200;
		private var middle_x : Number = stage.stageWidth * .5;
		private var stage_right : Number = stage.stageWidth + 150;
		private var next_step : Function;
		private var middle_y : Number = stage.stageHeight * .5 - 20;
		private var move_forward_txt : Move_Forward_MC;
		private var pull_mc : Pull_MC;
		private var bg : Background_MC;
		private var all_timeline : TimelineLite;
		private var move_forward : Move_Forward;
		private var take_control_scroller : Take_Control_Scroller;
		private var pulling_arrow : Pulling_Arrow;
		private var next_frame : Number;
		private var pause_timer : Timer;
		private var clickTag1 : String;

		[SWF(width="300", height="250", backgroundColor="#FFFFFF")]
		public function Main()
		{
			get_flash_vars();
			create_hot_spots();

			create_display_objects();
			add_display_objects();
			add_event_listeners();
			create_all_timeline();

			next_frame = 0;

			pause_timer = new Timer(HOT_SPOT_DELAY, 1);
			pause_timer.addEventListener(TimerEvent.TIMER, resume_timeline);
			begin();
		}

		private function get_flash_vars() : void
		{
			clickTag1 = String(root.loaderInfo.parameters.clickTag);
		}

		private function create_hot_spots() : void
		{
			intro_pills = new Intro_Pills(new Pills_Intro_MC(), new Pulse(Ring_MC));
			email = new Email(new Email_MC(), new Pulse(Ring_MC), new Green_Dot_MC());
			advice = new Advice(new Advice_MC(), new Pulse(Ring_MC), new Green_Dot_MC());
			heart = new Heart(new Heart_MC(), new Pulse(Ring_MC), new Green_Dot_MC());
			move_forward = new Move_Forward(new Move_Forward_Blue_MC(), new Pulse(Ring_MC), new Yellow_Dot_MC());
			pills_final = new Pills_Final(new Pills_Final_MC());
			take_control_scroller = new Take_Control_Scroller(new Take_Control_MC());
			pulling_arrow = new Pulling_Arrow(new Yellow_Arrow());
		}

		private function create_display_objects() : void
		{
			bg = new Background_MC();

			pulling_arrow.mc.y = 208;
			pulling_arrow.mc.x = -250;

			move_forward_txt = new Move_Forward_MC();
			move_forward_txt.y = 170;
			move_forward_txt.x = -140;

			pull_mc = new Pull_MC();
			pull_mc.text.alpha = 0;
			pull_mc.x = 160;
			pull_mc.y = 204;

			intro_pills.mc.x = middle_x;
			intro_pills.mc.y = middle_y;

			email.mc.x = stage_right;
			email.mc.y = middle_y;
			advice.mc.x = stage_right;
			advice.mc.y = middle_y;
			heart.mc.x = stage_right;
			heart.mc.y = middle_y;

			pills_final.mc.x = middle_x;
			pills_final.mc.y = middle_y;
			// pills_final.mc.alpha = 0;

			move_forward.mc.x = stage_right;
			move_forward.mc.y = 208;

			take_control_scroller.mc.x = 189.05;
			take_control_scroller.mc.y = 17.95;
			take_control_scroller.mc.alpha = 0;
		}

		private function add_display_objects() : void
		{
			addChild(bg);
			addChild(move_forward_txt);
			addChild(pull_mc);
			addChild(move_forward.mc);
			addChild(intro_pills.mc);
			addChild(email.mc);
			addChild(advice.mc);
			addChild(heart.mc);
			addChild(pills_final.mc);
			addChild(pulling_arrow.mc);
			addChild(take_control_scroller.mc);
		}

		private function add_event_listeners() : void
		{
			pills_final.mc.addEventListener(MouseEvent.CLICK, check_click_tag);

			pulling_arrow.addEventListener(Pulling_Arrow.ARROW_TRIGGERED, next_stage);
			pulling_arrow.mc.addEventListener(MouseEvent.MOUSE_DOWN, stop_timer);
			take_control_scroller.mc.addEventListener(MouseEvent.MOUSE_DOWN, stop_timeline_play);

			email.addEventListener(Main.HOT_SPOT_HIT, update_next_frame);
			advice.addEventListener(Main.HOT_SPOT_HIT, update_next_frame);
			heart.addEventListener(Main.HOT_SPOT_HIT, update_next_frame);

			stage.addEventListener(Event.ENTER_FRAME, update_progress);
			stage.addEventListener(Event.MOUSE_LEAVE, reset_arrow);
		}

		private function reset_arrow(event : Event) : void
		{
			// trace(this + " @ " + 'reset_arrow' + ' event: ' + (event));
		}

		private function stop_timer(event : MouseEvent) : void
		{
			pause_timer.stop();
		}

		private function check_click_tag(event : MouseEvent) : void
		{
			var url : URLRequest = new URLRequest(clickTag1);
			navigateToURL(url, "_blank");
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

		private function resume_timeline_play(event : MouseEvent) : void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, update_timeline_progress);
			stage.removeEventListener(MouseEvent.MOUSE_UP, resume_timeline_play);

			take_control_scroller.mc.addEventListener(MouseEvent.MOUSE_DOWN, stop_timeline_play);
			stage.addEventListener(Event.ENTER_FRAME, update_progress);
			all_timeline.play();
		}

		private function update_progress(event : Event) : void
		{
			set_take_control_handle(all_timeline.currentProgress);
		}

		private function begin() : void
		{
			var intro_timeline : TimelineLite = new TimelineLite({onComplete:function():void
			{
				do_pause();
			}});
			intro_timeline.append(TweenLite.to(intro_pills.mc.chemo_txt_mc, .5, {alpha:1}));
			intro_timeline.append(TweenLite.to(intro_pills.mc.pills_mc, .5, {alpha:1}), -.35);
			intro_timeline.appendMultiple([TweenLite.to(pulling_arrow.mc, .75, {x:-69, ease:Back.easeOut}), TweenLite.to(move_forward_txt, .75, {x:90, ease:Back.easeOut})]);
			intro_timeline.append(TweenLite.to(pull_mc.arrow_left, .25, {x:0.7, y:14.8}));
			intro_timeline.append(TweenLite.to(pull_mc.arrow_right, .25, {x:7.9, y:7.9}), -.1);
			intro_timeline.append(TweenLite.to(pull_mc.arrow_base, .25, {x:9, y:12.4}), -.1);
			intro_timeline.appendMultiple([TweenLite.to(pull_mc.text, .25, {alpha:1})]);
		}

		private function do_pause() : void
		{
			all_timeline.pause();
			pause_timer.start();
		}

		private function resume_timeline(event : TimerEvent) : void
		{
			all_timeline.play();
			pause_timer.stop();
		}

		private function create_all_timeline() : void
		{
			all_timeline = new TimelineLite();
			all_timeline.stop();
			all_timeline.appendMultiple([TweenLite.to(pull_mc, .5, {alpha:0}), TweenLite.to(email.mc, 1, {onComplete:do_pause, x:middle_x}), TweenLite.to(intro_pills.mc, 1, {x:stage_left}), TweenLite.to(move_forward_txt, 1, {x:stage_left})]);
			all_timeline.appendMultiple([TweenLite.to(advice.mc, 1, {x:middle_x}), TweenLite.to(email.mc, 1, {onComplete:do_pause, x:stage_left})]);
			all_timeline.appendMultiple([TweenLite.to(heart.mc, 1, {x:middle_x}), TweenLite.to(advice.mc, 1, {onComplete:do_pause, x:stage_left})]);
			all_timeline.appendMultiple([TweenLite.to(pulling_arrow.mc, .75, {x:-180, ease:Back.easeOut}), TweenLite.to(move_forward.mc, 1, {x:49}), TweenLite.to(heart.mc, 1, {x:stage_left})]);
			all_timeline.append(TweenLite.to(move_forward.yellow_dot, .25, {alpha:0}));
			all_timeline.append(TweenLite.to(move_forward.mc.mc1, .6, {alpha:1, scaleX:1, scaleY:1, ease:Back.easeOut}));
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
			all_timeline.appendMultiple([TweenLite.to(pulling_arrow.mc, .7, {y:65}), TweenLite.to(move_forward.mc, .7, {y:65})]);
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
			TweenLite.to(take_control_scroller.mc.handle, .5, {x:100});
		}

		private function set_take_control_handle(currentProgress : Number) : void
		{
			take_control_scroller.set_handle_pos(currentProgress * 100);
		}
	}
}

