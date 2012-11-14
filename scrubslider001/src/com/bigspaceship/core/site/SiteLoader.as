/*
Copyright (C) 2006 Big Spaceship, LLC

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

To contact Big Spaceship, email info@bigspaceship.com or write to us at 45 Main Street #716, Brooklyn, NY, 11201.
*/

package com.bigspaceship.core.site
{	
	import flash.net.URLRequest;

	import flash.display.Loader;
	import flash.display.MovieClip;

	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import com.bigspaceship.utils.Out;
	import com.bigspaceship.core.display.PreloaderClip;
		
	public class SiteLoader extends MovieClip
	{
		private static var __instance			:SiteLoader;
		public var preloader_mc 				:PreloaderClip;
		
		public static function getInstance():SiteLoader { return __instance; };
		
		public function SiteLoader()
		{
			Out.enableAllLevels();
			Out.disableAllLevels();
			
			__instance = this;
			
			preloader_mc.animateIn();
			preloader_mc.addEventListener(Event.INIT,_startLoad,false,0,true);
			preloader_mc.addEventListener(Event.COMPLETE,_onPreloaderOut,false,0,true);
		};

		protected function _startLoad($evt:Event):void
		{
			var l:Loader = new Loader();
			l.contentLoaderInfo.addEventListener(Event.COMPLETE,_onLoadComplete,false,0,true);
			l.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,_onLoadProgress,false,0,true);
			
			var baseSWFPath:String = stage.loaderInfo.parameters.baseSWFPath || "./";
			
			l.load(new URLRequest(baseSWFPath + "main.swf"));
		};
		
		protected function _onLoadProgress($evt:ProgressEvent):void { preloader_mc.updateProgress($evt.bytesLoaded,$evt.bytesTotal,0,10); };
		protected function _onLoadComplete($evt:Event):void { addChild($evt.target.content); };		
		protected function _onPreloaderOut($evt:Event):void { __instance = null; };
	};
}