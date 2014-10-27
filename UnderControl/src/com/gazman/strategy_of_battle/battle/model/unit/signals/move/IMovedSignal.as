package com.gazman.strategy_of_battle.battle.model.unit.signals.move
{
	public interface IMovedSignal
	{
		function moveHandler(x:int, y:int):void;
	}
}