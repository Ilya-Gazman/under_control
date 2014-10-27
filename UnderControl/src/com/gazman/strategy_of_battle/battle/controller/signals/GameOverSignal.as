package com.gazman.strategy_of_battle.battle.controller.signals
{
	import com.gazman.life_cycle.Signal;
	
	public class GameOverSignal extends Signal implements IGameOverSignal
	{
		public function gameOverHandler(won:Boolean):void
		{
			dispatch(arguments);
		}
	}
}