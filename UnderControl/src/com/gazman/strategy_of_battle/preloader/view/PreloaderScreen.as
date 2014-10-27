package com.gazman.strategy_of_battle.preloader.view
{
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.strategy_of_battle.battle.model.Resources;
	import com.gazman.strategy_of_battle.preloader.model.PreloaderModel;
	import com.gazman.strategy_of_battle.preloader.tasks.signals.IResourceLoadedSignal;
	import com.gazman.strategy_of_battle.preloader.view.signals.PreloaderCompleteSingal;
	import com.gazman.strategy_of_battle.screens.Screen;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.layouts.Layout;
	import com.gazman.ui.screens.signals.root_created.IRootCratedSignal;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	import starling.display.Image;
	import starling.textures.Texture;
	
	import starling.display.Quad;
	import starling.events.EnterFrameEvent;
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class PreloaderScreen extends Screen implements IRootCratedSignal, IResourceLoadedSignal, ISingleTon
	{
		private var resources:Resources = inject(Resources);
		private var preloaderModel:PreloaderModel = inject(PreloaderModel);
		private var preloderCompleteSingal:PreloaderCompleteSingal = inject(PreloaderCompleteSingal);
		
		override protected function initilize():void
		{
			super.initilize();
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		
		public function rootCratedHandler():void
		{
			open();
		}
		
		public function resourceLoadedHandler():void 
		{
			addBackground();
		}
		
		private function addBackground():void
		{
			var backgroundImage:Image = injectWithParams(Image, [resources.getTexture("preloader.jpg")]);
			backgroundImage.width = width;
			var containerLayout:ContainerLayout = inject(ContainerLayout);
			containerLayout.center();
			containerLayout.applyLayoutOn(backgroundImage, background);
			addChild(backgroundImage);
		}
		
		private function onEnterFrame():void
		{
			var progress:Number = preloaderModel.getProgress();
			if (progress == 1) {
				removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
				preloderCompleteSingal.preloaderCompleteHandler();
			}
		}
	}
}