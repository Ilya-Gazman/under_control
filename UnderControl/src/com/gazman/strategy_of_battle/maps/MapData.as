package com.gazman.strategy_of_battle.maps
{
	import flash.geom.Point;

	public class MapData
	{
		public var enemyCommanderIcon:Point = new Point();
		public var myCommanderIcon:Point = new Point();
		
		private var _commander1:Vector.<Point> = new Vector.<Point>();
		private var _commander2:Vector.<Point> = new Vector.<Point>();
		private var _lions:Vector.<Point> = new Vector.<Point>();
		private var _rocks:Vector.<Point> = new Vector.<Point>();
		
		public function MapData() 
		{
			super();
		}
		
		public function get rocks():Vector.<Point>
		{
			return _rocks;
		}

		public function get lions():Vector.<Point>
		{
			return _lions;
		}

		public function get commander2():Vector.<Point>
		{
			return _commander2;
		}

		public function get commander1():Vector.<Point>
		{
			return _commander1;
		}

		public function setCommander1(cells:XMLList):void
		{
			parseCells(cells, commander1);
		}
		
		public function setCommander2(cells:XMLList):void
		{
			parseCells(cells, commander2);
		}
		
		public function setLions(cells:XMLList):void
		{
			parseCells(cells, lions);
		}
		
		public function setRocks(cells:XMLList):void
		{
			parseCells(cells, rocks);
		}
		
		private function parseCells(cells:XMLList, output:Vector.<Point>):void
		{
			for each (var cell:XML in cells){
				var point:Point = new Point();
				point.x = cell.x;
				point.y = cell.y;
				output.push(point);
			}
		}
	}
}