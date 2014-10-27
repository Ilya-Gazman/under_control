package com.gazman.strategy_of_battle.developers 
{
	import com.gazman.life_cycle.Registrator;
	import com.gazman.strategy_of_battle.developers.signals.DevelopersSignal;
	
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class DeveloperRegistrator extends Registrator
	{
		
		override protected function initSignalsHandler():void
		{
			registerSignal(DevelopersSignal, DevelopersScreen);
		}
		
	}

}