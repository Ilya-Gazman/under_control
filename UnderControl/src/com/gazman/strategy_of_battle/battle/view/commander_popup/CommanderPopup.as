package com.gazman.strategy_of_battle.battle.view.commander_popup
{
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.strategy_of_battle.battle.model.BattleModel;
	import com.gazman.strategy_of_battle.battle.model.commander.Commander;
	import com.gazman.strategy_of_battle.battle.view.commander_popup.signals.IShowCommanderOptionsSignal;
	import com.gazman.strategy_of_battle.menu.view.MenuButton;
	import com.gazman.strategy_of_battle.popups.Popup;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.layouts.LinearLayout;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.utils.Color;
	
	public class CommanderPopup extends Popup implements IShowCommanderOptionsSignal
	{
		public function CommanderPopup() 
		{
			super();
		}
		public var isMyCommander:Boolean;
		
		private var background:Quad = injectWithParams(Quad, [1,1, Color.GRAY]);
		private var battleModel:BattleModel = inject(BattleModel);
		
		public function showCommanderOptionsHandler(options:Array, isMyCommander:Boolean):void
		{
			this.isMyCommander = isMyCommander;
			open();
			updateOptions(options);
			lauoutBackground();
			layoutSelf();
		}
		
		private function lauoutBackground():void
		{
			var padding:int = -5;
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.bottom = padding;
			containerLayout.top = padding;
			containerLayout.left = padding;
			containerLayout.right = padding;
			containerLayout.applyLayoutOn(background, this);
		}
		
		private function layoutSelf():void
		{
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.bottom = 10;
			containerLayout.horizontalCenter = 0;
			containerLayout.applyLayoutOn(this, parent);
		}
		
		private function updateOptions(options:Array):void
		{
			var layout:LinearLayout = inject(LinearLayout);
			for each (var option:String in options){
				var menuButton:MenuButton = createButton(option);
				layout.addChildren(menuButton.view);
				addChild(menuButton.view);
			}
			layout.applyLayout();
		}
		
		override protected function initilize():void
		{
			addChild(background);
		}
		
		private function createButton(option:String):MenuButton
		{
			var button:MenuButton = inject(MenuButton);
			button.text = option;
			button.view.addEventListener(Event.TRIGGERED, onTrigger);
			return button;
		}
		
		private function onTrigger(event:Event):void
		{
			removeChildren(1);
			close();
			
			var button:Button = Button(event.target);
			var commander:Commander;
			if(isMyCommander){
				commander = battleModel.myCommander;
			}
			else{
				commander = battleModel.enemyCommander;
			}
			commander.getPackage().getCommander().handleOption(button.text);
		}
	}
}