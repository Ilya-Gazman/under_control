package com.gazman.strategy_of_battle.battle.view
{
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.ui.screens.signals.root_created.IRootCratedSignal;
	
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.events.EnterFrameEvent;

	public class GameJuggler extends Juggler implements ISingleTon, IRootCratedSignal
	{
		private var _pause:Boolean;
		
		public function GameJuggler() 
		{
			super();
		}
		
		public function rootCratedHandler():void
		{
			pause = false;
		}
		
		public function get pause():Boolean
		{
			return _pause;
		}

		public function set pause(value:Boolean):void
		{
			_pause = value;
			if(!value){
				Starling.current.stage.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			}
			else{
				Starling.current.stage.removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			}
		}

		private function onEnterFrame(event:EnterFrameEvent, time:Number):void
		{
			advanceTime(time);
		}
	}
}