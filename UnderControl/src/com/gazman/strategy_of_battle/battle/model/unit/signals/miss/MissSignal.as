package com.gazman.strategy_of_battle.battle.model.unit.signals.miss
{
	import com.gazman.life_cycle.Signal;
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;
	
	public class MissSignal extends Signal implements IMissedSignal
	{
		public function missHandler(target:UnitModel, x:int,y:int):void
		{
			dispatch(arguments);
		}
	}
}