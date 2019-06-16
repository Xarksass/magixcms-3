{switch $action}
{case 'add' break}
{capture name="icon_name"}{$action}{/capture}
{case 'delete' break}
{capture name="icon_name"}{$action}{/capture}
{/switch}
<a href="{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}&amp;action={$action}" title="{$title}" class="btn btn-link{if $icon} btn-icon{/if}">
	{if $icon}<i class="material-icons">{$smarty.capture.icon_name}</i><span>{/if}{$title|ucfirst}{if $icon}</span>{/if}
</a>