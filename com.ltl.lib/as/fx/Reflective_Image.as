package  fx
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;

	/**
	 * @author Alan
	 */
	public class Reflective_Image extends Sprite
	{
		private static const GRADIENT_OFFSET : Number = 5;
		private var bm : Bitmap;
		private var reflection : Bitmap;
		private var bmd : BitmapData;
		private var matrix : Matrix;
		private var matr : Matrix;
		private var gradient_mask : Sprite;

		public function Reflective_Image(bm : Bitmap)
		{
			this.addEventListener(Event.REMOVED_FROM_STAGE, clean);
			this.bm = bm;
			
			bmd = new BitmapData(bm.width, bm.height);
			matrix = new Matrix();
			var ratio : Number = bm.width / bm.bitmapData.width;
			matrix.scale(ratio, ratio);
			bmd.draw(bm, matrix, null, null, null, true);
			reflection = new Bitmap(bmd);
			reflection.x = bm.x;
			reflection.y = bm.y + bm.height * 2 + GRADIENT_OFFSET;
			reflection.scaleY = -1;
			
			gradient_mask = new Sprite();			
			matr = new Matrix();
			matr.createGradientBox(50, 200, (90 / 180) * Math.PI, 0, 0);
			gradient_mask.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xFFFFFF], [50, 0], [0, 50], matr, SpreadMethod.PAD);  
			gradient_mask.graphics.drawRect(0, 0, bm.width, 100);
			
			gradient_mask.cacheAsBitmap = true;
			reflection.cacheAsBitmap = true;
			reflection.alpha = .1;
			gradient_mask.y = bm.y + bm.height + GRADIENT_OFFSET;
			gradient_mask.x = bm.x;
			
			reflection.mask = gradient_mask;
			addChild(bm);
			addChild(reflection);
			addChild(gradient_mask);
		}

		private function clean(event : Event) : void 
		{
			removeChild(bm);
			removeChild(reflection);
			removeChild(gradient_mask);
			
			bmd.dispose();
			reflection = null;
			bmd = null;
			matrix = null;
			matr = null;
			gradient_mask = null;
		}
	}
}
