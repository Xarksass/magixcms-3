const mc_login = (function ($, undefined) {
    'use strict';
    function displayForgotPassword() {
        $('#error').hide();
        $("#login").find('.flip-container').toggleClass("flip");
        setTimeout(function(){$('.front').hide()},200);
        setTimeout(function(){$('.back').show()},200);
        $('#email_forgot').select();
    }

    function displayLogin() {
        $('#error').hide();
        $("#login").find('.flip-container').toggleClass("flip");
        setTimeout(function(){$('.back').hide()},200);
        setTimeout(function(){$('.front').show()},200);
        $('#email').select();
        return false;
    }

    return {
        initLoginForm: function () {
            let form = $("#login_form");
            let $this = this;

            let ld_label = form.data('ld-label');
            let loader = new loaderSVG({
                label: (ld_label ? ld_label : null)
            });

            form.validate({
                rules: {
                    "employee[email_admin]":{
                        "email": true,
                        "required": true
                    },
                    "employee[passwd_admin]": {
                        "required": true
                    }
                },
                submitHandler: function(f,e) {
                    e.preventDefault();
                    $.jmRequest({
                        handler: "submit",
                        url: '/admin/index.php?controller=login',
                        method: 'post',
                        form: f,
                        resetForm: true,
                        beforeSend: function(){
                            $('.flip-container > .alert').remove();
                            $(f).hide().after(loader.render());
                        },
                        success: function(d){
                            if(d.status) {
                                window.location.href = d.result;
                            }
                            else {
                                if(typeof d.notify !== 'undefined' && d.notify !== null) $.jmRequest.initbox(d.notify,{ display:true });
                                f.reset();
                                if(niceForms !== undefined) niceForms.reset();
                                $(f).show();
                                loader.remove();
                                $('#email_admin').focus();
                            }
                        }
                    });
                    return false;
                }
            });
        },
        initPwdForm: function () {
            $("#forgot_password_form").validate({
                rules: {
                    "email_forgot": {
                        "email": true,
                        "required": true
                    }
                },
                onsubmit: true,
                event: 'submit',
                highlight: function(element) {
                    $(element).closest('.form-group').addClass('has-error');
                },
                unhighlight: function(element) {
                    $(element).closest('.form-group').removeClass('has-error');
                },
                errorElement: 'span',
                errorClass: 'help-block',
                errorPlacement: function(error, element) {
                    if(element.parent('.input-group').length) {
                        error.insertAfter(element.parent());
                    } else {
                        error.insertAfter(element);
                    }
                },
                submitHandler: function(f,e) {
                    e.preventDefault();
                    $.jmRequest({
                        handler: "submit",
                        url: '/admin/index.php?controller=login&action=rstpwd',
                        method: 'post',
                        form: $(f),
                        resetForm:true,
                        beforeSend:function(){
                            $(f).find('.mc-message').hide().after('<div class="svg-loader text-center"><svg xmlns="http://www.w3.org/2000/svg" viewBox="25 25 50 50">\n' +
                                '\t<circle class="ring-bg" cx="50" cy="50" r="20"></circle>\n' +
                                '\t<circle class="outer" cx="50" cy="50" r="20"></circle>\n' +
                                '</svg></div>');
                            $(f).find('.form-group').hide();
                            $(f).find('[type="submit"]').hide();
                            //displayLoader(f);
                        },
                        success:function(d){
                            if(d.status) {
                                $('.svg-loader').remove();
                                var content = $(f).find('.mc-message').html();
                                $(f).find('.mc-message').show().toggleClass('alert-info').toggleClass('alert-success').find('h4').text(d.result);
                                $(f).find('.mc-message').find('p').remove();

                                setTimeout(function(){
                                    $(f).find('.form-group').show();
                                    $(f).find('[type="submit"]').show();
                                    $(f).find('.mc-message').empty();
                                    $(f).find('.mc-message').toggleClass('alert-info').toggleClass('alert-success').prepend(content);
                                },6000);
                            }
                        }
                    });
                    return false;
                }
            });
        },
        initFlipper: function () {
            $('.forgot-password').on('click',function(e) {
                e.preventDefault();
                displayForgotPassword();
            });

            $('.login-form').on('click',function(e) {
                e.preventDefault();
                displayLogin();
            });
        },
        run: function () {
            this.initLoginForm();
            this.initPwdForm();
            this.initFlipper();

            $('#email_admin').focus();
        }
    };
})(jQuery);

$(document).ready(function() { mc_login.run(); });