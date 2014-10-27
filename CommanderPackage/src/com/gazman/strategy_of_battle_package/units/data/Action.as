package com.gazman.strategy_of_battle_package.units.data
{
	import flash.geom.Point;

	public class Action
	{
		public var actionEnum:String;
		private var _destination:Point;

		public function get destination():Point
		{
			// Protection ;)
			return _destination.clone();
		}

		public function set destination(value:Point):void
		{
			_destination = value;
		}

	}
}