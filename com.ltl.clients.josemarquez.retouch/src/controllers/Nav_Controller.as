package controllers 
{
	import com.greensock.TweenLite;

	import interactive.Glowing_Btn;
	import interactive.Interactive_Thumb;

	import vos.Image_VO;

	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;

	import org.osflash.signals.Signal;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author Alan
	 */
	public class Nav_Controller 
	{
		public var vo_clicked : Signal = new Signal(Image_VO);
		public var info_clicked : Signal = new Signal(String);
		public var notfy_clear_complete : Signal = new Signal();
		public var thumb_holder : Sprite = new Sprite();
		private static const THUMB_SPACE : Number = 45;
		private var nav_mc : MovieClip;
		private var jump_right : Glowing_Btn;
		private var jump_left : Glowing_Btn;
		private var step_right : Glowing_Btn;
		private var step_left : Glowing_Btn;
		private var info_btn : Glowing_Btn;
		private var current_thumb : Interactive_Thumb;
		private var current_page : Array = [];
		private var page_index : int = 0;
		private var current_thumb_pages : Array;

		public function Nav_Controller(nav_mc : MovieClip) 
		{
			this.nav_mc = nav_mc;
			build_references();
			set_properties();
			add_listeners();
		}

		private function build_references() : void 
		{
			jump_right = new Glowing_Btn(MovieClip(nav_mc.getChildByName("jump_right_mc")));
			jump_left = new Glowing_Btn(MovieClip(nav_mc.getChildByName("jump_left_mc")));
			step_right = new Glowing_Btn(MovieClip(nav_mc.getChildByName("step_right_mc")));
			step_left = new Glowing_Btn(MovieClip(nav_mc.getChildByName("step_left_mc")));
			info_btn = new Glowing_Btn(MovieClip(nav_mc.getChildByName("info_mc")));
		}

		private function set_properties() : void 
		{
			thumb_holder.y = 8;
			thumb_holder.x = 9;
			nav_mc.addChild(thumb_holder);
		}

		private function add_listeners() : void 
		{
			info_btn.notify_clicked.add(dispatch_info);
			step_right.notify_clicked.add(load_next_image);	
			step_left.notify_clicked.add(load_previous_image);
			jump_right.notify_clicked.add(next_page);
			jump_left.notify_clicked.add(previous_page);
		}

		public function clear_thumbs_from_view() : void 
		{	
			thumb_holder.mouseChildren = false;
			thumb_holder.mouseEnabled = false;
			
			var timeline : TimelineMax = new TimelineMax({onComplete:clean_stage});
			for (var i : int = 0;i < current_page.length;i++) 
			{
				var thumb : Interactive_Thumb = Interactive_Thumb(current_page[i]);
				timeline.append(new TweenMax(thumb, .5, {alpha:0}), -.45);	
			}
		}	

		private function clean_stage() : void 
		{
			while(thumb_holder.numChildren > 0)
			{
				thumb_holder.removeChildAt(thumb_holder.numChildren - 1);	
			}
			
			notfy_clear_complete.dispatch();			
		}

		public function clear_thumbs_from_view3() : void 
		{	
			thumb_holder.mouseChildren = false;
			thumb_holder.mouseEnabled = false;
			
			var timeline : TimelineMax = new TimelineMax({onComplete:clean_stage3});
			for (var i : int = 0;i < current_page.length;i++) 
			{
				var thumb : Interactive_Thumb = Interactive_Thumb(current_page[i]);
				timeline.append(new TweenMax(thumb, .5, {alpha:0}), -.45);	
			}
		}	

		private function clean_stage3() : void 
		{
			while(thumb_holder.numChildren > 0)
			{
				thumb_holder.removeChildAt(thumb_holder.numChildren - 1);	
			}
		}

		public function update_thumbs(pages : Array) : void 
		{
			thumb_holder.mouseChildren = false;
			thumb_holder.mouseEnabled = false;
			
			this.current_thumb_pages = pages;
			page_index = 0;
			check_for_pages();
			
			this.current_page = current_thumb_pages[page_index];
			current_thumb = current_page[0];
			vo_clicked.dispatch(current_thumb.vo);
			current_thumb.set_as_selected();
			add_page_to_stage();
			check_if_currnet_img_has_info();
		}

		private function check_if_currnet_img_has_info() : void 
		{
			if(current_thumb.vo.no_info)
			{
				new TweenLite(info_btn.mc, .5, {alpha:.25});
				info_btn.mc.mouseChildren = false;
				info_btn.mc.mouseEnabled = false;
			}
			else
			{
				new TweenLite(info_btn.mc, .5, {alpha:1});
				info_btn.mc.mouseChildren = true;
				info_btn.mc.mouseEnabled = true;
			}
		}

		
		private function add_page_to_stage() : void 
		{			
			var timeline : TimelineMax = new TimelineMax({onComplete:function():void
			{
				thumb_holder.mouseChildren = true;
				thumb_holder.mouseEnabled = true;
			}});
						
			for (var i : int = 0;i < current_page.length;i++) 
			{
				var thumb : Interactive_Thumb = Interactive_Thumb(current_page[i]);
				thumb.x = THUMB_SPACE * i;
				thumb_holder.addChild(thumb);
				thumb.notify_selected.add(notify_of_selection);
			
				if(thumb == current_thumb)
				{
					timeline.append(new TweenMax(thumb, .7, {alpha:1, ease:Expo.easeInOut}), -.65);					
				}
				else
				{				
					timeline.append(new TweenMax(thumb, .7, {alpha:.4, ease:Expo.easeInOut}), -.65);
				}
			}
		}

		private function load_previous_image(event : MouseEvent) : void 
		{
			if(current_thumb != current_page[0])
			{
				current_thumb = current_thumb.previous_link.payload;
				notify_of_selection(current_thumb);			
			}
		}

		private function load_next_image(event : MouseEvent) : void 
		{			
			if(current_thumb != current_page[current_page.length - 1])
			{
				current_thumb = current_thumb.next_link.payload;
				notify_of_selection(current_thumb);
			}
		}

		private function next_page(event : MouseEvent) : void 
		{
			thumb_holder.mouseChildren = false;
			thumb_holder.mouseEnabled = false;
			
			if(current_thumb_pages[page_index + 1])
			{
				page_index++;
				var timeline : TimelineMax = new TimelineMax({onComplete:clean_stage_2});
				for (var i : int = 0;i < current_page.length;i++) 
				{
					var thumb : Interactive_Thumb = Interactive_Thumb(current_page[i]);
					timeline.append(new TweenMax(thumb, .5, {alpha:0}), -.45);	
				}
	
				check_for_pages();			
			}
		}

		private function check_for_pages() : void 
		{
			if(current_thumb_pages[page_index - 1] == undefined)
			{
				jump_left.hide();
			}
			else
			{
				jump_left.show();
			}

			if(current_thumb_pages[page_index + 1] == undefined)
			{
				jump_right.hide();
			}
			else
			{
				jump_right.show();
			}
		}

		private function previous_page(event : MouseEvent) : void 
		{
			thumb_holder.mouseChildren = false;
			thumb_holder.mouseEnabled = false;
			
			if(current_thumb_pages[page_index - 1])
			{
				page_index--;
				var timeline : TimelineMax = new TimelineMax({onComplete:clean_stage_2});
				for (var i : int = 0;i < current_page.length;i++) 
				{
					var thumb : Interactive_Thumb = Interactive_Thumb(current_page[i]);
					timeline.append(new TweenMax(thumb, .5, {alpha:0}), -.45);	
				}
				
				check_for_pages();
			}
		}

		private function clean_stage_2() : void 
		{
			
			while(thumb_holder.numChildren > 0)
			{
				thumb_holder.removeChildAt(thumb_holder.numChildren - 1);	
			}

			this.current_page = current_thumb_pages[page_index];
			add_page_to_stage();	
		}

		private function notify_of_selection(thumb : Interactive_Thumb) : void 
		{
			current_thumb = thumb;
			current_thumb.set_as_selected();
			check_if_currnet_img_has_info();
			vo_clicked.dispatch(current_thumb.vo);
			
			turn_off_other_thumbs();
		}

		private function turn_off_other_thumbs() : void 
		{
			for each (var thumb : Interactive_Thumb in current_page) 
			{
				if(thumb != current_thumb)
				{
					thumb.set_as_unselected();					
				}
			}
		}

		private function dispatch_info(event : MouseEvent) : void 
		{
			info_clicked.dispatch(current_thumb.vo.info_img);
		}

		public function turn_btn_off() : void 
		{
			//info_btn.reset();
		}
	}
}
