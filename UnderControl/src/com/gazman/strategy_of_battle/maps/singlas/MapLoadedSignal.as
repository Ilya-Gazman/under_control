package com.gazman.strategy_of_battle.maps.singlas
{
	import com.gazman.life_cycle.Signal;
	import com.gazman.strategy_of_battle.maps.MapLoader;
	
	public class MapLoadedSignal extends Signal implements IMapLoadedSignal
	{
		public function mapLoadedHandler(mapLoader:MapLoader):void
		{
			dispatch(arguments);
		}
	}
}