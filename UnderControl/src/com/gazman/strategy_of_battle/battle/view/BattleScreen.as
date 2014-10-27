package com.gazman.strategy_of_battle.battle.view
{
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.strategy_of_battle.battle.controller.signals.IGameOverSignal;
	import com.gazman.strategy_of_battle.battle.model.map.signals.IUnitAddedSignal;
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;
	import com.gazman.strategy_of_battle.battle.view.game_over_popup.signals.IBackToMenuSignal;
	import com.gazman.strategy_of_battle.battle.view.moral.MoralView;
	import com.gazman.strategy_of_battle.battle.view.signals.RequestBattleSignal;
	import com.gazman.strategy_of_battle.battle.view.units.UnitView;
	import com.gazman.strategy_of_battle.maps.MapData;
	import com.gazman.strategy_of_battle.maps.MapLoader;
	import com.gazman.strategy_of_battle.maps.singlas.IMapLoadedSignal;
	import com.gazman.strategy_of_battle.menu.view.signals.fight.IFightSelectedSignal;
	import com.gazman.strategy_of_battle.screens.Screen;
	import com.gazman.strategy_of_battle.warning.WarningData;
	import com.gazman.strategy_of_battle.warning.signals.ShowWarningSignal;
	import com.gazman.strategy_of_battle_package.resources.ResourcesPackage;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.layouts.ContainerLayout;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.geom.Point;
	import starling.events.Touch;

	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class BattleScreen extends Screen implements IFightSelectedSignal, IUnitAddedSignal, ISingleTon,
		IBackToMenuSignal, IMapLoadedSignal, IGameOverSignal
	{
		private var myBackground:Image;
		private var backgroundContainer:Group = inject(Group);
		private var commanderIcon:CommanderIcon = inject(CommanderIcon);
		private var unitsContainer:Group = inject(Group);
		private var messageContainer_1:Group = inject(Group);
		private var messageContainer_2:Group = inject(Group);
		private var battleScreenLoadedSignal:RequestBattleSignal = inject(RequestBattleSignal);
		private var myCommanderIcon:CommanderIcon = inject(CommanderIcon);
		private var enemyCommanderIcon:CommanderIcon = inject(CommanderIcon);
		private var showWarningSignal:ShowWarningSignal = inject(ShowWarningSignal);
		private var gameJuggler:GameJuggler = inject(GameJuggler);
		private var moralView:MoralView = new MoralView();
		private var bufferPoint:Point = new Point();
		
		public function BattleScreen() 
		{
			super();
		}
		
		public function mapLoadedHandler(mapLoader:MapLoader):void
		{
			initBackground(mapLoader.assetManager);
			initCommanderIcon(mapLoader.mapData);
		}
		
		private function initCommanderIcon(mapData:MapData):void
		{
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.top = mapData.myCommanderIcon.y;
			containerLayout.left = mapData.myCommanderIcon.x;
			containerLayout.applyLayoutOn(myCommanderIcon, backgroundContainer);
			
			containerLayout.top = mapData.enemyCommanderIcon.y;
			containerLayout.left = mapData.enemyCommanderIcon.x;
			containerLayout.applyLayoutOn(enemyCommanderIcon, backgroundContainer);
			
			myCommanderIcon.show();
			enemyCommanderIcon.show();
		}
		
		private function initBackground(assetManager:AssetManager):void{
			var mapTexture:Texture = assetManager.getTexture("map.jpg");
			myBackground = injectWithParams(Image, [mapTexture]);
			backgroundContainer.addChild(myBackground);
			myBackground.addEventListener(TouchEvent.TOUCH, onBackgroundTouch);
		}
		
		public function fightSelectedHandler():void
		{
			open();
			gameJuggler.pause = false;
			battleScreenLoadedSignal.requestBattleHandler();
		}
		
		public function backToMenuHandler():void
		{
			close();
		}
		
		override protected function initilize():void
		{
			super.initilize();
			addChild(backgroundContainer);
			initMyCommanderIcon();
			addChild(enemyCommanderIcon);
			addChild(messageContainer_1);
			addChild(unitsContainer);
			addChild(messageContainer_2);
			addChild(moralView);
		}
		
		public function gameOverHandler(won:Boolean):void
		{
			unitsContainer.removeChildren();
		}
		
		public function unitAddedHandler(unitModel:UnitModel):void
		{
			var resources:ResourcesPackage = unitModel.commander.getPackage().getResources();
			var unitview:UnitView = injectWithParams(UnitView, [resources]);
			unitview.setModel(unitModel);
			unitsContainer.addChild(unitview);
			unitview.setRoot(this);
		}
		
		override public function onBackPressed():Boolean
		{
			gameJuggler.pause = true;
			var warningData:WarningData = new WarningData();
			warningData.message = "Battle is saved and paused";
			
			warningData.positive.label = "Go to Menu";
			warningData.positive.action = backToMenuHandler;
			
			warningData.negative.label = "Resume";
			warningData.negative.action = resumeGame;
			
			showWarningSignal.showWarningHandler(warningData);
			return true;
		}
		
		private function resumeGame():void
		{
			gameJuggler.pause = false;
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		}
		
		override public function pauseHandler():void 
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
		}
		
		private function onBackgroundTouch(event:TouchEvent):void 
		{
			var touch:Touch = event.getTouch(myBackground, TouchPhase.BEGAN);
			if (!touch) {
				return;
			}
			
			touch.getLocation(myBackground, bufferPoint);
			moralView.x = bufferPoint.x - moralView.width / 2;
			moralView.y = bufferPoint.y - moralView.height / 2;
			moralView.handleHit();
		}
		
		private function initMyCommanderIcon():void 
		{
			addChild(myCommanderIcon);
			myCommanderIcon.isMyCommander = true;
		}
	}
}