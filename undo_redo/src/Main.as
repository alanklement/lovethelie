package {
	import com.bit101.components.PushButton;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class Main extends Sprite {
		private var undoButton : PushButton;
		private var redoButton : PushButton;
		private var propertyHistory : PropertyRecorder;
		private var redSquare : RedSquare;
		private var text : TextField;

		public function Main() {
			buildText();
			buildButtons();
			buildShapes();
			createHistoryManager();
		}

		private function buildText() : void {
			text = new TextField();
			text.text = "Grab The Blue Handle And Drag";
			text.autoSize = TextFieldAutoSize.LEFT;
			text.x = 200;
			text.y = 100;

			addChild(text);
		}

		private function buildButtons() : void {
			undoButton = new PushButton(this, 100, 50, "Undo", undo);
			addChild(undoButton);

			redoButton = new PushButton(this, 300, 50, "Redo", redo);
			addChild(redoButton);
		}

		private function buildShapes() : void {
			redSquare = new RedSquare();
			redSquare.x = 200;
			redSquare.y = 300;

			addChild(redSquare);
		}

		private function createHistoryManager() : void {
			propertyHistory = new PropertyRecorder(redSquare, ["x", "y", "rotation", "alpha"]);
			addEventListeners();
		}

		private function addEventListeners() : void {
			redSquare.handle.addEventListener(MouseEvent.MOUSE_DOWN, startCircleDrag);
			redSquare.handle.addEventListener(MouseEvent.MOUSE_UP, stopCircleDrag);
		}

		private function startCircleDrag(event : MouseEvent) : void {
			redSquare.startDrag();
			addEventListener(MouseEvent.MOUSE_MOVE, rotateRectangle);
		}

		private function rotateRectangle(event : MouseEvent) : void {
			var ratio : Number = this.mouseX / stage.stageWidth ;
			ratio = ratio - (1 - ratio);
			redSquare.rotation += ratio * 10;
		}

		private function stopCircleDrag(event : MouseEvent) : void {
			removeEventListener(MouseEvent.MOUSE_MOVE, rotateRectangle);
			redSquare.stopDrag();
			propertyHistory.recordNewHistory();
		}

		private function undo(event : MouseEvent) : void {
			propertyHistory.undo();
		}

		private function redo(event : MouseEvent) : void {
			propertyHistory.redo();
		}
	}
}


