package com.gazman.strategy_of_battle.developers.signals 
{
	import com.gazman.life_cycle.Signal;
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class DevelopersSignal extends Signal implements IDevelopersSignal
	{
		public function developersHandler():void {
			dispatch(arguments);
		}
		
	}

}