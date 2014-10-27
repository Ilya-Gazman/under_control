package com.gazman.strategy_of_battle.preloader.tasks.signals 
{
	import com.gazman.life_cycle.Signal;
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class ResourceLoadedSignal extends Signal implements IResourceLoadedSignal
	{
		
		public function resourceLoadedHandler():void {
			dispatch(arguments);
		}
		
	}

}