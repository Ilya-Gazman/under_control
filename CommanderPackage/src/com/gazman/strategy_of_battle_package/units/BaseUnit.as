package com.gazman.strategy_of_battle_package.units
{
	import com.gazman.strategy_of_battle_package.map.MapUtils;
	import com.gazman.strategy_of_battle_package.units.data.Action;
	import com.gazman.strategy_of_battle_package.units.data.TurnData;
	
	import flash.geom.Point;
	
	public class BaseUnit implements IUnitController
	{
		private var turnData:TurnData;
		
		public final function playTurn(turnData:TurnData):Action
		{
			this.turnData = turnData;
			return onPlayTurn(turnData);
		}
		
		protected function onPlayTurn(turnData:TurnData):Action
		{
			return null;
		}
		
		protected function canAttack(destination:Point):Boolean{
			return MapUtils.isInRange(turnData.position, destination, turnData.states.range) && turnData.stamina >= turnData.states.attackCost;
		}
		
		protected function canMove():Boolean{
			return turnData.stamina >= turnData.states.moveCost;
		}
	}
}