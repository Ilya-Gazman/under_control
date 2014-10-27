package com.gazman.strategy_of_battle.battle.view.units.animations 
{
	import com.gazman.strategy_of_battle.battle.view.units.Animation;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class RemoveYourSelfAnimation extends Animation 
	{
		static public const TYPE:String = "removeYourSelfAnimation";
		public function RemoveYourSelfAnimation() 
		{
			super(TYPE);
		}
		
		public function init():void 
		{
			var tween:Tween =  buildTween(1, Transitions.EASE_IN);
			tween.animate("width", target.width * 0.5);
			tween.animate("height", target.height * 0.5);
			tween.fadeTo(0);
			addTweens(tween);
		}
		
	}

}