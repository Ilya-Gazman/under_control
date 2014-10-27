package com.gazman.strategy_of_battle.screens
{
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.popups.Popup;
	import com.gazman.strategy_of_battle.popups.PopupContainer;
	import com.gazman.strategy_of_battle.screens.signals.PromotExtitSignal;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.screens.model.ScreenModel;
	
	import flash.desktop.NativeApplication;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class MainScreen extends Group
	{
		private var screens:ScreenContainer = inject(ScreenContainer);
		private var popups:PopupContainer = inject(PopupContainer);
		private var screenModel:ScreenModel = inject(ScreenModel, Screen.FAMILY);
		private var popupsModel:ScreenModel = inject(ScreenModel, Popup.FAMILY);
		private var promoteExit:PromotExtitSignal = inject(PromotExtitSignal);
		
		public function MainScreen() 
		{
			super();
		}
		
		override protected function initilize():void
		{
			stage.stageWidth = 800;
			stage.stageHeight = 480;
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKey);
			addChild(screens);
			addChild(popups);
		}
		
		protected function handleKey(event:KeyboardEvent):void
		{
			event.preventDefault();
			switch(event.keyCode){
				case Keyboard.BACK:
					if(popupsModel.numberOfScreensInStack > 0){
						popupsModel.pop();
					}
					else{
						if(screenModel.numberOfScreensInStack == 2){
							promoteExit.promotExitHandler();
						}
						else{
							if(!Screen(screenModel.activeScreen).onBackPressed()){
								screenModel.pop();
							}
						}
					}
					break;
			}
		}		
	}
}