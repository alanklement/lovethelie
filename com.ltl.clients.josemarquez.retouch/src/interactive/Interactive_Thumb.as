package interactive 
{
	import interfaces.Double_Linked_List_Node;

	import vos.Image_VO;

	import com.greensock.TweenMax;

	import org.osflash.signals.Signal;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Interactive_Thumb extends Sprite implements Double_Linked_List_Node
	{
		public var notify_selected : Signal = new Signal(Interactive_Thumb);
		public var vo : Image_VO;
		public var thumb : Sprite = new Sprite();
		private var drop_shadow : Object = {color:0x000000, alpha:.75, blurX:6, blurY:6, distance:5}; 
		//		private var drop_shadow_off : Object = {color:0x000000, alpha:0, blurX:6, blurY:6, distance:5}; 
		private var _next_link : Double_Linked_List_Node;
		private var _previous_link : Double_Linked_List_Node;

		public function Interactive_Thumb(vo : Image_VO) 
		{
			this.vo = vo;
			
			addChild(vo.thumb_img);			
			set_properties();
			add_listeners();
		}

		private function set_properties() : void 
		{
			this.buttonMode = true;
			this.alpha = 0;
		}

		private function add_listeners() : void 
		{
			this.addEventListener(Event.REMOVED_FROM_STAGE, disable);
			this.addEventListener(Event.ADDED_TO_STAGE, show_drop_shadow);
			this.addEventListener(MouseEvent.ROLL_OVER, fade_in);
			this.addEventListener(MouseEvent.ROLL_OUT, fade_out);
			this.addEventListener(MouseEvent.CLICK, notify_of_click);
		}

		private function show_drop_shadow(event : Event) : void 
		{
			
			new TweenMax(this, .25, {dropShadowFilter:drop_shadow});
		}

		private function notify_of_click(event : MouseEvent) : void 
		{
			notify_selected.dispatch(this);
		}

		private function fade_in(event : MouseEvent) : void 
		{
			new TweenMax(this, .5, {alpha:1}); 
		}

		private function fade_out(event : MouseEvent) : void 
		{
			new TweenMax(this, .5, {alpha:.4}); 
		}

		public function get next_link() : Double_Linked_List_Node
		{
			return _next_link;
		}

		public function get previous_link() : Double_Linked_List_Node
		{
			return _previous_link;
		}

		public function get payload() : *
		{
			return this;
		}

		public function set next_link(node : Double_Linked_List_Node) : void
		{
			this._next_link = node;
		}

		public function set previous_link(node : Double_Linked_List_Node) : void
		{
			this._previous_link = node;
		}

		public function set_as_selected() : void 
		{
			disable_events();
			new TweenMax(this, .5, {alpha:1}); 
		}

		public function set_as_unselected() : void 
		{
			add_listeners();
			new TweenMax(this, .5, {alpha:.4}); 
		}

		private function disable(event : Event) : void 
		{
			//disable_events();
		}

		private function disable_events() : void 
		{
			this.removeEventListener(MouseEvent.ROLL_OVER, fade_in);
			this.removeEventListener(MouseEvent.ROLL_OUT, fade_out);
			this.removeEventListener(MouseEvent.CLICK, notify_of_click);
		}
	}
}
