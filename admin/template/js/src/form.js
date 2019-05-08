/**
 * @version    1.0
 * @author Salvatore Di Salvo <disalvo.infographiste@gmail.com>
 */
const niceForms = (function ($, undefined) {
    'use strict';

    function isEmpty(elem) {
        const val = elem.val();
        return ((typeof val === 'string' && val.length === 0) || (typeof val === 'object' && val == null));
    }

    function updateParent(elem) {
        const id = elem.attr('id');
        if(isEmpty(elem))
            $('[for="'+id+'"]').addClass('is_empty');
        else
            $('[for="'+id+'"]').removeClass('is_empty');
    }

    function reset() {
        $('form').each(function(){
            let nicefields = $(this).find('input:not(.not-nice),textarea:not(.not-nice),select:not(.not-nice)');
            nicefields.each(function(){updateParent($(this));});
        });
    }

    function init() {
        $('form').each(function(){
            let input = $(this).find('input:not(.not-nice)');
            let txtarea = $(this).find('textarea:not(.not-nice)');
            let select = $(this).find('select:not(.not-nice)');

            input.each(function(){
                let self = $(this);
                if(self.attr('type') !== 'hidden') {
                    updateParent(self);
                    self.on('change',function(){updateParent(self)});
                }
            });
            txtarea.each(function(){
                let self = $(this);
                updateParent(self);
                self.on('change',function(){updateParent(self)});
            });
            select.each(function(){
                let self = $(this);
                updateParent(self);
                self.on('change',function(){updateParent(self)});
            });
        });
    }

    return {
        /**
         * Public functions
         */
        init: function () { init(); },
        reset: function () { reset(); }
    };
})(jQuery);

