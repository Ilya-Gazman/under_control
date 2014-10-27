package com.gazman.strategy_of_battle.battle.model.unit.states
{
	import com.gazman.strategy_of_battle_package.units.data.UnitStates;
	import com.gazman.strategy_of_battle_package.units.enums.UnitEnum;
	
	public class ArcherStates extends UnitStates
	{
		public function ArcherStates(){
			_type = UnitEnum.ARCHER;
			_attackCost = 4;
			_dmg = 2;
			_life = 6;
			_moveCost = 2;
			_range = 10;
			_stamina = 5;
		}
	}
}