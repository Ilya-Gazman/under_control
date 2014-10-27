package com.gazman.strategy_of_battle.menu.view
{
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.strategy_of_battle.battle.model.BattleModel;
	import com.gazman.strategy_of_battle.battle.model.Resources;
	import com.gazman.strategy_of_battle.developers.signals.DevelopersSignal;
	import com.gazman.strategy_of_battle.menu.view.signals.fight.FightSelectedSignal;
	import com.gazman.strategy_of_battle.pick_up_commander.signals.PickUpCommanderSignal;
	import com.gazman.strategy_of_battle.preloader.view.signals.IPreloaderCompleteSingal;
	import com.gazman.strategy_of_battle.screens.Screen;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.layouts.LinearLayout;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	
	public class MenuScreen extends Screen implements IPreloaderCompleteSingal
	{
		public function MenuScreen() 
		{
			super();
		}
		private var linearLayout:LinearLayout = inject(LinearLayout);
		private var buttonsContainer:Group = inject(Group);
		private var fightSignal:FightSelectedSignal = inject(FightSelectedSignal);
		private var resources:Resources = inject(Resources);
		private var backgroundImage:Image;
		private var pickUpCommanderSignal:PickUpCommanderSignal = inject(PickUpCommanderSignal);
		private var battleModel:BattleModel = inject(BattleModel);
		private var developersSignal:DevelopersSignal = inject(DevelopersSignal);
		
		public function preloaderCompleteHandler():void
		{
			open();
		}
		
		override protected function initilize():void
		{
			super.initilize();
			initBackground();
			initButton("Fight", fightHandler);
			initButton("Select Commander", pickUpCommanderHandler);
			initButton("Developers", developersHandler);
			addChild(buttonsContainer);
			
			linearLayout.horizontalCenter = 0;
			linearLayout.gap = 10;
			linearLayout.verticalLayout = true;
			linearLayout.applyLayout();
			var containerLayout:ContainerLayout = inject(ContainerLayout);
			containerLayout.center();
			containerLayout.applyLayoutOn(backgroundImage, background);
			
			containerLayout.clear();
			containerLayout.top = 30;
			containerLayout.left = 20;
			containerLayout.applyLayoutOn(buttonsContainer, background);
			
			var tween:Tween = injectWithParams(Tween, [buttonsContainer, 3, Transitions.EASE_IN_ELASTIC]);
			tween.animate("y", buttonsContainer.y + 20);
			tween.repeatCount = 0;
			tween.reverse = true;
			Starling.juggler.add(tween);
		}
		
		private function pickUpCommanderHandler():void
		{
			pickUpCommanderSignal.pickUpCommanderHandler();
		}
		
		private function initBackground():void
		{
			backgroundImage = injectWithParams(Image, [resources.getTexture("menu.png")]);
			addChild(backgroundImage);
		}
		
		private function developersHandler():void
		{
			developersSignal.developersHandler();
		}
		
		private function fightHandler():void
		{
			if(battleModel.myCommander == null){
				pickUpCommanderHandler();
			}
			else{
				fightSignal.fightSelectedHandler();
			}
		}
		
		private function initButton(label:String, handler:Function):void
		{
			var button:MenuButton = inject(MenuButton);
			button.text = label;
			button.addClickListenerEvent(handler);
			buttonsContainer.addChild(button.view);
			linearLayout.addChildren(button.view);
		}		
		
	}
}