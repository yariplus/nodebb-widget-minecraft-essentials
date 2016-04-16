<form id="minecraft-widgets" autocomplete="off">

	<div>
		<label class="control-label" data-toggle="tooltip" data-placement="right" title="[[mw:help_server_name]]">[[mw:server_name]]</small></label>
		<input data-key="name" class="form-control" type="text" placeholder=""/>
	</div>

	<br>

	<div>
		<label class="control-label" data-toggle="tooltip" data-placement="right" title="[[mw:help_server_address]]">[[mw:server_address]]</small></label>
		<input data-key="address" class="form-control" type="text" placeholder=""/>
	</div>

	<div style="display:none;">
		<label for="avatarCDN" data-toggle="tooltip" data-placement="right" title="[[mw:help_avatar_cdn]]">[[mw:avatar_cdn]]</label>
		<select data-key="avatarCDN" class="form-control">
			<option value="mojang" selected="selected">Mojang</option>-->
			<option value="brony">Brony ModPack</option>
			<option value="cravatar">Cravatar.eu</option>
			<option value="minotar">Minotar</option>
			<option value="signaturecraft">Signaturecraft</option>
		</select>
	</div>

	<br>

	<div class="checkbox">
		<label class="mdl-switch mdl-js-switch mdl-js-ripple-effect">
			<input class="mdl-switch__input" type="checkbox" data-key="noQuery">
			<span class="mdl-switch__label" data-toggle="tooltip" data-placement="right" title="[[mw:help_navbar_status]]"><strong>[[mw:navbar_status]]</strong></span>
		</label>
	</div>

	<br>

	<div class="checkbox">
		<label class="mdl-switch mdl-js-switch mdl-js-ripple-effect">
			<input class="mdl-switch__input" type="checkbox" data-key="noQuery">
			<span class="mdl-switch__label" data-toggle="tooltip" data-placement="right" title="[[mw:help_show_icon]]"><strong>[[mw:show_icon]]</strong></span>
		</label>
	</div>

	<br>

	<div class="checkbox">
		<label class="mdl-switch mdl-js-switch mdl-js-ripple-effect">
			<input class="mdl-switch__input" type="checkbox" data-key="noQuery">
			<span class="mdl-switch__label" data-toggle="tooltip" data-placement="right" title="[[mw:help_no_query]]"><strong>[[mw:no_query]]</strong></span>
		</label>
	</div>

	<br>

	<div>
		<label class="control-label" data-toggle="tooltip" data-placement="right" title="[[mw:help_server_queryport]]">[[mw:server_queryport]]</label>
		<input data-key="queryport" class="form-control" type="text" placeholder=""/>
	</div>

	<br>

	<button type="button" id="save" class="btn btn-success">Save Settings</button>
</form>

<br>

<div class="alert alert-info clearfix beg">
	<div class="h1">Hello!</div>
	<p>I'm <a href="https://github.com/yariplus">yariplus</a>, creator of this fine plugin. If you found this plugin useful, consider supporting me by making a financial contribution using one of the services below. And thanks for using my plugins!</p>
	<div>
		<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top" class="pay">
			<input type="hidden" name="cmd" value="_s-xclick">
			<input type="hidden" name="hosted_button_id" value="DQP2MAQGKT7KC">
			<input type="image" src="https://www.paypalobjects.com/webstatic/en_US/btn/btn_donate_pp_142x27.png" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
			<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
		</form>
		<a href="https://www.patreon.com/yariplus">
			<img src="https://s3.amazonaws.com/patreon_public_assets/toolbox/patreon.png" width="82px" class="ptr">
		</a>
	</div>
</div>

<br><br>

<style>

#minecraft-widgets .tooltip-inner {
	max-width: 300px;
	color: #757575;
	background: #fff;
	border: 1px #727272 solid;
	border-radius: 10px;
}

.beg .h1 {
	margin-top: 0;
	color: white;
}

.beg p {
	margin-bottom: 15px;
}

.pay {
	display: inline-block;
}

.pay input {
	border-radius: 4px;
}

.ptr {
	border-radius: 4px;
	vertical-align: baseline;
	margin-left: 5px;
	background: white none repeat scroll 0% 0%;
	padding: 5px;
	display: inline-block;
	outline: medium none;
	cursor: pointer;
	text-align: center;
	text-decoration: none;
	-webkit-border-radius: 20px;
	-moz-border-radius: 20px;
	-webkit-box-shadow: inset 1px -4px 2px rgba(0, 0, 0, 0.2)
	-moz-box-shadow: inset 1px -4px 2px rgba(0, 0, 0, 0.2);
	box-shadow: inset 1px -4px 2px rgba(0, 0, 0, 0.2);
}

</style>

<script>
$(function(){
	require(['settings'], function (settings) {

		var	wrapper = $('#minecraft-widgets'),
			namespace = "minecraft-widgets";

		settings.sync(namespace, wrapper, function(){
			$('[type="checkbox"]').each(function(){
				var element = $(this);
				element.closest('.mdl-switch').toggleClass('is-checked', element.is(':checked'));
			});
		});
		$('label, .mdl-switch__label').tooltip();

		wrapper.on('click', '#save', function (e) {
			settings.persist(namespace, wrapper, function(){
				socket.emit('admin.settings.syncMinecraftWidgets');
			});
		});
	});
});
</script>