const globalForm = (function ($, undefined) {
    'use strict';
    /**
     * Redirection function.
     * @param {string} loc - url where to redirect.
     * @param {int} [timeout=2800] - Time before redirection.
     */
    function redirect(loc,timeout) {
        timeout = typeof timeout !== 'undefined' ? timeout : 2800;
        setTimeout(function(){
            window.location.href = loc;
        },timeout);
    }

    /**
     * Replace the submit button by a loader icon.
     * @param {string} f - id of the form.
     * @param {boolean} [closeForm=true] - hide the form.
     */
    function displayLoader(f,closeForm) {
        closeForm = typeof closeForm !== 'undefined' ? closeForm : true;
        var loader = $(document.createElement("div")).addClass("loader pull-right")
            .append(
                $(document.createElement("i")).addClass("fa fa-spinner fa-pulse fa-2x fa-fw"),
                $(document.createElement("span")).append("Opération en cours...").addClass("sr-only")
            );
        if(closeForm) $(f).collapse();
        $('button[type="submit"]').parent().empty().append(loader);
    }

    /**
     * Remove the loader icon.
     * @param {string} f - id of the form.
     * @param {boolean} [closeForm=true] - hide the form.
     */
    function removeLoader(f,closeForm) {
        closeForm = typeof closeForm !== 'undefined' ? closeForm : true;
        if(closeForm) $(f).collapse('hide');
        $('.loader').parent().empty();
    }

    /**
     * Initialise the display of notice message
     * @param {html} m - message to display.
     * @param {int|boolean} [timeout=false] - Time before hiding the message.
     * @param {string|boolean} [sub=false] - Sub-controller name to select the container for the message.
     */
    function initAlert(m,timeout,sub) {
        sub = typeof sub !== 'undefined' ? sub : false;
        timeout = typeof timeout !== 'undefined' ? timeout : false;
        if(sub) $.jmRequest.notifier = { cssClass : '.mc-message-'+sub };
        $.jmRequest.initbox(m,{ display:true });
        if(timeout) window.setTimeout(function () { $('.mc-message .alert').alert('close'); }, timeout);
    }

    /**
     * Assign the correct success handler depending of the validation class attached to the form
     * @param {string} f - id of the form.
     * @param {string} controller - The name of the script to be called by te form.
     * @param {string|boolean} sub - The name of the sub-controller used by the script.
     */
    function successHandler(f,controller,sub) {
        // --- Default options of the ajax request
        var options = {
            handler: "submit",
            url: $(f).attr('action'),
            method: 'post',
            form: $(f),
            resetForm: false,
            success: function (d) {
                if(d.debug !== undefined && d.debug !== '') {
                    initAlert(d.debug);
                }
                else if(d.notify !== undefined && d.notify !== '') {
                    initAlert(d.notify,4000);
                }
            }
        };

        // --- Rules form classic add form
        if($(f).hasClass('add_form')) {
            options.beforeSend = function(){ displayLoader(f); };
            options.success = function (d) {
                removeLoader(f);
                $.jmRequest.initbox(d.notify,{ display:true });
                redirect(controller);
                initModalActions();
            };
        }
        // --- Rules form search form
        else if($(f).hasClass('search_form')) {
            options.method = 'get';
            options.data = {ajax: true};
            options.success = function (d) {
                if(d.status && d.result) {
                    $(f).find('tbody').empty().append(d.result);
                }
            };
        }
        // --- Rules form search form
        else if($(f).hasClass('pwd_form')) {
            options.resetForm = true;
        }
        // --- Rules form classic edit form but with replace from extend data
        else if($(f).hasClass('edit_form_extend')) {
            options.success = function (d) {
                $.jmRequest.initbox(d.notify,{ display:true });
                initAlert(d.notify,4000);
                $.each(d.extend[0], function(i,item) {
                    if($('#lang-'+i).length !== 0){
                        $('#lang-'+i+' #public_url'+i).val(item);
                    }
                });
            };
        }
        else if($(f).hasClass('edit_form_img')) {
            options.success = function (d) {
                $.jmRequest.initbox(d.notify,{ display:true });
                //initAlert(d.notify,4000);
                if(d.status && d.result) {
                    if($(f).data('target')){
                        var targ = $(f).data('target');
                        $('#'+targ).empty();
                        $('#'+targ).html(d.result);
                    }else{
                        $('.block-img').empty();
                        $('.block-img').html(d.result);
                    }
                }
            };
        }
        else if($(f).hasClass('delete_form_img')) {
            options.success = function (d) {
                $.jmRequest.initbox(d.notify,{ display:true });
                if(d.status && d.result) {
                    if($(f).data('target')){
                        var targ = $(f).data('target');
                        $('#'+targ).empty();
                        $('#'+targ).html(d.result);
                    }else{
                        $('.block-img').empty();
                        $('.block-img').html(d.result);
                    }

                    if(typeof imgdrop !== 'undefined') imgdrop.reset();
                    if(typeof $('.img-drop') !== 'undefined') $('.img-drop').addClass('no-img');
                }
            };
        }
        // --- Rules for add form in a modal
        else if($(f).hasClass('add_modal_form')) {
            options.success = function (d) {
                initAlert(d.notify,4000);
                $('#add_modal').modal('hide');
                if(d.status && d.result) {
                    //controller = controller.substr(1,(controller.indexOf('.')-1));
                    var table = '#table-'+controller;
                    var nbr = $(table).find('tbody').find('tr').length;
                    if(!nbr) {
                        $(table).removeClass('hide').next('.no-entry').addClass('hide');
                    }
                    $(table).find('tbody').prepend(d.result);
                    initModalActions();
                }
            };
        }
        // --- Rules for add form that add the new record into the associated table
        else if($(f).hasClass('add_to_list')) {
            options.resetForm = true;
            options.success = function (d) {
                sub = $(f).data('sub') == '' ? false : $(f).data('sub');
                initAlert(d.notify,4000,sub);
                if(d.status && d.result) {
                    var table = $(f).next().find('table');
                    $(table).children('tbody').prepend(d.result).find('a.targetblank').off().on('click',function(){
                        window.open($(this).attr('href'));
                        return false;
                    });
                }
                initValidation(controller,'.edit_in_list');
                initModalActions();
            };
        }
        // --- Rules for add form that add the new record into the associated list
        else if($(f).hasClass('add_to_ullist')) {
            options.resetForm = true;
            options.success = function (d) {
                if($(f).find('.selectpicker')) {
                    $(f).find('.selectpicker').bootstrapSelect('clear');
                    if(d.extend) {
                        $(f).find('.selectpicker [data-value="'+d.extend[0].id+'"]').remove();
                        $(f).find('.selectpicker').bootstrapSelect('reset');
                    }
                    else {
                        $(f).find('.selectpicker').bootstrapSelect('empty');
                    }
                }
                sub = $(f).data('sub') == '' ? false : $(f).data('sub');
                initAlert(d.notify,4000,sub);
                if(d.status && d.result) {
                    var ul = $(f).next().children('ul');
                    var nen = $('.no-entry');
                    if(!nen.hasClass('hide')) {
                        nen.addClass('hide');
                    }
                    $(ul).append(d.result);
                    $(ul).find('[data-toggle="collapse"]').each(function(){
                        var targ = $(this).attr("href");
                        $(targ).removeData('bs.collapse').collapse({toggle: false});
                        $(this).off().on('click',function(e){
                            e.preventDefault();
                            $(targ).collapse('toggle');
                            return false;
                        });
                    });
                    initDroplang();
                }
                initValidation(controller,'.edit_in_list');
                initModalActions();
                $('.additional-fields').collapse('hide');
            };
        }
        // --- Rules for edit form that edit a record into a table list
        else if($(f).hasClass('edit_in_list')) {
            options.success = function (d) {
               $.jmRequest.initbox(d.notify, { display: false });
               if(d.status) {
                   $('[type="submit"]', f).hide();
                   $('.text-success', f).removeClass('hide');

                   window.setTimeout(function () {
                       $('.text-success', f).addClass('hide');
                       $('[type="submit"]', f).show();
                   }, 3000);
               }
           };
        }
        // --- Rules for delete form, will remove the deleted rows form the record list based on their id
        else if($(f).hasClass('delete_form')) {
            options.resetForm = true;
            //controller = sub?sub:controller.substr(1,(controller.indexOf('.')-1));
            controller = sub?sub:controller;

            options.success = function (d) {
                $('#delete_modal').modal('hide');
                //$.jmRequest.notifier.cssClass = '.mc-message-'+controller;
                $.jmRequest.notifier = {
                    cssClass : '.mc-message-'+controller
                };
                initAlert(d.notify,4000);
                if(d.status && d.result) {
                    if(typeof d.result.id === 'string' || typeof d.result.id === 'number') {
                        let ids = 0;
                        if(typeof d.result.id === 'string') {
                            ids = d.result.id.split(',');
                        }
                        else if(typeof d.result.id === 'number') {
                            ids = [d.result.id];
                        }
                        let nbr = 0;
                        let table = $('#table-'+controller);
                        let container = null;

                        for(var i = 0;i < ids.length; i++) {
                            container = $('#'+controller+'_' + ids[i]).parent();
                            $('#'+controller+'_' + ids[i]).next('.collapse').remove();
                            $('#'+controller+'_' + ids[i]).remove();
                            if(table.is("table")) {
                                nbr = table.find('tbody').find('tr').length;
                            }
                            else if(table.is("ul") && !nbr) {
                                nbr = table.children('li').length;
                            }
                        }

                        container.trigger('change');

                        if(table.is("table") && !nbr) {
                            table.addClass('hide').next('.no-entry').removeClass('hide');
                        }
                        else if(table.is("ul") && !nbr) {
                            table.next('.no-entry').removeClass('hide');
                        }
                        $('.nbr-'+controller).text(nbr);
                    }
                    else {
                        console.log(d.result);
                    }

                    initModalActions();
                }
            };
        }

        // --- Initialise the ajax request
        $.jmRequest(options);
    }

    /**
     * Initialise the rules of validation for the form(s) matching the selector passed throught the form parameter
     * @param {string} controller - The name of the script to be called by te form.
     * @param {string} form - id of the form.
     * @param {string} sub - The name of the sub-controller used by the script.
     */
    function initValidation(controller,form,sub) {
        form = typeof form !== 'undefined' ? form : '.validate_form';
        sub = typeof sub !== 'undefined' ? sub : false;

        // --- Global validation rules
        $(form).each(function(){
            $(this).removeData();
            $(this).off();
            $(this).validate({
                ignore: [],
                onsubmit: true,
                event: 'submit',
                submitHandler: function(f,e) {
                    e.preventDefault();
                    successHandler(f,controller,sub);
                    return false;
                }
            });
        });
    }

    /**
     * Configure the delete modal by filling the id input and set the destination of the form
     * Then initialise the validation of the delete form
     *
     * @param {string} modal - id of the delete modal.
     * @param {int|string} id - id(s) to be deleted.
     * @param {string} controller - The name of the script to be called by te form.
     * @param {string} sub - The name of the sub-controller used by the script.
     */
    function delete_data(modal, id, controller, sub) {
        if(id === 'uninstall') {
            $(modal+' input[name="action"]').val(id);
            $(modal+' input[name="controller"]').val(controller);
            $(modal).modal('show');
        }
        else {
            $(modal+' input[type="hidden"]').val(id);
            $(modal).modal('show');
            var url = $('#delete_form').attr('action');
            if(url.indexOf("tabs") === -1) {
                url = url+(sub?'&tabs='+sub:'');
            }
            else {
                url.replace('&tabs=([^&]*)','&tabs='+sub);
            }

            $(modal).find('form').attr('action',url);

            initValidation(controller,'#delete_form',sub);
        }
    }

    /**
     * Initialise all modals
     * ---------------------
     *
     * Initialise all delete buttons and retrieves all the data needed for the delete action
     */
    function initModalActions() {
        var modals = $('.modal');

        if(modals.length) {
            modals.modal({show: false});

            $('.modal_action').each(function(){
                $(this).off().on('click',function(e){
                    e.preventDefault();
                    var modal = $(this).data('target'),
                        controller = $(this).data('controller'),
                        sub = $(this).data('sub') ? $(this).data('sub') : false,
                        id = false;

                    if($(this).hasClass('action_on_record')) {
                        id = $(this).data('id') ? $(this).data('id') : false;
                    } else {
                        var selected = $('#table-'+(sub?sub:controller)).find('input[type="checkbox"]:checked');
                        if(selected.length) {
                            var ids = $.map(selected, function (v){ return $(v).val(); });
                            id = ids.join();
                        }
                    }

                    if(modal && id && controller) {
                        delete_data(modal, id, controller, sub);
                    } else {
                        $('#error_modal').modal('show');
                    }
                });
            });
        }
    }

    /**
     * Call the collapse show function on element
     * depending on if it's had been hide previously or not
     * @param box
     */
    function showBox(box) {
        if(!$(box).data('fstt')) {
            $(box).on('hidden.bs.collapse', function() {
                $(this).off('hidden.bs.collapse');
                $(this).collapse('show').data({opened: false, closed: true}).on('hidden.bs.collapse', function() {
                    $(this).data({opened: false, closed: true});
                });
            });
        }
        else {
            $(box).collapse('show');
        }
    }

    /**
     * @param content
     * @param contc
     * @param $boxes
     */
    function displayContent(content,contc,$boxes) {
        if (content !== null && content.length > 0) {
            // *** Adding content to the dedicated container(s)
            if(contc.indexOf('|') === -1 && !Array.isArray(content)) {
                var targ = $(contc),
                    $def = targ.find('.default');
                targ.empty();
                if($def !== null && $def !== undefined) {
                    var dflt = $def.clone();
                    targ.append(dflt);
                }
                targ.append(content);
            }
            else {
                contc = contc.split('|');
                for(var c = 0; c < contc.length; c++) {
                    var targ = $(contc[c]),
                        $def = targ.children('.default');
                    if(targ.hasClass('selectpicker')) {
                        var list = targ.find('.list-to-filter ul');
                        list.empty();
                        if($def !== null && $def !== undefined) {
                            var dflt = $def.clone();
                            list.append(dflt);
                        }
                        if(Array.isArray(content))
                            list.append(content[c]);
                        else
                            list.append(content);

                        //targ.off();
                        //targ.removeData('bs.dropdownselect');
                        targ.bootstrapSelect('reset');
                    }
                    else {
                        targ.empty();
                        if($def !== null && $def !== undefined) {
                            var dflt = $def.clone();
                            targ.append(dflt);
                        }
                        if(Array.isArray(content))
                            targ.append(content[c]);
                        else
                            targ.append(content);
                    }
                }
            }

            //initOptionalFields(controller);

            // *** Displaying boxe(s)
            if($boxes.indexOf('|') === -1) {
                showBox($boxes);
            }
            else {
                $boxes = $boxes.split("|");
                for (var b = 0; b < $boxes.length; b++) {
                    showBox($boxes[b]);
                }
            }
        }
    }

    function getContent(controller,type,id,content) {
        var dfd = $.Deferred();

        $.jmRequest({
            handler: "ajax",
            url: controller+'&action=get&content='+type+'&id='+id,
            method: 'get',
            success: function(d){
                content.push(d);
                dfd.resolve();
            }
        });

        return dfd.promise();
    }

    /**
     * Initialise the handlers of optional fields
     */
    function initOptionalFields(controller) {
        $('.additional-fields').collapse({toggle: false}).data({fstt: true, opened: false, closed: true})
            .on('shown.bs.collapse', function() {
                $(this).data({opened: true, closed: false});
            })
            .on('hidden.bs.collapse', function() {
                $(this).data({opened: false, closed: true});
            }).each(function(){
                if($(this).hasClass('in')) {
                    $(this).data({fstt: true, opened: true, closed: false})
                }
        });

        $('.has-optional-fields').each(function(){
            var select = $(this);
            var $slct = select.find(':selected');
            var smf = $(this).find('.optional-field');
            var rboxes = [];

            smf.each(function(){
                if($(this).data('target') && rboxes.indexOf($(this).data('target')) === -1)
                    rboxes = rboxes.concat($(this).data('target').split("|"));
            });

            $(this).off('change');
            $(this).on('change',function(){
                var change = $slct !== select.find(':selected');
                $slct = select.find(':selected');

                if($slct.length && change) {
                    for(var n = 0; n < rboxes.length; n++) {
                        if($(rboxes[n]).data('closed')) {
                            $(rboxes[n]).data('fstt',true);
                        } else {
                            $(rboxes[n]).collapse('hide');
                            $(rboxes[n]).data('fstt',false);
                        }
                    }

                    if($slct.hasClass('optional-field')) {
                        var $boxes = $slct.data('target'); // Get boxes to display
                        var getc = $slct.data('get'); // get content to retrieve

                        // *** Retrieving content(s)
                        if(getc !== undefined && getc !== null) {
                            getc = getc.split('|');

                            var contc = $slct.data('appendto'), // get container which receive content
                                id = $slct.data('id'), // get id to specify content
                                content = [],
                                requests = [];

                            for(var c = 0; c < getc.length; c++){
                                requests.push(getContent(controller,getc[c],id,content));
                            }

                            $.when.apply($, requests).done(function(){
                                displayContent(content,contc,$boxes);
                            });
                        }
                        else {
                            // *** Displaying boxe(s)
                            if($boxes.indexOf('|') === -1) {
                                showBox($boxes);
                            }
                            else {
                                $boxes = $boxes.split("|");
                                for (var b = 0; b < $boxes.length; b++) {
                                    showBox($boxes[b]);
                                }
                            }
                        }
                    }
                }
            });
        });
    }

    /**
     *
     */
    function initDroplang() {
        $('.dropdown-lang').each(function () {
            var self = $(this);
            var items = $(this).find('a[data-toggle="tab"]');

            $(items).off().on('shown.bs.tab', function (e) {
                $(self).find('.dropdown-menu li.active').removeClass('active');
                $(this).parent('li').addClass('active');
                $(self).find('.lang').text($(this).text());
                $('[data-toggle="toggle"]').each(function(){
                    $(this).bootstrapToggle('destroy');
                }).each(function(){
                    $(this).bootstrapToggle();
                });
            });
        });
    }

    return {
        /**
         * Public functions
         * @param {string} controller - The name of the script to be called by te form.
         */
        run: function (controller) {
            $.gForms = globalForm;
            // --- Launch forms validators initialisation
            initValidation(controller);
            // --- Launch modal initialisations
            initModalActions();
            // --- Launch optional fields handler initialisation
            initOptionalFields(controller);
            // --- Launch dropdown menu for languages initialisation
            initDroplang();
        },
        initModals: function () {
            // --- Launch modal initialisations
            initModalActions();
        }
    };
})(jQuery);

