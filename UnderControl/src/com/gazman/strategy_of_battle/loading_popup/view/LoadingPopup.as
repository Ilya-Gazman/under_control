package com.gazman.strategy_of_battle.loading_popup.view
{
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.strategy_of_battle.loading_popup.model.LoadingModel;
	import com.gazman.strategy_of_battle.loading_popup.singals.loading_complete.ILoadingCompleteSignal;
	import com.gazman.strategy_of_battle.loading_popup.singals.start_loading.IStartLoadingSignal;
	import com.gazman.strategy_of_battle.popups.Popup;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.panel.Panel;
	
	import starling.text.TextField;
	
	public class LoadingPopup extends Popup implements ISingleTon, IStartLoadingSignal, ILoadingCompleteSignal
	{
		private var loadingModel:LoadingModel = inject(LoadingModel);
		private var panel:Panel = inject(Panel);
		private var messages:TextField;
		
		public function LoadingPopup() 
		{
			super();
		}
		
		override protected function initilize():void
		{
			super.initilize();
			messages = injectWithParams(TextField, [300, 200, ""]);
			addChild(panel);
			panel.title = "Loading please hold...";
			panel.container.addChild(messages);
			panel.resizeByContainer(5);
			var containerLayout:ContainerLayout = inject(ContainerLayout);
			containerLayout.center(0, -20);
			containerLayout.applyLayoutOn(panel, this);
			
			validate();
		}
		
		public function loadingCompleteHandler():void
		{
			close();
		}
		
		public function startLoadingHandler():void
		{
			open();
			if(isInitilized){
				validate();
			}
		}
		
		private function validate():void
		{
			var messagesText:String = loadingModel.getMessages().join("\n");
			messages.text = messagesText;
		}
		
	}
}