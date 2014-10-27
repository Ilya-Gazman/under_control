package com.gazman.strategy_of_battle.battle.view.game_over_popup.signals
{
	import com.gazman.life_cycle.Signal;
	
	public class BackToMenuSignal extends Signal implements IBackToMenuSignal
	{
		public function backToMenuHandler():void
		{
			dispatch(arguments);
		}
	}
}