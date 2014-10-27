package com.gazman.strategy_of_battle_package.map
{
	public class Cell
	{
		public var isBlocked:Boolean;
		public var commander:String;
		
		public function toString():String{
			
			return isBlockedString  + commanderString + isBlockedString;
		}
		
		private function get commanderString():String{
			return commander != null ? commander.substr(commander.length - 1, 1) : " ";
		}
		
		private function get isBlockedString():String{
			return isBlocked ? "X" : "V";
		}
	}
}