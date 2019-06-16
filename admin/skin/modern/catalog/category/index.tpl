{extends file="layout.tpl"}
{block name='head:title'}{#catalog_category#|ucfirst}{/block}
{block name='body:id'}catalog-category{/block}
{block name="body:class"} root{/block}

{if {employee_access type="view" class_name=$cClass} eq 1}
    {block name='header:title'}
        <a href="{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}" title="{#display_category_list#}">{#catalog_category#|ucfirst}</a>
    {/block}

    {block name="header:toolbar"}
        {if {employee_access type="append" class_name=$cClass} eq 1}
            {include file="brick/count.tpl" total=$nb_pages title={#nbr_cat#}}
            {include file="brick/button.tpl" icon=true action="add" title={#add_cat#}}
        {/if}
    {/block}

    {block name='main:content'}
        <div id="sections" class="container-fluid">
            <section>
                {if $smarty.get.search}{$sortable = false}{else}{$sortable = true}{/if}
                {include file="form/table-form/table.tpl" data=$pages idcolumn='id_cat' activation=true sortable=$sortable controller="category" change_offset=true}
            </section>
        </div>
    {/block}

    {block name='main:after'}
        {include file="modal/delete.tpl" data_type='category' title={#modal_delete_title#|ucfirst} info_text=true delete_message={#delete_category_message#}}
        {include file="modal/error.tpl"}
    {/block}

    {block name="jslist" append},/{$baseadmin}/skin/modern/js/magicform.min.js,/{$baseadmin}/skin/modern/js/globalform.min.js,/{$baseadmin}/skin/modern/js/table-form.min.js{/block}
{else}
    {block name='main:content'}
        {include file="section/brick/viewperms.tpl"}
    {/block}
{/if}