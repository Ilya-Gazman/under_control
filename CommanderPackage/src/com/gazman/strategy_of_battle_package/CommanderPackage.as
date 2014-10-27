package com.gazman.strategy_of_battle_package
{
	import com.gazman.strategy_of_battle_package.errors.NotImplementedError;
	import com.gazman.strategy_of_battle_package.resources.ResourcesPackage;
	import com.gazman.strategy_of_battle_package.units.ICommanderController;

	public class CommanderPackage
	{
		private var commander:ICommanderController;
		public final function getCommander():ICommanderController{
			if(commander == null){
				commander = createNewCommander();
			}
			return commander;
		}
		
		protected function createNewCommander():ICommanderController
		{
			throw new NotImplementedError();
		}
		
		/**
		 * Will be used as your commander name for the user. Default is Dark Knight
		 */
		public function getFullNameAndTitle():String{
			throw new NotImplementedError();
		}
		
		public function getResources():ResourcesPackage{
			return new ResourcesPackage();
		}
	}
}