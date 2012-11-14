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
package com.bigspaceship.utils
{
	import flash.utils.getQualifiedClassName;
	import flash.events.EventDispatcher;

	import com.bigspaceship.events.OutputEvent;
	
	public class Out extends EventDispatcher{
		public  static const INFO      : Number = 0;
		public  static const STATUS    : Number = 1;
		public  static const DEBUG     : Number = 2;
		public  static const WARNING   : Number = 3;
		public  static const ERROR     : Number = 4;
		public  static const FATAL     : Number = 5;
		
		private static var __levels    : Array  = new Array();
		private static var __silenced  : Object = new Object();
		private static var __instance  : Out;	
		
		
		public function Out() {
			
		};
		
	
		public static function enableLevel($level:Number):void {
			__levels[$level] = __output;
		};
		
		public static function disableLevel($level:Number):void {
			__levels[$level] = __foo;
		};
		
		public static function enableAllLevels():void {
			enableLevel(INFO   );
			enableLevel(STATUS );
			enableLevel(DEBUG  );
			enableLevel(WARNING);
			enableLevel(ERROR  );
			enableLevel(FATAL  );
		};
		
		public static function disableAllLevels():void {
			disableLevel(INFO   );
			disableLevel(STATUS );
			disableLevel(DEBUG  );
			disableLevel(WARNING);
			disableLevel(ERROR  );
			disableLevel(FATAL  );
		};
		
		public static function isSilenced($o:*):Boolean {
			var s:String = __getClassName($o);
			
			return __silenced[s];
		};
		
		public static function silence($o:*):void {
			var s:String = __getClassName($o);
			
			__silenced[s] = true;
		};
		
		public static function unsilence($o:*):void {
			var s:String = __getClassName($o);
			
			__silenced[s] = false;
		};
		
		public static function info($origin:*, $str:String):void {
			if(isSilenced($origin)) return;
			
			__levels[INFO]("INFO", $origin, $str, OutputEvent.INFO);
		};
		
		public static function status($origin:*, $str:String):void {
			if(isSilenced($origin)) return;
			
			__levels[STATUS]("STATUS", $origin, $str, OutputEvent.STATUS);
		};
		
		public static function debug($origin:*, $str:String):void {
			if(isSilenced($origin)) return;
			
			__levels[DEBUG]("DEBUG", $origin, $str, OutputEvent.DEBUG);
		};
		
		public static function warning($origin:*, $str:String):void {
			if(isSilenced($origin)) return;
			
			__levels[WARNING]("WARNING", $origin, $str, OutputEvent.WARNING);
		};
		
		public static function error($origin:*, $str:String):void {
			if(isSilenced($origin)) return;
			
			__levels[ERROR]("ERROR", $origin, $str, OutputEvent.ERROR);
		};
		
		public static function fatal($origin:*, $str:String):void {
			if(isSilenced($origin)) return;
			
			__levels[FATAL]("FATAL", $origin, $str, OutputEvent.FATAL);
		};
		
		public static function traceObject($origin:*, $str:String, $obj:*):void{
			if(isSilenced($origin)) return;
			
			__output("OBJECT", $origin, $str, OutputEvent.ALL);
			for(var p in $obj) __output("", null, p + " : " + $obj[p], OutputEvent.ALL);
		};
		
		public static function addEventListener($type:String, $func:Function):void{
			__getInstance().addEventListener($type, $func);
		};
		
		public static function removeEventListener($type:String, $func:Function):void {
			__getInstance().removeEventListener($type, $func);
		};
		
		private static function __getInstance():Out{
			return (__instance ? __instance : (__instance = new Out()));
		};
		
		public static function createInstance():void
		{
			var i:*;
			var ii:*;
			var reSilence:Object = {};			
			var reDisable:Array = [];
			
			for(i in __silenced) { reSilence[i] = __silenced; }
			for(i in __levels) { if(__levels[i] && __levels[i] == __foo) reDisable.push(i); }			
			enableAllLevels();
			for(ii in reSilence) { silence(ii); }
			for(ii=0;ii<reDisable.length;ii++) { disableLevel(reDisable[ii]); }
		};
		
		private static function __foo($level:String,$origin:*,$str:String,$type:String):void {};
		
		private static function __output($level:String, $origin:*, $str:String, $type:String):void {
			var l:String = $level;
			var s:String = $origin ? __getClassName($origin) : "";
			var i:Out    = __getInstance();
			
			while(l.length < 8) l += " ";
			
			var output:String = l + ":::	" + s + "	:: " + $str;
			
			trace(output);
			
			i.dispatchEvent(new OutputEvent(OutputEvent.ALL, output));
			i.dispatchEvent(new OutputEvent($type,           output));
		};
		
		
		
		private static function __getClassName($o:*):String {
			var c:String = flash.utils.getQualifiedClassName($o);
			var s:String = (c == "String" ? $o : c.split("::")[1] || c);
			
			return s;
		};
		
	};
};