package effects 
{
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.DropShadowFilterPlugin;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;

	/**
	 * @author Alan
	 */
	public class Plugins 
	{
		public static function init() : void 
		{
			TweenPlugin.activate([DropShadowFilterPlugin,GlowFilterPlugin,AutoAlphaPlugin]);
		}
	}
}
