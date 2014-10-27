package com.gazman.strategy_of_battle.battle.view.signals
{
	import com.gazman.life_cycle.Signal;
	
	public class RequestBattleSignal extends Signal implements IRequestBattleSignal
	{
		public function requestBattleHandler():void
		{
			dispatch(arguments);
		}
	}
}