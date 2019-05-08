{extends file="layout.tpl"}
{block name='head:title'}{#login_root#|ucfirst}{/block}
{block name='body:id'}login{/block}
{block name="header"}{/block}
{block name="main"}
    <main id="page" class="container-fluid">
        <div class="login-panel">
            {if $error}
                <div class="error">
                    {$error}
                </div>
            {/if}
            {if $debug}
                {$debug}
            {/if}
            <div id="logo">
                <img src="/{baseadmin}/template/img/logo/logo-magix_cms@229.png" alt="Magix CMS" width="229" height="50">
            </div>
            <div class="flip-container">
                <div class="flipper">
                    <div class="login-box front panel">
                        <form id="login_form" method="post" action="{$url}/admin/index.php?controller=login" class="nice-form">
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="{#placeholder_login#}" id="email_admin" name="employee[email_admin]" value="" />
                                <label class="control-label" for="email_admin">{#email#|ucfirst}</label>
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" placeholder="{#placeholder_password#}" id="passwd_admin" name="employee[passwd_admin]" value="" />
                                <label class="control-label" for="passwd_admin">{#passwd#}</label>
                            </div>
                            <div class="form-group submit-group">
                                <input type="hidden" id="hashtoken" name="employee[hashtoken]" value="{$hashpass}" />
                                <input type="submit" class="btn btn-box btn-block btn-main-theme" value="{#login#|upper}" />
                            </div>
                            <div class="form-group log-opt">
                                <div class="switch">
                                    <input type="checkbox" id="stay_logged" name="stay_logged" class="switch-native-control" />
                                    <div class="switch-bg">
                                        <div class="switch-knob"></div>
                                    </div>
                                </div>
                                <label for="stay_logged">{#stay_logged#}</label>
                                <a class="forgot-password pull-right" href="#">{#passwd_forgot#}</a>
                            </div>
                        </form>
                    </div>
                    <div class="pwd-box back panel">
                        <form id="forgot_password_form" method="post" action="#" class="nice-form">
                            <div class="mc-message alert alert-info">
                                <h4>{#passwd_forgot#} ?</h4>
                                <p>{#passwd_forgot_txt#}</p>
                            </div>
                            <div class="form-group">
                                <input id="email_forgot" class="form-control" type="text" placeholder="{#placeholder_login#}" name="email_forgot">
                                <label class="control-label" for="email_forgot">{#email#|ucfirst}</label>
                            </div>
                            <div class="form-group">
                                <button class="btn btn-box btn-link login-form" href="#" type="button">
                                    <i class="material-icons" aria-hidden="true">chevron_left</i>
                                    <span>{#back_to_login#}</span>
                                </button>
                                <button class="btn btn-box btn-main-theme pull-right" type="submit" name="submitLogin">{#send#|ucfirst}</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <p><i class="material-icons">copyright</i> 2018 Magix CMS &mdash; {#all_right_reserved#}</p>
        </div>
    </main>
{/block}
{block name="footer"}{/block}
{block name="foot" append}
    {script src="/{baseadmin}/min/?f={baseadmin}/template/js/src/login.js" type="javascript"}
{/block}