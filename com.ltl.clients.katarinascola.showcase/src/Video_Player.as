package {
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;

	/**
	 * @author Alan
	 */
	public class Video_Player extends EventDispatcher implements Meta_Data_Delegate {
		public static const SHOW_BUFFER : String = "SHOW_BUFFER";
		public static const HIDE_BUFFER : String = "HIDE_BUFFER";
		public var view : Sprite;
		private var video : Video;
		private var net_connection : NetConnection;
		private var net_stream : NetStream;
		private var buffer_timer : Timer;
		private var videoStatus : VideoStatus;

		public function Video_Player() {
			view = new Sprite();
			video = new Video(338, 254);
			configure_net_stream();
			create_meta_data_handler();
			connect_stream_to_video();
			create_buffer_timer();
		}

		public function replay() : void {
			net_stream.seek(0);
		}

		public function resume() : void {
			net_stream.resume();
			buffer_timer.start();
		}

		public function pause() : void {
			net_stream.pause();
			buffer_timer.stop();
		}

		private function configure_net_stream() : void {
			net_connection = new NetConnection();
			net_connection.connect(null) ;
			net_stream = new NetStream(net_connection);
			net_stream.bufferTime = 5;
		}

		private function create_meta_data_handler() : void {
			net_stream.client = new Metadata_Handler(this);
		}

		public function handle_meta_data(vo : Meta_Data_VO) : void {
			video.width = vo.width;
			video.height = vo.height;
		}

		private function connect_stream_to_video() : void {
			video.attachNetStream(net_stream) ;
		}

		private function create_buffer_timer() : void {
			buffer_timer = new Timer(1000, 0);
			// buffer_timer.addEventListener(TimerEvent.TIMER, check_buffer);
		}

		public function start_video_load(video_url : String) : void {
			kill_video_playback();
			create_video_status();

			net_stream.play(video_url);
			net_stream.togglePause();
			buffer_timer.start();
			add_items_to_view();
		}

		private function create_video_status() : void {
			videoStatus = new VideoStatus() ;
			// tell videoStatus what NetStream to listen to
			videoStatus.attachNetStream(net_stream) ;
			// assign listeners to the special events dispatched by VideoStatus
			videoStatus.addEventListener(VideoStatus.BUFFERING_START, onBufferingStart) ;
			videoStatus.addEventListener(VideoStatus.BUFFERING_END, onBufferingEnd) ;
		}

		public function kill_video_playback() : void {
			null_existing_net_stream();
			null_exsiting_net_connection();
			null_existing_video();
			net_stream.seek(0);
			net_stream.pause();
			net_stream.close();
			buffer_timer.stop();
		}

		private function null_existing_video() : void {
			if ( video ) {
				// clear the image in the video
				video.clear() ;
				// if the video is on the stage remove it from the display list
				// if ( video.parent == this ) removeChild(video) ;
				// remove the reference to the Video object
				video = null ;
			}
		}

		private function null_exsiting_net_connection() : void {
			if ( net_connection ) {
				// remove the event listeners on the nc NetConnection
				net_connection.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onNCAsyncError);
				net_connection.removeEventListener(IOErrorEvent.IO_ERROR, onNCIOError);
				net_connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onNCSecurityError);
				net_connection.removeEventListener(NetStatusEvent.NET_STATUS, onNCNetStatus);
				// close the nc NetConnection
				net_connection.close() ;
				// remove the reference to the NetConnection
				net_connection = null ;
			}
		}

		private function onNCNetStatus(event : NetStatusEvent) : void {
		}

		private function onNCSecurityError(event : SecurityErrorEvent) : void {
		}

		private function onNCIOError(event : IOErrorEvent) : void {
		}

		private function onNCAsyncError(event : AsyncErrorEvent) : void {
		}

		private function null_existing_net_stream() : void {
			if ( net_stream ) {
				// close the ns NetStream
				net_stream.close() ;
				// remove the event listeners on the ns NetStream
				net_stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onNSAsyncError);
				net_stream.removeEventListener(IOErrorEvent.IO_ERROR, onNSIOError);
				net_stream.removeEventListener(NetStatusEvent.NET_STATUS, onNSNetStatus);
				if ( videoStatus != null ) {
					// remove videoStatus' reference to the ns NetStream
					videoStatus.removeNetStream() ;
					// remove the event listeners on the videoStatus object
					videoStatus.removeEventListener(VideoStatus.BUFFERING_START, onBufferingStart) ;
					videoStatus.removeEventListener(VideoStatus.BUFFERING_END, onBufferingEnd) ;
					// remove the reference to the videoStatus object
					videoStatus = null ;
				}
				// remove the reference to the ns NetStream (to free it for garbage collection)
				net_stream = null ;
			}
		}

		private function onBufferingEnd(event : VideoStatus) : void {
		}

		private function onBufferingStart(event : VideoStatus) : void {
		}

		private function onNSNetStatus(event : NetStatusEvent) : void {
		}

		private function onNSIOError(event : IOErrorEvent) : void {
		}

		private function onNSAsyncError(event : AsyncErrorEvent) : void {
		}

		private function check_buffer(event : Event) : void {
			// net_stream.
			if (net_stream.bufferLength < 2) {
				net_stream.pause();
				buffer_timer.delay = 3000;
				dispatchEvent(new Event(Video_Player.SHOW_BUFFER));
			} else {
				net_stream.resume();
				buffer_timer.delay = 1000;
				dispatchEvent(new Event(Video_Player.HIDE_BUFFER));
			}
		}

		private function add_items_to_view() : void {
			view.addChild(video);
		}
	}
}
