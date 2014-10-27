package com.gazman.strategy_of_battle.battle.model.map.signals
{
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;

	public interface IUnitAddedSignal
	{
		function unitAddedHandler(unitModel:UnitModel):void;
	}
}