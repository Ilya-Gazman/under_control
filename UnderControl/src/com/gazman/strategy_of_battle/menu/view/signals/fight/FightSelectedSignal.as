package com.gazman.strategy_of_battle.menu.view.signals.fight
{
	import com.gazman.life_cycle.Signal;
	
	public class FightSelectedSignal extends Signal implements IFightSelectedSignal
	{
		public function fightSelectedHandler():void
		{
			dispatch(arguments);
		}
	}
}