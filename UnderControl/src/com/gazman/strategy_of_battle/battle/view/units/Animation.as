package com.gazman.strategy_of_battle.battle.view.units {
	import adobe.utils.CustomActions;
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.strategy_of_battle.battle.model.animation_queue.AnimationQue;
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;
	import com.gazman.strategy_of_battle.battle.view.GameJuggler;
	import com.gazman.ui.group.Group;
	import starling.animation.Tween;
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class Animation 
	{
		public var onComplete:Function;
		public var cellWidth:int;
		public var cellHeight:int;
		public var deltaX:int;
		public var deltaY:int;
		public var target:UnitView;
		public var onStart:Function;
		public var nextAnimation:Animation;
		private var _isRunning:Boolean;
		public var unitModel:UnitModel;
		
		private var gameJuggler:GameJuggler = inject(GameJuggler);
		private var animationQue:AnimationQue = inject(AnimationQue);
		private var tweens:Vector.<Tween> = new Vector.<Tween>();
		private var _type:String;
		
		public function Animation(type:String) {
			_type = type;
		}
		
		public function addTweens(...tweens):void {
			for (var i:int = 0; i < tweens.length - 1; i++) {
				var tween1:Tween = tweens[i];
				var tween2:Tween = tweens[i + 1];
				tween1.nextTween = tween2;
			}
			
			if (this.tweens.length > 0) {
				this.tweens[this.tweens.length - 1].nextTween = tweens[0];
			}
			
			this.tweens.push.apply(tweens, tweens);
		}
		
		public function start():Boolean {
			if (tweens.length == 0) {
				throw new Error("No tweens been added");
			}
			if (onStart != null) {
				onStart();
			}
			tweens[tweens.length - 1].onComplete = onCompleteHandler;
			gameJuggler.add(tweens[0]);
			animationQue.add();
			_isRunning = true;
			unitModel.currentAnimation = type;
			
			return true;
		}
		
		protected function buildTween(time:Number, transition:Object="linear"):Tween {
			return injectWithParams(Tween, [target, time, transition]);
		}
		
		private function onCompleteHandler():void {
			_isRunning = false;
			if (this.onComplete != null) {
				onComplete();
			}
			if (nextAnimation == null || !nextAnimation.start()) {
				unitModel.currentAnimation = null;
			}
			animationQue.remove();
		}
		
		public function get isRunning():Boolean 
		{
			return _isRunning;
		}		
		
		public function get type():String 
		{
			return _type;
		}
	}
}