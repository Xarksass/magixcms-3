{extends file="catalog/category/add.tpl"}
{block name='head:title'}{#edit_cat#}{/block}

{if {employee_access type="append" class_name=$cClass} eq 1}
    {block name='header:title'}{#edit_cat#}{/block}
    {block name='main:content'}
        <div class="container-fluid">
            {capture name="post_action"}{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}&amp;action=edit{/capture}
            {$conf = [
                'action' => $smarty.capture.post_action,
                'method' => 'post',
                'handlers' => 'edit:img',
                'controller' => 'catalog',
                'subcontroller' => 'category',
                'sections' => [
                    'content',
                    'img',
                    'seo',
                    'children_cat' => ['id' => 'children', 'form' => false],
                    'plugins'
                ],
                'page' => $page,
                'footer' => [
                    'menu' => true,
                    'publish' => true,
                    'save' => true,
                    'leave' => false,
                    'section' => "cat",
                    'input' => true,
                    'edit' => $page.id_cat
                ]
            ]}
            {include file="form/form.tpl" form_config=$conf}
        </div>
    {/block}
{else}
    {include file="section/brick/viewperms.tpl"}
{/if}