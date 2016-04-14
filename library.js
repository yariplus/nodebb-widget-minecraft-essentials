'use strict';

var plugin = module.exports;

plugin.Widgets = require('./lib/widgets');
plugin.Hooks   = require('./lib/hooks');

var analytics = require('./lib/analytics');
var Backend   = require('./lib/backend');
var Config    = require('./lib/config');
var NodeBB    = require('./lib/nodebb');
var Utils     = require('./lib/utils');
var Updater   = require('./lib/updater');
var Views     = require('./lib/views');

plugin.load = function (data, next) {

	NodeBB.app        = data.app;
	NodeBB.router     = data.router;
	NodeBB.middleware = data.middleware;

	console.log("Loading Minecraft Widgets");

	NodeBB.init();

	// Settings
	NodeBB.SocketAdmin.settings.syncMinecraftWidgets = function(){
		Config.settings.sync(function(){
			Config.logSettings();
		});
	};

	Updater.updateServers();

	next();
};

plugin.getConfig = function (data, next) {
	data.MinecraftWidgets = Config.settings.get();
	data.MinecraftWidgets.onlinePlayers = Backend.status ? Backend.status.onlinePlayers : 0;
	next(null, data);
};
