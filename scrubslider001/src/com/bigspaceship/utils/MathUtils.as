package com.bigspaceship.utils
{
	public class MathUtils
	{
		public static function getRandom(min_num:Number,max_num:Number):Number
		{
			return min_num + Math.floor(Math.random() * (max_num + 1 - min_num));
		}
	
		public static function getRandomFloat(min_num:Number,max_num:Number):Number
		{
			return min_num + (Math.random() * (max_num - min_num));
		}		
		
		public static function normalize($value:Number, $min:Number, $max:Number):Number
		{
			return ($value - $min) / ($max - $min);
		};
		
		public static function interpolate($normValue:Number, $min:Number, $max:Number):Number
		{
			return $min + ($max - $min) * $normValue;
		};
		
		public static function map($value:Number, $min1:Number, $max1:Number, $min2:Number, $max2:Number):Number
		{
			return interpolate( normalize($value, $min1, $max1), $min2, $max2);
		};
		
		/**
	     *  The <code>limit()</code> method checks if a given value is within a specific range.
	     * 	It returns the value if it's within the range.
	     * 	It returns the min/max value if the value is lower/higher than the min/max. 
	     *
	     *  @param value Specifies value.
	     *
	     *  @param min Specifies the minimum value.
	     *
	     *  @param max Specifies the maximum value.
	     *
	     *  @return Number within the given range.
	     */
		public static function limit($value:Number, $min:Number, $max:Number):Number
		{
			return Math.min(Math.max($min, $value), $max);
		};
		
		// correct ratio to fit content in a container using maximum area.
		public static function findPreferredRatio($width:Number, $height:Number, $maxWidth:Number, $maxHeight:Number):Number
		{
			var dw:Number = $maxWidth/$width;
			var dh:Number = $maxHeight/$height;
			return dw < dh ? dw : dh;
		}
		
		/**
	     *  The <code>roundNumber()</code> method 
	     *
	     *  @param val Specifies the Number to round.
	     *
	     *  @param digits Specifies the digits after the comma.
	     *
	     *  @return Rounded Number.
	     */  
		public static function roundNumber($val:Number, $digits:Number=0):Number{
			var factor:Number = Math.pow(10, $digits);
			return int($val*factor)/factor;
		}
		/**
	     *  The <code>degreesToRadians()</code> method calculates degrees to radians 
	     *
	     *  @param degrees Specifies degrees to be converted.
	     *
	     *  @return Radians.
	     */  
		public static function degreesToRadians($degrees:Number):Number
		{
			return $degrees*(Math.PI/180);
		}
		
		/**
	     *  The <code>degreesToRadians()</code> method calculates degrees to radians 
	     *
	     *  @param radians Specifies radians to be converted.
	     *
	     *  @return Degrees.
	     */  
		public static function radiansToDegrees(radians:Number):Number
		{
			return radians*(180/Math.PI);
		}
	};
};