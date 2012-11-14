package com.bigspaceship.utils
{
	import com.bigspaceship.utils.MathUtils;
	
	public class ArrayUtils
	{
		public static function removeAllWithValue($array:Array,$value:*):Array { return $array.join("").replace($value,"").split(""); };		
		public static function removeFirstWithValue($array:Array,$value:*):Array { return $array.slice($array.indexOf($value), 1); };

		public static function shuffle($array:Array):Array
		{
			var a:Array = [].concat($array);
				a.sort(__shuffleSort);
			return a;
		};
		
		private static function __shuffleSort($a:*,$b:*):Number { return MathUtils.getRandom(-1,1); };
		
		
		/**
	     *  The <code>swap()</code> method 
	     *
	     *  @param arr Specifies the Array to swap.
	     *
	     *  @param a Specifies the first index.
	     *
	     *  @param b Specifies the second index.
	     *
	     *  @return Swapped Array.
	     */
		public static function swap($arr:Array, $a:int, $b:int):Array
		{
			var temp:int = $arr[$a];
			$arr[$a] = $arr[$b];
			$arr[$b] = temp;
			return $arr;
		};
		
		
		/**
	     *  The <code>unique()</code> method 
	     *
	     *  @param $a Specifies the Array from which to remove the duplicates.
	     *	
	     *  @return unique Array.
	     */
		public static function unique($a:Array):Array
		{
			var obj:Object = new Object;
			var i:Number = $a.length;
			var a:Array = new Array();
			var t;
			
			while(i--)
			{
				t = $a[i];
				obj[t] = t;
			}
			
			for each(var item:* in obj){ a.push(item); }
			return a;
		};
	};
};