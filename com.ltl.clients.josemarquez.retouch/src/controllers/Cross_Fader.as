package controllers 
{
	import effects.Glowing;
	import interactive.Scroll_Bar;

	import com.greensock.TweenMax;

	import org.osflash.signals.Signal;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * @author Alan
	 */
	public class Cross_Fader 
	{
		public static const SHOW_BEFORE : String = 'SHOW_BEFORE';
		public static const SHOW_AFTER : String = "SHOW_AFTER";
		public var switch_state : Signal = new Signal(String);
		private var mc : MovieClip;
		private var slider : MovieClip;
		private var track : MovieClip;
		private var after_btn : MovieClip;
		private var before_btn : MovieClip;
		private var scroller : Scroll_Bar;
		private var current_state : String;

		public function Cross_Fader(mc : MovieClip) 
		{
			this.mc = mc;
			create_references();
			create_scroller();
			set_properties();
			add_listeners();
		}

		private function set_properties() : void 
		{
			mc.buttonMode = true;
			current_state = SHOW_BEFORE;
		}

		private function create_references() : void 
		{
			slider = MovieClip(mc.getChildByName('slider_mc'));
			track = MovieClip(mc.getChildByName('track_mc'));
			after_btn = MovieClip(mc.getChildByName('after_mc'));
			before_btn = MovieClip(mc.getChildByName('before_mc'));
		}

		private function create_scroller() : void 
		{
			scroller = new Scroll_Bar(slider, track);
		}

		private function add_listeners() : void 
		{
			mc.addEventListener(MouseEvent.CLICK, change);
		}

		private function change(event : MouseEvent) : void 
		{
			if(current_state == SHOW_BEFORE )
			{
				jump_to_before();
				current_state = SHOW_AFTER;
			}
			else
			{
				jump_to_after();
				current_state = SHOW_BEFORE;
			}
		}

		private function jump_to_after() : void 
		{
			new TweenMax(after_btn, .5, {glowFilter:Glowing.GLOW_4});
			new TweenMax(before_btn, .5, {glowFilter:Glowing.GLOW_3});
			scroller.jump_to_min();
			switch_state.dispatch(SHOW_AFTER);
		}

		private function jump_to_before() : void 
		{		
			new TweenMax(after_btn, .5, {glowFilter:Glowing.GLOW_3});
			new TweenMax(before_btn, .5, {glowFilter:Glowing.GLOW_4});
			scroller.jump_to_max();
			switch_state.dispatch(SHOW_BEFORE);
		}

		public function reset() : void 
		{
			scroller.reset();
			new TweenMax(after_btn, .5, {glowFilter:Glowing.GLOW_4});
			new TweenMax(before_btn, .5, {glowFilter:Glowing.GLOW_3});
		}
	}
}
