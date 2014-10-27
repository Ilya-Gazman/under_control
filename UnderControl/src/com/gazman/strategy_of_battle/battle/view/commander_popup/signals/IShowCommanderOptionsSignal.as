package com.gazman.strategy_of_battle.battle.view.commander_popup.signals
{
	public interface IShowCommanderOptionsSignal
	{
		function showCommanderOptionsHandler(options:Array, isMyCommander:Boolean):void;
	}
}