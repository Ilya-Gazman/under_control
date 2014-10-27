package com.gazman.strategy_of_battle.battle.controller.signals
{
	public interface IGameOverSignal
	{
		function gameOverHandler(won:Boolean):void;
	}
}