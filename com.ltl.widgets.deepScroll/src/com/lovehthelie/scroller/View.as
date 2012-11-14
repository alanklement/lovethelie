package com.lovehthelie.scroller 
{
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;

	public class View extends Sprite
	{
		public var backGroundArt : MovieClip;
		public var shoeDescription : TextField;

		private var buildCompleteCallback : Function;
		private var animateCompleteCallback : Function;

		public function View(buildCompleteCallback : Function, view : ApplicationDomain)
		{
			this.buildCompleteCallback = buildCompleteCallback;
			
			createBackground(view);
		}

		private function createBackground(viewArt : ApplicationDomain) : void
		{
			var BackgroundArtFromFlashAuthoring : Class = Class(viewArt.getDefinition("BackgroundViewMC"));
			this.backGroundArt = new BackgroundArtFromFlashAuthoring();
			addChild(backGroundArt);			
			buildCompleteCallback();
		}

		public function animateIn(animateCompleteCallback : Function) : void
		{
			this.animateCompleteCallback = animateCompleteCallback;
			backGroundArt.addEventListener("INTRO_ANIMATION_COMPLETE", disableGradientMouseInteraction);
			backGroundArt.gotoAndPlay("ANIMATE_IN");	
		}
		
		private function disableGradientMouseInteraction(event : Event) : void
		{
			backGroundArt.removeEventListener(event.type, executeCallback);

			MovieClip(backGroundArt.getChildByName("whiteGradientMC")).mouseEnabled = false;	
			MovieClip(backGroundArt.getChildByName("whiteGradientMC")).mouseChildren = false;
			
			createReferenceToShoeDescription();
		}
		
		private function createReferenceToShoeDescription() : void
		{
			this.shoeDescription = TextField(backGroundArt.getChildByName("shoeDescriptionTF"));
			executeCallback();	
		}

		private function executeCallback() : void
		{			
			animateCompleteCallback();				
		}
	}
}
