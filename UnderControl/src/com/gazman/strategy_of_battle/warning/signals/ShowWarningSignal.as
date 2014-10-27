package com.gazman.strategy_of_battle.warning.signals
{
	import com.gazman.life_cycle.Signal;
	import com.gazman.strategy_of_battle.warning.WarningData;
	
	public class ShowWarningSignal extends Signal implements IShowWarningSignal
	{
		public function showWarningHandler(warningData:WarningData):void
		{
			dispatch(arguments);
		}
	}
}