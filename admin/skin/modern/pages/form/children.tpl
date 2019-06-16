<p class="text-right">
	{#nbr_pages#|ucfirst}: {$pagesChild|count} <a href="{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}&amp;action=add&parent_id={$smarty.get.edit}" title="{#add_pages#}" class="btn btn-link btn-icon">
		<i class="material-icons">add</i>{#add_pages#|ucfirst}
	</a>
</p>
{if $smarty.get.search}{$sortable = false}{else}{$sortable = true}{/if}
{include file="form/table-form/table.tpl" data=$pagesChild ajax_form=true idcolumn='id_pages' activation=true sortable=$sortable controller="pages" change_offset=false}