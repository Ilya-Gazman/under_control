package com.gazman.strategy_of_battle.menu
{
	import com.gazman.life_cycle.Registrator;
	import com.gazman.strategy_of_battle.menu.view.MenuScreen;
	import com.gazman.strategy_of_battle.preloader.view.signals.PreloaderCompleteSingal;
	
	public class MenuRegistrator extends Registrator
	{
		
		override protected function initSignalsHandler():void
		{
			registerSignal(PreloaderCompleteSingal, MenuScreen);
		}
		
	}
}