package com.gazman.strategy_of_battle.battle.model.unit.signals.take_damage {
	import com.gazman.life_cycle.Signal;
	
	public class TakeDamageSignal extends Signal implements ITakeDamageSignal
	{
		public function takeDamageHandler(dmg:int):void
		{
			dispatch(arguments);
		}
	}
}