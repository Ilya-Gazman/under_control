package com.gazman.strategy_of_battle.alien
{
	import com.gazman.strategy_of_battle_package.map.Map;
	import com.gazman.strategy_of_battle_package.units.ICommanderController;
	import com.gazman.strategy_of_battle_package.units.IUnitController;
	import com.gazman.strategy_of_battle_package.units.enums.UnitEnum;
	
	public class PacmanCommander implements ICommanderController
	{
		private static const GATHER:String = "Gather";
		private static const ADVANCE:String = "Advance";
		
		private var gathering:Boolean;
		
		public function summon(map:Map, summonsLeft:int):String
		{
			if (Math.random() < 0.2) {
				return UnitEnum.SHAMAN;		
			}
			if(Math.random() > 0.5){
				return UnitEnum.ARCHER;
			}
			return UnitEnum.KNIGHT;			
		}
		
		public function playTurn(map:Map):void
		{
			// Doing nothing in this implamintation
		}
		
		public function summonShaman():IUnitController
		{
			return new PacHealer();
		}
		
		public function summonArcher():IUnitController
		{
			return new PacFighter(this);
		}
		
		public function summonKnight():IUnitController
		{
			return new PacFighter(this);
		}
		
		public function getUserOptions():Array
		{
			return [GATHER, ADVANCE];
		}
		
		public function handleOption(option:String):void
		{
			switch(option){
				case GATHER:
					gathering = true;
					break;
				case ADVANCE:
					gathering = false;
					break;
			}
		}
		
		public function isGathering():Boolean
		{	return gathering;
		}
	}
}