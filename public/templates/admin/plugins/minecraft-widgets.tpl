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

	<button type="button" id="save" class="btn btn-success">Save Settings</button>

</form>

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
