package com.gazman.strategy_of_battle_package.errors
{
	public class NotImplementedError extends Error
	{
		public function NotImplementedError()
		{
			super("Not implemented error", 666);
		}
	}
}