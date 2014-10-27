package com.gazman.strategy_of_battle.battle.model.unit.states
{
	import com.gazman.strategy_of_battle_package.units.data.UnitStates;
	import com.gazman.strategy_of_battle_package.units.enums.UnitEnum;
	
	public class KnightStates extends UnitStates
	{
		public function KnightStates(){
			_type = UnitEnum.KNIGHT;
			_attackCost = 3;
			_dmg = 3;
			_life = 8;
			_moveCost = 2;
			_range = 1;
			_stamina = 6;
		}
	}
}