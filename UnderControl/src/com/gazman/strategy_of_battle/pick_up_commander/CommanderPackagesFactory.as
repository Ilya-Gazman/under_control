package com.gazman.strategy_of_battle.pick_up_commander
{
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.strategy_of_battle.alien.PacmanPackage;
	import com.gazman.strategy_of_battle_package.CommanderPackage;
	

	public class CommanderPackagesFactory implements ISingleTon
	{
		private var commanders:Array = [
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
			PacmanPackage,
		];
		
		public function CommanderPackagesFactory() 
		{
			super();
		}
		
		public function createRandomPackage():CommanderPackage{
			return commanders[Math.random() * commanders.length];
		}
		
		public function getAll():Array{
			var commanders:Array = new Array();
			for each(var commander:Class in this.commanders){
				commanders.push(inject(commander));
			}
			
			return commanders;
		}
	}
}