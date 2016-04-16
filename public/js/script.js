$(function(){

	if (config.MinecraftWidgets.navbarStatus)
	{
		var icon;

		if (config.MinecraftWidgets.isServerOnline) {
			if (config.MinecraftWidgets.icon && config.MinecraftWidgets.showIcon) {
				icon = '<img src="'+config.MinecraftWidgets.icon+'" style="height: 46px; margin-right: 0.75em;">';
			}else{
				icon = '<span style="height: 25px; vertical-align: middle; display: inline-block; margin-right: 0.75em;"><i style="font-size: 2.5rem;" class="fa fa-check-circle text-success"></i></span>';
			}
		}else{
			icon = '<span style="height: 25px; vertical-align: middle; display: inline-block; margin-right: 0.75em;"><i style="font-size: 2.5rem;" class="fa fa-times-circle text-danger"></i></span>';
		}

		$('<ul class="nav navbar-nav navbar-right"><div class="mw-container">'+
			'<div style="height: 50px; display: table-cell; vertical-align: middle;" class="mw-container">'+
			'<div style="display: inline-block; vertical-align: middle; margin-right: 0.5em;">'+icon+
				'<span style="opacity: 0.8; display: inline-block; vertical-align: middle;">'+
					'<div>'+
						'<span style="font-size: larger;" class="servername">'+config.MinecraftWidgets.address+'</span>'+
						'<i class="fa fa-copy servernamecopy hide" data-clipboard-action="copy" data-clipboard-target=".servername"></i>'+
					'</div>'+
					'<div style="opacity: 0.6; font-size: smaller;">Players online: <span class="mwOnlinePlayers">'+config.MinecraftWidgets.onlinePlayers+'</span></div>'+
				'</span>'+
			'</div></div>'+
		'</ul>').insertBefore($('.pagination-block, #main-nav').first());

	}

	socket.on('mw.StatusUpdate', function (data) {
		$('.mwOnlinePlayers').text(data.onlinePlayers);
	});

	require(['https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/1.5.5/clipboard.min.js'], function (Clipboard)
	{
		var	clipboard = new Clipboard('.servernamecopy');

		$('.servernamecopy')
			.mouseout(function () {
				$(this).tooltip('destroy');
				$(this).removeClass('mwHighlight');
				$('.servername').removeClass('mwHighlight');
			})
			.mouseenter(function () {
				$(this).addClass('mwHighlight');
				$('.servername').addClass('mwHighlight');
			})
			.removeClass('hide');

		clipboard.on('success', function(e) {
			e.clearSelection();
			$('.servernamecopy').tooltip({title:'Copied!',placement:'bottom'});
			$('.servernamecopy').tooltip('show');
		});
	});
});
