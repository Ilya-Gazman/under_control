package com.gazman.strategy_of_battle.maps
{
	import com.gazman.life_cycle.ISingleTon;

	public class Maps implements ISingleTon
	{
		private var maps:Array = ["classic"];
		
		public function Maps() 
		{
			super();
		}
		
		public function getRandomMap():String{
			return maps[int(Math.random() * maps.length)];
		}
	}
}