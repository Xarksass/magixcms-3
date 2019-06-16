+function ($) {
	'use strict';

    // *** Add fl2uc method - First Letter To Upper Case
	String.prototype.fl2uc = function() {
		return this.charAt(0).toUpperCase() + this.slice(1);
	};
	$('[data-toggle="popover"]').popover();
	$.jmRequest.notifier = { cssClass : '.mc-message' };

	// *** target_blank
	$('a.targetblank').click( function() {
		window.open($(this).attr('href'));
		return false;
	});

	$('[data-toggle="popover"]').popover();

	$('.navbar-toggle[data-toggle="collapse"]').each(function(){
		let self = $(this);

		$(self.data('target')).on('show.bs.collapse hide.bs.collapse',function(e){
			if(e.target === this) self.toggleClass('open',e.type === 'show');
		});
	});

	let menu_overlay = null;
	$('.open-menu, .close-menu').click(function(){
		let self = this, target = $(self).data('target'), opened = $(target).hasClass('open');
		$(self).toggleClass('open', !opened);
		$(target).toggleClass('open', !opened);

		if(!opened) {
			menu_overlay = new overlay({
				target: 'drawer',
				method: {
					type: 'class',
					class: 'open'
				}
			});
		}
		else {
			menu_overlay.destroy();
			menu_overlay = null;
		}
	});

	$('.fold-menu').click(function(){
		let self = this, target = $(self).data('target'), opened = $(target).hasClass('fold');
		$(self).toggleClass('fold', !opened);
		$(target).toggleClass('fold', !opened);
		$('body').toggleClass('menu-fold', !opened);
		var event = new CustomEvent("body-resize", { "detail": "body-resize" });
		document.body.dispatchEvent(event);
	});

	$('#menu .navbar-toggle').each(function(){
		$(this).on('click',function(){
			$('#menu .collapse').collapse('hide');
			let menu = $(this).data('target');
			$(menu).collapse('show');
		});
	});

    //Unlock input text
    $('.unlocked').on('click',function(event){
        event.preventDefault();
        let self = $(this),
			input = self.prev(),
        	icon = $('i.material-icons',this),
			locked = input.hasClass('locked');
		input.attr('readonly',!locked ? 'readonly' : null).attr('disabled',!locked ? 'disabled' : null).toggleClass('locked',!locked);
		icon.text(locked ? 'lock' : 'lock_open');
    });

	if(typeof IScroll !== "undefined") {
		var scrollmenu = new IScroll('#menu', {
			mouseWheel: true,
			scrollbars: false
		});
		$('#menu .collapse').on('shown.bs.collapse hidden.bs.collapse',function(){ scrollmenu.refresh(); });
		$(window).resize(function(){ scrollmenu.refresh(); });
	}

	$('a.changeAdminLang').on('click',function(e){
		e.preventDefault();
		let iso = $(this).data('iso');
		$.jmRequest({
			handler: "ajax",
			url: '/admin/index.php?controller=login&action=changelanguage&iso='+iso,
			method: 'get',
			success:function(d){
				if(d.status) {
					location.reload();
				}
			}
		});
		return false;
	});
}(jQuery);

window.addEventListener("beforeunload", function (e) {
	let id_input = document.querySelectorAll('#form-footer [name="id"]')[0];
	if(typeof id_input !== "undefined") {
		let id = id_input.value;
		$.jmRequest({
			url: controller + '&action=cleanout',
			handler: 'ajax',
			method: 'POST',
			data: {id: id}
		})
	}
});