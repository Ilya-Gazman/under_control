package com.gazman.strategy_of_battle.battle.model.unit.signals.attack
{	
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;
	public interface IAttackSignal
	{
		function attackHandler(target:UnitModel, damage:int, x:Number, y:Number):void;
	}
}