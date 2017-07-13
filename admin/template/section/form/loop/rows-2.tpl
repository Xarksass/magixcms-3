{if isset($data) && !empty($data) && isset($section) && $section != ''}
    <tr id="{if $subcontroller}{$subcontroller}{else}{$controller}{/if}_{$data[$idcolumn]}">
        <td class="text-center">
            <div class="checkbox">
                <label for="{if $subcontroller}{$subcontroller}{else}{$controller}{/if}{$data[$idcolumn]}">
                    <input type="checkbox" id="{if $subcontroller}{$subcontroller}{else}{$controller}{/if}{$data[$idcolumn]}" name="{if $subcontroller}{$subcontroller}{else}{$controller}{/if}[]" value="{$data[$idcolumn]}"{if $data[$idcolumn]|in_array:$readonly} readonly disabled{/if}/>
                </label>
            </div>
        </td>
        {foreach $scheme as $name => $col}
            <td class="{$col.class}">
                {if $col.type == 'enum'}
                    {$text = $col.enum|cat:$data[$name]}
                    {#$text#}
                {elseif $col.type == 'bin'}
                    {if $data[$name]}<span class="fa fa-check text-success"></span>{else}<span class="fa fa-times text-danger"></span>{/if}
                {elseif $col.type == 'content'}
                    {if $data[$name]}{$data[$name]|truncate:100:'...'}{else}&mdash;{/if}
                {elseif $col.type == 'price'}
                    {if $data[$name]}{$data[$name]}&nbsp;<span class="fa fa-euro"></span>{elseif $data[$name] == null}&mdash;{else}{#price_0#|ucfirst}{/if}
                {elseif $col.type == 'date'}
                    {if $data[$name]}{$data[$name]|date_format:'%d/%m/%Y'}{else}&mdash;{/if}
                {else}
                    {if $data[$name]}{$data[$name]}{else}&mdash;{/if}
                {/if}
            </td>
        {/foreach}
        <td class="actions text-center">
            {if {employee_access type="edit" class_name=$cClass} eq 1}
            <a href="/{baseadmin}/index.php?controller={$controller}&action=edit&edit={$data[$idcolumn]}{if $subcontroller}&tabs={$subcontroller}{/if}" class="btn btn-link action_on_record"><span class="fa fa-pencil-square-o"></span></a>
            {/if}
            {if {employee_access type="del" class_name=$cClass} eq 1}
            {if !$data[$idcolumn]|in_array:$readonly}
                <a href="#" class="btn btn-link action_on_record modal_action" data-id="{$data[$idcolumn]}" data-controller="{$controller}" {if $subcontroller} data-sub="{$subcontroller}"{/if} data-target="#delete_modal"><span class="fa fa-trash"></span></a>
            {/if}
            {/if}
        </td>
    </tr>
{/if}