package com.gazman.strategy_of_battle.battle.model.unit.signals.move
{
	import com.gazman.life_cycle.Signal;
	
	public class MoveSignal extends Signal implements IMovedSignal
	{
		public function moveHandler(x:int, y:int):void
		{
			dispatch(arguments);
		}
	}
}