$(document).ready(function(){
    // *** Set default values for forms validation
    /*jQuery.validator.addClassRules("phone", {
        pattern: '((?=[0-9\+\-\ \(\)]{9,20})(\+)?\d{1,3}(-| )?\(?\d\)?(-| )?\d{1,3}(-| )?\d{1,3}(-| )?\d{1,3}(-| )?\d{1,3})'
    });*/
    $.validator.setDefaults({
        debug: false,
        highlight: function(element, errorClass, validClass) {
            let parent = $(element).parent();
            if(parent.is("div,p")) {
                if(parent.hasClass('input-group')) {
                    parent.parent().addClass("has-error has-feedback");
                } else {
                    //if(!parent.hasClass('has-error')) parent.append('<span class="fa fa-warning form-control-feedback" aria-hidden="true"></span>');
                    parent.addClass("has-error has-feedback");
                }
            }
            else if($(element).is('[type="radio"],[type="checkbox"]')) {
                parent.parent().addClass("has-error").parent().addClass("has-error");
            }
        },
        unhighlight: function(element, errorClass, validClass) {
            let parent = $(element).parent();
            if(parent.is("div,p")) {
                if(parent.hasClass('input-group')) {
                    parent.parent().removeClass("has-error has-feedback");
                } else {
                    if(parent.hasClass('has-error'))
                        parent.find('.fa').remove();
                    parent.removeClass("has-error has-feedback");
                }
            }
            else if($(element).is('[type="radio"],[type="checkbox"]')) {
                parent.parent().removeClass("has-error").parent().removeClass("has-error");
            }
        },
        // the errorPlacement has to take the table layout into account
        errorPlacement: function(error, element) {
            if ( element.is(":radio") ) {
                element.parent().parent().parent().append(error);
            } else if ( element.is(":checkbox,.checkMail")) {
                error.insertAfter(element.next());
            } else if ( element.is("#cryptpass,:submit")) {
                error.insertAfter(element.next());
                $("<br />").insertBefore(error,null);
            } else if ( element.next().is(":button,:file") ) {
                error.insertAfter(element);
                $("<br />").insertBefore(error,null);
            } else if ( element.parent().hasClass('input-group') ) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
        },
        errorClass: "help-block error",
        errorElement: "span",
        validClass: "success",
        // set this class to error-labels to indicate valid fields
        success: function(label) {
            // set &nbsp; as text for IE
            label.remove();
        }
    });

    // *** Set default format for date input
    $('.date-input').formatter({
        'pattern': '{{99}}/{{99}}/{{9999}}',
        'persistent': false
    });

    // *** Set default format for date input
    $('.time-input').formatter({
        'pattern': '{{99}}:{{99}}',
        'persistent': false
    });

    niceForms.init();
    if(controller) globalForm.run(controller);
});