"use strict";

var NodeBB = require('./nodebb'),
	Config = require('./config'),
	Views = require('./views'),
	async = require('async'),
	Hooks = module.exports = {
		filter: {
			admin: {
				header: {
					build: Views.buildAdminHeader
				}
			},
			widgets: {
				getWidgets: Views.getWidgets
			},
			post: {
				get: function (data, next) {
					//console.log("Post Data");
					//console.dir(data);
					next(null, data);
				},
				getPosts: function (data, next) {
					//{posts: posts, uid: uid}
					//console.log("Post Data");
					//console.dir(data);
					next(null, data);
				}
			},
			topic: {
				build: function (data, next) {
					//{req: req, res: res, templateData: data}
					if (!(data && data.templateData && data.templateData.posts && data.templateData.posts[0])) return next(null, data);

					data.templateData.prefixes = {};

					async.each(data.templateData.posts, function (post, next) {
						if (!(post && post.user && post.user.uid)) return next();
						NodeBB.User.getUserField(post.user.uid, 'yuuid', function (err, id) {
							post.user.yuuid = id;
							if (id && !data.templateData.prefixes[post.user.uid]) {
								NodeBB.db.getObjectField('yuuid:' + id, 'prefix', function (err, prefix) {
									data.templateData.prefixes[post.user.uid] = prefix;
									next();
								});
							}else{
								next();
							}
						});
					}, function (err) {
						next(null, data);
					});
				}
			},
			user: {
				create: function (userData, callback) {
					console.log('Setting new user avatar for ' + userData.username);
					//var picture = pic;
					//userData['picture'] = picture;
					//userData['uploadedpicture'] = picture;
					callback(null, userData);
				},
				profileLinks: function (links, next) {
					links.push({
						id: 'minecraft',
						public: true,
						route: 'minecraft',
						icon: 'fa-cube',
						name: 'Minecraft Profile'
					});
					next(null, links);
				}
			},
			users: {
			}
		}
	};
