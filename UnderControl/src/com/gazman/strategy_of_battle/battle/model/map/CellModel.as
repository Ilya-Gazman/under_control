package com.gazman.strategy_of_battle.battle.model.map
{
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;

	public class CellModel
	{
		public var blocked:Boolean;
		private var _unit:UnitModel;
		private var _previuseUnit:UnitModel;

		public function CellModel() 
		{
			super();
		}
		
		public function get previouseUnit():UnitModel
		{
			return _previuseUnit;
		}

		public function get unit():UnitModel
		{
			return _unit;
		}

		public function set unit(value:UnitModel):void
		{
			_previuseUnit = _unit;
			_unit = value;
		}

	}
}