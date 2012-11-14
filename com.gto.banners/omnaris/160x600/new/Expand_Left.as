package
{
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;

	import com.doubleclick.studio.events.StudioEvent;
	import com.doubleclick.studio.expanding.ExpandingComponent;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.doubleclick.studio.proxy.Enabler;

	import flash.display.MovieClip;
	import flash.events.Event;

	public class Expand_Left extends MovieClip
	{
		private var intro_timeline : TimelineLite;
		public var mc_log : MovieClip;
		public var mc_photo1 : MovieClip;
		public var mc_photo2 : MovieClip;
		public var mtd_copy_mc : MovieClip;
		public var click_to_see_vis_mc : MovieClip;
		public var video_title_mc : MovieClip;
		public var mask_mc : MovieClip;
		public var movie_holder_mc : MovieClip;
		public var logo_mc : MovieClip;
		public var closeBtn : SimpleButton;
		public var bg : MovieClip;
		public var mc_sis : Object;
		private var click_to_see_vis_mc_start_y : Number;
		private var movie_holder_mc_start_y : Number;
		private var bg_start_x : Number;

		public function Expand_Left()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, animate_in);
			movie_holder_mc.video_player.stop();
			closeBtn.addEventListener(MouseEvent.CLICK, close_banner);
			Enabler.addEventListener(StudioEvent.ON_EXIT, onExitHandler);
			
			click_to_see_vis_mc_start_y = click_to_see_vis_mc.y;
			movie_holder_mc_start_y = movie_holder_mc.y;
			bg_start_x = bg.x;
			create_timelines();
		}

		private function onExitHandler(event : StudioEvent) : void
		{
			intro_timeline.reverse();
			movie_holder_mc.video_player.stop();
			TweenLite.to(mask_mc, intro_timeline.totalDuration, {width:160});
			TweenLite.to(mc_sis, intro_timeline.totalDuration, {y:600});

			ExpandingComponent.collapse();
		}

		private function close_banner(event : MouseEvent) : void
		{
			intro_timeline.reverse();
			movie_holder_mc.video_player.stop();
			TweenLite.to(mask_mc, intro_timeline.totalDuration, {width:160});
			TweenLite.to(bg, intro_timeline.totalDuration, {x:160});
			TweenLite.to(mc_sis, intro_timeline.totalDuration, {y:600});
			TweenLite.to(logo_mc, intro_timeline.totalDuration, {x:178.95});

			ExpandingComponent.collapse();
		}

		private function create_timelines():void
		{
			intro_timeline = new TimelineLite({onComplete:start_movie, onReverseComplete:reverse_complete});
			intro_timeline.append(TweenLite.to(mc_log, .75, {y:517.65}), -.7);
			intro_timeline.append(TweenLite.to(mtd_copy_mc, .5, {alpha:0}), -.5);
			intro_timeline.append(TweenLite.to(click_to_see_vis_mc, .5, {y:click_to_see_vis_mc_start_y + 100}), -.4);
			intro_timeline.append(TweenLite.from(video_title_mc, .5, {alpha:0}), -.4);
			intro_timeline.append(TweenLite.to(mc_photo1, .75, {x:104.25, y:390, scaleX:.5, scaleY:.5}), -.7);
			intro_timeline.append(TweenLite.to(mc_photo2, .75, {x:20, y:385, scaleX:.5, scaleY:.5}), -.7);
			intro_timeline.append(TweenLite.from(movie_holder_mc, .5, {y:movie_holder_mc_start_y + 300}), -.4);
		}

		private function reverse_complete() : void
		{
			ExpandingComponent.endAnimatedCollapse();
		}

		public function animate_in(event : Event = null) : void
		{
			TweenLite.to(mask_mc, intro_timeline.totalDuration, {width:320});
			TweenLite.to(bg, intro_timeline.totalDuration, {x:0});
			TweenLite.to(logo_mc, intro_timeline.totalDuration, {x:24.95});
			TweenLite.to(mc_sis, .5, {y:500});

			intro_timeline.play();
		}

		private function start_movie() : void
		{
			movie_holder_mc.video_player.play();
		}
	}
}