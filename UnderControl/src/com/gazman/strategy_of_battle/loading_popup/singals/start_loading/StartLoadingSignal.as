package com.gazman.strategy_of_battle.loading_popup.singals.start_loading
{
	import com.gazman.life_cycle.Signal;
	
	public class StartLoadingSignal extends Signal implements IStartLoadingSignal
	{
		public function startLoadingHandler():void
		{
			dispatch(arguments);
		}
	}
}