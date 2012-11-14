package  
{
	import com.greensock.TweenLite;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class KedsButton 
	{
		public var mc : MovieClip;
		private var blueBackground : MovieClip;

		public function KedsButton(mc:MovieClip)
		{
			this.mc = mc;
			setButtonProperties();
			addEventListeners();	
		}
		
		private function setButtonProperties() : void
		{
			mc.buttonMode = true;
			blueBackground = MovieClip(mc.getChildByName("artMC"));
		}

		private function addEventListeners() : void
		{
			mc.addEventListener(MouseEvent.ROLL_OVER, tintLightBlue);			
			mc.addEventListener(MouseEvent.ROLL_OUT, restoreColor);			
		}

		private function tintLightBlue(event : MouseEvent) : void
		{				
//			TweenLite.to(blueBackground, .15, {tint:0x32CCFF});
			TweenLite.to(blueBackground, .5, {tint:0x32CCFF});
		}

		private function restoreColor(event : MouseEvent) : void
		{
			TweenLite.to(blueBackground, .5, {tint:0x003366});
		}
	}
}
