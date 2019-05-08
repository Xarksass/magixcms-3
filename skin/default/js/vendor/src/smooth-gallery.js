/*! ========================================================================
 * Smooth Gallery: smooth-galler.js v2.0.0
 * ========================================================================
 * Copyright 2015, Salvatore Di Salvo (disalvo-infographiste[dot]be)
 * ======================================================================== */

+function ($) {
	'use strict';

	// SMOOTH GALLERY PUBLIC CLASS DEFINITION
	// =======================================

	const SmoothGallery = function (element, options) {
		this.$element  = $(element)
		this.options   = $.extend({}, this.defaults(), options)
		this.structure   = $.extend({}, this.parts())
		this.init()
	}

	SmoothGallery.VERSION  = '2.0.0'

	SmoothGallery.DEFAULTS = {
		container : this,
		scrollSpeed: 500,
		list: 'ul',
		items: '.item',
		ipl: 3,
		btn: {
			prv: '.button.prev',
			nxt: '.button.next'
		},
		vars: {},
		swipe: false
	}

	SmoothGallery.prototype.parts = function() {
		return {
			$container : this.$element,
			$list      : $(this.options.list, this.$element),
			$items     : $(this.options.items, this.$element),
			$btn       : {
				prv: $(this.options.btn.prv, this.$element),
				nxt: $(this.options.btn.nxt, this.$element)
			}
		}
	}

	SmoothGallery.prototype.defaults = function() {
		return {
			container      : SmoothGallery.DEFAULTS.container,
			scrollSpeed   : this.$element.attr('data-scrollSpeed') || SmoothGallery.DEFAULTS.scrollSpeed,
			list  : SmoothGallery.DEFAULTS.list,
			items : SmoothGallery.DEFAULTS.items,
			ipl   : SmoothGallery.DEFAULTS.ipl,
			btn   : SmoothGallery.DEFAULTS.btn,
			vars  : SmoothGallery.DEFAULTS.vars
		}
	}

	SmoothGallery.prototype.init = function() {
		let $this = this,
			nbli = this.structure.$items.length;

		if (nbli > $this.options.ipl) {
			$this.structure.copies = $this.structure.$items.clone();
			$this.structure.copies.attr('aria-hidden',true).addClass('item-copy').removeClass('active');
			$($this.structure.copies[$this.structure.copies.length -1]).addClass('active left');
			$this.structure.copies.prependTo($this.structure.$list);
			$this.structure.$items = $($this.options.items, $this.$element);

            // *** for gallery pictures
            $(".show-img").off('click').click(function(){
                $(".big-image a").animate({ opacity: 0, 'z-index': -1 }, 200);
                $($(this).data('target')).animate({ opacity: 1, 'z-index': 1 }, 200);
                return false;
            });

			// Click functions on buttons prev and next
			this.structure.$btn.prv.mousedown( function() {
				$this.click('prev');
			});
			this.structure.$btn.nxt.mousedown( function() {
				$this.click('next');
			});

			// Swipe functions on gallery
			if(this.options.swipe) {
                this.structure.$list.on ( 'swiperight', function() {
                    $this.click('prev');
                });
                this.structure.$list.on ( 'swipeleft', function() {
                    $this.click('next');
                });
			}
		}
	}

	SmoothGallery.prototype.getItemForDirection = function(dir, active) {
		let $this = this;
		let $lastActive = active[$this.options.ipl];
		let $lAIndex = $this.structure.$items.index($lastActive);
		let next;

		if(dir === 'next') {
			next = $lAIndex + 1;
		} else {
			next = $this.structure.$items.index(active[0]);
		}

		return $this.structure.$items[next];
	}

	SmoothGallery.prototype.click = function(dir) {
		let $this = this;
		let $active = this.$element.find('.item.active');
		let $next   = this.getItemForDirection(dir, $active);
		let ni = $this.structure.$items.length;

		if(dir === 'next') {
			$($next).addClass('active').attr('aria-hidden',false);
			$($active[1]).addClass('left').attr('aria-hidden',true);
			$($active[0]).removeClass('active left').addClass('item-copy');
			$($this.structure.$items[0]).appendTo($this.structure.$list).removeClass('item-copy').attr('aria-hidden',false);
		}
		else {
            $($active[$this.options.ipl + 1]).removeClass('active');
            $($next).removeClass('left').removeClass('item-copy').attr('aria-hidden',false);
            $($next).prev().addClass('active left').attr('aria-hidden',true);
			$($this.structure.$items[ni - 1]).prependTo($this.structure.$list).addClass('item-copy').attr('aria-hidden',true);
		}

		$this.structure.$items = $($this.options.items, $this.$element);
		//initGallery();
	}


	// SMOOTH GALLERY PLUGIN DEFINITION
	// =================================

	function Plugin() {
		let arg = arguments;
		return this.each(function () {
			let $this   = $(this),
				data    = $this.data('bs.dropdownselect'),
				method  = arg[0];

			if( typeof(method) === 'object' || !method ) {
				let options = typeof method === 'object' && method;
				if (!data) $this.data('bs.dropdownselect', (data = new SmoothGallery(this, options)));
			} else {
				if (data[method]) {
					method = data[method];
					arg = Array.prototype.slice.call(arg, 1);
					if(arg != null || arg !== undefined || arg !== [])  method.apply(data, arg);
				} else {
					$.error( 'Method ' +  method + ' does not exist on jQuery.SmoothGallery' );
					return this;
				}
			} })
	}

	let old = $.fn.smoothGallery

	$.fn.smoothGallery             = Plugin
	$.fn.smoothGallery.Constructor = SmoothGallery

	// SMOOTH GALLERY NO CONFLICT
	// ===========================

	$.fn.toggle.noConflict = function () {
		$.fn.smoothGallery = old
		return this
	}

	// SMOOTH GALLERY DATA-API
	// ========================

	$(function() {
		$('.smooth-gallery').smoothGallery();
	});
}(jQuery);