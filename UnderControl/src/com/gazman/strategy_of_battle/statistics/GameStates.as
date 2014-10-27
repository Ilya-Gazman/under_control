package com.gazman.strategy_of_battle.statistics 
{
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class GameStates extends JsonSerializer 
	{
		public var summons:int = 0;
		public var misses:int = 0;
		public var attacks:int = 0;
		public var kills:int = 0;
		public var moves:int = 0;
		public var skips:int = 0;
		
		public function reset():void 
		{
			summons = 0;
			misses = 0;
			attacks = 0;
			kills = 0;
			moves = 0;
			skips = 0;	
		}
	}

}