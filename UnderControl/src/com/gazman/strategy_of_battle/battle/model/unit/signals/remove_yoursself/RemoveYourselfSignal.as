package com.gazman.strategy_of_battle.battle.model.unit.signals.remove_yoursself
{
	import com.gazman.life_cycle.Signal;
	
	public class RemoveYourselfSignal extends Signal implements IRemoveYourselfSignal
	{
		public function removeYourselfHandler():void
		{
			dispatch(arguments);
		}
	}
}