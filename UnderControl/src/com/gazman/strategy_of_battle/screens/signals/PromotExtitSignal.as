package com.gazman.strategy_of_battle.screens.signals
{
	import com.gazman.life_cycle.Signal;
	
	public class PromotExtitSignal extends Signal implements IPromoteExtitSignal
	{
		public function promotExitHandler():void
		{
			dispatch(arguments);
		}
	}
}