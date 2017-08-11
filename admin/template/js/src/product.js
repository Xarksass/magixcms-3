var product = (function ($, undefined) {
    function tree(){
        $('a.tree-toggle').click(function(){
            var target = $($(this).data('target'));
            if($(this).hasClass('open') || $(target).hasClass('collapse in')){
                $(this).removeClass('open').children('span').removeClass('fa-minus-square').addClass('fa-plus-square');
            }else{
                $(this).addClass('open').children('span').removeClass('fa-plus-square').addClass('fa-minus-square');
            }
        });
    }

    function initGen(fd){

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
                    var new_response = xhr.responseText.substring(xhr.oldResponse.length);
                    if(new_response != '') {
                        var result = JSON.parse(new_response);
                        var loader = null;
                        if(result.rendering) {
                            loader = {type: 'fa', icon: 'cog', anim: 'spin'}
                        }
                        progressBar.update({progress: result.progress, state: result.message, loader: loader});
                        xhr.oldResponse = xhr.responseText;
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
                $.jmRequest.initbox(d.notify,{ display:false });
                if(d.statut && d.result) {
                    $('.block-img').empty();
                    $('.block-img').html(d.result);
                }
            },
            complete: function () {
                progressBar.update({progress: 100});
                progressBar.initHide();
                progressBar.element.parent().next().removeClass('hide');
            }
        });
    }

    function isEmpty( el ){
        return !$.trim(el.html())
    }

    function openTree(link, div, reset) {
        $(link).addClass('open').find('.fa').removeClass('fa-folder').addClass('fa-folder-open');
        $(div).collapse('show');
        if(reset) {
            initTree();
        }
    }

    function initTree() {
        $('.tree-toggle').each(function(){
            $(this).removeData();
            $(this).off();
            $(this).on('click',function(){
                var self = this,
                    edit = $(this).data('edit'),
                    parentId = $(this).data('id'),
                    targetDiv = $(this).attr('href');

                if($(this).hasClass('open')) {
                    $(this).removeClass('open').find('.fa').removeClass('fa-folder-open').addClass('fa-folder');
                    $(targetDiv).collapse('hide');
                }
                else {
                    if (isEmpty($(targetDiv))) {
                        $.jmRequest({
                            handler: "ajax",
                            url: '/admin/index.php?controller=product&edit='+edit+'&action=getSubcat&parentid='+parentId,
                            method: 'GET',
                            success: function (d) {
                                if(typeof d.result !== 'undefined') {
                                    $(targetDiv).append(d.result);
                                    openTree(self,targetDiv,true);
                                }
                            }
                        });
                    } else {
                        openTree(self,targetDiv,false);
                    }
                }
            });
        });
    }

    return {
        run: function(){
            $('.progress').hide();
            $('.form-gen').on('submit', function(e) {
                e.preventDefault();
                var fd = new FormData(this);
                initGen(fd);
                return false;
            });
            initTree();

            $( ".row.sortable" ).sortable();
            $( ".row.sortable" ).disableSelection();

            var dropZoneId = "drop-zone";
            var buttonId = "clickHere";
            var mouseOverClass = "mouse-over";
            var btnSend = $("#" + dropZoneId).find('button[type="submit"]');

            var dropZone = $("#" + dropZoneId);
            var ooleft = dropZone.offset().left;
            var ooright = dropZone.outerWidth() + ooleft;
            var ootop = dropZone.offset().top;
            var oobottom = dropZone.outerHeight() + ootop;
            var inputFile = dropZone.find("input");
            document.getElementById(dropZoneId).addEventListener("dragover", function (e) {
                e.preventDefault();
                e.stopPropagation();
                dropZone.addClass(mouseOverClass);
                var x = e.pageX;
                var y = e.pageY;

                if (!(x < ooleft || x > ooright || y < ootop || y > oobottom)) {
                    inputFile.offset({ top: y - 15, left: x - 100 });
                } else {
                    inputFile.offset({ top: -400, left: -400 });
                }

            }, true);

            if (buttonId != "") {
                var clickZone = $("#" + buttonId);

                var oleft = clickZone.offset().left;
                var oright = clickZone.outerWidth() + oleft;
                var otop = clickZone.offset().top;
                var obottom = clickZone.outerHeight() + otop;

                $("#" + buttonId).mousemove(function (e) {
                    var x = e.pageX;
                    var y = e.pageY;
                    if (!(x < oleft || x > oright || y < otop || y > obottom)) {
                        inputFile.offset({ top: y - 15, left: x - 160 });
                    } else {
                        inputFile.offset({ top: -400, left: -400 });
                    }
                });
            }

            $("#" + dropZoneId).find('input[type="file"]').change(function(){
                var inputVal = $(this).val();
                if(inputVal === '') {
                    $(btnSend).prop('disabled',true);
                } else {
                    $(btnSend).prop('disabled',false);
                }
            });

            document.getElementById(dropZoneId).addEventListener("drop", function (e) {
                $("#" + dropZoneId).removeClass(mouseOverClass);
            }, true);
        }
    }
})(jQuery);