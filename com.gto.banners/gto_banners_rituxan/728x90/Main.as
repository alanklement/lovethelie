package
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenAlign;
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
		public var envelope : MovieClip;
		public var logo : MovieClip;
		public var special_invite : MovieClip;
		public var from_living : MovieClip;
		private var flap : MovieClip;
		private var postcard_holder : MovieClip;
		private var postcard_one : MovieClip;
		private var postcard_two : MovieClip;
		private var same_stage : MovieClip;
		private var hear_about : MovieClip;
		private var sign_up : MovieClip;
		private var emails : MovieClip;
		private var resources : MovieClip;
		private var throughout : MovieClip;
		private var at_living : MovieClip;
		private var join_now : MovieClip;
		private var swoosh : MovieClip;
		private var btn_bg : MovieClip;
		private var clickTag1 : String;
		private var click_tag_btn : Sprite;

		public function Main()
		{
			get_flash_vars();
			create_clicktag();
			create_references();
			init_properties();
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
			click_tag_btn.graphics.drawRect(0, 0, 728, 90);
			click_tag_btn.graphics.endFill();
			click_tag_btn.buttonMode = true;
			click_tag_btn.mouseChildren = true;
			click_tag_btn.addEventListener(MouseEvent.MOUSE_DOWN, clickTagEvent);
			addChild(click_tag_btn);
		}

		private function clickTagEvent(event : MouseEvent) : void
		{
			trace('event: ' + (event));
			if (clickTag1)
			{
				var url : URLRequest = new URLRequest(clickTag1);
				navigateToURL(url, "_blank");
			}
		}

		private function create_references() : void
		{
			logo = MovieClip(this.getChildByName("logo_mc"));
			special_invite = MovieClip(this.getChildByName("special_invite_mc"));
			from_living = MovieClip(this.getChildByName("from_living_mc"));
			same_stage = MovieClip(this.getChildByName("same_stage_mc"));
			hear_about = MovieClip(this.getChildByName("hear_about_mc"));
			sign_up = MovieClip(this.getChildByName("sign_up_mc"));
			emails = MovieClip(this.getChildByName("emails_mc"));
			resources = MovieClip(this.getChildByName("resources_mc"));
			throughout = MovieClip(this.getChildByName("throughout_mc"));
			at_living = MovieClip(this.getChildByName("at_living_mc"));
			join_now = MovieClip(this.getChildByName("join_now_mc"));
			swoosh = MovieClip(join_now.getChildByName("swoosh_mc"));
			btn_bg = MovieClip(join_now.getChildByName("btn_bg"));

			// envelope
			envelope = MovieClip(this.getChildByName("envelope_mc"));
			postcard_holder = MovieClip(envelope.getChildByName("postcard_holder_mc"));
			flap = MovieClip(envelope.getChildByName("envelope_flap_mc"));
			postcard_one = MovieClip(envelope.postcard_holder_mc.getChildByName("postcard_one"));
			postcard_two = MovieClip(envelope.postcard_holder_mc.getChildByName("postcard_two"));
		}

		private function init_properties() : void
		{
			same_stage.alpha = 0;
			hear_about.alpha = 0;
			emails.alpha = 0;
			sign_up.alpha = 0;
			resources.alpha = 0;
			throughout.alpha = 0;
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
			timeline.append(TweenLite.from(envelope, 2, {y:"200"}));
			timeline.append(TweenLite.from(special_invite, 1, {alpha:0}), -.5);
			timeline.append(TweenLite.from(from_living, 1, {alpha:0}), -.5);
			timeline.append(TweenLite.to(special_invite, .5, {alpha:0}), 2);
			timeline.append(TweenLite.to(from_living, .5, {alpha:0}), -.2);
			timeline.append(TweenLite.to(envelope, .5, {scaleX:.78, scaleY:.78, x:294.7, y:61.35}), -.2);
			timeline.append(TweenLite.to(flap, .5, {rotationX:180}), -.2);
			timeline.appendMultiple([TweenLite.to(postcard_one, .5, {onInit:set_postcard_on_top, y:"-20"}), TweenLite.to(postcard_two, .5, {y:"-15"})], -.2, TweenAlign.SEQUENCE, -.3);
			timeline.append(TweenLite.to(hear_about, .5, {alpha:1}), -.2);
			timeline.append(TweenLite.to(same_stage, .5, {alpha:1}), -.3);
			timeline.append(TweenLite.to(postcard_two, .5, {y:"-100", onComplete:swap_postcard_depths}), 2);
			timeline.append(TweenLite.to(postcard_two, .5, {y:"100"}));
			timeline.append(TweenLite.to(hear_about, .5, {alpha:0}), -.3);
			timeline.append(TweenLite.to(same_stage, .5, {alpha:0}), -.25);
			timeline.append(TweenLite.to(sign_up, .5, {alpha:1}), -.1);
			timeline.append(TweenLite.to(emails, .5, {alpha:1}), -.25);
			timeline.append(new TweenLite(sign_up, .25, {alpha:0}), 3);
			timeline.append(new TweenLite(emails, .25, {alpha:0}), -.15);
			timeline.appendMultiple([TweenLite.to(postcard_one, .25, {y:"20"}), TweenLite.to(postcard_two, .25, {y:"14"})], -.2, TweenAlign.SEQUENCE);
			timeline.appendMultiple([TweenLite.to(flap, 1, {onInit:set_postcard_on_bottom, rotationX:0}), TweenLite.to(envelope, 1, {y:"150"})], -.15, TweenAlign.SEQUENCE);
			timeline.append(new TweenLite(resources, .75, {alpha:1}), -.8);
			timeline.append(new TweenLite(throughout, .75, {alpha:1}), -.6);
			timeline.append(new TweenLite(join_now, .75, {alpha:1}), -.4);
			timeline.append(new TweenLite(at_living, .75, {alpha:1, onComplete:activate_cta}), -.75);
		}

		private function activate_cta() : void
		{
			swoosh.x = -8;
			new TweenLite(swoosh, .6, {x:190, delay:.5});

			join_now.addEventListener(MouseEvent.ROLL_OVER, highlight_cta);
			join_now.addEventListener(MouseEvent.ROLL_OVER, tint);
			join_now.addEventListener(MouseEvent.ROLL_OUT, untint);
			join_now.addEventListener(MouseEvent.MOUSE_DOWN, clickTagEvent);

			join_now.buttonMode = true;
		}

		private function tint(event : MouseEvent) : void
		{
			TweenLite.to(btn_bg, .3, {colorTransform:{exposure:1.1}});
		}

		private function highlight_cta(event : MouseEvent) : void
		{
			join_now.removeEventListener(MouseEvent.ROLL_OVER, highlight_cta);
			swoosh.x = -8;

			new TweenLite(swoosh, .6, {x:190, onComplete:function():void
			{
				trace('');
				join_now.addEventListener(MouseEvent.ROLL_OVER, highlight_cta);
			}});
		}

		private function untint(event : MouseEvent) : void
		{
			TweenLite.to(btn_bg, .3, {colorTransform:{exposure:1}});
		}

		private function set_postcard_on_bottom() : void
		{
			envelope.setChildIndex(flap, envelope.numChildren - 1);
		}

		private function swap_postcard_depths() : void
		{
			postcard_holder.setChildIndex(postcard_one, 0);
		}

		private function set_postcard_on_top() : void
		{
			envelope.setChildIndex(flap, 3);
		}
	}
}
