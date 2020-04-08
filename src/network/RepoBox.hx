package network;

import haxe.ui.containers.VBox;
import haxe.ui.util.Color;
import haxe.ui.components.Label;
import haxe.ui.components.DropDown;
import haxe.ui.components.Button;
import haxe.ui.containers.HBox;
import haxe.ui.data.ArrayDataSource;
import haxe.ui.events.UIEvent;
import haxe.Http;
import haxe.Json;
import lime.net.HTTPRequest;
import lime.net.HTTPRequestHeader;
import haxe.io.Bytes;
import openfl.Lib;
import openfl.net.URLRequest;


/**
 * ...
 * @author Kaelan
 */
class RepoBox extends VBox 
{
	var items:Map<String, String>;
	public var nextmodule:Null<RepoBox> = null;
	
	var title:Label;
	var version:Label;
	var item_dropdown:DropDown;
	var download_button:Button;
	var dropdown_items:ArrayDataSource<String>;
	var hbox_download:HBox;
	public var repo:String;
	public function new() 
	{
		super();
		
		width = 400;
		backgroundColor = Color.fromComponents(0x88, 0x88, 0x88, 0xFF);
		
		title = new Label();
		title.text = "Loading repository...";
		addComponent(title);
		
		version = new Label();
		addComponent(version);
		
		item_dropdown = new DropDown();
		download_button = new Button();
		download_button.text = "Download Package";
		hbox_download = new HBox();
		
		dropdown_items= new ArrayDataSource();
		
		hbox_download.addComponent(item_dropdown);
		hbox_download.addComponent(download_button);
	}
	
	public function loadRepo() {
		
		items = new Map();
		var apiurl:String = "https://api.github.com/repos/";
		
		//convert provided repository URL into Github API URL
		
		var repo_loc:String = repo.substr(repo.indexOf(".com/") + 5, repo.length);
		var release:String = apiurl + repo_loc + "/releases/latest";
		
		var http_repo = new Http(release);
		
		http_repo.onData = function(_packet:String) {
			var data:Dynamic = Json.parse(_packet);
			
			title.text = data.name;
			version.text = data.tag_name;
			
			var dlArray:Array<Dynamic> = data.assets;
			for (dl_item in dlArray) {
				var dl_string:String = dl_item.browser_download_url.substr(dl_item.browser_download_url.lastIndexOf("/") + 1);
				dropdown_items.add(dl_string);
				items[dl_string] = dl_item.browser_download_url;
			}
			item_dropdown.dataSource = dropdown_items;
			item_dropdown.updateComponentDisplay();
			addComponent(hbox_download);
			
			if (nextmodule != null) nextmodule.loadRepo();
			
			download_button.onClick = downloadPackage;
		}
		http_repo.onError = function(_packet:String) {
			title.text = "Failed to load repository";
			if (nextmodule != null) nextmodule.loadRepo();
		}
		http_repo.setHeader('User-Agent', 'DRSN');
		http_repo.request();
	}
	
	function downloadPackage(e:UIEvent)
	{
		var pack = items[item_dropdown.value];
		
		Lib.navigateToURL(new URLRequest(pack));
	}
	
}