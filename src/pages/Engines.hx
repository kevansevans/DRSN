package pages;

import haxe.ui.containers.Box;
import haxe.ui.containers.Grid;
import haxe.ui.containers.VBox;
import network.RepoBox;

/**
 * ...
 * @author Kaelan
 */
class Engines extends Box 
{
	var vscroll:VBox;
	var itemgrid:Grid;
	var page_loaded:Bool = false;
	
	var engine_repos:Array<String> = [
		"https://github.com/coelckers/gzdoom",
		"https://github.com/chocolate-doom/chocolate-doom",
		"https://github.com/fabiangreffrath/crispy-doom",
	];
	var repoboxes:Array<RepoBox>;
	
	public function new() 
	{
		super();
		
		this.text = "Engines";
		
		vscroll = new VBox();
		addComponent(vscroll);
		
		itemgrid = new Grid();
		vscroll.addComponent(itemgrid);
		
		repoboxes = new Array();
	}
	
	public function startLoading() {
		if (!page_loaded) {
			for (url in engine_repos) {
				var repobox = new RepoBox();
				repobox.repo = url;
				repoboxes.push(repobox);
			}
			for (index in 0...repoboxes.length) {
				if (repoboxes[index + 1] != null) {
					repoboxes[index].nextmodule = repoboxes[index + 1];
				}
				itemgrid.addComponent(repoboxes[index]);
			}
			repoboxes[0].loadRepo();
			page_loaded = true;
		}
	}
}