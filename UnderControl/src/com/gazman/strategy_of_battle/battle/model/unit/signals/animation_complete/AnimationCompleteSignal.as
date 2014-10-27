package com.gazman.strategy_of_battle.battle.model.unit.signals.animation_complete 
{
	import com.gazman.life_cycle.Signal;
	
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class AnimationCompleteSignal extends Signal implements IAnimationCompleteSignal 
	{
		public function animationCompleteHandler():void 
		{
			dispatch(arguments);
		}
		
	}

}