const product = (function () {
    function initGen(fd,edit,globalForm,tableForm){
        var progressBar = new ProgressBar('#progress-thumbnail',{loader: {type:'text', icon:'etc'}});

        $.jmRequest({
            handler: "ajax",
            url: $('#add_img_product').attr('action'),
            method: 'POST',
            data:  fd,
            processData: false,
            contentType: false,
            beforeSend: function () {
                progressBar.init({progress: 5, state: 'Demande au serveur'});
            },
            xhr: function() {
                var xhr = $.ajaxSettings.xhr();
                xhr.oldResponse = '';
                // Generation progress
                xhr.addEventListener("progress", function(e){
                    if(!(xhr.readyState === 4 && xhr.status === 200)) {
                        var new_response = xhr.responseText.substring(xhr.oldResponse.length);
                        if(new_response !== '') {
                            var result = JSON.parse(new_response);
                            var loader = null;
                            if(result.rendering) {
                                loader = {type: 'fa', icon: 'cog', anim: 'spin'};
                            }
                            progressBar.update({progress: result.progress, state: result.message, loader: loader});
                            xhr.oldResponse = xhr.responseText;
                        }
                    }
                }, false);
                return xhr;
            },
            dataFilter: function (response) {
                var responses = response.split('{');
                response = '{'+responses.pop();
                return response;
            },
            error: function (xhr, ajaxOptions, thrownError) {
                progressBar.updateState('danger');
                console.log(xhr);
                console.log(ajaxOptions);
                console.log(thrownError);
            },
            success: function (d) {
                if(d.status == 'success') {
                    progressBar.updateState('success');
                    progressBar.update({state: d.message+' <span class="fa fa-check"></span>',loader: false});

                    $.jmRequest({
                        handler: "ajax",
                        url: '/admin/index.php?controller=product&edit='+edit+'&action=getImages',
                        method: 'get',
                        success: function (d) {
                            $('.block-img').empty();
                            $('.block-img').html(d.result);
                            globalForm.initModals();
                            tableForm.run();
                            $('.block-img').find('.img-zoom').fancybox();
                            initDefaultImg(edit);
                            initSortable(edit);
                        }
                    });
                }
                else {
                    switch (d.error_code) {
                        case 'access_denied':
                            progressBar.updateState('danger');
                            progressBar.update({state: d.message+' <span class="fa fa-ban"></span>',loader: false});
                            break;
                        case 'error_data':
                            progressBar.updateState('warning');
                            progressBar.update({state: '<span class="fa fa-warning"></span> '+d.message,loader: false});
                            break;
                    }
                }
            },
            complete: function () {
                progressBar.update({progress: 100});
                progressBar.initHide();
                progressBar.element.parent().next().removeClass('hide');
            }
        });
    }

    function initTree() {
        $('.tree-toggle').each(function(){
            $(this).on('click',function(){
                var targetDiv = $(this).attr('href');

                if($(this).hasClass('open')) {
                    $(this).removeClass('open').find('.fa').removeClass('fa-folder-open').addClass('fa-folder');
                    $(targetDiv).collapse('hide');
                }
                else {
                    $(this).addClass('open').find('.fa').removeClass('fa-folder').addClass('fa-folder-open');
                    $(targetDiv).collapse('show');
                }
            });
        });

        $('.tree-actions').each(function(){
            $(this).click(function(){
                var action = $(this).data('action');

                $('.tree-toggle').each(function(){
                    var self = this,
                        targetDiv = $(this).attr('href');
                    if($(this).parents('div.cat-tree').length === 0) {
                        if(action === 'toggle-down') {
                            $(this).addClass('open').find('.fa').removeClass('fa-folder').addClass('fa-folder-open');
                            $(targetDiv).collapse('show');
                        } else if(action === 'toggle-up') {
                            $(this).removeClass('open').find('.fa').removeClass('fa-folder-open').addClass('fa-folder');
                            $(targetDiv).collapse('hide');
                        }
                    } else {
                        if(action === 'toggle-down') {
                            $(this).parents('div.cat-tree').on('shown.bs.collapse',function(){
                                $(self).addClass('open').find('.fa').removeClass('fa-folder').addClass('fa-folder-open');
                                $(targetDiv).collapse('show');
                                $(this).off();
                            });
                        } else if(action === 'toggle-up') {
                            $(this).parents('div.cat-tree').on('hidden.bs.collapse',function(){
                                $(self).removeClass('open').find('.fa').removeClass('fa-folder-open').addClass('fa-folder');
                                $(targetDiv).collapse('hide');
                                $(this).off();
                            });
                        }
                    }
                });
            });
        });
    }

    function initDefaultImg(edit) {
        $('.make_default').off().on('click', function(){
            var self = this,
                dflt = $('.default.in'),
                id = $(this).data('id');

            $('.default').removeClass('in');
            $('.make-default').removeClass('hide');
            $(this).parent().addClass('hide').prev().addClass('in').find('.fa').attr('class','fa fa-spinner fa-pulse');

            $.jmRequest({
                handler: "ajax",
                url: '/admin/index.php?controller=product&edit='+edit+'&action=setImgDefault',
                data: {id_img: id},
                method: 'post',
                success: function (d) {
                    if(!d.status) {
                        $(self).parent().removeClass('hide').prev().removeClass('in');
                        dflt.addClass('in').next().addClass('hide');
                    }

                    $(self).parent().prev().find('.fa').attr('class','fa fa-check text-success');
                }
            });
            return false;
        });

        $('#gallery-product .sortable').off().on('change',function(){
            var dflt = $('.default.in');
            if(!dflt.length) {
                $.jmRequest({
                    handler: "ajax",
                    url: '/admin/index.php?controller=product&edit='+edit+'&action=getImgDefault',
                    method: 'get',
                    success: function (d) {
                        $('#image_'+d).find('.default').addClass('in').next().addClass('hide');
                    }
                });
            }
        });
    }

    function initSortable(edit) {
        $( ".row.sortable" ).sortable({
            items: "> div",
            cursor: "move",
            update: function(){
                var serial = $( ".sortable" ).sortable('serialize');
                $.jmRequest({
                    handler: "ajax",
                    url: '/admin/index.php?controller=product&edit='+edit+'&action=orderImages',
                    method: 'POST',
                    data : serial,
                    success:function(e){
                        $.jmRequest.initbox(e,{
                                display: false
                            }
                        );
                    }
                });
            }
        });
        $( ".row.sortable" ).disableSelection();
    }

    function calcultateIncPrice() {
        let pInput = document.getElementById('price_p'),
            incInput = document.getElementById('price_inc'),
            p = pInput.value,
            vat = pInput.dataset.vat;

        incInput.value = p*vat;
    }

    return {
        run: function(globalForm,tableForm,edit){
            $('.progress').hide();
            $('.form-gen').on('submit', function(e) {
                e.preventDefault();
                var fd = new FormData(this);
                initGen(fd,edit,globalForm,tableForm);
                return false;
            });
            initTree();

            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                if($(e.target).attr('href') === '#images') {
                    initDefaultImg(edit);
                    initSortable(edit);
                }
            });

            $('.catlisting input[type="checkbox"]').change(function(){
                let radio = $(this).next().next().find('input[type="radio"]');
                let enabledRadios = null;

                if($(this).prop('checked')) {
                    radio.prop('disabled',false);

                    enabledRadios = $('.catlisting input[type="radio"]:enabled');

                    if(enabledRadios.length === 1) {
                        radio.prop('checked',true);
                    }
                } else {
                    enabledRadios = $('.catlisting input[type="radio"]:enabled');

                    if(enabledRadios.length > 1) {
                        let rad = enabledRadios.index(radio) ? 0 : 1;
                        $(enabledRadios[rad]).prop('checked',true);
                    }

                    $(this).next().next().find('input[type="radio"]').prop('checked',false).prop('disabled',true);
                }
            });

            $('#price_p').on('change input focusout',function(){
                let p = $(this).val();
            });

            let pInput = document.getElementById('price_p');
            pInput.addEventListener('input', calcultateIncPrice);
            pInput.addEventListener('change', calcultateIncPrice);
            pInput.addEventListener('focusout', calcultateIncPrice);
            calcultateIncPrice();
        }
    }
})(jQuery);

window.addEventListener('load',function(){
    product.run();
});