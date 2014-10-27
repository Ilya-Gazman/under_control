package com.gazman.strategy_of_battle.warning
{
	import com.gazman.life_cycle.Registrator;
	import com.gazman.strategy_of_battle.warning.signals.ShowWarningSignal;
	
	public class WarningRegistrator extends Registrator
	{
		override protected function initSignalsHandler():void
		{
			registerSignal(ShowWarningSignal, WarningPopup);
		}
		
	}
}