package interfaces 
{
	import flash.events.Event;

	/**
	 * @author Alan
	 */
	public interface Disposable 
	{
		function dispose(event:Event = null) : void;
	}
}
