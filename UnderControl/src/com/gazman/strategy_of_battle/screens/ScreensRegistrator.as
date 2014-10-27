package com.gazman.strategy_of_battle.screens
{
	import com.gazman.life_cycle.Registrator;
	import com.gazman.strategy_of_battle.screens.signals.PromotExtitSignal;
	
	public class ScreensRegistrator extends Registrator
	{
		
		override protected function initSignalsHandler():void
		{
			registerSignal(PromotExtitSignal, ExitApplicationController);
		}
		
	}
}