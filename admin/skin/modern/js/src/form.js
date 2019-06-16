$(document).ready(function(){
    // *** Set default values for forms validation
    if($.validator !== undefined) {
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
                }
                else if ( element.is(":checkbox,.checkMail")) {
                    error.insertAfter(element.next());
                }
                else if ( element.is("#cryptpass,:submit")) {
                    error.insertAfter(element.next());
                    $("<br />").insertBefore(error,null);
                }
                else if ( element.next().is(":button,:file") ) {
                    error.insertAfter(element);
                    $("<br />").insertBefore(error,null);
                }
                else if ( element.parent().hasClass('input-group') ) {
                    error.insertAfter(element.parent());
                }
                else {
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
    }

    if($.formatter !== undefined) {
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
    }
});