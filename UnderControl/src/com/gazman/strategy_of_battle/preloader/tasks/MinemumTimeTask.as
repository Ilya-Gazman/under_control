package com.gazman.strategy_of_battle.preloader.tasks
{
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.strategy_of_battle.preloader.model.Task;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.animation.Tween;
	import starling.core.Starling;

	public class MinemumTimeTask extends Task
	{
		private var timer:Timer = new Timer(3000, 1);
		override public function excecute():void
		{
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onnTime);
			timer.start();
		}
		
		private function onnTime(e:TimerEvent):void 
		{
			progress = 1;
		}
		
	}
}