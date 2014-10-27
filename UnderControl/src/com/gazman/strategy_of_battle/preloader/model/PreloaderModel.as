package com.gazman.strategy_of_battle.preloader.model
{
	import com.gazman.life_cycle.ISingleTon;

	public class PreloaderModel implements ISingleTon
	{
		public const tasks:Vector.<Task> = new Vector.<Task>();
		
		public function PreloaderModel() 
		{
			super();
		}
		
		public function addTask(task:Task):void{
			tasks.push(task);
		}
		
		public function getProgress():Number{
			var totalProgress:Number = 0;
			for (var i:int = 0; i < tasks.length; i++) 
			{
				totalProgress += tasks[i].progress;
			}
			
			var progress:Number = totalProgress / tasks.length;
			var roundValue:int = 1000;
			progress = Math.round(progress * roundValue) / roundValue;
			
			return Math.min(1, progress);
		}
	}
}