package com.gazman.strategy_of_battle_package.units
{
	import com.gazman.strategy_of_battle_package.map.Map;

	public interface ICommanderController
	{
		/**
		 * Your summon logic goes here. You need to decide who you are going to summon
		 */
		function summon(map:Map, summonsLeft:int):String;
		
		/**
		 * When summons run out this is the only method that will be called each turn.
		 * Use it to create communication channale with your units.<br>
		 * Also this method implementation is optional
		 */
		function playTurn(map:Map):void;
		
		function summonShaman():IUnitController;
		
		function summonArcher():IUnitController;
		
		function summonKnight():IUnitController;
		
		/**
		 * Return 0 - 3 options(Strings) for the user, when user select an otion, handleOption() will be called
		 */
		function getUserOptions():Array;
		
		/**
		 * Handling user response
		 */
		function handleOption(option:String):void;
	}
}