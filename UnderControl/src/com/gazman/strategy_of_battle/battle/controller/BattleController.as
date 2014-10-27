package com.gazman.strategy_of_battle.battle.controller
{
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.strategy_of_battle.battle.controller.signals.GameOverSignal;
	import com.gazman.strategy_of_battle.battle.model.animation_queue.AnimationQue;
	import com.gazman.strategy_of_battle.battle.model.animation_queue.signals.IAnimationsFinishedSignal;
	import com.gazman.strategy_of_battle.battle.model.BattleModel;
	import com.gazman.strategy_of_battle.battle.model.commander.Commander;
	import com.gazman.strategy_of_battle.battle.model.map.MapModel;
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;
	import com.gazman.strategy_of_battle.battle.view.signals.IRequestBattleSignal;
	import com.gazman.strategy_of_battle.CommandersMap;
	import com.gazman.strategy_of_battle.maps.MapLoader;
	import com.gazman.strategy_of_battle.maps.Maps;
	import com.gazman.strategy_of_battle.maps.singlas.IMapLoadedSignal;
	import com.gazman.strategy_of_battle.utils.ArrayUtils;
	import com.gazman.strategy_of_battle_package.map.MapUtils;
	import com.gazman.strategy_of_battle_package.units.data.Action;
	import com.gazman.strategy_of_battle_package.units.data.TurnData;
	import com.gazman.strategy_of_battle_package.units.enums.ActionEnum;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	

	public class BattleController implements IAnimationsFinishedSignal, ISingleTon, IRequestBattleSignal, IMapLoadedSignal
	{
		private var battleModel:BattleModel = inject(BattleModel);
		private var mapModel:MapModel = inject(MapModel);
		private var animationQue:AnimationQue = inject(AnimationQue);
		private var turnData:TurnData = inject(TurnData);
		private var gameOverSignal:GameOverSignal = inject(GameOverSignal);
		private var maps:Maps = inject(Maps);
		private var isExcecuting:Boolean = false;
		private var resuming:Boolean;
		private var resumeRequested:Boolean;
		
		public function BattleController() 
		{
			super();
		}
		
		public function requestBattleHandler():void
		{
			battleModel.commanderStates.setKeys("Commander_" + battleModel.myCommander.name);
			battleModel.commanderStates.load();
			if(!battleModel.gameOver){
				if(!resumeRequested){
					ressumeBattle();
				}
			}
			else{
				var mapLoader:MapLoader = inject(MapLoader);
				battleModel.gameOver = false;
				pickUpCommnaders();
				var mapName:String = maps.getRandomMap();
				mapModel.save(mapName);
				mapLoader.load(mapName);
				battleModel.save();
			}
		}
		
		private function ressumeBattle():void
		{
			resumeRequested = true;
			resuming = true;
			var mapLoader:MapLoader = inject(MapLoader);
			var mapName:String = mapModel.getMapName();
			mapLoader.load(mapName);
		}
		
		public function mapLoadedHandler(mapLoader:MapLoader):void
		{
			mapModel.setMap(mapLoader.mapData);
			startBattle();
		}
		
		private function startBattle():void{
			if(resuming){
				resuming = false;
				loadUnits(battleModel.enemyCommander);	
				loadUnits(battleModel.myCommander);
			}
			else{
				summonUnitsFromLastBattle(battleModel.myCommander);
			}
			mapModel.buildMap();
			playCommanders();
			continueBattle();
		}
		
		private function loadUnits(commander:Commander):void
		{
			for each(var unit:UnitModel in commander.units){
				mapModel.loadUnit(unit);
			}
		}
		
		private function pickUpCommnaders():void
		{
			battleModel.enemyCommander = pickUpCommnader();
			battleModel.myCommander.resetSummons();
		}
		
		private function summonUnitsFromLastBattle(commander:Commander):void
		{
			for each(var unit:UnitModel in commander.units){
				unit.resetStamina();
				mapModel.addUnit(unit);
			}
		}
		
		private function pickUpCommnader():Commander
		{
			var commander:Commander = inject(Commander);
			var randomIndex:int = Math.min(Math.random() * CommandersMap.COMMANDERS.length, CommandersMap.COMMANDERS.length - 1);
			commander.setPackage(inject(CommandersMap.COMMANDERS[randomIndex]));
			return commander;
		}
		
		private function continueBattle():void{
			if(isExcecuting || battleModel.gameOver){
				return;
			}
			isExcecuting = true;
			for (var i:int = 0; i < 1000 && animationQue.isEmpty(); i++){
				mapModel.buildMap();
				if (tryFinishBattle()){
					break;
				}
				playLions();
				playCommanders();
				playUnits();
			}
			isExcecuting = false;
			saveCommanders();
			battleModel.commanderStates.save();
		}
		
		private function saveCommanders():void 
		{
			battleModel.enemyCommander.save();
			battleModel.myCommander.save();
		}
		
		public function animationsFinishedHandler():void
		{
			continueBattle();
		}
		
		private function playLions():void
		{
//			if(Math.round(Math.random() * 100) ==  26){
//				mapModel.addUnit(inject(LionStates));
//			}
		}
		
		private function playUnits():void
		{
			var units:Vector.<UnitModel> = new Vector.<UnitModel>();
			collectUnits(units, battleModel.myCommander);
			collectUnits(units, battleModel.enemyCommander);
			if(units.length == 0){
				resetStamina(battleModel.myCommander);
				resetStamina(battleModel.enemyCommander);
				collectUnits(units, battleModel.myCommander);
				collectUnits(units, battleModel.enemyCommander);
			}
			ArrayUtils.shuffle(units);
			var startingTime:Number = new Date().time;
			for each (var unit:UnitModel in units){
				if(unit.isActive()){ // Is unit alive?
					playUnitTurn(unit);
				}
			}
			//trace(new Date().time - startingTime);
		}
		
		/**
		 * @Return If other action than "Skip" been performed
		 */
		private function playUnitTurn(unit:UnitModel):void{
			turnData.map = mapModel.getMap();
			turnData.myCommander = unit.commander.name;
			turnData.stamina = unit.stamina;
			turnData.states = unit.states;
			turnData.position = mapModel.getUnitLocation(unit);
			var action:Action = unit.controller.playTurn(turnData);
			validateAcion(action);
			switch(action.actionEnum){
				case ActionEnum.ATTACK:
					valiateAttack(unit, action.destination);
					unit.reduceStamina(unit.states.attackCost);
					var target:UnitModel = mapModel.getUnitAt(action.destination);
					if(target != null){
						target.reduceLife(unit.states.dmg);
						unit.notifyAttack(target, unit.states.dmg, action.destination.x, action.destination.y);
						if (unit.commander.isMyCommander) {
							if (target.life > 0) {
								battleModel.commanderStates.lastGame.attacks++;								
							}
							else {
								battleModel.commanderStates.lastGame.kills++;
							}
						}
					}
					else {
						target = mapModel.getPreviousUnitAt(action.destination);
						unit.notifyMiss(target, action.destination.x, action.destination.y);
						if (unit.commander.isMyCommander) {
							battleModel.commanderStates.lastGame.misses++;
						}
					}
					break;
				case ActionEnum.MOVE:
					valiateMove(unit, action.destination);
					unit.reduceStamina(unit.states.moveCost);
					mapModel.move(unit, action.destination);
					if (unit.commander.isMyCommander) {
						battleModel.commanderStates.lastGame.moves++;
					}
					break;
				case ActionEnum.SKIP:
					if (unit.commander.isMyCommander) {
						battleModel.commanderStates.lastGame.skips++;
					}
					unit.reduceStamina(unit.states.skipCost);
					break;
				default:
					throw new Error("Undefined action", action.actionEnum);
			}
		}
		
		private function validateAcion(action:Action):void
		{
			if(action == null){
				throw new Error("Turn action cannot be null");
			}
			if(action.actionEnum == null){
				throw new Error("Turn action.actionEnum cannot be null");
			}
		}
		
		private function valiateAttack(unit:UnitModel, destination:Point):void
		{
			if(destination == null){
				throw new Error("Destination havve not been set");
			}
			if(unit.stamina < unit.states.attackCost){
				throw new Error("Not enough stamina to attack");
			}
			if(!MapUtils.isInRange(mapModel.getUnitLocation(unit), destination, unit.states.range)){
				throw new Error("Target not in range");
			}
		}
		
		private function valiateMove(unit:UnitModel, destination:Point):void
		{
			if(destination == null){
				throw new Error("Destination havve not been set");
			}
			if(unit.stamina < unit.states.moveCost){
				throw new Error("Not enough stamina to move");
			}
			if(mapModel.isBlocked(destination)){
				throw new Error("Destination is a block cell");
			}
		}
		
		private function playCommanders():void
		{
			if (battleModel.myCommander.playTurn(mapModel.getMap())) {
				battleModel.commanderStates.lastGame.summons++;
			}
			battleModel.enemyCommander.playTurn(mapModel.getMap());
		}

		private function tryFinishBattle():Boolean
		{
			if (battleModel.myCommander.units.length == 0)
			{
				endGame(false)
				return true;
			}
			if(battleModel.enemyCommander.units.length == 0)
			{
				endGame(true);
				return true;
			}
			return false;
		}
		
		private function endGame(won:Boolean):void
		{
			battleModel.gameOver = true;
			setTimeout(function():void{gameOverSignal.gameOverHandler(won)}, 1000);
		}
		
		private function resetStamina(commander:Commander):void
		{
			for each(var unit:UnitModel in commander.units){
				unit.resetStamina();
			}
		}
		
		private function collectUnits(units:Vector.<UnitModel>, commander:Commander):void
		{
			for each(var unit:UnitModel in commander.units){
				if(unit.isActive()){
					units.push(unit);
				}
			}
		}
	}
}