package com.gazman.strategy_of_battle_package.units
{
	import com.gazman.strategy_of_battle_package.units.data.Action;
	import com.gazman.strategy_of_battle_package.units.data.TurnData;

	public interface IUnitController
	{
		/**
		 * Perform a logic to determinat the action of this turn
		 * @param map Full map of the battle field
		 * @param stamina How much stamina you have
		 * @param commander Your commander name, used to identify allys and enemies
		 * @return the action to be performed this turn 
		 * 
		 */		
		function playTurn(turnData:TurnData):Action;
	}
}