package com.gazman.strategy_of_battle.battle.model.unit.signals.miss
{
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;
	public interface IMissedSignal
	{
		function missHandler(target:UnitModel, x:int,y:int):void;
	}
}