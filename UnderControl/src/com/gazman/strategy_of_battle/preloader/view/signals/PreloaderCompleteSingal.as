package com.gazman.strategy_of_battle.preloader.view.signals
{
	import com.gazman.life_cycle.Signal;
	
	public class PreloaderCompleteSingal extends Signal implements IPreloaderCompleteSingal
	{
		public function preloaderCompleteHandler():void
		{
			dispatch(arguments);
		}
	}
}