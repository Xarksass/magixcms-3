{extends file="news/index.tpl"}
{block name='head:title'}{#edit_news#}{/block}
{block name="body:class"}{/block}
{block name="header:toolbar"}{/block}
{block name="stylesheets"}
    {if $browser !== 'IE'}<link rel="preload" href="/{$baseadmin}/min/?g=inputcss" as="style">{/if}
    <link rel="stylesheet" href="/{$baseadmin}/min/?g=inputcss">
{/block}

{if {employee_access type="append" class_name=$cClass} eq 1}
    {block name='header:title'}{#edit_news#}{/block}
    {block name='main:content'}
        <div class="container-fluid">
            {capture name="post_action"}{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}&amp;action=edit{/capture}
            {$conf = [
                'action' => $smarty.capture.post_action,
                'method' => 'post',
                'handlers' => 'edit:img',
                'controller' => 'news',
                'subcntroller' => false,
                'sections' => [
                    'content',
                    'img',
                    'seo',
                    'plugins'
                ],
                'page' => $page,
                'footer' => [
                    'menu' => false,
                    'publish' => true,
                    'save' => true,
                    'leave' => false,
                    'section' => "news",
                    'input' => true,
                    'edit' => $page.id_news
                ]
            ]}
            {include file="form/form.tpl" form_config=$conf}
        </div>
    {/block}
    {block name="footer"}<footer id="footer"></footer>{/block}
    {include file="brick/editor.tpl"}
    {block name="jsgrouplist" append},inputjs{/block}
    {block name="jslist" append},libjs/vendor/datetimepicker/{$lang}.js,libjs/vendor/bootstrap-datetimepicker.min.js,/{$baseadmin}/skin/{$theme}/js/dropzone.min.js{/block}
    {block name="footer"}<footer id="footer"></footer>{/block}
{else}
    {include file="section/brick/viewperms.tpl"}
{/if}

{block name='main:after'}{/block}