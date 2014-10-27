package com.gazman.strategy_of_battle.pick_up_commander.signals
{
	import com.gazman.life_cycle.Signal;
	
	public class PickUpCommanderSignal extends Signal implements IPickUpCommanderSignal
	{
		public function pickUpCommanderHandler():void
		{
			dispatch(arguments);
		}
		
	}
}