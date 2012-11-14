package com.bigspaceship.utils
{
	import flash.display.MovieClip;
	import flash.display.FrameLabel;
	import flash.display.DisplayObjectContainer;
	
	public class DisplayUtils
	{
		public static function ignoreMouse($do:DisplayObjectContainer):void
		{
           if($do.mouseEnabled) $do.mouseEnabled = false;
           if($do.mouseChildren) $do.mouseChildren = false;

           if($do.numChildren && $do.numChildren > 0)
           {
               for(var i:int=0;i<$do.numChildren;i++)
               {
                   if($do.mouseEnabled) DisplayUtils.ignoreMouse(($do.getChildAt(i) as DisplayObjectContainer));
               }
			}	
		};
		
		
		public static function respondToMouse($do:DisplayObjectContainer):void
		{
			if(!$do.mouseEnabled) $do.mouseEnabled = true;
			if(!$do.mouseChildren) $do.mouseChildren = true;

			if($do.numChildren && $do.numChildren > 0)
			{
				for(var i:int=0;i<$do.numChildren;i++)
				{
					if(!$do.mouseEnabled) DisplayUtils.respondToMouse(($do.getChildAt(i) as DisplayObjectContainer));
				}
			}
		};
		
		/**
		 *  The <code>stopAllChildren()</code> method stops the passed Movieclip and all it's children-Movieclips.
		 *
		 *  @param $mc A Movieclip 
		 *
		*/
		public static function stopAllChildren($mc:MovieClip):void{
			//trace('STOP called for: '+$mc);
			$mc.stop();
			for(var i:int = 0; i < $mc.numChildren; i++){
				if($mc.getChildAt(i)){
					if($mc.getChildAt(i).hasOwnProperty('currentFrame')){
						stopAllChildren(MovieClip($mc.getChildAt(i)));
					}
				}
			}   
		}
		
        /**
		 *  The <code>playAllChildren()</code> method starts playing the passed Movieclip and all it's children-Movieclips.
		 *	You can add "var doNotPlay:Boolean=true;" on the Timeline of the Movieclip or on the Timeline on one of the child-Movieclips 
		 *	if you don't want the movieclip to play.
		 *	
		 *  @param $mc A Movieclip 
		 *
		*/
		public static function playAllChildren($mc:MovieClip):void{
			//trace('PLAY called for: '+$mc.replayable);
			if(!$mc.doNotPlay)$mc.play();
			for(var i:int = 0; i < $mc.numChildren; i++){
				if($mc.getChildAt(i)){
					if($mc.getChildAt(i).hasOwnProperty('currentFrame')){		
						playAllChildren(MovieClip($mc.getChildAt(i)));
					}
				}
			}   
		}
		
		/**
		 *  The <code>generateFrameLabelObject()</code> method returns an Object that contains 
		 *	Frame-Labels as Keys and corresponding Frame-number as a value.
		 *	
		 *  @param $mc A Movieclip to analyse
		 *	
		 *	@return Object that contains Frame-Labels as Keys and corresponding Frame-number as a value
		 *
		*/
		public static function generateFrameLabelObject($mc:MovieClip):Object{
			var labels:Array = $mc.currentLabels;
			var frameLabelObj:Object = new Object();
			//trace('_generateFrameLabelObject:: '+$mc.name);
			for (var i:uint = 0; i < labels.length; i++) {
        
			    var label:FrameLabel = labels[i];
			    //trace(label.name+': '+label.frame);
			    frameLabelObj[label.name] = label.frame;
			}
			return frameLabelObj;
		}
	};
};