package com.gazman.strategy_of_battle.menu.view
{
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.ui.utils.ShapeTextur;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.Color;

	public class MenuButton
	{
		private var _button:Button;
		
		public function MenuButton()
		{
			var upState:Texture = ShapeTextur.roundRectangle("menu button", 180, 40, 2, Color.BLUE);
			_button = injectWithParams(Button, [upState, ""]);
			_button.fontSize = 20;
			_button.fontColor = Color.WHITE;
		}
		
		public function addClickListenerEvent(listener:Function):void{
			_button.addEventListener(Event.TRIGGERED, function(event:Event):void {
				if (listener !=  null) {
					if (listener.length == 0) {
						listener();		
					}
					else {
						listener(event);
					}
				}
				
			});
		}
	
		public function get text():String
		{
			return _button.text;
		}

		public function set text(value:String):void
		{
			_button.text = value;
		}

		public function get view():Button
		{
			return _button;
		}

	}
}