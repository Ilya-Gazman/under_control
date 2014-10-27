package com.gazman.strategy_of_battle.pick_up_commander.view
{
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.battle.model.BattleModel;
	import com.gazman.strategy_of_battle.battle.model.commander.Commander;
	import com.gazman.strategy_of_battle.battle.model.Resources;
	import com.gazman.strategy_of_battle.pick_up_commander.signals.commander_selected.CommanderSelectedSignal;
	import com.gazman.strategy_of_battle.warning.signals.ShowWarningSignal;
	import com.gazman.strategy_of_battle.warning.WarningData;
	import com.gazman.strategy_of_battle_package.CommanderPackage;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.list.ItemRenderer;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.VAlign;
	
	
	
	public class CommanderItem extends ItemRenderer
	{
		public const HOUR:int = 1000 * 60 * 60;
		private var defaultIcon:String = "monkey.png"; // default
		private var label:TextField = new TextField(100, 40, "");
		private var resources:Resources = inject(Resources);
		private var containerLayout:ContainerLayout = inject(ContainerLayout);
		private var alignLayout:AlignLayout = inject(AlignLayout);
		private var icon:Button;
		private var battleModel:BattleModel = inject(BattleModel);
		private var showWarningSignal:ShowWarningSignal = inject(ShowWarningSignal);
		private var commanderSelectedSignal:CommanderSelectedSignal = inject(CommanderSelectedSignal);
		private var pressedTime:Number;
		private var lastY:Number = -1;
		
		public function CommanderItem(){
			initIcon();
			label.vAlign = VAlign.TOP;
			addChild(label);
			alignLayout.below = 5;
			containerLayout.horizontalCenter = 0;
			
			layout();
		}
		
		private function initIcon():void
		{
			var texture:Texture = resources.getTexture(defaultIcon);
			icon = new Button(texture);
			icon.addEventListener(TouchEvent.TOUCH, onTrigger);
			Starling.current.stage.addEventListener(TouchEvent.TOUCH, onStageTouch);
			addChild(icon);
		}
		
		private function onStageTouch(event:TouchEvent):void 
		{
			var touch:Touch = event.getTouch(Starling.current.stage, TouchPhase.ENDED);
			if (touch) {
				pressedTime = 0;
			}
		}
		
		override protected function dataChangeHandler(data:Object):void
		{
			var commanderPackage:CommanderPackage = CommanderPackage(data);
			label.text = commanderPackage.getFullNameAndTitle();
			var commanderIcon:String = commanderPackage.getResources().commanderIcon;
			var texture:Texture = resources.getTexture(commanderIcon);
			icon.upState = texture;
			icon.downState = texture;
			
			layout();
		}
		
		private function layout():void
		{
			alignLayout.applyLayoutOn(label, icon);
			containerLayout.applyLayoutOn(label, icon);
		}
		
		private function onTrigger(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(icon);
			if (!touch) {
				return;
			}
			
			if (touch.phase == TouchPhase.BEGAN) {
				pressedTime = new Date().time;
				lastY = touch.globalY;
				return;
			}
			
			if (touch.phase != TouchPhase.ENDED || new Date().time - pressedTime > 500 ||Math.abs(touch.globalY - lastY) > 5) {
				return;
			}
			
			var commanderPackage:CommanderPackage = CommanderPackage(data);
			
			var warningData:WarningData = new WarningData();
			
			var currentTime:Number = new Date().time;
			
			if (battleModel.nextUpdate - currentTime > 0) {
				
				var timeLeft:Number = battleModel.nextUpdate - currentTime;
				var hourse:int = timeLeft / HOUR;
				var minutes:int = (timeLeft - HOUR * hourse) / 1000 / 60;
				
				warningData.message = "You will be able to change your commander in:\n" + hourse + " hours and " + minutes + " minutes";
				warningData.oneButton = true;
			}
			else {
				warningData.icon.image = icon.upState;
				warningData.icon.description = commanderPackage.getFullNameAndTitle();
				warningData.message = "You can change your commander every 24 hours. Are you sure that this is the one?";
				warningData.positive.action = confirmSelection;	
			}
			
			showWarningSignal.showWarningHandler(warningData);
		}
		
		private function confirmSelection():void
		{
			battleModel.myCommander = inject(Commander);
			battleModel.myCommander.setPackage(CommanderPackage(data));
			battleModel.nextUpdate = new Date().time + HOUR * 24;
			commanderSelectedSignal.commnaderSelctedHandler();
		}
	}
}