package;

import haxe.ui.events.UIEvent;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.Event;
import pages.Engines;
import pages.Home;

import haxe.ui.Toolkit;
import haxe.ui.containers.TabView;

/**
 * ...
 * @author Kaelan
 */
class Main extends Sprite 
{
	var roottab:TabView;
	
	var home:Home;
	var engines:Engines;
	public function new() 
	{
		super();
		
		Toolkit.scaleX = 1.25;
		Toolkit.scaleY = 1.25;
		Toolkit.init();
		
		roottab = new TabView();
		addChild(roottab);
		
		resize();
		
		stage.addEventListener(Event.RESIZE, resize);
		
		home = new Home();
		engines = new Engines();
		
		roottab.addComponent(home);
		roottab.addComponent(engines);
		
		roottab.onChange = function(e:UIEvent) {
			switch(roottab.selectedPage.text.toUpperCase()) {
				case "HOME" :
				
				case "ENGINES" :
					engines.startLoading();
				default :
					trace("No handler!", roottab.selectedPage);
			}
		}
	}
	
	function resize(?e:Event) {
		roottab.x = roottab.y = 5;
		roottab.width = stage.stageWidth - 10;
		roottab.height = stage.stageHeight - 10;
	}

}
