{extends file="catalog/product/index.tpl"}
{block name='head:title'}{#add_product#}{/block}
{block name="body:class"}{/block}
{block name="header:toolbar"}{/block}

{if {employee_access type="append" class_name=$cClass} eq 1}
    {block name='header:title'}{#add_product#}{/block}
    {block name='main:content'}
        <div class="container-fluid">
            {capture name="post_action"}{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}&amp;action=add{/capture}
            {$conf = [
                'action' => $smarty.capture.post_action,
                'method' => 'post',
                'handlers' => 'add:edit',
                'controller' => 'catalog',
                'subcontroller' => 'product',
                'sections' => [
                    'content',
                    'details',
                    'categories',
                    'seo'
                ],
                'footer' => [
                    'menu' => false,
                    'publish' => true,
                    'save' => true,
                    'leave' => true,
                    'section' => "p",
                    'input' => true,
                    'edit' => $page.id_product
                ]
            ]}
            {include file="form/form.tpl" form_config=$conf}
        </div>
    {/block}
    {include file="brick/editor.tpl"}
    {block name="jslist" append},libjs/vendor/tabcomplete.min.js,libjs/vendor/livefilter.min.js,libjs/vendor/bootstrap-select.min.js,libjs/vendor/filterlist.min.js,/{$baseadmin}/skin/{$theme}/js/dropzone.min.js{/block}
    {block name="footer"}<footer id="footer"></footer>{/block}
{else}
    {include file="section/brick/viewperms.tpl"}
{/if}

{block name='main:after'}{/block}