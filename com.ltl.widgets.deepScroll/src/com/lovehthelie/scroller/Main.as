package com.lovehthelie.scroller 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.ApplicationDomain;

	public class Main extends Sprite 
	{
		private var dataModel : DataModel;
		private var skinLoader : ExternalSwfSkinLoader;
		private var xmlLoader : XMLLoader;
		private var view : View;
		private var shoeVOBuilder : ShoeVOBuilder;
		private var shoeScroller : ShoeScroller;

		public function Main()
		{
			pushFlashVarsIntoDataModel();
		}

		private function pushFlashVarsIntoDataModel() : void
		{
			dataModel = new DataModel();
			stage.align = StageAlign.TOP_LEFT;
			dataModel.skinSwfURL = "http://blog.alanklement.com/files/examples/lookup_tables/skins/scroller_skins.swf";
			dataModel.shoesXMLURL = "http://blog.alanklement.com/files/examples/lookup_tables/xml/scrollerShoes.xml";
			dataModel.imgFolderURL = "http://blog.alanklement.com/files/examples/lookup_tables/images/";
			
			loadSkins();	
		}

		private function loadSkins() : void
		{
			skinLoader = new ExternalSwfSkinLoader(createBackgroundView, dataModel.skinSwfURL);
		}

		private function createBackgroundView(viewSkin : ApplicationDomain) : void
		{
			dataModel.skinApplicationDomain = viewSkin;
			view = new View(loadShoeXML, viewSkin); 
		}

		private function loadShoeXML() : void
		{						
			xmlLoader = new XMLLoader(dataModel.shoesXMLURL, buildShoeVOs);
		}

		private function buildShoeVOs(shoeXml : XML) : void
		{			
			var ShoeHitAreaMC : Class = Class(dataModel.skinApplicationDomain.getDefinition("ShoeHitAreaMC"));
				  
			shoeVOBuilder = new ShoeVOBuilder(passShoesToScroller, shoeXml, dataModel.imgFolderURL, ShoeHitAreaMC);
		}

		private function passShoesToScroller(shoes : Array) : void
		{
			shoeScroller = new ShoeScroller(shoes);
			addObjectsToStage();
		}

		private function addObjectsToStage() : void
		{
			addChild(view);
			view.backGroundArt.addChildAt(shoeScroller, 1);	
			
			addUpdateShoeListenersBehaviour();
		}

		private function addUpdateShoeListenersBehaviour() : void
		{
			shoeScroller.addEventListener(ShoeScroller.UPDATE_SHOE_DESCIPTION, changeShoeDescription);
			shoeScroller.addEventListener(ShoeScroller.SHOE_CLICKED, navigateToShoeURL);
			startView();
		}

		private function startView() : void
		{
			view.animateIn(animateInShoes);
		}

		private function animateInShoes() : void
		{
			shoeScroller.fadeInShoesAndStartScrolller();
		}

		private function navigateToShoeURL(event : Event) : void
		{
			navigateToURL(new URLRequest(shoeScroller.clickedShoeURL));
		}

		private function changeShoeDescription(event : Event) : void
		{
		//	view.shoeDescription.text = shoeScroller.shoeDescripton;
		}
	}
}
