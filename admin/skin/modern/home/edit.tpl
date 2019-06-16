{extends file="layout.tpl"}
{block name='head:title'}{#edit_home#}{/block}
{block name='body:id'}home{/block}

{block name='header:title'}
    <a href="{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}" title="{#edit_home#}">{#edit_home#}</a>
{/block}
{block name="header:toolbar"}{/block}

{if {employee_access type="append" class_name=$cClass} eq 1}
    {block name='main:content'}
        <div class="container-fluid">
            {capture name="post_action"}{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}&amp;action=edit{/capture}
            {$conf = [
                'action' => $smarty.capture.post_action,
                'method' => 'post',
                'handlers' => 'add:edit',
                'controller' => 'home',
                'subcontroller' => false,
                'sections' => [
                    'content',
                    'seo'
                ],
                'page' => $page,
                'footer' => [
                    'menu' => false,
                    'publish' => true,
                    'save' => true,
                    'leave' => false,
                    'section' => "",
                    'input' => true,
                    'edit' => $page.id_page
                ]
            ]}
            {include file="form/form.tpl" form_config=$conf}
        </div>
    {/block}
    {block name="footer"}<footer id="footer"></footer>{/block}
    {include file="brick/editor.tpl"}
    {block name="jslist" append},/{$baseadmin}/skin/modern/js/globalform.min.js{/block}
{else}
    {block name='main:content'}
        {include file="section/brick/viewperms.tpl"}
    {/block}
{/if}