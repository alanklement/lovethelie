package interactive 
{
	import flash.geom.Rectangle;

	import com.greensock.TweenMax;

	import org.osflash.signals.Signal;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Scroll_Bar 
	{
		public var value_udpated : Signal = new Signal(Number);
		private var gutter : MovieClip;
		private var xMin : int;
		private var xMax : int;
		private var handle : MovieClip;

		public function Scroll_Bar(handle : MovieClip,gutter : MovieClip) 
		{
			this.handle = handle;
			this.gutter = gutter;
			
			set_properties();
			add_listeners();
		}

		private function set_properties() : void 
		{
			handle.buttonMode = true;
			handle.x = 0;
			xMin = 0;
			xMax = gutter.width;
		}

		private function add_listeners() : void 
		{
			handle.addEventListener(MouseEvent.MOUSE_DOWN, start_drag);				
		}

		public function reset() : void 
		{
			new TweenMax(handle, .25, {x:xMin});
		}

		private function start_drag(event : MouseEvent) : void 
		{
			handle.stage.addEventListener(MouseEvent.MOUSE_UP, stop_drag);
			handle.stage.addEventListener(MouseEvent.MOUSE_MOVE, get_move_ratio);
			handle.stage.addEventListener(Event.MOUSE_LEAVE, stop_drag);
			handle.startDrag(false, new Rectangle(0, -20, xMax, 0));
		}

		private function get_move_ratio(event : MouseEvent) : void 
		{
			var ratio : Number = handle.x / xMax;  	
			value_udpated.dispatch(ratio);
		}

		private function stop_drag(event : Event) : void 
		{
			handle.stage.removeEventListener(MouseEvent.MOUSE_UP, stop_drag);
			handle.stage.removeEventListener(MouseEvent.MOUSE_MOVE, get_move_ratio);
			handle.stage.removeEventListener(Event.MOUSE_LEAVE, stop_drag);
			handle.addEventListener(MouseEvent.MOUSE_DOWN, start_drag);				
			
			handle.stopDrag();	
		}

		public function jump_to_max() : void 
		{
			new TweenMax(handle, .5, {x:xMax, onUpdate:update_value});
		}

		private function update_value() : void 
		{
			var ratio : Number = handle.x / xMax;  	
			value_udpated.dispatch(ratio);
		}

		public function jump_to_min() : void 
		{
			new TweenMax(handle, .5, {x:0, onUpdate:update_value});
		}
	}
}
