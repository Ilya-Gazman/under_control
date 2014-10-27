package com.gazman.strategy_of_battle.battle.view.units.animations
{
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;
	import com.gazman.strategy_of_battle.battle.view.units.Animation;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.utils.deg2rad;
	
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class MissAnimation extends Animation
	{
		private var waitForAnimation:WaitForAnimationController = inject(WaitForAnimationController);
		private var targetModel:UnitModel;
		static public const TYPE:String = "missAnimation";
		
		public function MissAnimation()
		{
			super(TYPE);
		}
		
		public function init(targetModel:UnitModel, x:int, y:int):void
		{
			this.targetModel = targetModel;
			waitForAnimation.init(targetModel, target, this);
			
			var tween1:Tween = buildTween(0.5, Transitions.EASE_IN);
			tween1.animate("x", x * cellWidth + deltaX);
			tween1.animate("y", y * cellHeight + deltaY);
			
			var tween2:Tween = buildTween(0.5, Transitions.LINEAR);
			tween2.animate("rotation", deg2rad(360));
			
			var tween3:Tween = buildTween(0.5, Transitions.EASE_OUT);
			tween3.moveTo(this.target.x, this.target.y);
			
			addTweens(tween1, tween2, tween3);
		}
		
		override public function start():Boolean
		{
			//if (!waitForAnimation.waitFor(TakeDamageAnimation.TYPE))
			{
				return super.start();
			}
		}
	
	}

}