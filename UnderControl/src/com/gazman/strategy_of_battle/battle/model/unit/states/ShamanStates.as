package com.gazman.strategy_of_battle.battle.model.unit.states
{
	import com.gazman.strategy_of_battle_package.units.data.UnitStates;
	import com.gazman.strategy_of_battle_package.units.enums.UnitEnum;
	
	public class ShamanStates extends UnitStates
	{
		public function ShamanStates(){
			_type = UnitEnum.SHAMAN;
			_attackCost = 2;
			_dmg = -1;
			_life = 1;
			_moveCost = 2;
			_range = 1;
			_stamina = 3;
		}
	}
}