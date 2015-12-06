"use strict";

(function(nbb){

	var NodeBB = module.exports = {
		SocketIO      : nbb.require('./src/socket.io'),
		SocketAdmin   : nbb.require('./src/socket.io/admin'),
		SocketPlugins : nbb.require('./src/socket.io/plugins'),
		Meta          : nbb.require('./src/meta'),
		Settings      : nbb.require('./src/settings'),
		User          : nbb.require('./src/user'),
		Plugins       : nbb.require('./src/plugins'),
		Password      : nbb.require('./src/password'),
		db            : nbb.require('./src/database'),
		pubsub        : nbb.require('./src/pubsub'),
		tjs           : nbb.require('templates.js'),
		translator    : nbb.require('./public/src/modules/translator')
	};

	NodeBB.init = function () {

		function render(req, res, next) {
			res.render('admin/plugins/minecraft-widgets', { });
		}

		NodeBB.router.get('/admin/plugins/minecraft-widgets', NodeBB.middleware.admin.buildHeader, render);
		NodeBB.router.get('/api/admin/plugins/minecraft-widgets', render);

	};

}(require.main));
