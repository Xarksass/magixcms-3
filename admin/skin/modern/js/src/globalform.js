/**
 * @name Global Form
 * @Description Form Validator and success handler
 * @version 2.0
 * @author Salvatore Di Salvo <disalvo.infographiste@gmail.com>
 * @date_created 21-05-2019
 */
class GlobalForm {
    constructor(options) {
        if(typeof $ === "undefined") throw new Error("jQuery is required by GlobalForm to run properly");
        if(typeof $.jmRequest === "undefined") throw new Error("jmRequest is required by GlobalForm to run properly");
        this.controller = null;
        this.forms = {
            selector: '.validate_form'
        };
        this.message = {
            selector: '.mc-message'
        };
        if(typeof options === 'object') this.set(options);
        this.loader = new loaderSVG();
    }

    set(options) {
        let instance = this;
        for (var key in options) {
            if (options.hasOwnProperty(key)) instance[key] = options[key];
        }
    }

    initDroplang() {
        let dropdownlang = $('.dropdown-lang');
        dropdownlang.each(function () {
            let items = $(this).find('a[data-toggle="tab"]');

            //TODO link all dropdown-langs together : 1 changes, all change
            $(items).off().on('shown.bs.tab', function (e) {
                let linkedid = $(this).data('target');
                let linked = $('a[data-toggle="tab"][data-target="'+linkedid+'"]');

                dropdownlang.find('.dropdown-menu li.active').removeClass('active');
                linked.parent('li').addClass('active');
                dropdownlang.find('.lang').text($(this).data('iso'));

                $('[data-toggle="toggle"]').each(function(){
                    $(this).bootstrapToggle('destroy');
                }).each(function(){
                    $(this).bootstrapToggle();
                });
            });
        });
    }

    initSections() {
        $('.form-sections').each(function(){
            let self = this;

            $('.header-title', self).each(function(){
                $(this).on('click',function(){
                    let parent = $(this).parent().parent(),
                        sectionID = parent.attr('id'),
                        open = parent.hasClass('open');

                    $('.menu-sections [data-toggle="tab"]').parent().removeClass('active');
                    $('.open', self).removeClass('open active in');
                    $('.collapse.in', self).collapse('hide');

                    if(!open) {
                        parent.addClass('open active in');
                        $('[href="#'+sectionID+'"]').parent().addClass('active');
                    }

                    if(parent.hasClass('open')) {
                        $(this).parent().next().collapse('show').trigger('shown');
                    }
                });
            });

            $('.menu-sections [data-toggle="tab"]', self).each(function(){
                $(this).on('shown.bs.tab',function(e) {
                    let newTabId = $(this).attr('href');
                    $('section', self).removeClass('open');
                    $('section > div', self).removeClass('in');
                    $(newTabId).addClass('open');
                    $(newTabId+' > div').addClass('in').height('auto').trigger('shown');
                });
            });
        });
    }

    initSubmitBtn(form) {
        $(form).find('button[type="submit"]').each(function(){
            $(this).on('click',function(){
                $(form).data('caller',$(this).data('type'));
            });
        });
    }

    /**
     * Initialise the display of notice message
     * @param {html} m - message to display.
     * @param {int|boolean} [timeout=false] - Time before hiding the message.
     * @param {string|boolean} [sub=false] - Sub-controller name to select the container for the message.
     */
    initAlert(m,timeout,sub) {
        let instance = this;
        sub = typeof sub !== 'undefined' ? sub : false;
        timeout = typeof timeout !== 'undefined' ? timeout : false;
        if(sub) $.jmRequest.notifier = { cssClass : instance.message.selector+'-'+sub };
        $.jmRequest.initbox(m);
        if(timeout) window.setTimeout(function () { $(instance.message.selector+' .alert').alert('close'); }, timeout);
    }

    /**
     * Redirection function.
     * @param {string} loc - url where to redirect.
     * @param {int} [timeout=2800] - Time before redirection.
     * @param {string} action - action parameter.
     * @param {int} id - edit parameter.
     */
    redirect(loc,timeout,action,id) {
        timeout = typeof timeout !== 'undefined' ? timeout : 2800;
        action = typeof action === 'string' ? action : null;
        id = typeof id !== 'undefined' ? id : null;
        setTimeout(function(){
            window.location.href = loc + (action !== null ? '&action='+action : '') + (Number.isInteger(id) ? '&edit='+id : '');
        },timeout);
    }

    /**
     * Replace the submit button by a loader icon.
     * @param {string} f - id of the form.
     * @param {boolean} [closeForm=true] - hide the form.
     */
    displayLoader(f,closeForm) {
        let instance = this;
        closeForm = typeof closeForm !== 'undefined' ? closeForm : true;

        let ld_label = $(f).data('ld-label');
        instance.loader.set({
            label: (ld_label ? ld_label : null)
        });

        if(closeForm) $('.form-sections').hide();
        $('.form-sections').after(instance.loader.render());
    }

