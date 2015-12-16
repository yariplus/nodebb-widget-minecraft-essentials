<div class="mw-container">
	<div>
		<!-- IF isServerOnline -->
			<!-- IF icon -->
				<img src="{icon}" style="height: 46px; margin-right: 0.75em;">
			<!-- ELSE -->
				<span style="float: left; margin-right: 1rem; margin-top: 1rem;"><i style="font-size: 2.5rem;" class="fa fa-check-circle text-success"></i></span>
			<!-- ENDIF icon -->
		<!-- ELSE -->
			<span style="float: left; margin-right: 1rem; margin-top: 1rem;"><i style="font-size: 2.5rem;" class="fa fa-exclamation-circle text-danger"></i></span>
		<!-- ENDIF isServerOnline -->

		<span style="float: right; margin-top: 0.325rem;">{onlinePlayers}/{maxPlayers}</span>
		<span style="font-size: 1.8rem;">{name}</span><br>
		<span style="opacity: 0.8;">{address}</span>
	</div>
	<div>
		<!-- BEGIN players -->
		<!-- END players -->
	</div>
</div>
