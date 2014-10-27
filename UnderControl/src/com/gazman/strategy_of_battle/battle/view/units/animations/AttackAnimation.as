package com.gazman.strategy_of_battle.battle.view.units.animations
{
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.battle.model.unit.signals.animation_complete.IAnimationCompleteSignal;
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;
	import com.gazman.strategy_of_battle.battle.view.units.Animation;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class AttackAnimation extends Animation
	{
		private var waitForAnimation:WaitForAnimationController = inject(WaitForAnimationController);
		private var targetModel:UnitModel;
		private var damage:int;
		static public const TYPE:String = "attackAnimation";
		
		public function AttackAnimation()
		{
			super(TYPE);
		}
		
		public function init(targetModel:UnitModel, damage:int, x:Number, y:Number):void
		{
			this.damage = damage;
			this.targetModel = targetModel;
			waitForAnimation.init(targetModel, target, this);
			var tween1:Tween = buildTween(0.5, Transitions.EASE_IN);
			tween1.animate("x", x * cellWidth + deltaX);
			tween1.animate("y", y * cellHeight + deltaY);
			
			var tween2:Tween = buildTween(0.5, Transitions.EASE_OUT);
			tween2.moveTo(target.x, target.y);
			
			addTweens(tween1, tween2);
		}
		
		override public function start():Boolean
		{
			if (!waitForAnimation.waitFor(TakeDamageAnimation.TYPE))
			{
				targetModel.notifyDamage(damage);
				return super.start();
			}
			if (nextAnimation)
			{
				return nextAnimation.start();
			}
			return false;
		}
	}
}