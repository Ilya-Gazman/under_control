package com.gazman.strategy_of_battle.battle.view.units.animations 
{
	import com.gazman.strategy_of_battle.battle.view.units.Animation;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class TakeDamageAnimation extends Animation 
	{
		static public const TYPE:String = "takeDamageAnimation";
		public function TakeDamageAnimation() 
		{
			super(TYPE);
		}
		public function init(dmg:int):void 
		{
			var tween1:Tween = buildTween(0.45, Transitions.EASE_IN);
			tween1.delay = 0.15;
			var scaleRatio:Number = 0.7;
			tween1.animate("width", target.width * scaleRatio);
			tween1.animate("height", target.height * scaleRatio);
			
			var tween2:Tween =  buildTween(0.45, Transitions.EASE_OUT);
			tween2.animate("width", target.width);
			tween2.animate("height", target.height);
			
			addTweens(tween1, tween2);
		}
	}
}