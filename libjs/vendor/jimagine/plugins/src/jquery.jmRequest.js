/**
 * Définir les valeurs par defaut pour le comportement du callback
 * *
 $.jmRequest.defaults = {
    display: true,
    refresh: false,
    redirectUrl: null,
    timeout: 2800,
    debug: false
};

 /**
 * Définir les valeurs par defaut pour le mode de notification
 * *
 $.jmRequest.notifier = {
    cssClass : '.mc-message'
};

 $.jmRequest({
    handler: "ajax",
    url: '',
    method: 'GET',
    dataType: 'json'
});

 $("#my_form").on('submit',function(){
     $.jmRequest({
            handler: "submit",
            url: '',
            method: 'post',
            form: $(this),
            resetForm:true,
            beforeSend:function(){},
            success:function(e){
                $.jmRequest.initbox(e,{
                        display: true
                    },{
                        cssClass : '.mc-message'
                    }
                );
            }
	 });
	 return false;
});
 *
 */

;(function ( $, window, document, undefined ) {
    $.jmRequest = function(options) {
        let settings = {
            handler: "ajax",
            method: "POST",
            dataType : '',
            url: null,
            data: {},
            form: null,
            beforeSerialize:null,
            resetForm: null,
            target: null,
            statusCode: {
                0: () => console.error("jQuery Error"),
                401: () => console.warn("access denied"),
                404: () => console.warn("object not found"),
                403: () => console.warn("request forbidden"),
                408: () => console.warn("server timed out waiting for request"),
                500: () => console.error("Internal Server Error")
            },
            processData: true,
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            async: true,
            cache: false,
            beforeSend: false,
            xhr: false,
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr);
                console.log(ajaxOptions);
                console.log(thrownError);
            },
            success: function(e, textStatus, XMLHttpRequest){
                $.jmRequest.initbox(e);
            },
            complete: false
        };
        let opt = $.extend(true, {}, settings,options);

        if(typeof opt !== 'object' || opt === "undefined") console.log(opt);
        if(opt.handler === "undefined" || opt.handler === '' || opt.handler == null) console.log('handler is null');

        let initHandler = {
            jmAjax: function(){
                // --- Default options of the ajax request
                let ajaxParams = {
                    method: opt.method,
                    type: opt.method,
                    url: opt.url,
                    dataType: opt.dataType,
                    statusCode: opt.statusCode,
                    processData:opt.processData,
                    contentType:opt.contentType,
                    async: opt.async,
                    cache: opt.cache,
                    data: opt.data,
                    beforeSend: opt.beforeSend,
                    success: opt.success
                };
                if(opt.dataFilter) ajaxParams.dataFilter = opt.dataFilter;
                if(opt.xhr) ajaxParams.xhr = opt.xhr;
                if(opt.error) ajaxParams.error = opt.error;
                if(opt.complete) ajaxParams.complete = opt.complete;

                if(opt.debug === true) {
                    if( console && console.log ) {
                        console.log(ajaxParams);
                    }
                }
                $.ajax(ajaxParams).done(function ( data ) {
                    if(opt.debug === true && console && console.log ) {
                        console.log(data);
                    }
                    if(opt.resetForm === true && opt.form !== null){
                        opt.form.reset();
                    }
                }).fail(function(xhr, status, error){
                    console.group('Error jmRequest');
                    console.error('Status %s ',status);
                    console.error('URL: '+opt.url+' %s',error);
                    console.error('xhr %s ',xhr);
                    console.log(opt);
                    console.dir(ajaxParams);
                    console.groupEnd();
                });
            },
            jmSubmit: function() {
                if(jQuery().ajaxSubmit) {
                    $(opt.form).ajaxSubmit.debug = opt.debug === true;

                    let submitParams = {
                        method: opt.method,
                        type: opt.method,
                        url: opt.url,
                        dataType: opt.dataType,
                        statusCode: opt.statusCode,
                        processData:opt.processData,
                        contentType:opt.contentType,
                        async: opt.async,
                        cache: opt.cache,
                        data: opt.data,
                        resetForm: opt.resetForm,
                        clearForm: opt.clearForm,
                        forceSync: opt.forceSync,
                        beforeSerialize:opt.beforeSerialize,
                        beforeSubmit:opt.beforeSend,
                        success: opt.success
                    };
                    if(opt.dataFilter) submitParams.dataFilter = opt.dataFilter;
                    if(opt.xhr) submitParams.xhr = opt.xhr;
                    if(opt.error) submitParams.error = opt.error;
                    if(opt.complete) submitParams.complete = opt.complete;

                    $(opt.form).ajaxSubmit(submitParams);
                }
                else {
                    console.error('jquery form is not defined');
                }
            },
            jmForm: function() {
                if(jQuery().ajaxForm) {
                    $(opt.form).ajaxForm.debug = opt.debug === true;
                    $(opt.form).ajaxForm({
                        url:opt.url,
                        type:opt.method,
                        data:opt.data,
                        dataType: opt.dataType,
                        resetForm: opt.resetForm,
                        clearForm: opt.clearForm,
                        forceSync:false,
                        beforeSerialize:opt.beforeSerialize,
                        beforeSubmit:opt.beforeSend,
                        success: opt.success
                    });
                }
                else {
                    console.error('jquery form is not defined');
                }
            }
        };

        if(opt.handler === "") {
            console.log("%s: %o","handler is null");
            return false;
        }
        else if(typeof(opt.handler) === "undefined") {
            console.log("%s: %o","handler is undefined");
            return false;
        }
        else {
            switch(opt.handler){
                case "ajax":
                    initHandler.jmAjax();
                    break;
                case "submit":
                    initHandler.jmSubmit();
                    break;
                case "form":
                    initHandler.jmForm();
                    break;
            }
        }
    };

    /**
     * Paramètres par defaut pour le comportement du callback
     * @type {Object}
     */
    $.jmRequest.defaults = {
        display: true,
        refresh: false,
        redirectUrl: false,
        timeout: 2800,
        debug: false
    };

    /**
     * Paramètres par defaut pour le mode de notification
     * @type {Object}
     */
    $.jmRequest.notifier = {
        cssClass : '.mc-message'
    };

    /**
     * Redirection function.
     * @param {string} loc - url where to redirect.
     * @param {int} [timeout=2800] - Time before redirection.
     */
    function redirect(loc, timeout) {
        timeout = typeof timeout !== 'undefined' ? timeout : 2800;
        setTimeout(function(){
            window.location.href = loc;
        },timeout);
    }

    /**
     * Reload function.
     * @param {int} [timeout=2800] - Time before reload.
     */
    function reload(timeout){
        timeout = typeof timeout !== 'undefined' ? timeout : 2800;
        setTimeout(function(){
            location.reload();
        },timeout);
    }

    /**
     * Retourne le setting avec des conditions pour la notification
     * @param setting
     * @return {Object|String}
     * @private
     */
    function setNotifier(setting){
        let optDefault = $.jmRequest.notifier,
            config = {cssClass: ''};

        switch (typeof setting) {
            case "string":
                config.cssClass = setting;
                break;
            case "object":
                if(typeof setting.cssClass === "string") {
                    config.cssClass = setting.cssClass;
                    break;
                }
            default:
                config.cssClass = (typeof(optDefault.cssClass) === "undefined" || optDefault.cssClass === "" || optDefault.cssClass === null) ? "" : optDefault.cssClass;
        }

        return config;
    }

    /**
     * Définition du comportement de l'affichage du callback
     * @param response
     * @param options
     * @param notifierOpts
     */
    $.jmRequest.initbox = function(response, options, notifierOpts) {
        let opts = $.extend(true, {}, $.jmRequest.defaults, options);
        let notifier = setNotifier(notifierOpts);

        if (!$.isPlainObject(opts)) console.log(notifier.cssClass);

        if(typeof opts !== 'object') console.log("%s: %o","jmRequest default initbox is not object");
        if(typeof notifier !== 'object') console.log("%s: %o","jmRequest notifier initbox is not object");

        if(opts.display !== false && notifier.cssClass !== '' && notifier.cssClass !== null && notifier.cssClass !== undefined){
            if(opts.debug) console.info(notifier.cssClass);
            $(notifier.cssClass).html(response);
        }

        if(opts.redirectUrl && typeof opts.redirectUrl === "string" && opts.redirectUrl !== "") redirect(opts.redirectUrl,opts.timeout);

        if(opts.refresh) reload(opts.timeout);
    }
})( jQuery, window, document );