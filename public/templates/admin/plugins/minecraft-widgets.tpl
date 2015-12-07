<form id="minecraft-widgets" autocomplete="off">

	<div class="row input-row">
		<div class="col-sm-7 col-xs-12 input-field">
			<label class="control-label">[[mi:server_name]] <small>([[mi:required]])</small></label>
			<input data-key="name" class="form-control" type="text" placeholder=""/>
		</div>
		<div class="col-sm-5 help-text" data-help="[[mi:help_server_name]]"></div>
	</div>

	<br>

	<div class="row input-row">
		<div class="col-sm-7 col-xs-12 input-field">
			<label class="control-label">[[mi:server_address]] <small>([[mi:required]])</small></label>
			<input data-key="address" class="form-control" type="text" placeholder=""/>
		</div>
		<div class="col-sm-5 help-text" data-help="[[mi:help_server_address]]"></div>
	</div>

	<br>

	<div class="row input-row">
		<div class="col-sm-7 col-xs-12 input-field">
			<label for="avatarCDN">[[mi:avatar_cdn]]</label>
			<select data-key="avatarCDN" class="form-control">
				<option value="mojang" selected="selected">Mojang</option>-->
				<option value="brony">Brony ModPack</option>
				<option value="cravatar">Cravatar.eu</option>
				<option value="minotar">Minotar</option>
				<option value="signaturecraft">Signaturecraft</option>
			</select>
		</div>
		<div class="col-sm-5 help-text" data-help="[[mi:help_avatar_cdn]]"></div>
	</div>

	<br>

	<button type="button" id="save">Save</button>

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
