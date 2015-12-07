"use strict";

var Config = module.exports = {
		cdns: {
			mojang: {
				format: "http://skins.minecraft.net/MinecraftSkins/{name}.png",
				styles: {
					flat: {
						transform: function (buffer, next) {
							lwip.open(buffer, 'png', function (err, image) {
								if (err) return next(err);

								image.crop(8, 8, 15, 15, function (err, image) {
									image.resize(64, 64, "nearest-neighbor", function (err, image) {
										image.toBuffer("png", next)
									});
								});
							});
						}
					}
				}
			},
			brony: {
				format: "http://minelpskins.voxelmodpack.com/skins/{uuid}.png",
				styles: {
					flat: {
						transform: function (buffer, next) {
							lwip.open(buffer, 'png', function (err, image) {
								if (err) return next(err);

								var scale = image.width()/8;

								image.extract(scale, scale, scale*2-1, scale*2-1, function (err, face) {
									image.extract(scale*5, scale, scale*6-1, scale*2-1, function (err, hair) {
										hair.crop((hair.width()/8), (hair.width()/8), hair.width()-(hair.width()/8)-1, hair.width()-(hair.width()/8)-1, function (err, hair) {
											hair.resize(64, 64, "nearest-neighbor", function (err, hair) {
												face.resize(64, 64, "nearest-neighbor", function (err, face) {
													face.paste(0, 0, hair, function (err, avatar) {
														avatar.toBuffer("png", next);
													});
												});
											});
										});
									});
								});
							});
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
	lwip    = require('lwip'),

	defaultSettings = {
		'address'    : "0.0.0.0:25565",
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
