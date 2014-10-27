package com.gazman.strategy_of_battle.battle.model.unit.signals.attack
{
	import com.gazman.life_cycle.Signal;
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;
	
	public class AttackSignal extends Signal implements IAttackSignal
	{
		public function attackHandler(target:UnitModel,damage:int, x:Number, y:Number):void
		{
			dispatch(arguments);
		}
	}
}