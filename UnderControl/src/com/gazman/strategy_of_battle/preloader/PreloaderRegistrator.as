package com.gazman.strategy_of_battle.preloader
{
	import com.gazman.life_cycle.Registrator;
	import com.gazman.strategy_of_battle.preloader.tasks.signals.ResourceLoadedSignal;
	import com.gazman.ui.screens.signals.root_created.RootCraetedSignal;
	import com.gazman.strategy_of_battle.preloader.view.PreloaderScreen;
	import com.gazman.strategy_of_battle.preloader.controller.PreloaderController;
	
	public class PreloaderRegistrator extends Registrator
	{
		
		override protected function initSignalsHandler():void
		{
			registerSignal(RootCraetedSignal, PreloaderController);	
			registerSignal(RootCraetedSignal, PreloaderScreen);	
			registerSignal(ResourceLoadedSignal, PreloaderScreen);	
		}
		
	}
}