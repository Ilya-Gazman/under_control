package com.gazman.strategy_of_battle.battle.model
{
	import com.gazman.life_cycle.IInjectable;
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.battle.model.commander.Commander;
	import com.gazman.strategy_of_battle.statistics.CommanderStates;
	import com.gazman.strategy_of_battle_package.CommanderPackage;
	
	import flash.compiler.embed.EmbeddedMovieClip;
	import flash.net.SharedObject;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;

	public class BattleModel implements ISingleTon, IInjectable
	{
		public var commanderStates:CommanderStates = inject(CommanderStates);
		private var _myCommander:Commander;
		public var enemyCommander:Commander;
		private var _nextUpdate:Number = 0;
		private var _gameOver:Boolean = true;
		private var sharedObject:SharedObject = SharedObject.getLocal("battleModel");
		
		public function BattleModel() 
		{
			super();
		}
		
		public function get myCommander():Commander
		{
			return _myCommander;
		}

		public function set myCommander(value:Commander):void
		{
			_myCommander = value;
			_myCommander.isMyCommander = true;
		}

		public function get gameOver():Boolean
		{
			return _gameOver;
		}

		public function set gameOver(value:Boolean):void
		{
			_gameOver = value;
			sharedObject.data.gameOver = gameOver;
			sharedObject.flush();
		}
		
		public function get nextUpdate():Number 
		{
			if (_nextUpdate == 0) {
				_nextUpdate = sharedObject.data.lastCommanderUpdate ? sharedObject.data.lastCommanderUpdate : 0;
			}
			return _nextUpdate;
		}
		
		public function set nextUpdate(value:Number):void 
		{
			_nextUpdate = value;
			sharedObject.data.lastCommanderUpdate = value;
			sharedObject.flush();
		}

		public function injectionHandler():void
		{
			if(sharedObject.data.saved){
				myCommander = loadCommander(sharedObject.data.myPackageName, true);
				enemyCommander = loadCommander(sharedObject.data.enemyPackageName, false);
			}
		}
		
		private function loadCommander(packageName:String, isMyCommander:Boolean):Commander
		{
			gameOver = sharedObject.data.gameOver;
			var commanderPackageClass:Class = Class(getDefinitionByName(packageName));
			var commanderPackage:CommanderPackage = inject(commanderPackageClass);
			
			var commander:Commander = inject(Commander);
			commander.isMyCommander = isMyCommander;
			commander.setPackage(commanderPackage);
			commander.load();
			return commander;
		}
		
		public function save():void
		{
			sharedObject.data.saved = true;
			sharedObject.data.myPackageName = getQualifiedClassName(myCommander.getPackage());
			sharedObject.data.enemyPackageName = getQualifiedClassName(enemyCommander.getPackage());
			sharedObject.data.gameOver = gameOver;
			sharedObject.flush();
		}
	}
}