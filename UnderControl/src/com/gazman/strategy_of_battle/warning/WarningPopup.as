package com.gazman.strategy_of_battle.warning
{
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.strategy_of_battle.menu.view.MenuButton;
	import com.gazman.strategy_of_battle.popups.Popup;
	import com.gazman.strategy_of_battle.warning.signals.IShowWarningSignal;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.Color;
	
	
	public class WarningPopup extends Popup implements IShowWarningSignal
	{
		private var messageContainer:Group = inject(Group);
		private var iconContainer:Group = inject(Group);
		private var mainContainer:Group = inject(Group);
		private var buttonsContainer:Group = inject(Group);
		private var background:Quad = new Quad(1, 1, Color.BLACK);
		private var iconBackground:Quad = new Quad(1, 1, Color.WHITE);
		private var yesButton:MenuButton = inject(MenuButton);
		private var singleYesButton:MenuButton = inject(MenuButton);
		private var noButton:MenuButton = inject(MenuButton);
		private var message:TextField = injectWithParams(TextField, [300, 120, ""]);
		private var iconDescription:TextField = injectWithParams(TextField, [100, 60, ""]);
		private var icon:Image;

		private var warningData:WarningData;
		
		public function WarningPopup() 
		{
			super();
		}
		
		public function showWarningHandler(warningData:WarningData):void
		{
			this.warningData = warningData;
			open();
			message.text = warningData.message;
			yesButton.text = warningData.positive.label;
			singleYesButton.text = warningData.positive.label;
			noButton.text = warningData.negative.label;
			initIcon();
			layoutConationers();
			layoutBackground(background, mainContainer, -10);
			noButton.view.visible = !warningData.oneButton;
			yesButton.view.visible = !warningData.oneButton;
			singleYesButton.view.visible = warningData.oneButton;
		}
		
		private function layoutBackground(background:Quad, relativeTo:Group, padding:Number):void
		{
			var containerLayout:ContainerLayout = inject(ContainerLayout);
			containerLayout.top = padding;
			containerLayout.bottom = padding;
			containerLayout.left = padding;
			containerLayout.right = padding;
			containerLayout.applyLayoutOn(background, relativeTo);
		}
		
		private function layoutConationers():void
		{
			var alignLayout:AlignLayout = new AlignLayout();
			alignLayout.toRight = 5;
			alignLayout.applyLayoutOn(messageContainer, iconContainer);
			
			var containerLayout:ContainerLayout = inject(ContainerLayout);
			containerLayout.center(0, -40);
			containerLayout.applyLayoutOn(mainContainer, parent);
		}
		
		private function initIcon():void
		{
			iconContainer.addChild(iconBackground);
			icon = new Image(warningData.icon.image);
			iconContainer.addChild(icon);
			iconDescription.text = warningData.icon.description;
			iconContainer.addChild(iconDescription);
			
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.horizontalCenter = 0;
			containerLayout.applyLayoutOn(iconDescription, icon);
			
			var alignLayout:AlignLayout = new AlignLayout();
			alignLayout.below = 0;
			alignLayout.applyLayoutOn(iconDescription, icon);
			
			layoutBackground(iconBackground, iconContainer, -2);
			
			containerLayout.clear();
			containerLayout.top = -2;
			containerLayout.bottom = 2;
			containerLayout.applyLayoutOn(iconBackground, mainContainer);
		}
		
		override protected function initilize():void
		{
			super.initilize();
			initBackground();
			initMessage();
			initContainer();
			initButtons();
			yesButton.addClickListenerEvent(yesClickHandler);
			singleYesButton.addClickListenerEvent(yesClickHandler);
			noButton.addClickListenerEvent(noClickHandler);
		}
		
		private function initMessage():void
		{
			message.color = Color.WHITE;
			message.fontSize = 20;
			messageContainer.addChild(message);
		}
		
		private function noClickHandler():void
		{
			warningData.negative.action();
			close();
		}
		
		private function yesClickHandler():void
		{
			warningData.positive.action();
			close();
		}
		
		private function initButtons():void
		{
			buttonsContainer.addChild(yesButton.view);
			buttonsContainer.addChild(noButton.view);
			buttonsContainer.addChild(singleYesButton.view);
			messageContainer.addChild(buttonsContainer);
			
			var alignLayout:AlignLayout = inject(AlignLayout);
			alignLayout.toRight = 10;
			alignLayout.applyLayoutOn(noButton.view, yesButton.view);
			alignLayout.clear();
			alignLayout.below = 10;
			alignLayout.applyLayoutOn(buttonsContainer, message);
			
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.horizontalCenter = 0;
			containerLayout.applyLayoutOn(message, buttonsContainer);
			containerLayout.applyLayoutOn(singleYesButton.view, buttonsContainer);
		}
		
		private function initContainer():void
		{
			mainContainer.addChild(messageContainer);
			mainContainer.addChild(iconContainer);
			addChild(mainContainer);
		}
		
		private function initBackground():void
		{
			background.filter = BlurFilter.createDropShadow();
			mainContainer.addChild(background);
			background.alpha = 0.8;
		}
	}
}


