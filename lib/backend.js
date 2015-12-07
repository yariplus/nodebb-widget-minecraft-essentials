"use strict";

var	NodeBB     = require('./nodebb'),
	Config     = require('./config'),
	Utils      = require('./utils'),

	async      = require('async'),
	request    = require('request'),
	winston    = require('winston'),

	Backend    = module.exports = { };

// Get the avatar base64 from the database.
function getAvatar(name, callback) {

	var	key  = 'mi:avatar:' + name;

	NodeBB.db.get(key, function (err, base64) {

		if (err) console.log(err);

		if (base64) return callback(null, base64);

		console.log("Avatar for player " + name + " was not found, fetching it from cdn...");

		fetchAvatar(name, function (err, binary, base64) {
			callback(null, base64);
		});

	});
}

Backend.getAvatar = function (data, callback) {

	// Asserts
	if (!(data && data.name && typeof data.name === 'string')) return callback(new Error("Invalid Data passed to getAvatar: " + data));

	getAvatar(data.name, function (err, base64) {
		if (data.size) {
			callback(err, new Buffer(base64, 'base64'));
		}else{
			callback(err, base64);
		}
	});

};

// Get list of avatar names in the database
Backend.getAvatarList = function (data, callback) {
	NodeBB.db.getSortedSetRange('mi:avatars', 0, -1, function (err, list) {
		callback(err, list ? list.sort() : []);
	});
};

Backend.clearOldAvatars = function (options, next) {
	NodeBB.db.sortedSetsRemoveRangeByScore(['mi:avatars'], 0, Date.now() - Config.getAvatarExpiry() * 1000, function (err) {
		if (err) console.log("Backend.clearOldAvatars error:", err);
		if (typeof next === 'function') next();
	});
};

Backend.refreshAvatar = function (data, next) {

	var	name = data.name;

	Backend.deleteAvatar(data, function () {
		fetchAvatar(name, function (err, binary, base64) {
			next(err, {base64: base64});
		});
	});
};

Backend.deleteAvatar = function (data, next) {

	var	name = data.name,
		key = 'mi:avatar:' + name;

	NodeBB.db.delete(key);
	NodeBB.db.sortedSetRemove('mi:avatars', name);

	next();
};

Backend.resetAvatars = function (data, callback) {
	Backend.getAvatarList({}, function (err, avatarList) {
		async.each(avatarList, function (player, next) {
			var key    = 'mi:avatar:' + player;

			NodeBB.db.delete(key);
			NodeBB.db.sortedSetRemove('mi:avatars', player);

			next();
		}, function (err) {
			callback(err);
		});
	});
};

Backend.setAvatar = function (data) {
};

// Gets the avatar from the configured cdn.
function fetchAvatar(name, next) {

	// Avatar database key. Stores the Base64 String.
	var key  = 'mi:avatar:' + name;

	async.parallel({
		url:     async.apply(Config.getAvatarUrl, {name: name, size: 64}), // The full url for the avatar.
		profile: async.apply(Backend.getProfileFromName, name)             // We need this for cdns that use uuids.
	}, function (err, payload) {

		if (err) {
			console.log(err);
			return next(err, null, null);
		}

		var url = payload.url.replace('{uuid}', payload.profile.id);

		console.log("Fetching: " + url);

		function transform(response, body, next) {
			var cdn = Config.settings.get('avatarCDN');
			if (Config.cdns[cdn].styles && Config.cdns[cdn].styles.flat && Config.cdns[cdn].styles.flat.transform) {
				Config.cdns[cdn].styles.flat.transform(body, next);
			}else{
				next(null, body);
			}
		}

		function storeAvatar(avatar, next) {
			avatar = new Buffer(avatar);
			var base64 = avatar.toString('base64');
			NodeBB.db.set(key, base64, function (err) {
				if (err) return callback(err);

				// Expire the avatar.
				console.log("Expiring " + key + " in " + Config.getAvatarExpiry() + " seconds.");
				NodeBB.db.expire(key, Config.getAvatarExpiry());

				return next(null, avatar, base64);
			});

			// Add to avatar set.
			NodeBB.db.sortedSetAdd('mi:avatars', Date.now(), name);
		}

		function storeSteve(next) {

			NodeBB.db.set(key, Config.steve, function (err) {

				if (err) return callback(err);

				// Expire the avatar.
				console.log("Expiring " + key + " in " + Config.getAvatarExpiry() + " seconds.");
				NodeBB.db.expire(key, Config.getAvatarExpiry());

				return next(null, null, Config.steve);

			});

			// Add to avatar set.
			NodeBB.db.sortedSetAdd('mi:avatars', Date.now(), name);
		}

		async.waterfall([
			async.apply(request, {url: url, encoding: null}),
			async.apply(transform)
		], function (err, avatar) {
			if (err) {
				console.log("Could not retrieve skin using the cdn: " + Config.settings.get('avatarCDN'));
				if (Config.settings.get('avatarCDN') === 'mojang') return storeSteve(next);

				// Try Mojang
				async.waterfall([
					async.apply(request, {url: 'http://skins.minecraft.net/MinecraftSkins/' + name + '.png', encoding: null}),
					function (response, body, next) {
						console.log("Defaulting to Mojang skin.");
						Config.cdns['mojang'].styles.flat.transform(body, next);
					}
				], function (err, avatar) {
					if (err) {

						console.log("Couldn't connect to Mojang skin server.");

						return storeSteve(next);

					}else{
						storeAvatar(avatar, next);
					}
				});
			}else{
				storeAvatar(avatar, next);
			}
		});
	});
};
