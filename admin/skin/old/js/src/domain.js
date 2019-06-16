var domain = (function ($, undefined) {
    function initGen(){
        var idDomain = $('#id_domain').val();
        var dataType = $('#data_type').val();
        var progressBar = new ProgressBar('#progress-thumbnail',{loader: {type:'text', icon:'etc'}});
        $.jmRequest({
            handler: "ajax",
            url: $('#create_sitemap').attr('action'),
            method: 'POST',
            data: {data_type: dataType,id: idDomain},
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
                    $("#sitemap-url").html(d.result);
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
    return {
        run: function(){
            $('.progress').hide();
            $('.form-gen').on('submit', function(e) {
                e.preventDefault();
                initGen();
                return false;
            });
        }
    }
})(jQuery);