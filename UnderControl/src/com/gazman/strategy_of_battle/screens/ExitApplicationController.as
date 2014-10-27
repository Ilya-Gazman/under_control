package com.gazman.strategy_of_battle.screens
{
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.screens.signals.IPromoteExtitSignal;
	import com.gazman.strategy_of_battle.warning.WarningData;
	import com.gazman.strategy_of_battle.warning.signals.ShowWarningSignal;
	
	import flash.desktop.NativeApplication;
	
	public class ExitApplicationController implements IPromoteExtitSignal
	{
		public function promotExitHandler():void
		{
			var warningData:WarningData = inject(WarningData);
			var showWarningSignal:ShowWarningSignal = inject(ShowWarningSignal);
			
			warningData.message = "Are you sure you wish to exit?";
			warningData.positive.label = "Yes";
			warningData.negative.label = "No";
			warningData.positive.action = exitHandler;
			
			showWarningSignal.showWarningHandler(warningData);
		}
		
		private function exitHandler():void
		{
			NativeApplication.nativeApplication.exit();
		}
		
	}
}