package {
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	public class Video_Player_2 extends EventDispatcher implements Meta_Data_Delegate {
		public static const SHOW_BUFFER : String = "SHOW_BUFFER";
		public static const HIDE_BUFFER : String = "HIDE_BUFFER";
		public var view : Sprite;
		private var net_connection : NetConnection;
		private var net_stream : NetStream;
		private var videoStatus : VideoStatus;
		private var video : Video;

		public function Video_Player_2() {
			create_view();
		}

		private function create_view() : void {
			view = new Sprite();
		}

		public function play_video(video : String) : void {
			kill_current_video();
			create_video();
			create_net_connection();
			create_net_stream();
			create_video_status();
			create_meta_data_handler();
			add_items_to_view();
			net_stream.play(video);
		}

		private function create_video() : void {
			video = new Video(478, 359);
			video.smoothing = true;
		}

		private function create_net_connection() : void {
			net_connection = new NetConnection();
			net_connection.connect(null) ;
			net_connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onNCAsyncError);
			net_connection.addEventListener(IOErrorEvent.IO_ERROR, onNCIOError);
			net_connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onNCSecurityError);
			net_connection.addEventListener(NetStatusEvent.NET_STATUS, onNCNetStatus);
		}

		private function create_net_stream() : void {
			net_stream = new NetStream(net_connection);
			net_stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onNSAsyncError);
			net_stream.addEventListener(IOErrorEvent.IO_ERROR, onNSIOError);
			net_stream.addEventListener(NetStatusEvent.NET_STATUS, onNSNetStatus);
			net_stream.bufferTime = 5;

			video.attachNetStream(net_stream);
		}

		private function create_video_status() : void {
			videoStatus = new VideoStatus();
			videoStatus.attachNetStream(net_stream);
			videoStatus.addEventListener(VideoStatus.BUFFERING_END, onBufferingEnd);
			videoStatus.addEventListener(VideoStatus.BUFFER_FLUSH, prevent_buffer_status);
			videoStatus.addEventListener(VideoStatus.START, video_started);
		}

		private function prevent_buffer_status(event : Event) : void {
			videoStatus.removeEventListener(VideoStatus.BUFFERING_START, onBufferingStart) ;
		}

		private function video_started(event : Event) : void {
			videoStatus.addEventListener(VideoStatus.BUFFERING_START, onBufferingStart);
			dispatchEvent(new Event(Video_Player_2.SHOW_BUFFER));
		}

		public function replay() : void {
			net_stream.seek(0);
		}

		public function resume() : void {
			net_stream.resume();
		}

		public function pause() : void {
			net_stream.pause();
		}

		private function create_meta_data_handler() : void {
			net_stream.client = new Metadata_Handler(this);
		}

		private function add_items_to_view() : void {
			view.addChild(video);
		}

		public function handle_meta_data(vo : Meta_Data_VO) : void {
			video.width = 368;
			// vo.width;
			video.height = 278;
			// vo.height;
		}

		public function kill_current_video() : void {
			null_existing_net_stream();
			null_exsiting_net_connection();
			null_existing_video();
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

		private function null_existing_video() : void {
			if ( video ) {
				video.clear() ;
				view.removeChild(video);
				video = null ;
			}
		}

		private function onBufferingStart(event : Event) : void {
			dispatchEvent(new Event(Video_Player_2.SHOW_BUFFER));
		}

		private function onBufferingEnd(event : Event) : void {
			dispatchEvent(new Event(Video_Player_2.HIDE_BUFFER));
		}

		private function onNSNetStatus(event : NetStatusEvent) : void {
			// trace('event: ' + (event));
		}

		private function onNSIOError(event : IOErrorEvent) : void {
			// trace('event: ' + (event));
		}

		private function onNSAsyncError(event : AsyncErrorEvent) : void {
			// trace('event: ' + (event));
		}

		private function onNCNetStatus(event : NetStatusEvent) : void {
			// trace('event: ' + (event));
		}

		private function onNCSecurityError(event : SecurityErrorEvent) : void {
			// trace('event: ' + (event));
		}

		private function onNCIOError(event : IOErrorEvent) : void {
			// trace('event: ' + (event));
		}

		private function onNCAsyncError(event : AsyncErrorEvent) : void {
			// trace('event: ' + (event));
		}
	}
}
