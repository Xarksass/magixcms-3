<p class="text-right">
	{#nbr_cat#|ucfirst}: {$pagesChild|count} <a href="{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}&amp;action=add&parent_id={$smarty.get.edit}" title="{#add_child_cat#}" class="btn btn-link btn-icon">
		<i class="material-icons">add</i>{#add_child_cat#|ucfirst}
	</a>
</p>
{if $smarty.get.search}{$sortable = false}{else}{$sortable = true}{/if}
{include file="form/table-form/table.tpl" data=$pagesChild ajax_form=true idcolumn='id_cat' activation=true sortable=$sortable controller="category" change_offset=false}