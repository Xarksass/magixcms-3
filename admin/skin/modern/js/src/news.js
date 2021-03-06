const news = {
    run: function(controller,iso){
        if($.fn.datetimepicker !== undefined) {
            $('.date-input-picker').datetimepicker({
                format: 'YYYY/MM/DD',
                locale: iso,
                icons: {
                    date: 'fa fa-calendar',
                    up: 'fa fa-chevron-up',
                    down: 'fa fa-chevron-down',
                    previous: 'fa fa-chevron-left',
                    next: 'fa fa-chevron-right',
                    today: 'fa fa-calendar-check-o',
                    clear: 'fa fa-trash-o',
                    close: 'fa fa-close'
                }
            });
        }

        if($.fn.tagsinput !== undefined) {
        //Select input contain keyword (tags) separated by comma
            $('.tags-input + input[type="hidden"]').each(function(){
                let tagsString = $(this).val().split(',');
                // convert in json tring
                let tagsArray = JSON.stringify(tagsString);
                tagsArray = JSON.parse(tagsArray);
                let datanames = new Bloodhound({
                    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
                    queryTokenizer: Bloodhound.tokenizers.whitespace,
                    local: $.map(tagsArray, function (item) {
                        return {
                            name: item
                        };
                    })
                });
                datanames.initialize();
                //select input for tagsinput
                let idTags = $(this).prev().attr('id');
                let idLang = $(this).prev().data('lang');
                $('input#'+idTags).tagsinput({
                    typeaheadjs: [{
                        minLength: 1,
                        highlight: true,
                    },{
                        minlength: 1,
                        name: 'datanames',
                        displayKey: 'name',
                        valueKey: 'name',
                        source: datanames.ttAdapter()
                    }],
                    freeInput: true
                });
                $('input#'+idTags).on('beforeItemRemove', function(event) {
                    let tag = event.item;
                    // Do some processing here
                    if (!event.options || !event.options.preventPost) {
                        $.jmRequest({
                            handler: "ajax",
                            url: controller+'&action=delete',
                            method: 'POST',
                            data: { 'name_tag': tag,'id': $('#id_news').val(), 'id_lang':idLang },
                            resetForm:false,
                            beforeSend:function(){},
                            success:function(data) {
                                $.jmRequest.initbox(data.notify, {
                                    display: false
                                });
                            }
                        });
                        return false;
                    }
                });
            });
        }
    }
};

window.addEventListener('load',function(){
    news.run(controller,iso);
});