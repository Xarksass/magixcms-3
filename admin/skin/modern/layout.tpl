{autoload_i18n}<!DOCTYPE html>
<!--[if lt IE 7]><html lang="fr" class="lt-ie9 lt-ie8 lt-ie7"><![endif]-->
<!--[if IE 7]><html lang="fr" class="lt-ie9 lt-ie8"><![endif]-->
<!--[if IE 8]><html lang="fr" class="lt-ie9"><![endif]-->
<!--[if gt IE 8]><!--><html lang="fr"><!--<![endif]-->
<head id="meta">
    <meta charset="utf-8">
    <title>{block name='head:title'}layout{/block} | {#admin#} | Magix CMS</title>
    <meta name="description" content="">
    <meta name="robots" content="no-index">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="{$url}/{$baseadmin}/skin/{$theme}/img/favicon.png" />
    <!--[if IE]>
    <link rel="shortcut icon" type="image/x-icon" href="{$url}/{baseadmin}/skin/{$theme}/img/favicon.ico" />
    <![endif]-->
    <link rel="manifest" href="{$url}/{$baseadmin}/skin/{$theme}/manifest.json">
    {block name="fontawesome"}
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/brands.css" integrity="sha384-i2PyM6FMpVnxjRPi0KW/xIS7hkeSznkllv+Hx/MtYDaHA5VcF0yL3KVlvzp8bWjQ" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/fontawesome.css" integrity="sha384-sri+NftO+0hcisDKgr287Y/1LVnInHJ1l+XC7+FOabmTTIK0HnE2ID+xxvJ21c5J" crossorigin="anonymous">
    {/block}
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons|Material+Icons+Outlined|Roboto:300,500,700" rel="stylesheet">
    {strip}{capture name="stylesheet"}/{$baseadmin}/skin/{$theme}/css/mobile.css{/capture}
    {if $browser !== 'IE'}<link rel="preload" href="{$smarty.capture.stylesheet}" as="style">{/if}
    <link rel="stylesheet" href="{$smarty.capture.stylesheet}">{/strip}
    {block name="stylesheets"}{/block}
    {capture name="scriptHtml5"}{strip}
        /{$baseadmin}/min/?f=
        libjs/vendor/html5shiv.js,
        libjs/vendor/respond.min.js
    {/strip}{/capture}
    {strip}<!--[if lt IE 9]>{script src=$smarty.capture.scriptHtml5 type="javascript"}<![endif]-->{/strip}
    </head>
<body id="{block name='body:id'}layout{/block}" class="{$viewport}{if $touch} touchscreen{/if}{block name="body:class"}{/block}">
{function cleantextarea}{$field|escape:'html':'UTF-8':TRUE}{/function}
{widget_plugins}
{block name="header"}
<header id="header">
    <button type="button" class="open-menu" data-target="#drawer">
        <span class="sr-only">{#openNavigation#|ucfirst}</span>
        <i class="material-icons">menu</i>
    </button>
    <h1>{block name='header:title'}{/block}</h1>
    <div class="toolbar">
        {block name="header:toolbar"}{/block}
    </div>
</header>
{/block}
{block name='aside'}
<aside id="drawer">
    <header>
        <button type="button" class="close-menu" data-target="#drawer">
            <span class="sr-only">{#closeNavigation#|ucfirst}</span>
            <i class="material-icons">close</i>
        </button>
        <button type="button" class="fold-menu" data-target="#drawer">
            <span class="sr-only">{#foldNavigation#|ucfirst}</span>
            <span class="show-more"><i class="material-icons">add</i></span>
            <span class="show-less"><i class="material-icons">remove</i></span>
        </button>
        <div id="adminLang" class="dropdown">
            <button class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                <span class="tounfold">{$lang|upper}</span>
                <span class="tofold">{$adminlangs[$lang]|ucfirst}
                    <span class="show-more"><i class="material-icons">arrow_drop_down</i></span>
                    <span class="show-less"><i class="material-icons">arrow_drop_up</i></span>
                </span>
            </button>
            <ul class="dropdown-menu">
                {foreach $adminlangs as $iso => $name}
                    <li{if $iso === $lang} class="active"{/if}>
                        <a href="#" class="changeAdminLang" data-iso="{$iso}">{$name|ucfirst}</a>
                    </li>
                {/foreach}
            </ul>
        </div>
        <p class="h3 tofold">{$adminProfile.firstname_admin} {$adminProfile.lastname_admin}</p>
        <div class="dropdown">
            <button class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                <span class="tounfold"><i class="material-icons">account_circle</i></span>
                <span class="tofold">{$adminProfile.email_admin}
                <span class="show-more"><i class="material-icons">arrow_drop_down</i></span>
                <span class="show-less"><i class="material-icons">arrow_drop_up</i></span></span>
            </button>
            <ul class="dropdown-menu">
                <li class="dropdown-header tounfold">{$adminProfile.email_admin}</li>
                <li>
                    <a href="{$url}/admin/index.php?controller=employee&action=edit&edit={$adminProfile.id_admin}">
                        <i class="material-icons">settings</i> {#edit_profile#}
                    </a>
                </li>
                <li>
                    <a href="{$url}/admin/index.php?controller=dashboard&logout=1">
                        <i class="material-icons">power_settings_new</i> {#logout#}
                    </a>
                </li>
            </ul>
        </div>
    </header>
    <div id="menu">
        <nav>
            {include file="section/menu.tpl"}
        </nav>
    </div>
</aside>
{/block}
{block name='main:before'}{/block}
{block name="main"}
<main id="{block name='main:id'}page{/block}">
    {block name='main:content'}{/block}
</main>
{/block}
{block name='main:after'}{/block}
{block name="footer"}
<footer id="footer">
    {include file="section/footer.tpl"}
</footer>
{/block}
{block name="notifier"}<div class="mc-message-container"><div class="mc-message"></div></div>{/block}
<script type="text/javascript">
    const editor_version = "{$smarty.const.VERSION_EDITOR}";
    const baseadmin = "{$baseadmin}";
    const iso = "{$lang}";
    const offset = "{if isset($offset)}{$offset}{else}null{/if}";
    const controller = "{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}";
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
{block name="vendors"}{/block}
<script src="/{$baseadmin}/min/?g=modernjs{block name="jsgrouplist"}{/block}"></script>
{block name="foot"}
    <script src="/{$baseadmin}/min/?f=/{$baseadmin}/skin/modern/js/global.min.js{block name="jslist"}{/block}{block name="jscontroller"},/{$baseadmin}/skin/modern/js/{$smarty.get.controller}.min.js{/block}"></script>
{/block}
</body>
</html>