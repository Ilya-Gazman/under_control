package com.gazman.strategy_of_battle_package.units.data
{
	public class UnitStates
	{
		protected var _stamina:int;
		protected var _moveCost:int;
		protected var _skipCost:int = 1;
		protected var _attackCost:int;
		protected var _type:String;
		protected var _range:int;
		protected var _life:int;
		protected var _dmg:int;
		protected var _maxLevel:int = 15;

		public function get type():String
		{
			return _type;
		}

		public function get maxLevel():int
		{
			return _maxLevel;
		}

		public function get dmg():int
		{
			return _dmg;
		}

		public function get life():int
		{
			return _life;
		}

		public function get range():int
		{
			return _range;
		}

		public function get attackCost():int
		{
			return _attackCost;
		}

		public function get skipCost():int
		{
			return _skipCost;
		}

		public function get moveCost():int
		{
			return _moveCost;
		}

		public function get stamina():int
		{
			return _stamina;
		}

	}
}