package com.gazman.strategy_of_battle.maps.singlas
{
	import com.gazman.strategy_of_battle.maps.MapLoader;

	public interface IMapLoadedSignal
	{
		function mapLoadedHandler(mapLoader:MapLoader):void;
	}
}