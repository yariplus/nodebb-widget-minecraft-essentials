"use strict";

var	NodeBB = require('./nodebb'),
	Config = require('./config'),

	fs = require('fs'),
	path = require('path'),
	async = require('async'),

	Views = module.exports = { };

Views.buildAdminHeader = function (custom_header, next) {
	custom_header.plugins.push({
		"route": '/plugins/minecraft-widgets',
		"icon": 'fa-cube',
		"name": 'Minecraft Widgets'
	});

	return next(null, custom_header);
};

Views.getWidgets = function (widgets, next) {
	var _widgets = [
		{ widget: "mw-status", name: "Minecraft Basic Status", content: 'admin/widgets/mw-status.tpl', description: "Lists information on a Minecraft server." }
	];

	async.each(_widgets, function (widget, next) {
		NodeBB.app.render(widget.content, {}, function (err, content) {
			NodeBB.translator.translate(content, function (content) {
				widget.content = content;
				next();
			});
		});
	}, function (err) {
		widgets = widgets.concat(_widgets);
		next(null, widgets);
	});
};
