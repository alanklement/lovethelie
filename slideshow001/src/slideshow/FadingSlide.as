package slideshow 
{
	import flash.display.Bitmap ;
	
	import com.gskinner.motion.GTween ;

	import flash.events.Event ;

	public class FadingSlide extends Slide 
	{
	
		private var _fadeIn 		: GTween ;
		private var _fadeOut 		: GTween ;
		private var _fadeDuration	: Number ;
	
		public function FadingSlide( $bm:Bitmap )
		{
			super( $bm );
			_bm.alpha = 0 ;
		}
		
		override public function enter ():void
		{
			_fadeIn = new GTween ( _bm, _fadeDuration, {alpha:1 } ) ;
			_fadeIn.addEventListener ( Event.COMPLETE, _fadeInComplete ) ;	
		}
			
		override public function exit ():void
		{
			_fadeOut = new GTween ( _bm, _fadeDuration, {alpha:0 } ) ;
			_fadeOut.addEventListener ( Event.COMPLETE, _fadeOutComplete ) ;
		}

		override protected function  _setUpTransistions():void
		{
			GTween.timingMode = GTween.TIME ;
			_fadeDuration = .5 ;
		}
		
		override protected function _addedToStage():void
		{
		}
		
		private function _fadeInComplete ( $evt:Event ):void
		{
			$evt.target.removeEventListener ( $evt.type, _fadeInComplete ) ;
			dispatchEvent ( new SlideEvent ( SlideEvent.ENTER_COMPLETE ) ) ;
		}	
		
		private function _fadeOutComplete ( $evt:Event ):void
		{
			$evt.target.removeEventListener ( $evt.type, _fadeOutComplete ) ;
			dispatchEvent ( new SlideEvent ( SlideEvent.EXIT_COMPLETE ) ) ;
		}	
	}

}

