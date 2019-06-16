/**
 * @name Drop Zone
 * @Description Droz Zone to drop files
 * @version 1.0
 * @author Salvatore Di Salvo <disalvo.infographiste@gmail.com>
 * @date_created 26-05-2019
 */
class DropZone {
    constructor() {
        if(typeof $ === "undefined") throw new Error("jQuery is required by GlobalForm to run properly");
        if(typeof $.jmRequest === "undefined") throw new Error("jmRequest is required by GlobalForm to run properly");
        this.selector = '.dropzone';
        this.btnFile = '.drop-btn';
        if(typeof options === 'object') this.set(options);
    }

    set(options) {
        let instance = this;
        for (var key in options) {
            if (options.hasOwnProperty(key)) instance[key] = options[key];
        }
    }

    readURL(input, dz) {
        if (input.files && input.files[0]) {
            let reader = new FileReader();

            reader.onload = function (e) {
                $('.preview',dz).attr('src', e.target.result);
            };

            reader.readAsDataURL(input.files[0]);
            $('.preview', dz).removeClass('no-img');
            $('.drop-zone', dz).removeClass('no-img');
        }
    }

    resetInput(dz) {
        $('.drop-input-img', dz).val('');
        $('.preview', dz).attr('src', '#').addClass('no-img');
    }

    initImageFunctions(dz) {
        dz = $(dz);
        let instance = this;
        let resetBtn = $('.resetImg', dz);
        let multiple = dz.data('multiple');
        let ratio = dz.data('ratio');

        if(ratio !== undefined) {
            $('.img-drop', dz).css('padding-top','calc(100% / '+ ratio +')')
        }

        $('.inputfile', dz).each(function() {
            // Firefox bug fix
            $(this).on( 'focus', function(){ $(this).addClass( 'has-focus' ); });
            $(this).on( 'blur', function(){ $(this).removeClass( 'has-focus' ); });
        });

        $(".drop-input-img", dz).change(function(){
            instance.readURL(this,dz);

            if(typeof resetBtn !== 'undefined') {
                resetBtn.removeClass('hide');
            }
        });

        resetBtn.on('click', function(e){
            e.preventDefault();
            $(this).addClass('hide');
            instance.resetInput(dz);
            return false;
        });
    }

    initDropZone(dz,type) {
        let instance = this;

        if(type === 'img') {
            instance.initImageFunctions(dz);
        }

        dz = $($(dz).find('.drop-zone')[0]);

        let mouseOverClass = "mouse-over";
        let btnSend = dz.find('button[type="submit"]');
        let btnFile = dz.find(instance.btnFile);
        let ooleft = dz.offset().left;
        let ooright = dz.outerWidth() + ooleft;
        let ootop = dz.offset().top;
        let oobottom = dz.outerHeight() + ootop;
        let inputFile = dz.find('input[type="file"]');

        dz.off().on("dragover", function (e) {
            e.preventDefault();
            e.stopPropagation();
            dz.addClass(mouseOverClass);
            /*let x = e.pageX;
            let y = e.pageY;

            if (!(x < ooleft || x > ooright || y < ootop || y > oobottom)) {
                inputFile.offset({ top: y - 15, left: x - 100 });
            } else {
                inputFile.offset({ top: -400, left: -400 });
            }*/
        });

        if(btnFile !== undefined) {
            let clickZone = $(btnFile[0]);
            let oleft = clickZone.offset().left;
            let oright = clickZone.outerWidth() + oleft;
            let otop = clickZone.offset().top;
            let obottom = clickZone.outerHeight() + otop;

            /*clickZone.on('mousemove', function (e) {
                let x = e.pageX;
                let y = e.pageY;

                if (!(x < oleft || x > oright || y < otop || y > obottom)) {
                    inputFile.offset({ top: y - 15, left: x - 160 });
                } else {
                    inputFile.offset({ top: -400, left: -400 });
                }
            });*/
        }

        inputFile.on('change', function(){
            let inputVal = $(this).val();
            $(btnSend).prop('disabled',(inputVal === ''));
        });

        dz.on("drop dragend dragleave", function() {
            dz.removeClass(mouseOverClass);
        });
    }

    initialize() {
        let instance = this;
        let dropzones = document.getElementsByClassName('dropzone');

        $(dropzones).each(function(){
            let dz = this;
            let hidden = dz.offsetParent;
            let parents = $(dz).parentsUntil($('.tab-pane'));
            let type = $(dz).data('type');

            if(hidden === null) {
                parents.each(function(){
                    $(this).on('shown',function(){
                        if(dz.offsetParent !== null) {
                            instance.initDropZone(dz,type);
                        }
                    });
                });
            }
            else {
                instance.initDropZone(dz,type);
            }
        });
    }
}

const dropZone = new DropZone();

window.addEventListener('load',function(){
    'use strict';

    dropZone.initialize();

    /*$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        if($(e.target).attr('href') === '#image') {
            dropZone.run();
        }
    });*/
});
