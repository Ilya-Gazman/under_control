package com.gazman.strategy_of_battle.loading_popup
{
	import com.gazman.life_cycle.Registrator;
	import com.gazman.strategy_of_battle.loading_popup.singals.loading_complete.LoadingCompleteSignal;
	import com.gazman.strategy_of_battle.loading_popup.singals.start_loading.StartLoadingSignal;
	import com.gazman.strategy_of_battle.loading_popup.view.LoadingPopup;
	
	public class LoadingPopupRegistrator extends Registrator
	{
		override protected function initSignalsHandler():void
		{
			registerSignal(LoadingCompleteSignal, LoadingPopup);
			registerSignal(StartLoadingSignal, LoadingPopup);
		}
		
	}
}