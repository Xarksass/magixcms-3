{extends file="layout.tpl"}
{block name='head:title'}{#catalog#}{/block}
{block name='body:id'}catalog{/block}
{block name="body:class"}{/block}

{block name='header:title'}
    <a href="{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}&action=editroot" title="{#catalog#}">{#catalog#}</a>
{/block}
{block name="header:toolbar"}{/block}

{if {employee_access type="append" class_name=$cClass} eq 1}
    {block name='main:content'}
        <div class="container-fluid">
            {capture name="post_action"}{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}&amp;action=edit{/capture}
            {$conf = [
                'action' => $smarty.capture.post_action,
                'method' => 'post',
                'handlers' => 'edit',
                'controller' => 'catalog',
                'subcontroller' => 'root',
                'sections' => [
                    'content' => 'content',
                    'seo' => 'seo'
                ],
                'page' => $page,
                'footer' => [
                    'menu' => false,
                    'publish' => false,
                    'save' => true,
                    'leave' => false,
                    'section' => "",
                    'input' => false,
                    'edit' => false
                ]
            ]}
            {include file="form/form.tpl" form_config=$conf}
        </div>
    {/block}
    {block name="footer"}<footer id="footer"></footer>{/block}
    {include file="brick/editor.tpl"}

    {block name="jslist" append},/{$baseadmin}/skin/modern/js/magicform.min.js,/{$baseadmin}/skin/modern/js/globalform.min.js,/{$baseadmin}/skin/modern/js/table-form.min.js{/block}
{else}
    {block name='main:content'}
        {include file="section/brick/viewperms.tpl"}
    {/block}
{/if}