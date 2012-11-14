package
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * @author Freelancer
	 */
	public class Main extends MovieClip
	{
		public var logo_mc : MovieClip;
		public var envelope_mc : MovieClip;
		public var from_living_txt : MovieClip;
		public var special_invite_txt : MovieClip;
		public var for_you_txt : MovieClip;
		public var resources_txt : MovieClip;
		private var time_elapsed : Number;
		private var postcard : MovieClip;
		private var envelope_flap : MovieClip;
		private var envelope : MovieClip;
		private var man_sky : MovieClip;
		private var postcard_copy_1 : MovieClip;
		private var report : MovieClip;
		private var postcard_copy_2 : MovieClip;
		private var envelope_front : MovieClip;
		private var postcard_slide_amount : String = "315";
		private var join_now : MovieClip;
		private var at_living : MovieClip;
		private var swoosh : MovieClip;
		private var btn_bg : MovieClip;
		private var clickTag1 : String;
		private var click_tag_btn : Sprite;

		public function Main()
		{
			get_flash_vars();
			create_clicktag();
			create_references();
			create_properties();
			TweenPlugin.activate([ColorTransformPlugin, TintPlugin]);
			begin();
		}

		private function get_flash_vars() : void
		{
			clickTag1 = String(root.loaderInfo.parameters.clickTag1);
		}

		private function create_clicktag() : void
		{
			click_tag_btn = new Sprite();
			click_tag_btn.graphics.beginFill(0xff000, 0);
			click_tag_btn.graphics.lineStyle(0, 0, 0);
			click_tag_btn.graphics.drawRect(0, 0, 160, 600);
			click_tag_btn.graphics.endFill();
			click_tag_btn.buttonMode = true;
			click_tag_btn.mouseChildren = true;
			click_tag_btn.addEventListener(MouseEvent.MOUSE_DOWN, clickTagEvent);
			addChild(click_tag_btn);
		}

		private function clickTagEvent(event : MouseEvent) : void
		{
			if (clickTag1)
			{
				var url : URLRequest = new URLRequest(clickTag1);
				navigateToURL(url, "_blank");
			}
		}

		private function create_references() : void
		{
			envelope = MovieClip(this.getChildByName("envelope_mc"));
			envelope_flap = MovieClip(envelope_mc.getChildByName("envelope_flap_mc"));
			envelope_front = MovieClip(envelope_mc.getChildByName("mc_envelope_front"));
			postcard = MovieClip(envelope_mc.postcard_mc.getChildByName("postcard_mc"));
			man_sky = MovieClip(postcard.getChildByName("man_sky_mc"));
			report = MovieClip(postcard.getChildByName("report_mc"));
			postcard_copy_1 = MovieClip(postcard.getChildByName("copy_1_mc"));
			postcard_copy_2 = MovieClip(postcard.getChildByName("copy_2_mc"));
			join_now = MovieClip(this.getChildByName("cta_mc"));
			at_living = MovieClip(this.getChildByName("at_living_mc"));
			swoosh = MovieClip(join_now.getChildByName("swoosh_mc"));
			btn_bg = MovieClip(join_now.getChildByName("bg_mc"));
		}

		private function create_properties() : void
		{
			time_elapsed = 0;
			from_living_txt.alpha = 0;
			resources_txt.alpha = 0;
			special_invite_txt.alpha = 0;
			for_you_txt.alpha = 0;
			at_living.alpha = 0;

			join_now.alpha = 0;
			this.removeChild(join_now);
			this.addChild(join_now);			

			swoosh.mouseChildren = false;
			swoosh.mouseEnabled = false;
		}

		private function begin() : void
		{
			var timeline : TimelineLite = new TimelineLite();
			timeline.append(TweenLite.from(envelope, 1.2, {y:650}), -.75);
			timeline.append(TweenLite.to(special_invite_txt, 1.5, {alpha:1}), -.5);
			timeline.append(TweenLite.to(for_you_txt, 1.2, {alpha:1}), -1.2);
			timeline.append(TweenLite.to(from_living_txt, 1.2, {alpha:1}), -1);
			timeline.appendMultiple([TweenLite.to(special_invite_txt, .5, {alpha:0}), TweenLite.to(for_you_txt, .5, {alpha:0}), TweenLite.to(from_living_txt, .5, {alpha:0})], 2);
			timeline.appendMultiple([TweenLite.to(envelope, .4, {y:"50"}), TweenLite.to(envelope_flap, .4, {rotationX:180})], -.25);

			timeline.append(TweenLite.to(postcard, 1, {onInit:set_postcard_on_top, y:("-" + postcard_slide_amount)}), -.2);
			timeline.append(TweenLite.to(postcard_copy_1, .5, {alpha:0}), 2);
			timeline.append(TweenLite.to(man_sky, .5, {alpha:0}), -.1);
			timeline.append(TweenLite.from(report, .5, {y:"100"}), -.1);
			timeline.append(TweenLite.from(postcard_copy_2, .5, {alpha:0}), -.1);
			timeline.append(TweenLite.to(postcard, 1, {y:postcard_slide_amount}), 3);
			timeline.appendMultiple([TweenLite.to(resources_txt, .8, {alpha:1}), TweenLite.to(resources_txt, 1, {alpha:1}), TweenLite.to(envelope_flap, .5, {onInit:set_postcard_on_bottom, rotationX:0}), TweenLite.to(envelope, .5, {scaleX:.62, scaleY:.62, y:"-52"}),]);
			timeline.append(new TweenLite(join_now, .4, {alpha:1, onComplete:activate_cta}), -.7);
			timeline.append(new TweenLite(at_living, .4, {alpha:1}), -.5);
		}

		private function activate_cta() : void
		{
			swoosh.x = -8;
			new TweenLite(swoosh, .6, {x:190, delay:.5});
			join_now.addEventListener(MouseEvent.ROLL_OVER, highlight_cta);
			join_now.addEventListener(MouseEvent.ROLL_OUT, untint);
			join_now.addEventListener(MouseEvent.MOUSE_DOWN, clickTagEvent);

			join_now.buttonMode = true;
		}

		private function untint(event : MouseEvent) : void
		{
			TweenLite.to(btn_bg, .3, {colorTransform:{exposure:1}});
		}

		private function highlight_cta(event : MouseEvent) : void
		{
			join_now.removeEventListener(MouseEvent.ROLL_OVER, highlight_cta);
			TweenLite.to(btn_bg, .3, {colorTransform:{exposure:1.1}});
			swoosh.x = -8;
			new TweenLite(swoosh, .6, {x:190, onComplete:function():void
			{
				join_now.addEventListener(MouseEvent.ROLL_OVER, highlight_cta);
			}});
		}

		private function set_postcard_on_top() : void
		{
			envelope.setChildIndex(envelope_flap, 3);
		}

		private function set_postcard_on_bottom() : void
		{
			envelope.setChildIndex(envelope_flap, envelope.numChildren - 1);
		}
	}
}
