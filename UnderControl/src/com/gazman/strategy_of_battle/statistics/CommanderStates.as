package com.gazman.strategy_of_battle.statistics 
{
	import com.gazman.life_cycle.inject;
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class CommanderStates extends JsonSerializer
	{
		private static const DELTA_LEVEL:int = 19;
		private static const X:Number = 1.8;
		private static const Y:int = 5;
		
		public var lastGame:GameStates = inject(GameStates);
		public var total:GameStates = inject(GameStates);
		public var wins:int = 0;
		public var loses:int = 0;
		private var loaded:Boolean = false;
		
		override public function setKeys(coockieKey:String, valueKey:String = null):void 
		{
			super.setKeys(coockieKey, valueKey);
			lastGame.setKeys(coockieKey, "lastGame");
			total.setKeys(coockieKey, "total");
		}
		
		override public function save():void {
			super.save();
			lastGame.save();
			total.save();
		}
		
		override public function load():void {
			if (loaded) {
				return;
			}
			loaded = true;
			super.load();
			lastGame.load();
			total.load();
		}
		
		/**
		 * @return level with decimal number as the progress for the next level
		 */
		public function getLevel(experiance:Number = -1):Number {
			var _experiance:int = experiance != -1 ? experiance : calculateExperiance(total);
					
			var currentLevel:int = getLevelByExperiance(_experiance);
			var currentLevelExperiance:int = getExperiaceForLevel(currentLevel);
			var experianceForNextLevel:int = getExperiaceForLevel(currentLevel + 1);
			var progress:Number = (_experiance - currentLevelExperiance) / (experianceForNextLevel - currentLevelExperiance);
			
			return currentLevel + progress;
		}
		
		private function calculateExperiance(state:GameStates):int {
			return state.misses * 1 +
					state.moves / 10 +
					state.summons * 2 +
					state.attacks * 4 +
					state.kills * 8 + getExperiaceForLevel(1);
		}
		
		private function getExperiaceForLevel(level:int):int {
			return Math.pow(level + DELTA_LEVEL, X) * Y;
		}
		
		private function getLevelByExperiance(experiance:int):int {
			return Math.pow(experiance / Y, 1 / X) - DELTA_LEVEL - 1;
		}
		
		public function applyLastGame():void 
		{
			trace("Eaned points", calculateExperiance(lastGame) - getExperiaceForLevel(1));
			total.attacks += lastGame.attacks;
			total.kills += lastGame.kills;
			total.misses += lastGame.misses;
			total.moves += lastGame.moves;
			total.skips += lastGame.skips;
			total.summons += lastGame.summons;
			lastGame.reset();
			save();
		}
	}
}