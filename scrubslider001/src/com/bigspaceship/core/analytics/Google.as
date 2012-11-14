package com.bigspaceship.frameworks.analytics
{
	import com.bigspaceship.utils.BigURL;
	
	import flash.events.EventDispatcher;

	public class Google extends EventDispatcher{
		
		private static var _oneTimePaths:Object = new Object()
		
		public function Google(){
			
		}
		
		public static function call_urchinTracker($path:String, $onlyTrackOneTime:Boolean = false):void{
			
			if(($onlyTrackOneTime && !_oneTimePaths.hasOwnProperty($path)) || !$onlyTrackOneTime){
				//trace('GOOOOOOGLE.call_urchinTracker:'+ $path);
				BigURL.callURL("javascript:urchinTracker('"+$path+"')");
				
			}
			if($onlyTrackOneTime && !_oneTimePaths.hasOwnProperty($path)){
				_oneTimePaths[$path] = 'oneTimeOnly';
			}
			
		}
		
	}
}