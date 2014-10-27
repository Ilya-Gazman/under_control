package com.gazman.strategy_of_battle_package.communication
{
	import flash.net.LocalConnection;

	public class CommunicationBridge
	{
		private static const CONNECTION_NAME:String = "local connection";
		public function CommunicationBridge()
		{
			var localConnection:LocalConnection = new LocalConnection();
			localConnection.connect(CONNECTION_NAME);
			localConnection.send(CONNECTION_NAME, "onRecieve");
			
		}
		
		private function onRecieve():void{
			
		}
	}
}