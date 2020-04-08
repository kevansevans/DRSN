package pages;

import haxe.ui.components.Label;
import haxe.ui.containers.Box;
import haxe.ui.containers.VBox;

/**
 * ...
 * @author Kaelan
 */
class Home extends Box 
{
	var welcome_box:VBox;
	var welcome_label:Label;
	public function new() 
	{
		super();
		
		this.text = "Home";
		
		welcome_box = new VBox();
		addComponent(welcome_box);
		
		welcome_label = new Label();
		welcome_label.text = 	['Welcome to the Doom Repository Sharing Network! Alpha Version\n',
								'----------\n',
								'The goal of this project is to provide an easy to access collection of\n',
								'Doom related tools, assets, materials, mods, where all users can contribute\n',
								'without the need of a centralized approval process, but offers one anyways\n',
								'----------\n',
								'This project is in a very early proof of concept stage and is willing to allow\n',
								'members to join in on the project and help maintain it.'
								].join("");
			
		addComponent(welcome_label);
	}
	
}