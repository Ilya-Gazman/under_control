package com.gazman.strategy_of_battle.battle.view
{
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.strategy_of_battle.battle.model.BattleModel;
	import com.gazman.strategy_of_battle.battle.model.Resources;
	import com.gazman.strategy_of_battle.battle.view.commander_popup.signals.ShowCommanderOptionsSignal;
	import com.gazman.strategy_of_battle_package.CommanderPackage;
	import com.gazman.ui.group.Group;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class CommanderIcon extends Group
	{
		private var battleModel:BattleModel = inject(BattleModel);
		private var resources:Resources = inject(Resources);
		private var icon:Button;
		private var showCommanderOptionsSignal:ShowCommanderOptionsSignal = inject(ShowCommanderOptionsSignal);
		public var isMyCommander:Boolean;
		
		public function CommanderIcon() 
		{
			super();
		}
		
		public function show():void{
			var commanderIcon:String = commanderPackage.getResources().commanderIcon;
			var texture:Texture = resources.getTexture(commanderIcon);
			if(icon == null){
				icon = injectWithParams(Button, [texture]);
				addChild(icon);
				icon.addEventListener(Event.TRIGGERED, onClick);
			}
			else{
				icon.upState = texture;
			}
		}
		
		private function onClick():void
		{
			if(!isMyCommander){
				return;
			}
			var userOptions:Array = commanderPackage.getCommander().getUserOptions();
			if(userOptions.length == 0){
				return;
			}
			showCommanderOptionsSignal.showCommanderOptionsHandler(userOptions, isMyCommander);
		}
		
		private function get commanderPackage():CommanderPackage{
			return isMyCommander ? battleModel.myCommander.getPackage() : battleModel.enemyCommander.getPackage();
		}
	}
}