    /**
     * Remove the loader icon.
     * @param {string} f - id of the form.
     * @param {boolean} [closeForm=true] - hide the form.
     */
    removeLoader(f,closeForm) {
        closeForm = typeof closeForm !== 'undefined' ? closeForm : true;
        if(closeForm) $(f).show();
        this.loader.remove();
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
    deleteData(modal, id, controller, sub) {
        if(id === 'uninstall') {
            $(modal+' input[name="action"]').val(id);
            $(modal+' input[name="controller"]').val(controller);
            $(modal).modal('show');
        }
        else {
            $(modal+' input[type="hidden"]').val(id);
            $(modal).modal('show');
            let url = $('#delete_form').attr('action');
            if(url.indexOf("tabs") === -1) {
                url = url+(sub?'&tabs='+sub:'');
            }
            else {
                url.replace('&tabs=([^&]*)','&tabs='+sub);
            }

            $(modal).find('form').attr('action',url);

            this.initValidation(controller,'#delete_form',sub);
        }
    }

    /**
     * Initialise all modals
     * ---------------------
     *
     * Initialise all delete buttons and retrieves all the data needed for the delete action
     */
    initModalActions() {
        let modals = $('.modal');
        let instance = this;

        if(modals.length) {
            modals.modal({show: false});

            $('.modal_action').each(function(){
                $(this).off().on('click',function(e){
                    e.preventDefault();

                    let modal = $(this).data('target'),
                        controller = $(this).data('controller'),
                        sub = $(this).data('sub') ? $(this).data('sub') : false,
                        id = false;

                    if($(this).hasClass('action_on_record')) {
                        id = $(this).data('id') ? $(this).data('id') : false;
                    }
                    else {
                        let selected = $('#table-'+(sub?sub:controller)).find('input[type="checkbox"]:checked');
                        if(selected.length) {
                            let ids = $.map(selected, function (v){ return $(v).val(); });
                            id = ids.join();
                        }
                    }

                    if(modal && id && controller) {
                        instance.deleteData(modal, id, controller, sub);
                    }
                    else {
                        $('#error_modal').modal('show');
                    }
                });
            });
        }
    }

    /**
     * Assign the correct success handler depending of the validation class attached to the form
     * @param {string} f - id of the form.
     * @param {string} controller - The name of the script to be called by te form.
     * @param {string|boolean} sub - The name of the sub-controller used by the script.
     * @param {string} caller - Type of call
     */
    successHandler(f,controller,sub,caller) {
        let instance = this;
        let resetForm = false;
        if($(f).hasClass('form-section')) {
            $('#form-footer').submit();
        }

        // --- Default options of the ajax request
        let options = {
            url: $(f).attr('action'),
            handler: 'ajax',
            method: 'POST',
            resetForm: false,
            form: f,
            success: function (d) {
                if(d.debug !== undefined && d.debug !== '') {
                    instance.initAlert(d.debug);
                }
                else if(d.notify !== undefined && d.notify !== '') {
                    instance.initAlert(d.notify,4000);
                }
            }
        };

        if($(f).hasClass('form-footer')) {
            let forms = document.querySelectorAll('.form-section');
            //let mf = new MagicForm(f);
            let data = {};

            forms.forEach(function(formElement){
                let mf = new MagicForm(formElement);
                data = MagicForm.mergeObject(data,mf.getData());
            });

            options.data = MagicForm.getFormDataFromData(data,f);
            options.cache = false;
            options.processData = false;
            options.contentType = false;
        }

        let handlers = $(f).data('handlers');

        if(typeof handlers === "string") {
            handlers = (handlers.indexOf('|') === -1) ? [handlers] : handlers.split('|');

            for(var h=0;h < handlers.length;h++) {
                let handler = handlers[h];
                let subhandler = null;

                if(handler.indexOf(':') !== -1) {
                    let parsedHandler = handler.split(':');
                    handler = parsedHandler[0];
                    subhandler = parsedHandler[1];
                }

                switch (handler) {
                    case 'edit':
                        options.beforeSend = function(){
                            $('#form-footer .submit').hide();
                            $('#form-footer').append(instance.loader.render(16));
                        };
                        options.success = function (d) {
                            instance.loader.remove();
                            $('#form-footer .submit').show();
                            switch (subhandler) {
                                case 'inlist':
                                    $.jmRequest.initbox(d.notify, { display: false });
                                    if(d.status) {
                                        $('[type="submit"]', f).hide();
                                        $('.text-success', f).removeClass('hide');

                                        window.setTimeout(function () {
                                            $('.text-success', f).addClass('hide');
                                            $('[type="submit"]', f).show();
                                        }, 3000);
                                    }
                                    break;
                                case 'img':
                                    if(d.status && d.display) {
                                        let tar = $(f).data('target');
                                        let container = tar ? $('#'+tar) : $('.block-img');
                                        container.empty();
                                        container.html(d.display);
                                    }
                                default:
                                    instance.initAlert(d.notify,4000);
                                    if(typeof d.extend !== "undefined") {
                                        $.each(d.extend, function(i,item) {
                                            let url_input = $('[name="public_url['+i+']"]');
                                            if(url_input !== undefined) {
                                                url_input.val(item.url);
                                                let uri_input = $('[name="'+url_input.data('uri')+'"]');
                                                if(uri_input !== undefined) uri_input.val(item.uri);
                                            }
                                        });
                                    }
                                }
                        };
                        break;
                    case 'add':
                        switch (subhandler) {
                            case 'edit':
                                options.success = function (d) {
                                    if(d.debug !== undefined && d.debug !== '') {
                                        instance.initAlert(d.debug);
                                    }
                                    else if(d.notify !== undefined && d.notify !== '') {
                                        instance.initAlert(d.notify,4000);

                                        if(caller === 'leave') {
                                            instance.initAlert(d.notify);
                                            if(d.status) {
                                                instance.displayLoader(f);
                                                instance.redirect(instance.controller,4000);
                                            }
                                        }
                                        else {
                                            instance.initAlert(d.notify,4000);
                                            if(d.status) {
                                                instance.displayLoader(f);
                                                instance.redirect(instance.controller,1000,'edit',d.result);
                                            }
                                        }

                                        if(d.result !== undefined) {
                                            $('input[name="id"]').val(d.result);
                                        }
                                    }
                                };
                                break;
                            case 'modal':
                                options.success = function (d) {
                                    instance.initAlert(d.notify,4000);
                                    $('#add_modal').modal('hide');
                                    if(d.status && d.result) {
                                        //controller = controller.substr(1,(controller.indexOf('.')-1));
                                        var table = '#table-'+controller;
                                        var nbr = $(table).find('tbody').find('tr').length;
                                        if(!nbr) {
                                            $(table).removeClass('hide').next('.no-entry').addClass('hide');
                                        }
                                        $(table).find('tbody').prepend(d.result);
                                        instance.initModalActions();
                                    }
                                };
                                break;
                            case 'tolist':
                                options.resetForm = true;
                                options.success = function (d) {
                                    sub = $(f).data('sub') == '' ? false : $(f).data('sub');
                                    instance.initAlert(d.notify,4000,sub);
                                    if(d.status && d.result) {
                                        var table = $(f).next().find('table');
                                        $(table).children('tbody').prepend(d.result).find('a.targetblank').off().on('click',function(){
                                            window.open($(this).attr('href'));
                                            return false;
                                        });
                                    }
                                    instance.initValidation(controller,'.edit_in_list');
                                    instance.initModalActions();
                                };
                                break;
                            case 'toullist':
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
                                    instance.initAlert(d.notify,4000,sub);
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
                                        instance.initDroplang();
                                    }
                                    instance.initValidation(controller,'.edit_in_list');
                                    instance.initModalActions();
                                    $('.additional-fields').collapse('hide');
                                };
                                break;
                            default:
                                options.beforeSend = function(){ instance.displayLoader(f); };
                                options.success = function (d) {
                                    instance.removeLoader(f);
                                    $.jmRequest.initbox(d.notify,{ display:true });
                                    redirect(controller);
                                    instance.initModalActions();
                                };
                        }

                        break;
                    case 'search':
                        options.method = 'get';
                        options.data = {ajax: true};
                        options.success = function (d) {
                            if(d.status && d.result) {
                                $(f).find('tbody').empty().append(d.result);
                            }
                        };
                        break;
                    case 'password':
                        options.resetForm = true;
                        break;
                    case 'delete':
                        switch (subhandler) {
                            case 'img':
                                options.success = function (d) {
                                    $.jmRequest.initbox(d.notify,{ display:true });
                                    if(d.status && d.result) {
                                        let tar = $(f).data('target');
                                        let resultContainer = typeof tar === "string" ? '#'+tar : '.block-img';

                                        $(resultContainer).empty();
                                        $(resultContainer).html(d.result);

                                        if(typeof imgdrop !== 'undefined') imgdrop.reset();
                                        if(typeof $('.img-drop') !== 'undefined') $('.img-drop').addClass('no-img');
                                    }
                                };
                                break;
                            default:
                                options.resetForm = true;
                                //controller = sub?sub:controller.substr(1,(controller.indexOf('.')-1));
                                controller = sub?sub:controller;

                                options.success = function (d) {
                                    $('#delete_modal').modal('hide');
                                    //$.jmRequest.notifier.cssClass = '.mc-message-'+controller;
                                    $.jmRequest.notifier = {
                                        cssClass : '.mc-message-'+controller
                                    };
                                    instance.initAlert(d.notify,4000);
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
                                            let parent = null;

                                            for(var i = 0;i < ids.length; i++) {
                                                let container = $('#'+controller+'_' + ids[i]);
                                                parent = container.parent();
                                                container.next('.collapse').remove();
                                                container.remove();
                                                if(table.is("table")) {
                                                    nbr = table.find('tbody').find('tr').length;
                                                }
                                                else if(table.is("ul") && !nbr) {
                                                    nbr = table.children('li').length;
                                                }
                                            }

                                            parent.trigger('change');

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

                                        instance.initModalActions();
                                    }
                                };
                        }
                }
            }
        }

        // --- Initialise the ajax request
        $.jmRequest(options);
        /*$.ajax(options).done(function(response) {
            if(resetForm === true) $(f).reset();
        });*/
    }

    /**
     * Initialise the rules of validation for the form(s) matching the selector passed throught the form parameter
     * @param {string|null} controller - The name of the script to be called by te form.
     * @param {string|null} form - id of the form.
     * @param {string|null} sub - The name of the sub-controller used by the script.
     */
    initValidation(controller,form,sub) {
        form = typeof form !== 'string' ? this.forms.selector : form;
        sub = typeof sub !== 'undefined' ? sub : false;
        let instance = this;

        // --- Global validation rules
        $(form).each(function(){
            instance.initSubmitBtn(this);

            $(this).removeData();
            $(this).off();
            $(this).validate({
                ignore: [],
                onsubmit: true,
                event: 'submit',
                submitHandler: function(f,e) {
                    let caller = $(f).data('caller');
                    if (caller === 'submit') {
                        f.submit();
                    }
                    else {
                        e.preventDefault();
                        instance.successHandler(f,controller,sub,caller);
                        return false;
                    }
                }
            });
        });
    }

    /**
     * Call the collapse show function on element
     * depending on if it's had been hide previously or not
     * @param box
     */
    showBox(box) {
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
    displayContent(content,contc,$boxes) {
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

    /**
     * @param controller
     * @param type
     * @param id
     * @param content
     * @returns {*}
     */
    getContent(controller,type,id,content) {
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
    initOptionalFields() {
        let instance = this;

        $('.additional-fields').collapse({toggle: false}).data({fstt: true, opened: false, closed: true})
            .on('shown.bs.collapse', function() {
                $(this).data({opened: true, closed: false});
            })
            .on('hidden.bs.collapse', function() {
                $(this).data({opened: false, closed: true});
            })
            .each(function(){
                if($(this).hasClass('in')) {
                    $(this).data({fstt: true, opened: true, closed: false})
                }
            });

        $('.has-optional-fields').each(function(){
            let select = $(this),
                $slct = select.find(':selected'),
                smf = $(this).find('.optional-field'),
                rboxes = [];

            smf.each(function(){
                if($(this).data('target') && rboxes.indexOf($(this).data('target')) === -1)
                    rboxes = rboxes.concat($(this).data('target').split("|"));
            });

            $(this).off('change').on('change',function(){
                let change = $slct !== select.find(':selected');
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
                        let $boxes = $slct.data('target'); // Get boxes to display
                        let getc = $slct.data('get'); // get content to retrieve

                        // *** Retrieving content(s)
                        if(getc !== undefined && getc !== null) {
                            getc = getc.split('|');

                            let contc = $slct.data('appendto'), // get container which receive content
                                id = $slct.data('id'), // get id to specify content
                                content = [],
                                requests = [];

                            for(var c = 0; c < getc.length; c++){
                                requests.push(instance.getContent(instance.controller,getc[c],id,content));
                            }

                            $.when.apply($, requests).done(function(){
                                instance.displayContent(content,contc,$boxes);
                            });
                        }
                        else {
                            // *** Displaying boxe(s)
                            if($boxes.indexOf('|') === -1) {
                                instance.showBox($boxes);
                            }
                            else {
                                $boxes = $boxes.split("|");
                                for (var b = 0; b < $boxes.length; b++) {
                                    instance.showBox($boxes[b]);
                                }
                            }
                        }
                    }
                }
            });
        });
    }

    initialize() {
        // --- Launch dropdown menu for languages initialisation
        this.initDroplang();
        // --- Launch form sections initialisation
        this.initSections();
        // --- Launch forms validators initialisation
        this.initValidation(null,null,null);
        // --- Launch modal initialisations
        this.initModalActions();
        // --- Launch optional fields handler initialisation
        this.initOptionalFields();
    }
}

const globalForm = new GlobalForm();

$(document).ready(function(){
    if(controller) {
        globalForm.set({controller: controller});
        globalForm.initialize();
    }
});