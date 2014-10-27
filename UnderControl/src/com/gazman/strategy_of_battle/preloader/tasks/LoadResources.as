package com.gazman.strategy_of_battle.preloader.tasks
{
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.battle.model.Resources;
	import com.gazman.strategy_of_battle.loading_popup.singals.loading_complete.LoadingCompleteSignal;
	import com.gazman.strategy_of_battle.preloader.model.Task;
	import com.gazman.strategy_of_battle.preloader.tasks.signals.ResourceLoadedSignal;
	
	import assets.game.StaticAssets;
	
	public class LoadResources extends Task
	{
		private var resources:Resources = inject(Resources);
		private var resourceLoadedSignal:ResourceLoadedSignal = inject(ResourceLoadedSignal);
		
		public function LoadResources() 
		{
			super();
		}
		
		override public function excecute():void
		{
			resources.enqueue(StaticAssets);
			resources.loadQueue(onProgress);
		}
		
		private function onProgress(progress:Number):void
		{
			this.progress = progress;
			if (progress == 1) {
				resourceLoadedSignal.resourceLoadedHandler();
			}
		}
	}
}