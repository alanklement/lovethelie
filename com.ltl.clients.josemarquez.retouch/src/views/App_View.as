package  
views
{
	import interactive.Glowing_Btn;

	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;

	import org.osflash.signals.Signal;
	import org.osflash.signals.natives.NativeSignal;

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * @author Alan
	 */
	public class App_View 
	{
		public var notify_intro_finished : Signal = new Signal();
		public var notify_view_ready : Signal = new Signal();
		public var notify_stage_click : NativeSignal;
		public var view_mc : MovieClip;
		public var before_after_slide : MovieClip;
		public var image_nav : MovieClip;
		public var img_holder : Sprite;
		public var pre_loader : MovieClip;
		public var fashion_nav : MovieClip;
		public var objects_nav : MovieClip;
		public var contact_nav : MovieClip;
		public var lines : MovieClip;
		public var logo : MovieClip;
		public var intro : MovieClip;
		public var info_holder : MovieClip;
		public var contact_section : MovieClip;
		private var _info : Loader;
		private var contact_holder : MovieClip;
		private var contact_hidden : Boolean = false;
		private var email_btn : Glowing_Btn;
		private var extra_copy : MovieClip;

		public function App_View(view_mc : MovieClip) 
		{
			this.view_mc = view_mc;
			img_holder = MovieClip(view_mc.getChildByName("img_holder_mc"));
			image_nav = MovieClip(view_mc.getChildByName("image_nav_mc"));
			before_after_slide = MovieClip(view_mc.getChildByName("before_after_mc"));
			pre_loader = MovieClip(view_mc.getChildByName('preloader_mc')); 
			fashion_nav = MovieClip(view_mc.getChildByName('fashion_nav_mc'));
			objects_nav = MovieClip(view_mc.getChildByName('objects_nav_mc')); 
			contact_nav = MovieClip(view_mc.getChildByName('contact_nav_mc'));
			extra_copy = MovieClip(view_mc.getChildByName('extra_copy'));
			lines = MovieClip(view_mc.getChildByName('lines_mc'));
			logo = MovieClip(view_mc.getChildByName('logo_mc'));
			intro = MovieClip(view_mc.getChildByName('intro_mc'));
			this.info_holder = MovieClip(view_mc.getChildByName("info_holder_mc"));
			this.contact_section = MovieClip(view_mc.getChildByName("contact_section"));
			this.contact_holder = MovieClip(contact_section.getChildByName("contact_holder"));
			this.email_btn = new Glowing_Btn(MovieClip(contact_section.getChildByName("email")));
			
			set_properties();
			create_signals();
		}

		private function create_signals() : void 
		{
			notify_stage_click = new NativeSignal(view_mc, MouseEvent.CLICK);
			email_btn.notify_clicked.add(email);
		}

		private function email(event : MouseEvent) : void 
		{
			var emailLink : URLRequest = new URLRequest("mailto:jmarquez@famunited.com");
			navigateToURL(emailLink);
		}

		private function set_properties() : void 
		{
			image_nav.alpha = 0;
			before_after_slide.alpha = 0;
			fashion_nav.alpha = 0;
			objects_nav.alpha = 0;
			contact_nav.alpha = 0;
			pre_loader.alpha = 0;
			lines.alpha = 0;
			logo.alpha = 0;	
			intro.alpha = 0;
			extra_copy.alpha = 0;
			this.contact_section.alpha = 0;
			this.contact_section.visible = false;
		}

		public function show_intro() : void 
		{
			new TweenMax(intro, .5, {alpha:1, onComplete:fade_in_complete});
		}

		private function fade_in_complete() : void 
		{
			notify_intro_finished.dispatch();
			notify_intro_finished.removeAll();
			notify_intro_finished = null;
		}

		public function show_rest_of_view() : void 
		{
			var timeline : TimelineMax = new TimelineMax({onComplete:notify_view_ready.dispatch});
			timeline.append(new TweenMax(lines, .5, {alpha:1}), -.5);
			timeline.append(new TweenMax(fashion_nav, .5, {alpha:1}), -.35);
			timeline.append(new TweenMax(objects_nav, .5, {alpha:1}), -.35);
			timeline.append(new TweenMax(contact_nav, .5, {alpha:1}), -.35);
			timeline.append(new TweenMax(logo, .5, {alpha:1}), -.35);
			timeline.append(new TweenMax(intro, .5, {autoAlpha:0}), -.45);
			timeline.append(new TweenMax(before_after_slide, .5, {alpha:1}), -.4);
			timeline.append(new TweenMax(extra_copy, .5, {alpha:1}), -.4);
			timeline.append(new TweenMax(image_nav, .5, {alpha:1}), -.4);
		}

		public function set info(info : Loader) : void
		{
			_info = info;
			contact_holder.addChild(info);
		}

		public function hide_not_contact() : void 
		{
			contact_hidden = true;
			new TweenMax(contact_section, .5, {autoAlpha:1});
//			new TweenMax(img_holder, .25, {alpha:0});
			new TweenMax(image_nav, .25, {autoAlpha:0});
			new TweenMax(before_after_slide, .25, {autoAlpha:0});
			img_holder.visible = false;	
		}

		public function turn_off_contacts() : void 
		{
			if(contact_hidden)
			{
				img_holder.visible = true;
				contact_hidden = false;
				new TweenMax(contact_section, .5, {autoAlpha:0});
//				new TweenMax(img_holder, .25, {alpha:1});
				new TweenMax(image_nav, .25, {autoAlpha:1});
				new TweenMax(before_after_slide, .25, {autoAlpha:1});
			}	
		}
	}
}
