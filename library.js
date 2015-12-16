"use strict";

var	plugin = module.exports = {
		Widgets: require('./lib/widgets'),
		Hooks: require('./lib/hooks')
	},

	Backend = require('./lib/backend'),
	Config  = require('./lib/config'),
	NodeBB  = require('./lib/nodebb'),
	Utils   = require('./lib/utils'),
	Updater = require('./lib/updater'),
	Views   = require('./lib/views');

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
