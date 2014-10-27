package com.gazman.strategy_of_battle.pick_up_commander
{
	import com.gazman.life_cycle.Registrator;
	import com.gazman.strategy_of_battle.pick_up_commander.signals.PickUpCommanderSignal;
	import com.gazman.strategy_of_battle.pick_up_commander.signals.commander_selected.CommanderSelectedSignal;
	import com.gazman.strategy_of_battle.pick_up_commander.view.PickUpCommanderScreen;
	
	public class PickUpCommanderRegistrator extends Registrator
	{
		override protected function initSignalsHandler():void
		{
			registerSignal(PickUpCommanderSignal, PickUpCommanderScreen);
			registerSignal(CommanderSelectedSignal, PickUpCommanderScreen);
		}
		
	}
}