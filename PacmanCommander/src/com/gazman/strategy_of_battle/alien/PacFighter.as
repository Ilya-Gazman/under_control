package com.gazman.strategy_of_battle.alien
{
	import com.gazman.strategy_of_battle_package.map.MapFilter;
	import com.gazman.strategy_of_battle_package.units.BaseUnit;
	import com.gazman.strategy_of_battle_package.units.data.Action;
	import com.gazman.strategy_of_battle_package.units.data.TurnData;
	import com.gazman.strategy_of_battle_package.units.enums.ActionEnum;
	
	import flash.geom.Point;
	
	public class PacFighter extends BaseUnit
	{
		private var mapFilter:MapFilter = new MapFilter();

		private var commander:PacmanCommander;
		
		public function PacFighter(commander:PacmanCommander){
			this.commander = commander;
		}
		
		override protected function onPlayTurn(turnData:TurnData):Action
		{
			var action:Action = new Action();
			
			mapFilter.filter(turnData.map, turnData.position, turnData.myCommander);
			var destination:Point = mapFilter.findNearestEnemy();
			if(destination == null){ // no enemys yet
				action.actionEnum = ActionEnum.SKIP;
			}
			else{
				if(canAttack(destination)){
					action.actionEnum = ActionEnum.ATTACK;
					action.destination = destination;
				}
				else if(canMove()){
					if(commander.isGathering()){
						destination = mapFilter.findNearestAlly();
					}
					action.actionEnum = ActionEnum.MOVE;
					action.destination = mapFilter.navigateTo(destination);
				}
				else{
					action.actionEnum = ActionEnum.SKIP;
				}
			}
			
			return action;
		}
	}
}