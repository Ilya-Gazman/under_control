package com.gazman.strategy_of_battle
{
	import com.gazman.life_cycle.Context;
	import com.gazman.strategy_of_battle.battle.BattleRegistrator;
	import com.gazman.strategy_of_battle.developers.DeveloperRegistrator;
	import com.gazman.strategy_of_battle.loading_popup.LoadingPopupRegistrator;
	import com.gazman.strategy_of_battle.menu.MenuRegistrator;
	import com.gazman.strategy_of_battle.pick_up_commander.PickUpCommanderRegistrator;
	import com.gazman.strategy_of_battle.preloader.PreloaderRegistrator;
	import com.gazman.strategy_of_battle.screens.ScreensRegistrator;
	import com.gazman.strategy_of_battle.warning.WarningRegistrator;
	
	public class StrategyContext extends Context
	{
		override protected function initRegistratorsHandler():void
		{
			addRegistrator(new PreloaderRegistrator());
			addRegistrator(new MenuRegistrator());
			addRegistrator(new ScreensRegistrator());
			addRegistrator(new BattleRegistrator());
			addRegistrator(new LoadingPopupRegistrator());
			addRegistrator(new WarningRegistrator());
			addRegistrator(new PickUpCommanderRegistrator());
			addRegistrator(new DeveloperRegistrator());
		}
		
	}
}