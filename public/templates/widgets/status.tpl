<div class="mi-container" data-widget="mi-status" data-sid="{sid}"
	<!-- IF !show-avatar-borders -->data-show-avatar-borders="off"<!-- ENDIF !show-avatar-borders -->
	data-avatar-border-start="#{avatar-border-start}"
	data-avatar-border-end="#{avatar-border-end}"
	data-avatar-border-style="{avatar-border-style}">
	<table class="table widget-table">
		<tbody>
			<!-- IF showMOTD -->
			<tr>
				<td class="td-label" colspan="2">
					<span<!-- IF colorMOTD --> style="color:#{colorMOTD}"<!-- ENDIF colorMOTD -->>
						{motd}
					</span>
				</td>
			</tr>
			<!-- ENDIF showMOTD -->

			<!-- BEGIN customaftername -->
			<tr>
				<td class="td-label">
					<span<!-- IF colorLabels --> style="color:#{colorLabels}"<!-- ENDIF colorLabels -->>
						<strong>{customaftername.label}</strong>
					</span>
				</td>
				<td>
					<span<!-- IF colorText --> style="color:#{colorText}"<!-- ENDIF colorText -->>
						{customaftername.text}
					</span>
				</td>
			</tr>
			<!-- END customaftername -->

			<tr>
				<td class="td-label">
					<span<!-- IF colorLabels --> style="color:#{colorLabels}"<!-- ENDIF colorLabels -->>
						<strong>[[mi:status]]</strong>
					</span>
				</td>
				<td>
					<span<!-- IF colorText --> style="color:#{colorText}"<!-- ENDIF colorText -->>

					<a class="mc-statusicon fa has-tooltip

						<!-- IF isServerOnline -->
							fa-check-circle text-success
						<!-- ENDIF isServerOnline -->
						<!-- IF !isServerOnline -->
							fa-exclamation-circle text-danger
						<!-- ENDIF !isServerOnline -->

					" data-placement="top" data-title=""></a>

					<strong>
						<span class="mc-statustext

							<!-- IF isServerOnline -->
								text-success
							<!-- ENDIF isServerOnline -->
							<!-- IF !isServerOnline -->
								text-danger
							<!-- ENDIF !isServerOnline -->

						"><!-- IF isServerOnline -->Online<!-- ENDIF isServerOnline --><!-- IF !isServerOnline -->Offline<!-- ENDIF !isServerOnline --></span>
					</strong>

					<!-- IF showPlayerCount -->
					<span class="mc-playercount">
						(<span class="online-players">{onlinePlayers}</span>/<span class="max-players">{maxPlayers}</span>)
					</span>
					<!-- ENDIF showPlayerCount -->

					<!-- IF isServerRestarting -->
						<a class="fa fa-question-circle text-info has-tooltip" data-placement="top" data-title="Pinged server at {serverIP}:{serverPort}"></a>&nbsp;<strong><span class="text-info">Restarting</span></strong>
					<!-- ENDIF isServerRestarting -->
					</span>
				</td>
			</tr>

			<!-- BEGIN customafterstatus -->
			<tr>
				<td class="td-label">
					<span<!-- IF colorLabels --> style="color:#{colorLabels}"<!-- ENDIF colorLabels -->>
						<strong>{customafterstatus.label}</strong>
					</span>
				</td>
				<td>
					<span<!-- IF colorText --> style="color:#{colorText}"<!-- ENDIF colorText -->>
						{customafterstatus.text}
					</span>
				</td>
			</tr>
			<!-- END customafterstatus -->

			<tr>
				<td class="td-label">
					<span<!-- IF colorLabels --> style="color:#{colorLabels}"<!-- ENDIF colorLabels -->>
						<strong>Address</strong>
					</span>
				</td>
				<td>
					<span<!-- IF colorText --> style="color:#{colorText}"<!-- ENDIF colorText -->>
						{address} <!-- IF showIP -->[{host}<!-- IF port -->:{port}<!-- ENDIF port --><!-- ENDIF showIP --><!-- IF showIP -->]<!-- ENDIF showIP -->
					</span>
				</td>
			</tr>

			<!-- BEGIN customafteraddress -->
			<tr>
				<td class="td-label">
					<span<!-- IF colorLabels --> style="color:#{colorLabels}"<!-- ENDIF colorLabels -->>
						<strong>{customafteraddress.label}</strong>
					</span>
				</td>
				<td>
					<span<!-- IF colorText --> style="color:#{colorText}"<!-- ENDIF colorText -->>
						{customafteraddress.text}
					</span>
				</td>
			</tr>
			<!-- END customafteraddress -->

			<!-- IF showVersion -->
			<tr>
				<td class="td-label">
					<span<!-- IF colorLabels --> style="color:#{colorLabels}"<!-- ENDIF colorLabels -->>
						<strong>Version</strong>
					</span>
				</td>
				<td>
					<span<!-- IF colorText --> style="color:#{colorText}"<!-- ENDIF colorText -->>
						{version}
						<!-- IF status.hasPlugins -->&nbsp;<a class="fa fa-plug text-info" data-popover="plugin-list" data-html="true" data-title="[[mi:plugin_list]]" data-placement="bottom"></a><!-- ENDIF status.hasPlugins -->
						<!-- IF status.hasMods -->&nbsp;<a class="fa fa-gavel text-danger" data-popover="mod-list" data-html="true" data-title="[[mi:mod_list]]" data-placement="bottom"></a><!-- ENDIF status.hasMods -->
						<!-- IF status.hasModPack -->&nbsp;<a class="fa fa-gift" data-popover="mod-list" data-html="true" data-title="[[mi:mod_pack_info]]" data-placement="bottom"></a><!-- ENDIF status.hasModPack -->
						<!-- IF status.hasSponge -->&nbsp;<a class="fa fa-life-ring" data-popover="mod-list" data-html="true" data-title="[[mi:sponge_mods]]" data-placement="bottom"></a><!-- ENDIF status.hasSponge -->
						<!-- IF status.hasBungeecord -->&nbsp;<a class="fa fa-arrows-alt" data-popover="mod-list" data-html="true" data-title="[[mi:hub_list]]" data-placement="bottom"></a><!-- ENDIF status.hasBungeecord -->
					</span>
				</td>
			</tr>
			<!-- ENDIF showVersion -->

			<!-- BEGIN customafterversion -->
			<tr>
				<td class="td-label">
					<span<!-- IF colorLabels --> style="color:#{colorLabels}"<!-- ENDIF colorLabels -->>
						<strong>{customafterversion.label}</strong>
					</span>
				</td>
				<td>
					<span<!-- IF colorText --> style="color:#{colorText}"<!-- ENDIF colorText -->>
						{customafterversion.text}
					</span>
				</td>
			</tr>
			<!-- END customafterversion -->

			<!-- IF showAvatars -->
			<tr>
				<td class="mi-avatars" colspan="2"></td>
			</tr>
			<!-- ENDIF showAvatars -->

			<!-- BEGIN customafterplayers -->
			<tr>
				<td class="td-label">
					<span<!-- IF colorLabels --> style="color:#{colorLabels}"<!-- ENDIF colorLabels -->>
						<strong>{customafterplayers.label}</strong>
					</span>
				</td>
				<td>
					<span<!-- IF colorText --> style="color:#{colorText}"<!-- ENDIF colorText -->>
						{customafterplayers.text}
					</span>
				</td>
			</tr>
			<!-- END customafterplayers -->

		</tbody>
	</table>
	<!-- IF mapshow -->
	<iframe class="mi-iframe" src="{uri}" data-height-ratio="2"></iframe>
	<!-- ENDIF mapshow -->
	<!-- IF mapURI -->
	<!-- IMPORT partials/modalMap.tpl -->
	<!-- ENDIF mapURI -->
</div>
