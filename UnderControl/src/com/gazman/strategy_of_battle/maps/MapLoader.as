package com.gazman.strategy_of_battle.maps
{
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.battle.view.units.UnitView;
	import com.gazman.strategy_of_battle.maps.singlas.MapLoadedSignal;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import starling.utils.AssetManager;

	public class MapLoader
	{
		private var mapLoadedSignal:MapLoadedSignal = inject(MapLoadedSignal);
		public var mapData:MapData = inject(MapData);
		public var assetManager:AssetManager = inject(AssetManager);

		public function MapLoader() 
		{
			super();
		}
		
		public function load(mapName:String):void{
			var applicationDirectory:File = File.applicationDirectory;
			var mapLoaction:File = applicationDirectory.resolvePath("assets/maps/" + mapName);
			loadBackground(mapLoaction);
			loadMap(mapLoaction);
		}
		
		private function loadBackground(mapLoaction:File):void
		{
			assetManager.enqueue(mapLoaction.resolvePath("sprites.jpg"));
			assetManager.enqueue(mapLoaction.resolvePath("sprites.xml"));
			assetManager.loadQueue(onProgress);
		}
		
		private function onProgress(progress:Number):void
		{
			if(progress == 1){
				mapLoadedSignal.mapLoadedHandler(this);
			}
		}
		
		private function loadMap(mapLoaction:File):void
		{
			var fileStream:FileStream = new FileStream();
			fileStream.open(mapLoaction.resolvePath("mapData.xml"),FileMode.READ);
			var mapData:XML = fileStream.readObject();
			fileStream.close();
			parseMap(mapData);
		}
		
		private function parseMap(data:XML):void
		{
			mapData.enemyCommanderIcon.x = data.redPumkin.x;
			mapData.enemyCommanderIcon.y = data.redPumkin.y;
			mapData.myCommanderIcon.x = data.greenPumkin.x;
			mapData.myCommanderIcon.y = data.greenPumkin.y;
			
			mapData.setCommander1(data.commander1..cell);
			mapData.setCommander2(data.commander2..cell);
			mapData.setLions(data.lions..cell);
			mapData.setRocks(data.rocks..cell);
		}
	}
}