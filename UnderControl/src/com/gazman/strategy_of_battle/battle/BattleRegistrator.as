package com.gazman.strategy_of_battle.battle
{
	import com.gazman.life_cycle.Registrator;
	import com.gazman.strategy_of_battle.battle.controller.BattleController;
	import com.gazman.strategy_of_battle.battle.controller.signals.GameOverSignal;
	import com.gazman.strategy_of_battle.battle.model.animation_queue.signals.AnimationFinishedSignal;
	import com.gazman.strategy_of_battle.battle.model.map.signals.UnitAddedSignal;
	import com.gazman.strategy_of_battle.battle.view.BattleScreen;
	import com.gazman.strategy_of_battle.battle.view.GameJuggler;
	import com.gazman.strategy_of_battle.battle.view.commander_popup.CommanderPopup;
	import com.gazman.strategy_of_battle.battle.view.commander_popup.signals.ShowCommanderOptionsSignal;
	import com.gazman.strategy_of_battle.battle.view.game_over_popup.GameOverPopup;
	import com.gazman.strategy_of_battle.battle.view.game_over_popup.signals.BackToMenuSignal;
	import com.gazman.strategy_of_battle.battle.view.signals.RequestBattleSignal;
	import com.gazman.strategy_of_battle.maps.singlas.MapLoadedSignal;
	import com.gazman.strategy_of_battle.menu.view.signals.fight.FightSelectedSignal;
	import com.gazman.ui.screens.signals.root_created.RootCraetedSignal;
	
	public class BattleRegistrator extends Registrator
	{
		
		override protected function initSignalsHandler():void
		{
			registerSignal(AnimationFinishedSignal, BattleController);
			registerSignal(BackToMenuSignal, BattleScreen);
			registerSignal(FightSelectedSignal, BattleScreen);
			
			registerSignal(GameOverSignal, GameOverPopup);
			registerSignal(GameOverSignal, BattleScreen);
			
			registerSignal(MapLoadedSignal, BattleScreen);
			registerSignal(MapLoadedSignal, BattleController);
			
			registerSignal(RequestBattleSignal, BattleController);
			registerSignal(RootCraetedSignal, GameJuggler);
			registerSignal(ShowCommanderOptionsSignal, CommanderPopup);
			registerSignal(UnitAddedSignal, BattleScreen);
		}
	}
}