"use strict";

var	NodeBB  = require('./nodebb'),
	Backend = require('./backend'),

	Widgets = module.exports = { };

Widgets['map']    = require('./widgets/map');
Widgets['status'] = require('./widgets/status');

Widgets.renderMap    = function (widget, callback) { render("map", widget, callback); };
Widgets.renderStatus = function (widget, callback) { render("status", widget, callback); };

function render(type, widget, callback) {

	widget.data.status = Backend.status;

	Widgets[type].render(data, function (err, data) {
		if (err) return callback(null, '');

		NodeBB.app.render('widgets/' + type, data, function(err, html) {
			NodeBB.translator.translate(html, function(translatedHTML) {
				callback(null, translatedHTML);
			});
		});
	});
}
