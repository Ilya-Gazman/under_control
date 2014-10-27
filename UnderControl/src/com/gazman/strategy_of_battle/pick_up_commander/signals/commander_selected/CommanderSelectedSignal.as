package com.gazman.strategy_of_battle.pick_up_commander.signals.commander_selected
{
	import com.gazman.life_cycle.Signal;
	
	public class CommanderSelectedSignal extends Signal implements ICommanderSelectedSignal
	{
		public function commnaderSelctedHandler():void
		{
			dispatch(arguments);
		}
	}
}