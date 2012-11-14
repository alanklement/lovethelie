package com.lovehthelie.scroller 
{
	import flash.display.Sprite;
	import flash.display.Bitmap;

	public class ShoeVOBuilder 
	{
		private var shoesBuiltCallback : Function;
		private var shoes : Array = [];
		private var simpleBulkLoader : SimpleBulkLoader;
		private var urlToImgFolder : String;
		private var shoesXML : XML;
		private var shoeKeys : Array;
		private var ShoeHitAreaMC : Class;

		public function ShoeVOBuilder(shoesBuiltCallback : Function, shoes : XML, urlToImgFolder : String, ShoeHitAreaMC : Class)
		{
			this.ShoeHitAreaMC = ShoeHitAreaMC;
			this.urlToImgFolder = urlToImgFolder;
			this.shoesBuiltCallback = shoesBuiltCallback;
			this.shoesXML = shoes;
			
			createExtraXMLShoeNodes();	
		}

		private function createExtraXMLShoeNodes() : void
		{
			while(shoesXML.shoe.length() <= 15)
			{
				var randomShoe : int = Math.floor(Math.random() * shoesXML.shoe.length());
			
				shoesXML.appendChild(shoesXML.shoe[randomShoe]);
			}
			
			addShoeImgUrlsToLoader();
		}

		private function addShoeImgUrlsToLoader() : void
		{
			simpleBulkLoader = new SimpleBulkLoader();
			
			var numOfShoes : int = shoesXML.shoe.length();
			shoeKeys = [];
			for (var i : int = 0;i < numOfShoes;i++) 
			{
				var shoeImgURL : String = urlToImgFolder + shoesXML.shoe[i].image;
				simpleBulkLoader.addItem(shoeImgURL, i);
				shoeKeys.push(i);
			}
			
			loadImages();
		}

		private function loadImages() : void
		{
			simpleBulkLoader.loadAllItems(createShoes);
		}

		private function createShoes() : void
		{				
			var numOfShoes : int = shoesXML.shoe.length();

			for (var i : int = 0;i < numOfShoes;i++) 
			{
				var shoeImg : Bitmap = simpleBulkLoader.getBitmap(shoeKeys[i]);
				shoeImg.smoothing = true;
				
				var shoeDiscription : String = String(shoesXML.shoe[i].description);
				var shoeURL : String = String(shoesXML.shoe[i].link);
							
				var shoeImgHolder : Sprite = new Sprite();
				shoeImgHolder.addChild(shoeImg);
							
				var shoe : InteractiveShoe = new InteractiveShoe(shoeImgHolder, shoeDiscription, shoeURL, ShoeHitAreaMC);
				shoes.push(shoe);
			}
			
			executeCallback();
		}

		private function executeCallback() : void
		{
			shoesBuiltCallback(shoes);
		}
	}
}
