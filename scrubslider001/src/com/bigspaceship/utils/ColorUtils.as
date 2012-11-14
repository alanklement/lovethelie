package com.bigspaceship.utils{
	
	public class ColorUtils{
		
		public function ColorUtils(){
			/* 
			var argb:Number = 0xFFC97B33;
			// mask the alpha bits, then shift them to the least significant bits
			// shifting 6 hex digits, so 24 binary digits
			var alpha:Number = (argb & 0xFF000000) >>> 24;
			trace("Alpha: "+alpha.toString(16));
			// isolate Red:
			var red:Number = (argb & 0x00FF0000) >>> 16;
			trace("Red: "+red.toString(16));
			// isolate Green:
			var green:Number = (argb & 0x0000FF00) >>> 8;
			trace("Green: "+green.toString(16));
			// isolate Blue:
			var blue:Number = argb & 0x000000FF;
			trace("Blue: "+blue.toString(16));
			 */
		}
		
		/*
		*	@Param hex Number
		*
		*	HexToRGB: returns the RGB (as Object) for the specified HEX value
		*/
		public static function hexToRGB($hex:Number):Object{
			return {r:$hex >> 16, g:($hex >> 8) & 0xff, b:$hex & 0xff};
		}
         
		/*
		*
		*	getHexStr: returns a string representing the HEX value 
		*	for the specified R,G,B values
		*/
		public static function getHexStr($prefix:String, $r:Number, $g:Number, $b:Number ):String{
			return  $prefix + twoDigit($r.toString(16)) + twoDigit($g.toString(16)) + twoDigit($b.toString(16));
		}
		
		/*
		*	getHex: returns the HEX value for the specified R,G,B values 
		*/
		public static function getHex($r:Number, $g:Number, $b:Number):Number{
			return $r << 16 | $g << 8 | $b;
		}
		
		/* NOT YET IMPLEMENTED 
		public static function invert($color:Number):Number {
			return $color;
		} */
		
		/*
		* twoDigit: adds "0" in front if the string is only
		*       one digit also useful for converting date time strings 
		*/
		public static function twoDigit(str:String):String{
			return str.length == 1 ? ("0" + str) : str ;
		}

		
		public static function getRandomHue($hex:Number, $offsetHex:Number):Number{
			var color:Number = ((Math.random()* 0xffffff) & $hex) | $offsetHex ;
			//trace(color.toString(16));
			return color;
		}

	}
}