package com.bigspaceship.core.analytics
{
	import com.bigspaceship.utils.BigURL;
	
	public class Omniture
	{
		// additional properties, to be added via appendAnalyticsProperty.
		public static const EVENTS				:String		= "s_events";
		public static const CHANNEL				:String		= "s_channel";
		public static const ACCOUNT				:String		= "s_accountName";
		public static const PAGENAME			:String		= "s_pageName";
		public static const CAMPAIGN			:String		= "s_campaign";	

		public static const PROP_1				:String		= "s_prop1";
		public static const PROP_2				:String		= "s_prop2";
		public static const PROP_3				:String		= "s_prop3";
		public static const PROP_4				:String		= "s_prop4";
		public static const PROP_5				:String		= "s_prop5";
		public static const PROP_6				:String		= "s_prop6";
		public static const PROP_7				:String		= "s_prop7";
		public static const PROP_8				:String		= "s_prop8";
		public static const PROP_9				:String		= "s_prop9";
		public static const E_VAR1				:String		= "s_eVar1";
		public static const E_VAR2				:String		= "s_eVar2";
		public static const E_VAR3				:String		= "s_eVar3";
		public static const E_VAR4				:String		= "s_eVar4";
		public static const E_VAR5				:String		= "s_eVar5";
		public static const E_VAR6				:String		= "s_eVar6";
		public static const E_VAR7				:String		= "s_eVar7";
		public static const E_VAR8				:String		= "s_eVar8";
		public static const E_VAR9				:String		= "s_eVar9";
				
		private static const __START			:String		= "='";
		private static const __SEPERATOR		:String		= ":";
		private static const __END				:String		= "';";
		private static const __SEND				:String		= "void(sendAnalyticsEvent());";

		private var _trackCall					:String;		
		private static var __instance			:Omniture;	

		public static function getInstance():Omniture { return __instance || (__instance = new Omniture()); };
		
		public function Omniture() { _trackCall = ""; };

		public function appendAnalyticsEvent($channel:String,$pageName:String):void
		{	
			appendAnalyticsProperty(CHANNEL,$channel);
			appendAnalyticsProperty(PAGENAME,$channel + __SEPERATOR + $pageName);
		};
		
		public function clearAnalyticsProperty($prop:String):void { _trackCall += $prop + __START + __END; };
		public function appendAnalyticsProperty($prop:String,$value:String):void { _trackCall += $prop + __START + $value + __END; };
		
		public function sendAnalyticsEvent():void
		{
			_trackCall += __SEND;
			BigURL.callURL("javascript: " + escape(_trackCall));	
			_trackCall = "";	
		};
	};
};

