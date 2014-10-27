package com.gazman.strategy_of_battle.battle.model.animation_queue
{
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.battle.model.animation_queue.signals.AnimationFinishedSignal;

	public class AnimationQue implements ISingleTon
	{
		private var animationsFinishedSignal:AnimationFinishedSignal = inject(AnimationFinishedSignal);
		private var animations:int;
		
		public function AnimationQue() 
		{
			super();
		}
		
		public function add():void{
			animations++;
		}
		
		public function remove():void{
			animations--;
			if(animations == 0){
				animationsFinishedSignal.animationsFinishedHandler();
			}
		}
		
		public function isEmpty():Boolean{
			return animations <= 0;
		}
	}
}