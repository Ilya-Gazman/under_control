package com.gazman.strategy_of_battle.battle.model.commander
{
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.battle.model.BattleModel;
	import com.gazman.strategy_of_battle.battle.model.map.MapModel;
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;
	import com.gazman.strategy_of_battle.battle.model.unit.states.ArcherStates;
	import com.gazman.strategy_of_battle.battle.model.unit.states.KnightStates;
	import com.gazman.strategy_of_battle.battle.model.unit.states.ShamanStates;
	import com.gazman.strategy_of_battle_package.CommanderPackage;
	import com.gazman.strategy_of_battle_package.map.Map;
	import com.gazman.strategy_of_battle_package.units.ICommanderController;
	import com.gazman.strategy_of_battle_package.units.IUnitController;
	import com.gazman.strategy_of_battle_package.units.data.UnitStates;
	import com.gazman.strategy_of_battle_package.units.enums.UnitEnum;
	
	import flash.net.SharedObject;

	public class Commander
	{
		public static const MAX_SUMMONS_ALOUD:int = 5;
		public static const MAX_UNITS_ALOUD:int = 6;
		
		private static var idCounter:int = 1;
		private var id:int = idCounter++;
		private var _units:Vector.<UnitModel> = new Vector.<UnitModel>();
		private var battleModel:BattleModel = inject(BattleModel);
		private var mapModel:MapModel = inject(MapModel);
		private var sharedObject:SharedObject;
		private var summonsLeft:int;
		
		private var commanderPackage:CommanderPackage;
		private var loading:Boolean;
		public var isMyCommander:Boolean;
		
		public function Commander(){
			resetSummons();
		}
		
		public function load():void
		{
			loading = true;
			loadUnits();
			summonsLeft = sharedObject.data.summonsLeft;
			loading = false;
		}
		
		private function loadUnits():void
		{
			var numberOfUnits:int = sharedObject.data.numberOfUnits;
			for(var i:int = 0; i < numberOfUnits; i++){
				var type:String = sharedObject.data[i + "unit_type"];
				var unit:UnitModel = summon(type);
				unit.stamina = sharedObject.data[i + "unit_stamina"];
				unit.id = sharedObject.data[i + "id"];
				unit.life = sharedObject.data[i + "unit_life"];
				unit.viewLife = unit.life;
			}
		}
		
		public function save():void{
			saveUnits();
			sharedObject.data.summonsLeft = summonsLeft;
			sharedObject.flush();
		}
		
		private function saveUnits():void
		{
			var numberOfUnits:int = _units.length;
			sharedObject.data.numberOfUnits = numberOfUnits;
			for(var i:int = 0; i < numberOfUnits; i++){
				var unit:UnitModel = _units[i];
				sharedObject.data[i + "id"] = unit.id;
				sharedObject.data[i + "unit_type"] = unit.states.type;
				sharedObject.data[i + "unit_stamina"] = unit.stamina;
				sharedObject.data[i + "unit_life"] = unit.life;
			}
		}
		
		public function get name():String{
			return commanderPackage.getFullNameAndTitle() + " - " + id;
		}
		
		public function resetSummons():void{
			summonsLeft = Math.min(MAX_UNITS_ALOUD - units.length, MAX_SUMMONS_ALOUD);
		}
		
		public function setPackage(commanderPackage:CommanderPackage):void{
			this.commanderPackage = commanderPackage;
			var fileName:String = commanderPackage.getFullNameAndTitle() + " commander";
			var pattern:RegExp = /[\s\r\n]+/gim;
			fileName = fileName.replace(pattern, "");
			sharedObject = SharedObject.getLocal(fileName + isMyCommander);
		}
		
		public function getPackage():CommanderPackage{
			return commanderPackage;
		}
		
		/**
		 * 
		 * @param	map
		 * @return if summoned
		 */
		public function playTurn(map:Map):Boolean{
			var commander:ICommanderController = commanderPackage.getCommander();
			commander.playTurn(map);
			if(canSummon()){
				summonsLeft--;
				summon(commander.summon(map, summonsLeft));
				return true;
			}
			return false;
		}
		
		private function canSummon():Boolean{
			return _units.length < MAX_UNITS_ALOUD && summonsLeft > 0;
		}
		
		/**
		 * Summon a soldier based on maxSummonsAloud and maxSoldiersAloud.
		 */
		private function summon(type:String):UnitModel{
			var unit:UnitModel;
			var commander:ICommanderController = commanderPackage.getCommander();
			switch(type){
				case UnitEnum.ARCHER:
					unit = injectUnit(ArcherStates, commander.summonArcher());
					break;
				case UnitEnum.KNIGHT:
					unit = injectUnit(KnightStates, commander.summonKnight());
					break;
				case UnitEnum.SHAMAN:
					unit = injectUnit(ShamanStates, commander.summonShaman());
					break;
				default:
					throw new Error("Cannot summon that");
			}
			unit.resetStamina();
			_units.push(unit);
			if(!loading){
				mapModel.addUnit(unit);
			}
			return unit;
		}
		
		private function injectUnit(statesClass:Class, player:IUnitController):UnitModel
		{
			var unit:UnitModel = inject(UnitModel);
			var states:UnitStates = inject(statesClass);
			unit.init(player, states, this);
			return unit;
		}		
		
		
		public function get units():Vector.<UnitModel>
		{
			return _units;
		}
		
		public function removeUnit(unit:UnitModel):void
		{
			for(var i:int = 0; i < _units.length; i++){
				if(_units[i] == unit){
					_units.splice(i, 1);
					mapModel.removeUnit(unit);
					return;
				}
			}
			throw new Error("Unit not found");
		}
	}
}