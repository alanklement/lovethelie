package interfaces 
{
	import org.osflash.signals.Signal;

	/**
	 * @author Alan
	 */
	public interface Vo_Loader 
	{
		function get vos_ready() : Signal;
	}
}
