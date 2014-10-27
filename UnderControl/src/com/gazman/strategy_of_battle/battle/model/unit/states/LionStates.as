package com.gazman.strategy_of_battle.battle.model.unit.states
{
	import com.gazman.strategy_of_battle_package.units.data.UnitStates;
	
	public class LionStates extends UnitStates
	{
		public function LionStates(){
			_attackCost = 5;
			_dmg = 8;
			_life = 20;
			_moveCost = 1;
			_range = 1;
			_stamina = 10;
		}
	}
}