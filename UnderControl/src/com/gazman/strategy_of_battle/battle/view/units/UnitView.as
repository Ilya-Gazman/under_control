package com.gazman.strategy_of_battle.battle.view.units
{
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.life_cycle.Signal;
	import com.gazman.strategy_of_battle.battle.controller.signals.GameOverSignal;
	import com.gazman.strategy_of_battle.battle.controller.signals.IGameOverSignal;
	import com.gazman.strategy_of_battle.battle.model.animation_queue.AnimationQue;
	import com.gazman.strategy_of_battle.battle.model.BattleModel;
	import com.gazman.strategy_of_battle.battle.model.Resources;
	import com.gazman.strategy_of_battle.battle.model.unit.signals.attack.IAttackSignal;
	import com.gazman.strategy_of_battle.battle.model.unit.signals.miss.IMissedSignal;
	import com.gazman.strategy_of_battle.battle.model.unit.signals.move.IMovedSignal;
	import com.gazman.strategy_of_battle.battle.model.unit.signals.remove_yoursself.IRemoveYourselfSignal;
	import com.gazman.strategy_of_battle.battle.model.unit.signals.take_damage.ITakeDamageSignal;
	import com.gazman.strategy_of_battle.battle.model.unit.UnitModel;
	import com.gazman.strategy_of_battle.battle.view.GameJuggler;
	import com.gazman.strategy_of_battle.battle.view.units.Animation;
	import com.gazman.strategy_of_battle.battle.view.units.animations.AttackAnimation;
	import com.gazman.strategy_of_battle.battle.view.units.animations.MissAnimation;
	import com.gazman.strategy_of_battle.battle.view.units.animations.MoveAnimation;
	import com.gazman.strategy_of_battle.battle.view.units.animations.RemoveYourSelfAnimation;
	import com.gazman.strategy_of_battle.battle.view.units.animations.TakeDamageAnimation;
	import com.gazman.strategy_of_battle_package.map.Map;
	import com.gazman.strategy_of_battle_package.resources.ResourcesPackage;
	import com.gazman.strategy_of_battle_package.units.enums.UnitEnum;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.group.strict.StrictGroup;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.progress_bar.ProgressBar;
	import starling.animation.Tween;
	import starling.display.Image;
	import starling.filters.BlurFilter;
	import starling.utils.Color;
	
	
	public class UnitView extends StrictGroup implements IMovedSignal, IAttackSignal, ITakeDamageSignal, IMissedSignal, IRemoveYourselfSignal, IGameOverSignal
	{
		private var resources:Resources = inject(Resources);
		private var background:Image;
		private var unitModel:UnitModel;
		private var animationQue:AnimationQue = inject(AnimationQue);
		private var gameJuggler:GameJuggler = inject(GameJuggler);
		private var cellHeight:int;
		private var cellWidth:int;
		private var isFirstMove:Boolean = true;
		private var battleModel:BattleModel = inject(BattleModel);
		private var deltaY:int;
		private var deltaX:int;
		private var lifeBar:ProgressBar = inject(ProgressBar);
		private var signals:Vector.<Signal> = new Vector.<Signal>();
		private var lastTween:Tween;
		private var lastAnimation:Animation;
		private var resourcesPackage:ResourcesPackage;
		
		public function UnitView(resourcesPackage:ResourcesPackage)
		{
			this.resourcesPackage = resourcesPackage;
		}
		
		override protected function addChildrenHandler():void
		{
			var texture:String;
			switch (unitModel.states.type)
			{
				case UnitEnum.ARCHER: 
					texture = resourcesPackage.archerIcon;
					break;
				case UnitEnum.KNIGHT: 
					texture = resourcesPackage.knightIcon;
					break;
				case UnitEnum.LION: 
					texture = "pirate.png"
					break;
				default: 
				case UnitEnum.SHAMAN: 
					texture = resourcesPackage.shamanIcon;
					break;
			}
			background = injectWithParams(Image, [resources.getTexture(texture)]);
			var color:int;
			if (unitModel.commander.name == battleModel.myCommander.name)
			{
				color = Color.GREEN;
			}
			else
			{
				color = Color.RED;
			}
			filter = BlurFilter.createGlow(color, 2, 2, 1);
			addChild(background);
			initLifeBar();
			updateLife(false);
		}
		
		private function initLifeBar():void 
		{
			addChild(lifeBar);
			lifeBar.juggler = gameJuggler;
		}
		
		override protected function initLayout():void
		{
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.horizontalCenter = 0;
			containerLayout.applyLayoutOn(lifeBar, background);
			var alignLayout:AlignLayout = new AlignLayout();
			alignLayout.below = -5;
			alignLayout.applyLayoutOn(background, lifeBar);
			pivotX = width / 2;
			pivotY = height / 2;
		}
		
		public function attackHandler(target:UnitModel, damage:int, x:Number, y:Number):void
		{
			var attackAnimation:AttackAnimation = new AttackAnimation();
			initAnimation(attackAnimation);
			attackAnimation.init(target, damage, x, y);
			addAnimation(attackAnimation);
		}
		
		public function missHandler(target:UnitModel, x:int, y:int):void
		{
			var missAnimation:MissAnimation = new MissAnimation();
			initAnimation(missAnimation);
			missAnimation.init(target, x, y);
			addAnimation(missAnimation);
		}
		
		public function removeYourselfHandler():void
		{
			var removeYourSelfAnimation:RemoveYourSelfAnimation = new RemoveYourSelfAnimation();
			initAnimation(removeYourSelfAnimation);
			removeYourSelfAnimation.init();
			removeYourSelfAnimation.onStart = updateLife;
			addAnimation(removeYourSelfAnimation);
		}
		
		public function takeDamageHandler(damage:int):void
		{
			var takeDamageAnimation:TakeDamageAnimation = new TakeDamageAnimation();
			initAnimation(takeDamageAnimation);
			takeDamageAnimation.init(damage);
			takeDamageAnimation.onStart = updateLife;
			addAnimation(takeDamageAnimation);
		}
		
		public function moveHandler(x:int, y:int):void
		{
			if (isFirstMove)
			{
				isFirstMove = false;
				this.x = x * cellWidth + deltaX;
				this.y = y * cellHeight + deltaY;
				return;
			}
			var moveAnimation:MoveAnimation = new MoveAnimation();
			initAnimation(moveAnimation);
			moveAnimation.init(x, y);
			addAnimation(moveAnimation);
		}
		
		private function initAnimation(animation:Animation):void
		{
			animation.cellWidth = cellWidth;
			animation.cellHeight = cellHeight;
			animation.deltaX = deltaX;
			animation.deltaY = deltaY;
			animation.target = this;
			animation.unitModel = unitModel;
		}
		
		private function updateLife(animate:Boolean = true):void
		{
			lifeBar.setProgress(unitModel.viewLife / unitModel.states.life, animate);
		}
		
		public function addAnimation(animation:Animation):void
		{
			if (unitModel.currentAnimation != null)
			{
				if (lastAnimation == null)
				{
					throw new Error("Unit view and Model view are not synchronized");
				}
				if (lastAnimation.type == animation.type)
				{
					return;
				}
				lastAnimation.nextAnimation = animation;
			}
			else
			{
				lastAnimation = animation;
				lastAnimation.start();
			}
		}
		
		override protected function verifyDependencies():Boolean
		{
			return false;
		}
		
		public function setModel(unitModel:UnitModel):void
		{
			this.unitModel = unitModel;
			
			addListener(unitModel.signal_attack);
			addListener(unitModel.signal_miss);
			addListener(unitModel.signal_move);
			addListener(unitModel.signal_removeYourself);
			addListener(unitModel.signal_takeDamage);
			addListener(inject(GameOverSignal));
		}
		
		private function addListener(signal:Signal):void
		{
			signals.push(signal);
			if (signal.hasListener(this))
			{
				throw new Error("Already registred");
			}
			signal.addListener(this);
		}
		
		public function gameOverHandler(won:Boolean):void
		{
			dispose();
		}
		
		override public function dispose():void
		{
			if (unitModel.currentAnimation != null)
			{
				throw new Error("How this happaned?");
			}
			if (lastAnimation != null && lastAnimation.isRunning)
			{
				throw new Error(":(");
			}
			if (signals.length == 0)
			{
				throw new Error("How this happaned?");
			}
			for each (var signal:Signal in signals)
			{
				signal.removeListener(this);
			}
			unitModel = null;
			signals.splice(0, signals.length);
			super.dispose();
		}
		
		public function setRoot(rootView:Group):void
		{
			cellWidth = rootView.width / Map.WIDTH;
			cellHeight = rootView.height / Map.HEIGHT;
			deltaX = (width - cellWidth) / 2;
			deltaY = (height - cellHeight) / 2;
		}
	}
}