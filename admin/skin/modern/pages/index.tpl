{extends file="layout.tpl"}
{block name='head:title'}{#pages#|ucfirst}{/block}
{block name='body:id'}pages{/block}
{block name="body:class"} root{/block}

{if {employee_access type="view" class_name=$cClass} eq 1}
    {block name='header:title'}
        <a href="{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}" title="{#display_page_list#}">{#root_pages#|ucfirst}</a>
    {/block}

    {block name="header:toolbar"}
        {if {employee_access type="append" class_name=$cClass} eq 1}
            {include file="brick/count.tpl" total=$nb_pages title={#nbr_pages#}}
            {include file="brick/button.tpl" icon=true action="add" title={#add_pages#}}
        {/if}
    {/block}

    {block name='main:content'}
        <div id="sections" class="container-fluid">
            <section>
            {if $smarty.get.search}{$sortable = false}{else}{$sortable = true}{/if}
            {include file="form/table-form/table.tpl" data=$pages idcolumn='id_pages' activation=true sortable=$sortable controller="pages" change_offset=true}
            </section>
        </div>
    {/block}

    {block name='main:after'}
        {include file="modal/delete.tpl" data_type='pages' title={#modal_delete_title#|ucfirst} info_text=true delete_message={#delete_pages_message#}}
        {include file="modal/error.tpl"}
    {/block}

    {block name="jslist" append},/{$baseadmin}/skin/modern/js/magicform.min.js,/{$baseadmin}/skin/modern/js/globalform.min.js,/{$baseadmin}/skin/modern/js/table-form.min.js{/block}
{else}
    {block name='main:content'}
        {include file="section/brick/viewperms.tpl"}
    {/block}
{/if}
{*{block name="footer"}<footer id="footer"></footer>{/block}*}