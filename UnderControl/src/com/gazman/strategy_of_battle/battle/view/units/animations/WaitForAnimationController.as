package com.gazman.strategy_of_battle.battle.view.units.animations 
{
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.battle.controller.signals.GameOverSignal;
	import com.gazman.strategy_of_battle.battle.controller.signals.IGameOverSignal;
	import com.gazman.strategy_of_battle.battle.model.unit.signals.animation_complete.IAnimationCompleteSignal;
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;
	import com.gazman.strategy_of_battle.battle.view.units.Animation;
	import com.gazman.strategy_of_battle.battle.view.units.UnitView;
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class WaitForAnimationController implements IAnimationCompleteSignal
	{
		private var animation:Animation;
		private var unitView:UnitView;
		private var unitModel:UnitModel;
		
		public function WaitForAnimationController() 
		{
			super();
		}
		
		public function init(unitModel:UnitModel, unitView:UnitView, animation:Animation):void {
			this.unitModel = unitModel;
			this.unitView = unitView;
			this.animation = animation;
		}
		
		public function waitFor(type:String):Boolean {
			if (!unitModel.currentAnimation || unitModel.currentAnimation == type) {
				return false;
			}
			
			unitModel.signal_animationComplete.addListener(this);
			
			return true;
		}
		
		public function animationCompleteHandler():void 
		{
			unitView.addAnimation(animation);
			unitModel.signal_animationComplete.removeListener(this);
		}
	}

}