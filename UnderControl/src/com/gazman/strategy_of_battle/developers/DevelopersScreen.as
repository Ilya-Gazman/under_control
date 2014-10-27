package com.gazman.strategy_of_battle.developers 
{
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.strategy_of_battle.battle.model.Resources;
	import com.gazman.strategy_of_battle.developers.signals.IDevelopersSignal;
	import com.gazman.strategy_of_battle.menu.view.MenuButton;
	import com.gazman.strategy_of_battle.screens.Screen;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.utils.ShapeTextur;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.utils.HAlign;
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class DevelopersScreen extends Screen implements IDevelopersSignal, ISingleTon
	{
		private var backgroundImage:Image;
		private var description:TextField;
		private var seeChallenge:MenuButton;
		private var fork:MenuButton;
		private var resources:Resources = inject(Resources);
		
		
		public function developersHandler():void 
		{
			open();
		}
		
		override protected function initilize():void 
		{
			super.initilize();
			initBackground();
			initDescription();
			seeChallenge = inject(MenuButton);
			fork = inject(MenuButton);
			addChild(seeChallenge.view);
			addChild(fork.view);
			seeChallenge.text = "Review Challenge";
			fork.text = "Show source code";
			layout();
		}
		
		private function initBackground():void
		{
			backgroundImage = injectWithParams(Image, [resources.getTexture("menu.png")]);
			var containerLayout:ContainerLayout = inject(ContainerLayout);
			containerLayout.center();
			containerLayout.applyLayoutOn(backgroundImage, background);
			addChild(backgroundImage);
		}
		
		private function layout():void 
		{
			var containerLayout:ContainerLayout = new ContainerLayout();
			var alignLayout:AlignLayout = new AlignLayout();
			
			containerLayout.left = 10;
			containerLayout.applyLayoutOn(description, background);
			containerLayout.applyLayoutOn(fork.view, background);
			containerLayout.applyLayoutOn(seeChallenge.view, background);
			alignLayout.below = 10;
			alignLayout.applyLayoutOn(seeChallenge.view, description);
			alignLayout.applyLayoutOn(fork.view, seeChallenge.view);
		}
		
		private function initDescription():void 
		{
			description = new TextField(500, 100, "Do you like this game?\nWould you like to build your own commander?\n\nJoin the developer challange on \"Programming Puzzles & Code Golf\"");
			description.hAlign = HAlign.LEFT;
			addChild(description);
		}
		
	}

}


/*

package com.gazman.strategy_of_battle.developers 
{
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.strategy_of_battle.battle.model.Resources;
	import com.gazman.strategy_of_battle.developers.signals.IDevelopersSignal;
	import com.gazman.strategy_of_battle.menu.view.MenuButton;
	import com.gazman.strategy_of_battle.screens.Screen;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.utils.ShapeTextur;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.utils.HAlign;
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	/*public class DevelopersScreen extends Screen implements IDevelopersSignal, ISingleTon
	{
		private var backgroundImage:Image;
		private var description:TextField;
		private var seeChallenge:MenuButton;
		private var fork:MenuButton;
		private var resources:Resources = inject(Resources);
		
		
		public function developersHandler():void 
		{
			open();
		}
		
		override protected function initilize():void 
		{
			initBackground();
			initDescription();
			seeChallenge = inject(MenuButton);
			fork = inject(MenuButton);
			addChild(seeChallenge.view);
			addChild(fork.view);
			seeChallenge.text = "Review Challenge";
			fork.text = "Show source code";
			layout();
		}
		
		private function initBackground():void
		{
			backgroundImage = injectWithParams(Image, [resources.getTexture("menu.png")]);
			var containerLayout:ContainerLayout = inject(ContainerLayout);
			containerLayout.center();
			containerLayout.applyLayoutOn(backgroundImage, background);
			addChild(backgroundImage);
		}
		
		private function layout():void 
		{
			var containerLayout:ContainerLayout = new ContainerLayout();
			var alignLayout:AlignLayout = new AlignLayout();
			
			containerLayout.left = 10;
			containerLayout.applyLayoutOn(description, background);
			containerLayout.applyLayoutOn(fork.view, background);
			containerLayout.applyLayoutOn(seeChallenge.view, background);
			alignLayout.below = 10;
			alignLayout.applyLayoutOn(seeChallenge.view, description);
			alignLayout.applyLayoutOn(fork.view, seeChallenge.view);
		}
		
		private function initDescription():void 
		{
			description = new TextField(500, 100, "Do you like this game?\nWould you like to build your own commander?\n\nJoin the developer challange on \"Programming Puzzles & Code Golf\"");
			description.hAlign = HAlign.LEFT;
			addChild(description);
		}
		
	}

}

*/