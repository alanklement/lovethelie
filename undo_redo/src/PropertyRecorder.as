package  
{

	public class PropertyRecorder 
	{
		private var objectToRecord : *;
		private var currentHistoryIndex : uint;
		private var historyStates : Array = [];
		private var propertiesToWatch : Array;

		public function PropertyRecorder(objectToRecord : *, propertiesToWatch : Array)
		{
			this.propertiesToWatch = propertiesToWatch;
			this.objectToRecord = objectToRecord;
			recordNewHistory();
		}

		public function undo() : void
		{
			if(currentHistoryIndex > 0)
			{
				currentHistoryIndex--;
				var historyToRestore : PropertyVO = PropertyVO(historyStates[currentHistoryIndex]);
				historyToRestore.restoreProperties(objectToRecord);
			}
		}

		public function redo() : void
		{
			if(currentHistoryIndex < historyStates.length - 1)
			{
				currentHistoryIndex++;
				var historyToRestore : PropertyVO = PropertyVO(historyStates[currentHistoryIndex]);				
				historyToRestore.restoreProperties(objectToRecord);
			}
		}

		public function recordNewHistory() : void
		{
			checkForOldHistoryToClean();         
		}

		private function checkForOldHistoryToClean() : void
		{
			while(currentHistoryIndex + 1 < historyStates.length) 
			{
				PropertyVO(historyStates.pop()).dispose();
			}
		
			createNewHistoryVO();		
		}

		private function createNewHistoryVO() : void
		{			
			var historyVO : PropertyVO = new PropertyVO(propertiesToWatch);         
			historyVO.extractCurrentProperties(objectToRecord);

			historyStates.push(historyVO);
			currentHistoryIndex = historyStates.length - 1;
		}
	}
}
