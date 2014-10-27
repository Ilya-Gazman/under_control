package com.gazman.strategy_of_battle.preloader.controller
{
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.preloader.tasks.LoadResources;
	import com.gazman.strategy_of_battle.preloader.tasks.MinemumTimeTask;
	import com.gazman.ui.screens.signals.root_created.IRootCratedSignal;
	import com.gazman.strategy_of_battle.preloader.model.PreloaderModel;
	import com.gazman.strategy_of_battle.preloader.model.Task;
	
	public class PreloaderController implements IRootCratedSignal
	{
		private var tasksModel:PreloaderModel = inject(PreloaderModel);
		
		public function PreloaderController() 
		{
			super();
		}
		
		public function rootCratedHandler():void
		{
			tasksModel.addTask(inject(MinemumTimeTask));
			tasksModel.addTask(inject(LoadResources));
			for each (var task:Task in tasksModel.tasks) 
			{
				task.excecute();	
			}
		}
	}
}