package com.gazman.strategy_of_battle.utils
{
	public class ArrayUtils
	{
		public static function shuffle(target:*):void{
			target.sort(shuffleVector);
		}
		
		private static function shuffleVector( a:Object, b:Object ):int
		{
			return Math.floor( Math.random() * 3 - 1 );
		}
	}
}