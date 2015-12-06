"use strict";

var NodeBB = require('../nodebb'),
	Config = require('../config'),
	Utils  = require('../utils'),

	ServerStatus = module.exports = { };

ServerStatus.render = function (data, callback) {

	data.isServerOnline = !!data.status;

	data.showPlayerCount  = data.showPlayerCount == "on" ? true : false;
	data.showAvatars      = data.showAvatars     == "on" ? true : false;
	data.showMOTD         = data.showMOTD        == "on" ? true : false;
	data.hidePluginList   = data.hidePluginList  == "on" ? true : false;
	data.showIP           = data.showIP          == "on" ? true : false;
	data.showModalMap     = data.showModalMap    == "on" ? true : false;

	data.version       = data.status.version;
	data.maxPlayers    = data.status.maxPlayers;
	data.onlinePlayers = data.status.onlinePlayers;

	data.showVersion = data.version ? true : false;

	callback(null, data);
};
