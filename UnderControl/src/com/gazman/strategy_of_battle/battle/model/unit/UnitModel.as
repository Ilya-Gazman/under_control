package com.gazman.strategy_of_battle.battle.model.unit
{
	import com.gazman.strategy_of_battle.battle.model.commander.Commander;
	import com.gazman.strategy_of_battle.battle.model.unit.signals.animation_complete.AnimationCompleteSignal;
	import com.gazman.strategy_of_battle.battle.model.unit.signals.attack.AttackSignal;
	import com.gazman.strategy_of_battle.battle.model.unit.signals.miss.MissSignal;
	import com.gazman.strategy_of_battle.battle.model.unit.signals.move.MoveSignal;
	import com.gazman.strategy_of_battle.battle.model.unit.signals.remove_yoursself.RemoveYourselfSignal;
	import com.gazman.strategy_of_battle.battle.model.unit.signals.take_damage.TakeDamageSignal;
	import com.gazman.strategy_of_battle_package.units.data.UnitStates;
	import com.gazman.strategy_of_battle_package.units.IUnitController;
	
	public class UnitModel
	{
		private var _id:int = idCounter++;
		private static var idCounter:int = 1;
		private var _commander:Commander;
		private var _states:UnitStates;
		private var _stamina:int;
		public var life:int = -1;
		public var viewLife:int;
		private var _controller:IUnitController;
		
		// Signals are signle tones, how ever I want each model to have it's own signals set
		// This is why I use the "new" keyword here and not inject.
		public const signal_move:MoveSignal = new MoveSignal();
		public const signal_miss:MissSignal = new MissSignal();
		public const signal_attack:AttackSignal = new AttackSignal();
		public const signal_takeDamage:TakeDamageSignal = new TakeDamageSignal();
		public const signal_removeYourself:RemoveYourselfSignal = new RemoveYourselfSignal();
		public const signal_animationComplete:AnimationCompleteSignal = new AnimationCompleteSignal();
		private var _currentAnimation:String = null;
		
		public function UnitModel()
		{
			super();
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function set id(value:int):void
		{
			if (idCounter < value)
			{
				idCounter = value + 1;
			}
			_id = value;
		}
		
		public function init(controller:IUnitController, states:UnitStates, commander:Commander):void
		{
			_commander = commander;
			_controller = controller;
			_states = states;
			if (life == -1)
			{
				life = states.life;
			}
			viewLife = life;
		}
		
		public function resetStamina():void
		{
			_stamina = states.stamina;
		}
		
		public function reduceLife(damage:int):void
		{
			life = calculateDamge(life, damage);
			if (life == 0) {
				commander.removeUnit(this);
			}
			//notifyDamage(damage);
		}
		
		private function calculateDamge(life:int, damage:int):int {
			if (damage > 0)
			{
				life -= damage;
				if (life <= 0)
				{
					life = 0;
				}
			}
			else if (life - damage < states.life * 1.2)
			{
				life -= damage;
			}
			
			return life;
		}
		
		public function isActive():Boolean
		{
			return stamina > 0 && life > 0;
		}
		
		public function reduceStamina(amount:int):void
		{
			if (amount > _stamina)
			{
				throw new Error("Not enough stamina");
			}
			
			_stamina -= amount;
		}
		
		public function notifyMiss(target:UnitModel, x:int, y:int):void
		{
			signal_miss.missHandler(target, x, y);
		}
		
		public function notifyMove(x:Number, y:Number):void
		{
			signal_move.moveHandler(x, y);
		}
		
		public function notifyAttack(target:UnitModel, damage:int, x:Number, y:Number):void
		{
			signal_attack.attackHandler(target, damage, x, y);
		}
		
		public function notifyDamage(damange:int):void
		{
			viewLife = calculateDamge(viewLife, damange);
			
			if (viewLife <= 0)
			{
				viewLife = 0;
				signal_removeYourself.removeYourselfHandler();
			}
			else
			{
				signal_takeDamage.takeDamageHandler(damange);
			}
		}
		
		public function get commander():Commander
		{
			return _commander;
		}
		
		public function get states():UnitStates
		{
			return _states;
		}
		
		public function get stamina():int
		{
			return _stamina;
		}
		
		public function set stamina(value:int):void
		{
			_stamina = value;
		}
		
		public function get controller():IUnitController
		{
			return _controller;
		}
		
		public function get currentAnimation():String
		{
			return _currentAnimation;
		}
		
		public function set currentAnimation(value:String):void
		{
			if (_currentAnimation == value)
			{
				return;
			}
			_currentAnimation = value;
			if (!value)
			{
				signal_animationComplete.animationCompleteHandler();
			}
		}
	}
}