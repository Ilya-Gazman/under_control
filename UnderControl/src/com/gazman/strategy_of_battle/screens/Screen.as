package com.gazman.strategy_of_battle.screens
{
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.screens.BaseScreen;
	import com.gazman.ui.utils.SpaceContainer;
	
	public class Screen extends BaseScreen
	{
		public static const FAMILY:String = "screens";
		protected var background:SpaceContainer = inject(SpaceContainer);
		
		public function Screen() 
		{
			super();
		}
		
		override protected function initilize():void
		{
			super.initilize();
			background.width = stage.stageWidth;
			background.height = stage.stageHeight;
			addChild(background);
		}
		
		override protected function get family():String
		{
			return FAMILY;
		}
		
		/**
		 * return true to prevent defualt logic to be applied. 
		 */
		public function onBackPressed():Boolean{
			return false;
		}
		
	}
}