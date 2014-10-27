package com.gazman.strategy_of_battle.loading_popup.model
{
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.loading_popup.singals.loading_complete.LoadingCompleteSignal;
	import com.gazman.strategy_of_battle.loading_popup.singals.start_loading.StartLoadingSignal;

	public class LoadingModel implements ISingleTon
	{
		private var loadingcount:int;
		private var map:Object = new Object();
		private var startLoadingSignal:StartLoadingSignal = inject(StartLoadingSignal);
		private var loadingCompleteSignal:LoadingCompleteSignal = inject(LoadingCompleteSignal);
		
		public function LoadingModel() 
		{
			super();
		}
		
		public function startLoading(message:String, key:String):void{
			if(!isEmpty(key)){
				return;
			}
			map[key] = message;
			loadingcount++;
			startLoadingSignal.startLoadingHandler();
		}
		
		public function completeLoading(key:String):void{
			if(isEmpty(key)){
				return;
			}
			delete map[key];
			loadingcount--;
			if(loadingcount == 0){
				loadingCompleteSignal.loadingCompleteHandler();
			}
		}
		
		public function getMessages():Vector.<String>{
			var messages:Vector.<String> = new Vector.<String>();
			for each (var value:String in map) {
				messages.push(value);
			}
			return messages;
		}
		
		private function isEmpty(key:String):Boolean{
			return map[key] == null;
		}
	}
}