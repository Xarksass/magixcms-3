{if isset($data) && !empty($data) && isset($section) && $section != ''}
    {if !isset($editController)}
        {$editController = $controller}
    {/if}
    {if !isset($editColumn)}
        {$editColumn = $idcolumn}
    {/if}
    {foreach $data as $row}
    <tr id="{if $subcontroller}{$subcontroller}{else}{$controller}{/if}_{$row[$idcolumn]}">
        <td class="text-center td-checkbox">
            {if $checkbox}
            <div class="checkbox material-checkbox">
                <label for="{if $subcontroller}{$subcontroller}{else}{$controller}{/if}{$row[$idcolumn]}">
                    <input type="checkbox" id="{if $subcontroller}{$subcontroller}{else}{$controller}{/if}{$row[$idcolumn]}" name="items[]" value="{$row[$idcolumn]}"{if $row[$idcolumn]|in_array:$readonly} readonly disabled{/if}/>
                    <span class="material-icons">
                        <span class="unchecked">check_box_outline_blank</span>
                        <span class="checked">check_box</span>
                    </span>
                </label>
            </div>
            {/if}
        </td>
        {if $sortable}<td class="text-center fixed-td-sm sort-handle"><i class="material-icons">unfold_more</i></td>{/if}
        {foreach $scheme as $name => $col}
            <td class="{$col.class}">
                {*{$col.enum|var_dump}
                {$row[$name]|var_dump}
                {$col.enum|cat:$row[$name]|var_dump}*}
                {if $col.type == 'enum'}
                    {$text = $col.enum|cat:$row[$name]}
                    {#$text#}
                {elseif $col.type == 'bin'}
                    {if $row[$name]}<span class="text-success"><i class="material-icons">check</i></span>{else}<span class="text-danger"><i class="material-icons">close</i></span>{/if}
                {elseif $col.type == 'content'}
                    {if $row[$name]}{$row[$name]|truncate:100:'...'}{else}&mdash;{/if}
                {elseif $col.type == 'price'}
                    {if $row[$name]}{$row[$name]|string_format:"%.2f"}&nbsp;<span class="fa fa-euro"></span>{elseif $row[$name] == null}&mdash;{else}{#price_0#|ucfirst}{/if}
                {elseif $col.type == 'date'}
                    {if $row[$name]}{$row[$name]|date_format:'%d/%m/%Y'}{else}&mdash;{/if}
                {else}
                    {if $row[$name]}{$row[$name]}{else}&mdash;{/if}
                {/if}
            </td>
        {/foreach}
        {if $edit || $dlt}
        <td class="actions text-center">
            {if {employee_access type="edit" class_name=$cClass} eq 1}
            {if $edit}
            <a href="/{baseadmin}/index.php?controller={$editController}&action=edit&edit={$row[$editColumn]}{if $subcontroller}&tabs={$subcontroller}{/if}" class="over-row"></a>
            <a href="/{baseadmin}/index.php?controller={$editController}&action=edit&edit={$row[$editColumn]}{if $subcontroller}&tabs={$subcontroller}{/if}" class="btn btn-link action_on_record"><i class="material-icons">edit</i></a>
            {/if}
            {/if}
            {if {employee_access type="del" class_name=$cClass} eq 1}
            {if !$row[$idcolumn]|in_array:$readonly && $dlt}
                <a href="#" class="btn btn-link action_on_record modal_action" data-id="{$row[$idcolumn]}" data-controller="{$controller}" {if $subcontroller} data-sub="{$subcontroller}"{/if} data-target="#delete_modal"><i class="material-icons">delete</i></a>
            {/if}
            {/if}
        </td>
        {/if}
    </tr>
    {/foreach}
{else}
    {$colspan = count($scheme) + 2}
    {if $sortable}
        {$colspan = $colspan + 1}
    {/if}
    {include file="form/table-form/loop/no-record.tpl" col=$colspan}
{/if}