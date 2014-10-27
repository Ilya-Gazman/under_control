package com.gazman.strategy_of_battle.battle.view.units.animations 
{
	import com.gazman.strategy_of_battle.battle.view.units.Animation;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class MoveAnimation extends Animation 
	{
		static public const TYPE:String = "moveAnimation";
		public function MoveAnimation() 
		{
			super(TYPE);
		}
		
		public function init(x:int, y:int):void 
		{
			var tween:Tween =  buildTween(1, Transitions.EASE_OUT);
			tween.animate("x", x * cellWidth + deltaX);
			tween.animate("y", y * cellHeight + deltaY);
			
			addTweens(tween);
		}
		
		
		
	}

}