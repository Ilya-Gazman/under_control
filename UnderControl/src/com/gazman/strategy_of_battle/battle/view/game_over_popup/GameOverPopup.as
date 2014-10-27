package com.gazman.strategy_of_battle.battle.view.game_over_popup
{
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.battle.controller.signals.IGameOverSignal;
	import com.gazman.strategy_of_battle.battle.model.BattleModel;
	import com.gazman.strategy_of_battle.battle.model.Resources;
	import com.gazman.strategy_of_battle.battle.view.game_over_popup.signals.BackToMenuSignal;
	import com.gazman.strategy_of_battle.battle.view.signals.RequestBattleSignal;
	import com.gazman.strategy_of_battle.menu.view.MenuButton;
	import com.gazman.strategy_of_battle.popups.Popup;
	import com.gazman.strategy_of_battle.statistics.CommanderStates;
	import com.gazman.strategy_of_battle.utils.Label;
	import com.gazman.ui.background.Frame;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.layouts.LinearLayout;
	import com.gazman.ui.progress_bar.ProgressBar;
	import com.gazman.ui.utils.SpaceContainer;
	import flash.utils.setTimeout;
	import starling.animation.Transitions;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class GameOverPopup extends Popup implements IGameOverSignal
	{
		private var next:MenuButton = inject(MenuButton);
		private var backToMenu:MenuButton = inject(MenuButton);
		private var buttonsLayout:LinearLayout = inject(LinearLayout);
		private var statusesLayout:LinearLayout = inject(LinearLayout);
		private var buttonsContainer:Group = inject(Group);
		private var requestBattleSignal:RequestBattleSignal = inject(RequestBattleSignal);
		private var backToMenuSignal:BackToMenuSignal = inject(BackToMenuSignal);
		private var resources:Resources = inject(Resources);
		private var containerLayout:ContainerLayout = new ContainerLayout();
		private var won:Boolean;
		private var level:ProgressBar = inject(ProgressBar);
		private var levelText:Label = inject(Label);
		private var misses:Status = inject(Status);
		private var moves:Status = inject(Status);
		private var summons:Status = inject(Status);
		private var attacks:Status = inject(Status);
		private var kills:Status = inject(Status);
		private var statuses:Vector.<Status> = new Vector.<Status>();
		private var image:Image;
		private var battleModel:BattleModel = inject(BattleModel);
		private var levelValue:LevelValue = new LevelValue();
		
		public function GameOverPopup() 
		{
			super();
		}
		
		public function gameOverHandler(won:Boolean):void
		{
			this.won = won;
			open();
		}
		
		override protected function initilize():void
		{
			super.initilize();
			initImage();
			var states:CommanderStates = battleModel.commanderStates;
			addStatus(misses, "Misses", states.total.misses, states.lastGame.misses);
			addStatus(moves, "Moves", states.total.moves, states.lastGame.moves);
			addStatus(summons, "Summons", states.total.summons, states.lastGame.summons);
			addStatus(attacks, "Attacks", states.total.attacks, states.lastGame.attacks);
			addStatus(kills, "Kills", states.total.kills, states.lastGame.kills);
			addChild(levelText);
			addChild(level);
			initButton("Next battle", nextHandler);
			initButton("Back to Menu", backToMenuHandler);
			addChild(buttonsContainer);
			layout();
			playOpenAnimation();
			levelValue.value = battleModel.commanderStates.getLevel();
			updateLevel();
			updateStates();
		}
		
		private function updateStates():void 
		{
			if (won) {
				battleModel.commanderStates.wins++;
			}
			else {
				battleModel.commanderStates.loses++;
			}
			battleModel.commanderStates.applyLastGame();
		}
		
		private function addStatus(status:Status, title:String, current:int, bonuse:int):void 
		{
			addChild(status);
			statuses.push(status);
			statusesLayout.addChildren(status);
			status.setCurrent(current);
			status.setBonuse(bonuse);
			status.setTitle(title);
			status.visible = false;
		}
		
		private function playOpenAnimation():void
		{
			scaleX = scaleY = 0.1;
			var tween:Tween = new Tween(this, 1);
			tween.onUpdate = onUpdateAnimation;
			tween.animate("scaleX", 1);
			tween.animate("scaleY", 1);
			tween.onComplete = playStatusAnimation;
			Starling.juggler.add(tween);
		}
		
		private function playStatusAnimation():void 
		{
			var timerSet:Boolean = false;
			var i:int;
			for (i = 0; i < statuses.length; i++ ) {
				if (!statuses[i].visible) {
					statuses[i].visible = true;
					setTimeout(playStatusAnimation, 300);
					timerSet = true;
					break;
				}
			}
			if (!timerSet) {
				for (i = 0; i < statuses.length; i++ ) {
					statuses[i].animate();
				}
				createLevelAniumation();
			}
		}
		
		private function onUpdateAnimation():void
		{
			containerLayout.applyLayoutOn(this, parent);
		}
		
		private function updateLevel():void 
		{
			var progress:Number = levelValue.value - int(levelValue.value);
			levelText.text = "Level " + int(levelValue.value);
			level.setProgress(progress, false);
		}
		
		private function layout():void
		{
			buttonsLayout.verticalLayout = false;
			buttonsLayout.applyLayout();
			
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.top = 10;
			containerLayout.left = 10;
			containerLayout.applyLayoutOn(misses, image);
			statusesLayout.verticalLayout = true;
			statusesLayout.applyLayout();
			
			containerLayout.clear();
			containerLayout.horizontalCenter = 0;
			containerLayout.applyLayoutOn(buttonsContainer, image);
			
			var alignLayout:AlignLayout = new AlignLayout();
			alignLayout.below = 10;
			alignLayout.applyLayoutOn(buttonsContainer, image);
			
			this.containerLayout.horizontalCenter = 0;
			this.containerLayout.top = 20;
			this.containerLayout.applyLayoutOn(this, parent);
			
			containerLayout.clear();
			containerLayout.left = 0;
			containerLayout.applyLayoutOn(levelText, kills);
			containerLayout.applyLayoutOn(level, kills);
			level.resize(100, 20);
			levelText.hAlign = HAlign.LEFT;
			levelText.color = 0x008000;
			levelText.backgroundColor = 0xFFFF00;
			levelText.backgroundAlpha = 0.8;
			levelText.bold = true;
			
			alignLayout.applyLayoutOn(levelText, kills);
			alignLayout.below = 2;
			alignLayout.applyLayoutOn(level, levelText);
		}
		
		private function backToMenuHandler():void
		{
			close();
			backToMenuSignal.backToMenuHandler();
		}
		
		private function nextHandler():void
		{
			close();
			requestBattleSignal.requestBattleHandler();
		}
		
		private function initButton(label:String, handler:Function):void
		{
			var button:MenuButton = inject(MenuButton);
			button.text = label;
			button.addClickListenerEvent(handler);
			buttonsContainer.addChild(button.view);
			buttonsLayout.addChildren(button.view);
		}
		
		private function initImage():void 
		{
			var textur:Texture = resources.getTexture(won ? "won.png" : "sheep.png");
			image = new Image(textur);
			addChild(image);
		}
		
		private function createLevelAniumation():void 
		{
			var tween:Tween = new Tween(levelValue, 2, Transitions.EASE_OUT);
			tween.animate("value", battleModel.commanderStates.getLevel());
			tween.onUpdate = updateLevel;
			Starling.juggler.add(tween);
		}
		
	}
}
class LevelValue {
	public var value:Number;
}