"use strict";

var Config = module.exports = {
		cdns: {
			mojang: {
				format: "http://skins.minecraft.net/MinecraftSkins/{name}.png",
				styles: {
					flat: {
						transform: function (buffer, next) {
						}
					}
				}
			},
			brony: {
				format: "http://minelpskins.voxelmodpack.com/skins/{uuid}.png",
				styles: {
					flat: {
						transform: function (buffer, next) {
						}
					}
				}
			},
			cravatar: {
				format: "http://cravatar.eu/avatar/{name}/{size}"
			},
			signaturecraft: {
				format: "http://signaturecraft.us/avatars/{size}/face/{name}.png"
			},
			minotar: {
				format: "http://minotar.net/avatar/{name}/{size}"
			},
		}
	},

	NodeBB = require('./nodebb'),
	Utils  = require('./utils'),

	async   = require('async'),
	util    = require('util'),
	request = require('request'),

	defaultSettings = {
		'address'    : "0.0.0.0",
		'queryport'  : "25565",
		'name'       : "A Minecraft Server",
		'avatarCDN'  : "mojang",
		'pingExpiry' : 365
	};

Config.settings = new NodeBB.Settings('minecraft-widgets', '1.0.0', defaultSettings);

Config.logSettings = function () {
	console.log(util.inspect(Config.settings.get(), { showHidden: true, depth: null }));
};

Config.getAvatarExpiry = function () {
	return 60 * 60;
};

Config.getAvatarUrl = function (data, callback) {
	var cdn = Config.settings.get('avatarCDN');

	if (cdn === 'custom') {
		cdn = Config.settings.get('customCDN');
	}else{
		cdn = Config.cdns[Config.settings.get('avatarCDN')].format;
	}

	if (data && data.size) {
		cdn = cdn.replace("{size}", data.size)
	}else{
		cdn = cdn.replace("{size}", Config.settings.get('avatarSize'));
	}
	if (data && data.name) cdn = cdn.replace("{name}", data.name);

	callback(null, cdn);
};
