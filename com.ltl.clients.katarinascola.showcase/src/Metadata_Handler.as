package {
	public class Metadata_Handler {
		private var delegate : Meta_Data_Delegate;

		public function Metadata_Handler(delegate : Meta_Data_Delegate) {
			this.delegate = delegate;
		}

		/* 
		 * b/c of Flash's wonky video protocall this method will be automatically called 
		 * by the net stream client
		 * e.g. my_net_stream.client.onMetaData(data_from_video)
		 */
		public function onMetaData(metaData : Object) : void {
			var metaDataVO : Meta_Data_VO = create_metadata_vo_from_stream(metaData);
			delegate.handle_meta_data(metaDataVO);

			/* 
			 * 'meta_data_ready_callback' is set to an empty function.  
			 *	the player seeks to 0. This cannot be controlled. 
			 *	I only want it once so further meta data VO pushes will
			 *	This is b/c the video pushes a new meta data VO when
			 *	be disabled.
			 */
			// meta_data_ready_callback = metadata_dummy_callback;
		}

		public function onXMPData(xmp_data : Object) : void {
		}

		private  function create_metadata_vo_from_stream(stream_data : Object) : Meta_Data_VO {
			var metaDataVO : Meta_Data_VO = new Meta_Data_VO();
			extract_properties_from_stream(metaDataVO, stream_data);
			return metaDataVO;
		}

		private function extract_properties_from_stream(metaDataVO : Meta_Data_VO, stream_data : Object) : void {
			for (var item : String in stream_data) {
				metaDataVO[item] = stream_data[item];
			}
		}
		// private function metadata_dummy_callback(metaData : Meta_Data_VO) : void
		// {
		// metaData = null;
		// }
	}
}
