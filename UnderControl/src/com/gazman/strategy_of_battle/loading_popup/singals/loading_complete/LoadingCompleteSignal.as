package com.gazman.strategy_of_battle.loading_popup.singals.loading_complete
{
	import com.gazman.life_cycle.Signal;
	
	public class LoadingCompleteSignal extends Signal implements ILoadingCompleteSignal
	{
		public function loadingCompleteHandler():void
		{
			dispatch(arguments);
		}
	}
}