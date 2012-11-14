package {
	/**
	 *	Class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *
	 *	@author R Blank
	 *	@since  03.01.2008
	 */
	import flash.net.NetStream;
	import flash.events.NetStatusEvent;
	import flash.events.Event;
	import flash.display.Sprite;

	public class VideoStatus extends Sprite {
		public static const END : String = "endOfVideo";
		public static const START : String = "startOfVideo";
		public static const RESUME : String = "resumeVideo";
		public static const BUFFERING_START : String = "bufferingStart";
		public static const BUFFERING_END : String = "bufferingEnd";
		public static const BUFFER_FLUSH : String = "BUFFER_FLUSH";
		private var _isStopped : Boolean;
		private var _isFlushed : Boolean;
		private var _isEmpty : Boolean;
		private var _ns : NetStream;
		private var _isBuffering : Boolean ;
		private var _isSeeking : Boolean ;

		function VideoStatus() {
			init() ;
		}

		public function set isBuffering(newVal : Boolean) : void {
			if ( newVal == true && _isBuffering == false ) {
				_isBuffering = true ;
				dispatchEvent(new Event(VideoStatus.BUFFERING_START)) ;
			} else if ( newVal == false && _isBuffering == true ) {
				_isBuffering = false ;
				dispatchEvent(new Event(VideoStatus.BUFFERING_END)) ;
			}
		}

		public function onNetStatus(evt : NetStatusEvent) : void {
			trace('onNetStatus', 'evt: ' + (evt).info.code);
			switch (evt.info.code) {
				case "NetStream.Play.Start":
					dispatchEvent(new Event(VideoStatus.START)) ;
					isBuffering = false ;
					_isStopped = false ;
					break ;
				case "NetStream.Play.Stop":
					_isStopped = true ;
					break;
				case "NetStream.Buffer.Flush":
					dispatchEvent(new Event(VideoStatus.BUFFER_FLUSH)) ;
					isBuffering = false ;
					_isFlushed = true ;
					break;
				case "NetStream.Seek.Notify":
					_isSeeking = true ;
					isBuffering = true ;
				case "NetStream.Buffer.Empty":
					dispatchEvent(new Event(VideoStatus.BUFFERING_START)) ;
					_isEmpty = true;
					break;
				case "NetStream.Buffer.Full":
					dispatchEvent(new Event(VideoStatus.BUFFERING_END)) ;
					isBuffering = false ;
					_isEmpty = false;
					if ( _isStopped || _isSeeking ) {
						dispatchEvent(new Event(VideoStatus.RESUME)) ;
						_isSeeking = false ;
						_isStopped = false ;
					}
					break;
				default:
					break;
			}
			/*trace ( "   _isEmpty: " + _isEmpty ) ;
			trace ( "   _isStopped: " + _isStopped ) ;
			trace ( "   _isFlushed: " + _isFlushed ) ;*/
			if (
			_isEmpty && _isStopped && _isFlushed
			) {
				_ns.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus) ;
				/*trace ( "dispatching EndOfVideo.END" ) ;*/
				dispatchEvent(new Event(VideoStatus.END)) ;
			}
		}

		public function attachNetStream(srcNS : NetStream = null) : void {
			if ( srcNS != null ) {
				reset() ;
				if ( _ns != null ) _ns.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus) ;
				_ns = srcNS;
				_ns.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus) ;
			}
		}

		public function removeNetStream() : void {
			if ( _ns != null ) {
				_ns.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus) ;
				_ns = null;
			}
		}

		private function init() : void {
		}

		private function reset() : void {
			_isStopped = false;
			_isFlushed = false;
			_isEmpty = false;
			_isBuffering = false ;
			_isSeeking = false ;
		}
	}
}