package
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Quart;
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.setTimeout;

	/**	 * @author Freelancer	 */
	public class Main extends MovieClip
	{
		public var text_3 : *;
		public var mc_envelope : *;
		public var txt_2 : *;
		public var txt_1 : *;
		public var txt_11 : *;
		public var txt_21 : *;
		public var clickTag1 : String;

		public function Main()
		{
			TweenPlugin.activate([ColorTransformPlugin, TintPlugin]);

			text_3.mc_cta.addEventListener(MouseEvent.MOUSE_OVER, ctaOver);
			text_3.mc_cta.addEventListener(MouseEvent.MOUSE_OUT, untint_cta);
			text_3.mc_cta.addEventListener(MouseEvent.MOUSE_DOWN, clickTagEvent);
			addChild(drawBorder(0, 0, 300, 250, 0x937fb4));
			mc_envelope.mc_postcard_front.scaleX = mc_envelope.mc_postcard_front.scaleY = .75;
			mc_envelope.mc_postcard_back.scaleX = mc_envelope.mc_postcard_back.scaleY = .75;
			mc_envelope.mc_postcard_back.visible = false;
			txt_2.alpha = 0;
			text_3.alpha = 0;
			txt_1.alpha = 0;
			txt_11.alpha = 0;
			txt_21.alpha = 0;
			mc_envelope.mc_cover_up.alpha = 0;
			mc_envelope.y = 260;
			mc_envelope.scaleX = mc_envelope.scaleY = .66;
			addEventListener(Event.ENTER_FRAME, checkrotatiom);
			text_3.mc_swoosh.mouseEnabled = false;
			text_3.mc_swoosh.mouseChildren = false;
			text_3.mc_cta.buttonMode = true;

			initFlashvars();
			create_clicktag();
			addChild(text_3);

			var del_0 : Number = .2;
			TweenLite.to(mc_envelope, 1, {y:169, delay:del_0, ease:Cubic.easeOut});

			var del_01 : Number = del_0 + .6;
			TweenLite.to(txt_1, 1, {alpha:1, delay:del_01});
			var del_02 : Number = del_01;
			TweenLite.to(txt_11, 1, {alpha:1, delay:del_02});

			var del_1 : Number = del_02 + 3;

			setTimeout(test, del_1 * 1000);
			TweenLite.to(mc_envelope, 1.1, {onInit:test, scaleY:1.3, scaleX:1.3, delay:del_1, overwrite:false});
			TweenLite.to(mc_envelope, 1, {x:150, y:291, delay:del_1 + .7, overwrite:false, ease:Cubic.easeInOut});

			var del_2 : Number = del_1 + 1;
			TweenLite.to(mc_envelope.mc_envelope_flap, .6, {rotationX:180, delay:del_2, overwrite:false, ease:Quart.easeOut});

			var del_3 : Number = del_2 + .4;
			TweenLite.delayedCall(del_3, reorderEnvelope, [0]);
			setTimeout(hide_grey_line, del_3 * 1000);
			TweenLite.to(mc_envelope.mc_postcard_front, 1, {y:-122, delay:del_3, overwrite:false, ease:Quart.easeOut});
			TweenLite.to(mc_envelope.mc_postcard_back, 1, {y:-122, delay:del_3, overwrite:false, ease:Quart.easeOut});

			var del_31 : Number = del_3 + 2.7;
			TweenLite.to(mc_envelope.mc_postcard_front, .5, {y:-152, delay:del_31, overwrite:false, ease:Quart.easeOut});
			TweenLite.to(mc_envelope.mc_postcard_back, .5, {y:-152, delay:del_31, overwrite:false, ease:Quart.easeOut});

			var del_4 : Number = del_31;
			TweenLite.to(mc_envelope.mc_postcard_front, 1, {rotationY:180, delay:del_4, overwrite:false, ease:Quart.easeOut});
			TweenLite.to(mc_envelope.mc_postcard_back, 1, {rotationY:180, delay:del_4, overwrite:false, ease:Quart.easeOut});

			var del_41 : Number = del_4 + .5;
			TweenLite.to(mc_envelope.mc_postcard_front, .5, {y:-122, delay:del_41, overwrite:false, ease:Quart.easeOut});
			TweenLite.to(mc_envelope.mc_postcard_back, .5, {y:-122, delay:del_41, overwrite:false, ease:Quart.easeOut});

			var del_5 : Number = del_41 + 3.7;
			TweenLite.to(mc_envelope.mc_cover_up, .1, {alpha:0, delay:del_5});
			TweenLite.to(mc_envelope.mc_postcard_front, 1, {y:0, delay:del_5, overwrite:false, ease:Quart.easeOut});
			TweenLite.to(mc_envelope.mc_postcard_back, 1, {y:0, delay:del_5, overwrite:false, ease:Quart.easeOut});
			TweenLite.to(mc_envelope, 1, {y:210, delay:del_5, overwrite:false, ease:Cubic.easeInOut});

			var del_6 : Number = del_5 + .6;
			TweenLite.delayedCall(del_6, reorderEnvelope, [5]);
			TweenLite.to(mc_envelope.mc_envelope_flap, .7, {rotationX:0, delay:del_6, overwrite:false, ease:Quart.easeOut});

			var del_7 : Number = del_6 + .1;
			TweenLite.to(txt_2, .9, {alpha:1, delay:del_7});

			var del_8 : Number = del_7 + .1;
			TweenLite.to(mc_envelope, 1, {x:242, y:207, scaleY:.4, scaleX:.4, delay:del_8, overwrite:false, ease:Quart.easeOut});

			var del_9 : Number = del_8 + .3;
			TweenLite.to(txt_21, 1, {alpha:1, delay:del_9});

			var del_10 : Number = del_9;
			TweenLite.to(text_3, 1, {alpha:1, onComplete:show_swoosh, delay:del_10});
		}

		private function create_clicktag() : void
		{
			var click_tag_btn : Sprite = new Sprite();
			click_tag_btn.graphics.beginFill(0xff000, 0);
			click_tag_btn.graphics.lineStyle(0, 0, 0);
			click_tag_btn.graphics.drawRect(0, 0, 300, 250);
			click_tag_btn.graphics.endFill();
			click_tag_btn.buttonMode = true;
			click_tag_btn.mouseChildren = true;
			click_tag_btn.addEventListener(MouseEvent.MOUSE_DOWN, clickTagEvent);
			addChild(click_tag_btn)
		}

		private function untint_cta(event : MouseEvent) : void
		{
			TweenLite.to(text_3.mc_cta, .3, {colorTransform:{exposure:1}});
		}

		private function show_swoosh() : void
		{
			text_3.mc_swoosh.x = -8;
			TweenLite.to(text_3.mc_swoosh, .6, {x:198});
		}

		private function hide_grey_line() : void
		{
			mc_envelope.mc_cover_up.alpha = 1;
		}

		private function test() : void
		{
			TweenLite.to(txt_1, .5, {alpha:0});
			TweenLite.to(txt_11, .5, {alpha:0});
		}

		private function checkrotatiom(event : Event) : void
		{
			if (mc_envelope.mc_postcard_front.rotationY > 89)
			{
				flipsides();
			}
		}

		private function flipsides() : void
		{
			mc_envelope.mc_postcard_front.visible = false;
			mc_envelope.mc_postcard_back.visible = true;
		}

		private function drawBorder(nColor : uint, nHeight : Number, nWidth : Number, yPos : Number, xPos : Number) : DisplayObject
		{
			var border : Sprite = new Sprite();
			border.graphics.beginFill(0x000000, 0);
			border.graphics.lineStyle(1, nColor, 1);
			border.graphics.drawRect(xPos, yPos, nWidth - 1, nHeight - 1);
			border.graphics.endFill();
			border.mouseEnabled = false;
			return border;
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

		private function initFlashvars() : void
		{
			clickTag1 = String(root.loaderInfo.parameters.clickTag);
		}

		private function ctaOver(event : MouseEvent) : void
		{
			text_3.mc_cta.removeEventListener(MouseEvent.MOUSE_OVER, ctaOver);
			text_3.mc_swoosh.x = -8;
			TweenLite.to(text_3.mc_cta, .3, {colorTransform:{exposure:1.1}});

			TweenLite.to(text_3.mc_swoosh, .6, {x:198, onComplete:function():void
			{
				text_3.mc_cta.addEventListener(MouseEvent.MOUSE_OVER, ctaOver);
			}});
		}

		private function reorderEnvelope(m): void
		{
			mc_envelope.addChildAt(mc_envelope.mc_envelope_flap, m);
		}
	}
}