package com.lovehthelie.scroller 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class InteractiveShoe extends Sprite
	{
		public var shoeDescription : String;
		public var shoeURL : String;

		private var shoeImgHolder : Sprite;
		private var shoeHitArea : MovieClip;

		public function InteractiveShoe(shoeImg : Sprite, shoeDiscrption : String,shoeURL : String, ShoeHitAreaMC : Class)
		{
			this.shoeImgHolder = shoeImg;
			this.shoeDescription = shoeDiscrption;
			this.shoeURL = shoeURL;
			this.shoeHitArea = new ShoeHitAreaMC();
			
			addItmesToDisplayList();
		}

		private function addItmesToDisplayList() : void
		{
			addChild(shoeImgHolder);
//			addChild(shoeHitArea);
			setObjectProperties();	
		}

		private function setObjectProperties() : void
		{
//			shoeImgHolder.mask = shoeHitArea;
//			this.buttonMode = true;
			addEventListeners();
		}	

		private function addEventListeners() : void
		{
		}
	}
}
