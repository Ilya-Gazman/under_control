package com.gazman.strategy_of_battle.battle.model.animation_queue.signals
{
	import com.gazman.life_cycle.Signal;
	
	public class AnimationFinishedSignal extends Signal implements IAnimationsFinishedSignal
	{
		public function animationsFinishedHandler():void
		{
			dispatch(arguments);
		}
	}
}
