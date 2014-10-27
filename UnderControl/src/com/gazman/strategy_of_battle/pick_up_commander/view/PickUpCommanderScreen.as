package com.gazman.strategy_of_battle.pick_up_commander.view
{
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.strategy_of_battle.battle.model.Resources;
	import com.gazman.strategy_of_battle.pick_up_commander.CommanderPackagesFactory;
	import com.gazman.strategy_of_battle.pick_up_commander.signals.IPickUpCommanderSignal;
	import com.gazman.strategy_of_battle.pick_up_commander.signals.commander_selected.ICommanderSelectedSignal;
	import com.gazman.strategy_of_battle.screens.Screen;
	import com.gazman.ui.drag.SmoothDragHandler;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.list.List;
	
	import starling.display.Image;
	import starling.text.TextField;
	
	public class PickUpCommanderScreen extends Screen implements IPickUpCommanderSignal, ICommanderSelectedSignal, ISingleTon
	{
		private var title:TextField;
		private var list:List = new List();
		private var commanderFactory:CommanderPackagesFactory = inject(CommanderPackagesFactory);
		private var backgroundImage:Image;
		private var resources:Resources = inject(Resources);
		
		public function PickUpCommanderScreen() 
		{
			super();
		}
		
		override protected function initilize():void
		{
			super.initilize();
			initBackground();
			initTitle();
			initList();
			layout();
			new SmoothDragHandler(list).allowHorizontalDrag = false;
		}
		
		private function initTitle():void
		{
			title = new TextField(400, 30, "Pick up commander");
			addChild(title);
		}
		
		private function initBackground():void
		{
			backgroundImage = injectWithParams(Image, [resources.getTexture("menu.png")]);
			var containerLayout:ContainerLayout = inject(ContainerLayout);
			containerLayout.center();
			containerLayout.applyLayoutOn(backgroundImage, background);
			addChild(backgroundImage);
		}
		
		private function layout():void
		{
			title.fontSize = 20;
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.horizontalCenter = 0;
			containerLayout.applyLayoutOn(list, background);
			
			containerLayout.top = 10;
			containerLayout.applyLayoutOn(title, background);
			
			var alignLayout:AlignLayout = new AlignLayout();
			alignLayout.below = 10;
			alignLayout.applyLayoutOn(list, title);
		}
		
		private function initList():void
		{
			list.structure.columnsCount = 4;
			list.structure.dataProvider = commanderFactory.getAll();
			list.structure.itemRenderer = CommanderItem;
			list.layout.columnsCount = 4;
			list.layout.rowsCount = 4;
			list.layout.typicalItem = new CommanderItem();
			addChild(list);
		}
		
		public function pickUpCommanderHandler():void
		{
			open();
		}
		
		public function commnaderSelctedHandler():void
		{
			close();
		}
	}
}