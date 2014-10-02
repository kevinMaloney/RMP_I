﻿package {
	import starling.events.Event;
	import starling.display.Sprite;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.label;
	import feathers.themes.MetalWorksMobileTheme;
	public class Main extends Sprite {
		protected var button: Button
		public function Main() {
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		protected function addedStageHandler(e.Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.stage.addEventListener(Event.RESIZE, stageResized);
			new MetalWorksMobileTheme();
			this.button = new Button();
			this.button.label = "Click Me";
			this.button.addEventListener(Event.TRIGGERED, button_triggeredHandler);
			this.addChild(this.button);
			this.button.validate();
			this.button.x = (this.stage.stageWidth - this.button.width) /2;
			this.button.y = (this.stage.stageHeight - this.button.height) /2;
		}
		protected function button_triggeredHandler(event:Event):void {
			var label:Label = new Label();
			label.text = "Hi, I'm Feathers!\nHave a nice day.";
			Callout.show(label, this.button);
		}
		protected function stageResized(e:Event):void {
			this.button.x = (this.stage.stageWidth - this.button.width) /2;
			this.button.y = (this.stage.stageHeight - this.button.height) /2;
		}
	}
}