{extends file="layout.tpl"}
{block name='head:title'}{#login_pwd#|ucfirst}{/block}
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
                    <div class="pwd-box front panel">
                        <form id="forgot_password_form" method="post" action="#">
                            {if isset($error_tikcet) && $error_tikcet}
                            <div class="mc-message alert alert-warning">
                                <h4>{#no_request_tle#}</h4>
                                <p>{#no_request_txt#}</p>
                            </div>
                            {else}
                            <div class="mc-message alert alert-success">
                                <h4>{#newpwd_tle#}</h4>
                                <p>{#newpwd_txt1#}</p>
                                <p>{#newpwd_txt2#}</p>
                            </div>
                            {/if}
                            <div class="form-group">
                                <a class="btn btn-box btn-link" href="{$url}/admin/" type="button">
                                    <i class="material-icons" aria-hidden="true">chevron_left</i>
                                    <span>{#back_to_login#}</span>
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <p><i class="material-icons">copyright</i> 2008{if 'Y'|date !== '2008'} - {'Y'|date}{/if} <a href="http://www.magix-cms.com/" class="targetblank">Magix CMS</a> &mdash; {#all_right_reserved#}</p>
        </div>
    </main>
{/block}
{block name="footer"}{/block}
{block name="foot" append}
    {script src="/{baseadmin}/min/?f={baseadmin}/template/js/src/login.js" type="javascript"}
{/block}