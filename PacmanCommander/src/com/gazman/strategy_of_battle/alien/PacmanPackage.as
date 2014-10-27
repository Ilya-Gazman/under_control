package com.gazman.strategy_of_battle.alien 
{
	import com.gazman.strategy_of_battle_package.CommanderPackage;
	import com.gazman.strategy_of_battle_package.resources.ResourcesPackage;
	import com.gazman.strategy_of_battle_package.units.ICommanderController;
	
	public class PacmanPackage extends CommanderPackage
	{
		override protected function createNewCommander():ICommanderController
		{
			return new PacmanCommander();
		}
		
		override public function getFullNameAndTitle():String
		{
			return "Gazl from planat Rok";
		}
		
		override public function getResources():ResourcesPackage
		{
			return super.getResources(); // using default
		}	
	}
}