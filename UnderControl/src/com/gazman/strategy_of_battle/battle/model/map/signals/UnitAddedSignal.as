package com.gazman.strategy_of_battle.battle.model.map.signals
{
	import com.gazman.life_cycle.Signal;
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;
	
	public class UnitAddedSignal extends Signal implements IUnitAddedSignal
	{
		public function unitAddedHandler(unitModel:UnitModel):void
		{
			dispatch(arguments);
		}
	}
}