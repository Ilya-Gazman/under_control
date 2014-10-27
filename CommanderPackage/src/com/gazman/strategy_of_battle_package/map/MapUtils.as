package com.gazman.strategy_of_battle_package.map
{
	import flash.geom.Point;

	public final class MapUtils
	{
		public static function isInRange(myLocation:Point, targetLocation:Point, attackRange:int):Boolean{
			var deltaX:int = myLocation.x - targetLocation.x;
			var deltaY:int = myLocation.y - targetLocation.y;
			var distance:int = Math.sqrt(deltaX * deltaX + deltaY * deltaY);
			return distance <= attackRange;
		}
	}
}