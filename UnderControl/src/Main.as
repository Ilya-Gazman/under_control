package 
{
	import com.gazman.strategy_of_battle.screens.MainScreen;
	import com.gazman.strategy_of_battle.StrategyContext;
	import com.gazman.strategy_of_battle.TestSettings;
	import com.gazman.ui.screens.FlashBaseView;
	import flash.display.Loader;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.describeType;
	
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	[SWF(width="800",height="480",frameRate="60",backgroundColor="#0")]
	public class Main extends FlashBaseView 
	{
		public function Main():void 
		{
			trace("Application Started");
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			initialize(new StrategyContext(), MainScreen);
			
			//var loader:Loader = new Loader();
			//addChild(loader);
			//loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			//loader.load(new URLRequest("assets/preloader.jpg"));
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
	}
}