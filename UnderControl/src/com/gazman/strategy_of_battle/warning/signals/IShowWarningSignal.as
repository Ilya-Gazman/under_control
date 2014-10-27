package com.gazman.strategy_of_battle.warning.signals
{
	import com.gazman.strategy_of_battle.warning.WarningData;

	public interface IShowWarningSignal
	{
		function showWarningHandler(warningData:WarningData):void;		
	}
}