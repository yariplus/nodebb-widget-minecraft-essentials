"use strict";

var	NodeBB  = require('./nodebb'),
	Backend = require('./backend'),
	Config  = require('./config'),

	Widgets = module.exports = { };

Widgets['map']    = require('./widgets/map');
Widgets['status'] = require('./widgets/status');

Widgets.renderMap    = function (widget, callback) { render("map", widget, callback); };
Widgets.renderStatus = function (widget, callback) { render("status", widget, callback); };

function render(type, widget, callback) {

	// Defaults
	widget.data.onlinePlayers = '?';
	widget.data.maxPlayers    = '?';

	if (Backend.status) {
		for (var p in Backend.status) widget.data[p] = Backend.status[p];
	}else{
		var config = Config.settings.get();
		for (var p in config) widget.data[p] = config[p];
	}

	if (!widget.data.showIcon) widget.data.icon = null;

	Widgets[type].render(widget.data, function (err, data) {
		if (err) return callback(null, '');

		NodeBB.app.render('widgets/mw-' + type, data, function(err, html) {
			NodeBB.translator.translate(html, function(translatedHTML) {
				callback(null, translatedHTML);
			});
		});
	});
}
