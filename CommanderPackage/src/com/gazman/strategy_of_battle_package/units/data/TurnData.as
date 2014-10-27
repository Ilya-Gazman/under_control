package com.gazman.strategy_of_battle_package.units.data
{
	import com.gazman.strategy_of_battle_package.map.Map;
	
	import flash.geom.Point;

	public class TurnData
	{
		public var map:Map;
		public var stamina:int;
		public var myCommander:String;
		public var states:UnitStates;
		public var position:Point;
	}
}