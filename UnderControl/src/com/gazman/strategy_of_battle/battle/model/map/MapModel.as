package com.gazman.strategy_of_battle.battle.model.map
{
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.strategy_of_battle.battle.model.BattleModel;
	import com.gazman.strategy_of_battle.battle.model.map.signals.UnitAddedSignal;
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;
	import com.gazman.strategy_of_battle.maps.MapData;
	import com.gazman.strategy_of_battle_package.map.Cell;
	import com.gazman.strategy_of_battle_package.map.Map;
	
	import flash.geom.Point;
	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	
	public class MapModel implements ISingleTon
	{
		private var cells:Vector.<Vector.<CellModel>>;
		private var map:Map;
		private var unitsMap:Dictionary;
		private var battleModel:BattleModel = inject(BattleModel);
		private var lions:Vector.<UnitModel> = new Vector.<UnitModel>();
		private var unitAddedSignal:UnitAddedSignal = inject(UnitAddedSignal);
		private var sharedObject:SharedObject = SharedObject.getLocal("map_model");
		private var mapData:MapData;
		
		public function MapModel() 
		{
			super();
		}
		
		public function setMap(mapData:MapData):void
		{
			this.mapData = mapData;
			unitsMap = new Dictionary();
			initCells();
		}
		
		public function save(mapName:String):void{
			sharedObject.data.mapName = mapName;
			sharedObject.flush();
		}
		
		private function initCells():void
		{
			var x:int;
			var y:int;
			cells = new Vector.<Vector.<CellModel>>();
			for(x = 0; x < Map.WIDTH; x++){
				cells.push(new Vector.<CellModel>());
				for(y = 0; y < Map.HEIGHT; y++){
					var cell:CellModel = inject(CellModel);
					cells[x].push(cell);
				}
			}
			
			for(var i:int = 0; i < mapData.rocks.length; i++){
				cells[mapData.rocks[i].x][mapData.rocks[i].y].blocked = true;
			}
		}
		
		public function addUnit(unit:UnitModel):void{
			unitAddedSignal.unitAddedHandler(unit);
			
			var x:int;
			var y:int;
			var collection:Vector.<Point>;
			
			if(unit.commander == battleModel.myCommander){
				collection = mapData.commander1;
			}
			else if(unit.commander == battleModel.enemyCommander){
				collection = mapData.commander2;
			}
			else{
				collection = mapData.lions;
			}
			
			var index:int = Math.random() * collection.length;
			x = collection[index].x - 1;
			y = collection[index].y - 1;
			
			if(!tryPlacingUnit(x,y,unit)){
				searchForPlace(x, y, unit);
			}
		}
		
		public function loadUnit(unit:UnitModel):void{
			unitAddedSignal.unitAddedHandler(unit);
			var x:int = sharedObject.data[unit.id + "x"];
			var y:int = sharedObject.data[unit.id + "y"];
			if (!tryPlacingUnit(x,y,unit)){
				sharedObject.clear();
				throw new Error("Fail loading data");
			}
		}
		
		private function searchForPlace(x:int, y:int, unit:UnitModel):void
		{
			var deltaX:int;
			var deltaY:int;
			var i:int;
			
			for(var delta:int = 1; delta < Map.WIDTH / 2; delta++){
				deltaX = x - delta;
				for(i = 0; i < delta * 2 + 1; i++){
					deltaY = y - delta + i;
					if(tryPlacingUnit(deltaX,deltaY, unit)){
						return;
					}
				}
				
				deltaX = x + delta;
				for(i = 0; i < delta * 2 + 1; i++){
					deltaY = y - delta + i;
					if(tryPlacingUnit(deltaX,deltaY, unit)){
						return;
					}
				}
				
				deltaY = y - delta;
				for(i = 1; i < delta * 2; i++){
					deltaX = x - delta + i;
					if(tryPlacingUnit(deltaX,deltaY, unit)){
						return;
					}
				}
				
				deltaY = y + delta;
				for(i = 1; i < delta * 2; i++){
					deltaX = x - delta + i;
					if( tryPlacingUnit(deltaX,deltaY, unit)){
						return;
					}
				}
			}
		}
		
		private function tryPlacingUnit(x:int,y:int,unit:UnitModel):Boolean{
			if(isAvailable(x,y)){
				cells[x][y].unit = unit;
				unitsMap[unit] = injectWithParams(Point, [x, y]);
				unit.notifyMove(x,y);
				sharedObject.data[unit.id + "x"] = x;
				sharedObject.data[unit.id + "y"] = y;
				sharedObject.flush();
				return true;
			}
			
			return false;
		}
		
		private function isAvailable(x:int,y:int):Boolean{
			if(x >= Map.WIDTH || x < 0){
				return false;
			}
			if(y >= Map.HEIGHT || y < 0){
				return false;
			}
			var cell:CellModel = cells[x][y];
			if(cell.blocked){
				return false;
			}
			if(cell.unit != null){
				return false;
			}
			return true;
		}
		
		public function buildMap():void{
			var cells:Vector.<Vector.<Cell>> = new Vector.<Vector.<Cell>>();
			for(var i:int = 0; i < Map.WIDTH; i++){
				cells.push(new Vector.<Cell>());
				for(var j:int = 0; j < Map.HEIGHT; j++){
					var unit:UnitModel = this.cells[i][j].unit;
					var cell:Cell = inject(Cell);
					cell.commander = unit != null ? unit.commander.name : null;
					cell.isBlocked = this.cells[i][j].blocked;
					cells[i].push(cell);
				}
			}
			map = injectWithParams(Map, [cells]);
		}
		
		public function getMap():Map{
			return map;
		}
		
		public function getUnitAt(detination:Point):UnitModel
		{
			return cells[detination.x][detination.y].unit;
		}
		
		public function getPreviousUnitAt(detination:Point):UnitModel
		{
			return cells[detination.x][detination.y].previouseUnit;
		}
		
		private function getCell(x:int, y:int):CellModel
		{
			if(x < Map.WIDTH && y < Map.HEIGHT){
				return cells[x][y];
			}
			return null;
		}
		
		public function move(unit:UnitModel, destination:Point):void
		{
			var point:Point = unitsMap[unit];
			if(point == null){
				throw new Error("Unit is not on the map");
			}
			
			if (isAvailable(destination.x, destination.y)){
				cells[point.x][point.y].unit = null;
				if(!tryPlacingUnit(destination.x, destination.y, unit)){
					throw new Error("How did that happaned?");
				}
			}
		}
		
		public function getUnitLocation(unit:UnitModel):Point
		{
			return unitsMap[unit];
		}
		
		public function isBlocked(destination:Point):Boolean
		{
			return cells[destination.x][destination.y].blocked;
		}
		
		public function removeUnit(unit:UnitModel):void
		{
			var location:Point = getUnitLocation(unit);
			cells[location.x][location.y].unit = null;
			delete unitsMap[unit];
		}
		
		public function getMapName():String
		{
			return sharedObject.data.mapName;
		}
	}
}