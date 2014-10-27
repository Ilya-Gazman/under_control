package com.gazman.strategy_of_battle.battle.view.commander_popup.signals
{
	import com.gazman.life_cycle.Signal;
	
	public class ShowCommanderOptionsSignal extends Signal implements IShowCommanderOptionsSignal
	{
		public function showCommanderOptionsHandler(options:Array, isMyCommander:Boolean):void
		{
			dispatch(arguments);
		}
	}
}