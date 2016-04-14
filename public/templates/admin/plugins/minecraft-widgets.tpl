<form id="minecraft-widgets" autocomplete="off">

	<div class="row input-row">
		<div class="col-sm-7 col-xs-12 input-field">
			<label class="control-label">[[mw:server_name]]</small></label>
			<input data-key="name" class="form-control" type="text" placeholder=""/>
		</div>
		<div class="col-sm-5 help-text" data-help="[[mw:help_server_name]]"></div>
	</div>

	<br>

	<div class="row input-row">
		<div class="col-sm-7 col-xs-12 input-field">
			<label class="control-label">[[mw:server_address]]</small></label>
			<input data-key="address" class="form-control" type="text" placeholder=""/>
		</div>
		<div class="col-sm-5 help-text" data-help="[[mw:help_server_address]]"></div>
	</div>

	<br>

	<div class="row input-row">
		<div class="col-sm-7 col-xs-12 input-field">
			<label class="control-label">[[mw:server_queryport]]</label>
			<input data-key="queryport" class="form-control" type="text" placeholder=""/>
		</div>
		<div class="col-sm-5 help-text" data-help="[[mw:help_queryport]]"></div>
	</div>

	<br>

	<div class="row input-row">
		<div class="col-sm-7 col-xs-12 input-field">
			<label for="avatarCDN">[[mw:avatar_cdn]]</label>
			<select data-key="avatarCDN" class="form-control">
				<option value="mojang" selected="selected">Mojang</option>-->
				<option value="brony">Brony ModPack</option>
				<option value="cravatar">Cravatar.eu</option>
				<option value="minotar">Minotar</option>
				<option value="signaturecraft">Signaturecraft</option>
			</select>
		</div>
		<div class="col-sm-5 help-text" data-help="[[mw:help_avatar_cdn]]"></div>
	</div>

	<br>

	<div class="row input-row">
		<div class="col-sm-7 col-xs-12 input-field">
			<label class="control-label">
				<input class="form-control" type="checkbox" data-key="navbarStatus"> [[mw:navbar_status]]
			</label>
		</div>
		<div class="col-sm-5 help-text" data-help="[[mw:help_navbar_status]]"></div>
	</div>

	<br>

	<div class="row input-row">
		<div class="col-sm-7 col-xs-12 input-field">
			<label class="control-label">
				<input class="form-control" type="checkbox" data-key="showIcon"> [[mw:show_icon]]
			</label>
		</div>
		<div class="col-sm-5 help-text" data-help="[[mw:help_show_icon]]"></div>
	</div>

	<br>

	<div class="row input-row">
		<div class="col-sm-7 col-xs-12 input-field">
			<label class="control-label">
				<input class="form-control" type="checkbox" data-key="noQuery"> [[mw:no_query]]
			</label>
		</div>
		<div class="col-sm-5 help-text" data-help="[[mw:help_no_query]]"></div>
	</div>

	<br>

	<button type="button" id="save" class="btn btn-success">Save Settings</button>
</form>

<br>

<div class="alert alert-info clearfix">
	<span>If you found this plugin useful, consider supporting me!</span>
	<a href="https://www.patreon.com/yariplus">
		<img src="https://s3.amazonaws.com/patreon_public_assets/toolbox/patreon.png" width="100px" style="vertical-align:baseline;float:right;margin-left:15px;">
	</a>
	<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top" style="display:inline;float:right;margin-left:15px;">
		<input type="hidden" name="cmd" value="_s-xclick">
		<input type="hidden" name="hosted_button_id" value="DQP2MAQGKT7KC">
		<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
		<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
	</form>
</div>

<br><br>

<script>
$(function(){
	require(['settings'], function (settings) {

		var	wrapper = $('#minecraft-widgets'),
			namespace = "minecraft-widgets";

		settings.sync(namespace, wrapper);

		wrapper.on('click', '#save', function (e) {
			settings.persist(namespace, wrapper, function(){
				socket.emit('admin.settings.syncMinecraftWidgets');
			});
		});
	});
});
</script>
