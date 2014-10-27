package com.gazman.strategy_of_battle.alien
{
	import com.gazman.strategy_of_battle_package.map.MapFilter;
	import com.gazman.strategy_of_battle_package.units.BaseUnit;
	import com.gazman.strategy_of_battle_package.units.data.Action;
	import com.gazman.strategy_of_battle_package.units.data.TurnData;
	import com.gazman.strategy_of_battle_package.units.enums.ActionEnum;
	
	import flash.geom.Point;
	
	public class PacHealer extends BaseUnit
	{
		private var mapFilter:MapFilter = new MapFilter();
		
		override protected function onPlayTurn(turnData:TurnData):Action
		{
			var action:Action = new Action();
			mapFilter.filter(turnData.map, turnData.position, turnData.myCommander);
			var destination:Point = mapFilter.findNearestAlly();
			if(destination == null){ // No other units been summoned just yet
				action.actionEnum = ActionEnum.SKIP;
				return action;
			}
			
			if(canAttack(destination)){
				action.actionEnum = ActionEnum.ATTACK;
				action.destination = mapFilter.navigateTo(destination);
			}
			else if(canMove()){
				action.actionEnum = ActionEnum.MOVE;
				action.destination = mapFilter.navigateTo(destination);
			}
			else{
				action.actionEnum = ActionEnum.SKIP;
			}
			
			return action;
		}
	}
}