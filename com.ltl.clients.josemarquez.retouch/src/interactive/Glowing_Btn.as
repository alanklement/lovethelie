package interactive 
{
	import effects.Glowing;

	import com.greensock.TweenMax;

	import org.osflash.signals.natives.NativeSignal;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * @author Alan
	 */
	public class Glowing_Btn
	{
		public var notify_clicked : NativeSignal;
		public var mc : MovieClip;

		public function Glowing_Btn(mc : MovieClip) 
		{
			this.mc = mc;	
			set_properties();
			add_listeners();
		}

		private function set_properties() : void 
		{
			mc.buttonMode = true;
			notify_clicked = new NativeSignal(mc, MouseEvent.CLICK, MouseEvent);
		}

		private function add_listeners() : void 
		{
			mc.addEventListener(MouseEvent.ROLL_OVER, do_glow);
			mc.addEventListener(MouseEvent.ROLL_OUT, remove_glow);
			mc.mouseEnabled = true;	
			mc.mouseChildren = true;	
		}

		public function remove_glow(event : MouseEvent = null) : void 
		{
			new TweenMax(mc, .25, {glowFilter:Glowing.GLOW_1});
		}

		public function do_glow(event : MouseEvent = null) : void 
		{
			new TweenMax(mc, .25, {glowFilter:Glowing.GLOW_2});
		}

		public function set_to_unselected() : void 
		{
			new TweenMax(mc, .25, {glowFilter:Glowing.GLOW_1});
			add_listeners();
		}

		public function set_to_selected() : void 
		{
			mc.removeEventListener(MouseEvent.ROLL_OVER, do_glow);
			mc.removeEventListener(MouseEvent.ROLL_OUT, remove_glow);
			new TweenMax(mc, .25, {glowFilter:Glowing.GLOW_2});
		
			mc.mouseEnabled = false;	
			mc.mouseChildren = false;		
		}

		public function hide() : void 
		{
			new TweenMax(mc, .25, {autoAlpha:0});
		}

		public function show() : void 
		{
			new TweenMax(mc, .25, {autoAlpha:1});
		}
	}
}
