package com.gazman.strategy_of_battle.battle.view.units
{
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.strategy_of_battle.battle.model.animation_queue.AnimationQue;
	import com.gazman.strategy_of_battle.battle.view.GameJuggler;
	import com.gazman.ui.group.Group;
	
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class SpeachBubble extends Group
	{
		private var animationQue:AnimationQue = inject(AnimationQue);
		private var textField:TextField = injectWithParams(TextField, [200, 50, ""]);
		private var gameJugglar:GameJuggler = inject(GameJuggler);
		private var _showMessage:Number = 0;
		private var message:String = "Hello Strategy of Battle";
		
		
		public function get showMessage():Number
		{
			return _showMessage;
		}
		
		public function set showMessage(value:Number):void
		{
			_showMessage = value;
			var length:int = value * message.length;
			textField.vAlign = VAlign.TOP;
			textField.hAlign = HAlign.LEFT;
			textField.text = message.substr(0, length);
		}
		
		override protected function initilize():void
		{
			addChild(textField);
			gameJugglar.tween(this, 1.2, 
				{
					showMessage: 1,
					onComplete: fadeout
				}); 
		}
		
		private function fadeout():void
		{
			gameJugglar.tween(this, 1.2, 
				{
					onComplete: onMessageComplete,
					delay: 0.5,
					alpha: 0
				}
			);
		}
		
		private function onMessageComplete():void
		{
			
		}
		
		
	}
	
	
}