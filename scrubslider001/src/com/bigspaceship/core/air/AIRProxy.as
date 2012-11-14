/*
	This program is distributed under the Creative Commons Attribution-NonCommercial 3.0 License.
	For more information, visit http://creativecommons.org/licenses/by-nc/3.0/us/
	
	This program was written by Jamie Kosoy. To contact him, email j.kosoy@bigspaceship.com.
	Copyright © 2007 Adobe Systems Incorporated.
*/

package com.bigspaceship.core.air
{
	// native AS3
	// blah
	import flash.net.URLRequest;

	import flash.display.Loader;
	import flash.display.MovieClip;
		
	// AIRProxy is the Document Root class of proxy.fla. This will circumvent the need to keep all of our FLAs in the _deploy directory, which will be really messy.
	public class AIRProxy extends MovieClip
	{
		private static var __instance		:AIRProxy;
		
		public function AIRProxy()
		{
			var l:Loader = new Loader();
			addChild(l);
			l.load(new URLRequest("main.swf"));
			__instance = this;
		};
		
		public static function getInstance():AIRProxy { return __instance; };
	};
}
