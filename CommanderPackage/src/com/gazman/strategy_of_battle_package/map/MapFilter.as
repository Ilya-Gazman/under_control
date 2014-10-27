package com.gazman.strategy_of_battle_package.map
{
	import flash.geom.Point;
	
	/**
	 * Implementing a path finding algorithm(Similar to A* search only there is no known target) to calculate the shortest path to each cell on the map.
	 * Once calculation is complete the information will be available at cellsMap. Each cell is a number representing the
	 * number of steps required to get to that location. Enemies and Allies will be represented with negative distance. Also the enemy and Allys
	 * coordination collections are provided. Blocked cells will have the value 0.<br><br>
	 * Worth case and best case efficiency is O(N) where N is the number of cells.
	 */
	public class MapFilter
	{
		private static const PULL:Vector.<MapFilter> = new Vector.<MapFilter>();
		public var cellsMap:Vector.<Vector.<int>>;
		public var allies:Vector.<Point>;
		public var enemies:Vector.<Point>;
		private static const stack:Vector.<MapFilter> = new Vector.<MapFilter>();
		private var map:Map;
		private var x:int;
		private var y:int;
		private var count:int;
		private var commander:String;
		private var filtered:Boolean;
		
		public function filter(map:Map, myLocation:Point, commander:String):void{
			filtered = true;
			this.commander = commander;
			this.map = map;
			this.x = myLocation.x;
			this.y = myLocation.y;
			init();
			cellsMap[x][y] = 1;
			execute();
			while(stack.length > 0){
				//trace(this);
				var length:int = stack.length;
				for(var i:int = 0; i < length; i++){
					var mapFilter:MapFilter = stack.shift();
					mapFilter.execute();
					PULL.push(mapFilter);
				}
			}
		}
		
		public function findNearestAlly():Point
		{
			return findNearestUnit(allies);
		}
		
		public function findNearestEnemy():Point
		{
			return findNearestUnit(enemies);
		}
		
		private function findNearestUnit(units:Vector.<Point>):Point{
			validate();
			var minDistance:int = int.MAX_VALUE;
			var nearestUnit:Point;
			for each(var unit:Point in units){
				var distance:int = Math.abs(cellsMap[unit.x][unit.y]);
				if(distance < minDistance){
					minDistance = distance;
					nearestUnit = unit;
				}
			}
			return nearestUnit;
		}
		
		public function navigateTo(location:Point):Point{
			validate();
			var position:int = Math.abs(cellsMap[location.x][location.y]);
			if(position == 0){
				throw new Error("Target unreachable");
			}
			while(position > 2){
				if(canNavigateTo(position, location.x + 1, location.y)){
					location.x++;
				}
				else if(canNavigateTo(position, location.x - 1, location.y)){
					location.x--;
				}
				else if(canNavigateTo(position, location.x, location.y + 1)){
					location.y++;
				}
				else if(canNavigateTo(position, location.x, location.y - 1)){
					location.y--;
				}
				position = cellsMap[location.x][location.y];
			}
			
			return location;
			throw new Error("Unexpected filtering error");
		}
		
		private function validate():void
		{
			if(!filtered){
				throw new Error("Must filter before navigating");
			}
		}
		
		private function canNavigateTo(position:int, targetX:int, targetY:int):Boolean
		{
			return isInMapRange(targetX, targetY) && cellsMap[targetX][targetY] < position && cellsMap[targetX][targetY] > 0;
		}
		
		private function execute():void
		{
			populate(x + 1, y);
			populate(x - 1, y);
			populate(x, y + 1);
			populate(x, y - 1);
		}
		
		private function isInMapRange(x:int, y:int):Boolean{
			return x < cellsMap.length && 
				x >= 0 &&
				y < cellsMap[0].length && 
				y >= 0;
		}
		
		private function populate(x:int, y:int):void
		{
			if(!isInMapRange(x,y) ||
				cellsMap[x][y] != 0 ||
				map.isBlocked(x,y)){
				return;
			}
			
			// we already checked that is not block
			// checking if there units
			if(map.isEmpty(x,y)){
				cellsMap[x][y] = count;
				addTask(x,y);
			}
			else{
				cellsMap[x][y] = -count;
				if(map.isAlly(x,y, commander)){
					allies.push(new Point(x,y));
				}
				else {
					enemies.push(new Point(x,y));
				}
			}
		}
		
		private function addTask(x:int, y:int):void
		{
			var mapFilter:MapFilter = PULL.pop();
			if(mapFilter == null){
				mapFilter = new MapFilter();
			}
			
			mapFilter.commander = commander;
			mapFilter.map = map;
			mapFilter.cellsMap = cellsMap;
			mapFilter.allies = allies;
			mapFilter..enemies = enemies;
			mapFilter.count = count + 1;
			mapFilter.x = x;
			mapFilter.y = y;
			stack.push(mapFilter);
		}
		
		private function init():void
		{
			cellsMap = new Vector.<Vector.<int>>();
			for(var i:int = 0; i < map.width;i++){
				cellsMap.push(new Vector.<int>);
				for(var j:int = 0; j < map.height;j++){
					cellsMap[i].push(0);
				}
			}	
			allies = new Vector.<Point>();
			enemies = new Vector.<Point>();
			count = 2;
		}
		
		public function toString():String{
			var log:String = "------------------------------------\n";
			for(var x:int = 0; x< cellsMap.length; x++ ){
				for(var y:int = 0; y< cellsMap[x].length; y++ ){
					var cell:String = cellsMap[x][y].toString();
					if(cell.length == 1){
						cell += " ";
					}
					log += cell + " ";
				}
				log += "\n";
			}
			return log;
		}
	}
}