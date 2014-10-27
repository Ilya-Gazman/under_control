package com.gazman.strategy_of_battle_package.map
{
	
	public class Map
	{
		public static const WIDTH:int = 40;
		public static const HEIGHT:int = 15;
		
		private var cells:Vector.<Vector.<Cell>> = new Vector.<Vector.<Cell>>();
		
		public function get width():int{
			return cells.length;
		}
		
		public function get height():int{
			return cells[0].length;
		}
		
		public function Map(cells:Vector.<Vector.<Cell>>){
			this.cells = cells;
		}
		
		/**
		 * Check if it's your ally or enemy 
		 * @param unit the unit who wants to know
		 * @param x map coordinations
		 * @param y map coordinations
		 * @return if the cell contain ally unit.
		 * 
		 */		
		public function isAlly(x:int, y:int, yourCommander:String):Boolean{
			return cells[x][y].commander == yourCommander;
		}
		
		public function isBlocked(x:int, y:int):Boolean{
			return cells[x][y].isBlocked;
		}
		
		/**
		 * Check if cell is empty from units and obsticles 
		 * @param x map coordinations
		 * @param y map coordinations
		 * @return if there is any unit on the cell
		 * 
		 */		
		public function isEmpty(x:int, y:int):Boolean{
			return !cells[x][y].isBlocked && cells[x][y].commander == null;
		}
		
		public function toString():String{
			var out:String = "";
			for(var x:int = 0;x < cells.length; x++){
				out += "\n";
				for(var y:int = 0; y < cells[x].length; y++){
					out += cells[x][y] + " ";
				}
			}
			return out;
		}
	}
}