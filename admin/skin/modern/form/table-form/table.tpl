{if !isset($activation)}
    {$activation = false}
{/if}
{if !isset($search)}
    {$search = true}
{/if}
{if !isset($readonly)}
    {$readonly = []}
{/if}
{if !isset($sortable)}
    {$sortable = false}
{/if}
{if !isset($edit)}
    {$edit = true}
{/if}
{if !isset($dlt)}
    {$dlt = true}
{/if}
{if !isset($checkbox)}
    {$checkbox = true}
{/if}
{if isset($data) && is_array($data)}
    {if $debug}{foreach $scheme as $sch}
        {$sch.input|var_dump}
    {/foreach}{/if}
    {if $debug}{$data|var_dump}{/if}
    {if $change_offset && !isset($smarty.get.search)}
        {$request = $smarty.server.REQUEST_URI}
        {$offset = strpos($request,'&offset=')}
        {if $offset}
            {$request = substr($request,0,$offset)}
        {/if}
        <div class="filter_offset">
            <ul class="list-inline">
                <li>{#display_step#}&nbsp;:</li>
                <li><a href="{$url}{$request}&offset=25" class="btn btn-link{if !isset($smarty.get.offset) || $smarty.get.offset == 25} active{/if}">25</a></li>
                <li><a href="{$url}{$request}&offset=50" class="btn btn-link{if $smarty.get.offset == 50} active{/if}">50</a></li>
                <li><a href="{$url}{$request}&offset=100" class="btn btn-link{if $smarty.get.offset == 100} active{/if}">100</a></li>
            </ul>
        </div>
    {/if}
    <div class="table-responsive{if (empty($data) || !count($data)) && !$smarty.get.search} hide{/if}" id="table-{if $subcontroller}{$subcontroller}{else}{$controller}{/if}">
        <form action="/{baseadmin}/index.php" method="get"{if $ajax_form} class="validate_form" data-handlers="search"{/if}>
            <input type="hidden" name="controller" value="{$smarty.get.controller}" />
            <input type="hidden" name="tableaction" value="true" />
            <input type="hidden" name="edit" value="{$smarty.get.edit}" />
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th class="fixed-td-sm"><span class="sr-only">{#select#}</span></th>
                    {if $sortable}<th><span class="sr-only">{#sort#}</span></th>{/if}
                    {foreach $scheme as $name => $col}
                        <th{if $col.class && !empty($col.class)} class="{$col.class}"{/if}>{if $debug}{$col['title']} | {/if}{#$col['title']#|ucfirst}</th>
                    {/foreach}
                    {if $edit OR $dlt}
                    <th class="fixed-td-lg text-center">{#actions#|ucfirst}</th>
                    {/if}
                </tr>
                {if $search}
                <tr class="search-bar">
                    <th class="text-center td-checkbox">
                        <div class="checkbox material-checkbox">
                            <label for="check-all">
                                <input type="checkbox" id="check-all" name="check-all" class="check-all" data-table="{if $subcontroller}{$subcontroller}{else}{$controller}{/if}"/>
                                <span class="material-icons">
                                    <span class="unchecked">check_box_outline_blank</span>
                                    <span class="checked">check_box</span>
                                </span>
                            </label>
                        </div>
                    </th>
                    {if $sortable}<th>&nbsp;</th>{/if}
                    {foreach $scheme as $name => $col}
                    <th>
                        <div class="form-group">
                            <label for="search[{$name}]" class="sr-only"></label>
                            {if $col.input.type == 'select'}
                            <select name="search[{$name}]" id="search[{$name}]" class="form-control" >
                                <option value=""{if !isset($smarty.get.search[$name]) || empty($smarty.get.search[$name])} selected{/if}>--</option>
                                {foreach $col.input.values as $val}
                                <option value="{$val.v}"{if isset($smarty.get.search[$name]) && $smarty.get.search[$name] === $val.v} selected{/if}>{if $col.input.var || !isset($val.name) || empty($val.name)}{$value = $col.enum|cat:$val.v}{#$value#}{else}{$val.name}{/if}</option>
                                {/foreach}
                            </select>
                            {elseif $col.input.type == 'text'}
                            <input type="text"
                                   id="search[{$name}]"
                                   name="search[{$name}]"
                                   class="form-control{if $col.input.class !== ''} {$col.input.class}{/if}"
                                   {if isset($smarty.get.search[$name])} value="{$smarty.get.search[$name]}"{/if}
                                    {if isset($col.input.placeholder)} placeholder="{$col.input.placeholder}"{/if}/>
                            {/if}
                        </div>
                    </th>
                    {/foreach}
                    <th>
                        <div class="form-group">
                            <button type="submit" id="search" name="action" value="search" class="btn btn-default btn-icon">
                                <i class="material-icons">search</i>{#search#|ucfirst}
                            </button>
                        </div>
                    </th>
                </tr>
                {/if}
                </thead>
                <tbody{if $sortable} class="ui-sortable"{/if}>
                {include file="form/table-form/loop/rows.tpl" data=$data section='pages' idcolumn=$idcolumn controller=$controller subcontroller=$subcontroller readonly=$readonly}
                </tbody>
            </table>
            <div class="hidden-ph hidden-xs">
                <p>
                    {if $checkbox}
                    <i class="material-icons">keyboard_return</i>
                    <button class="btn btn-link btn-icon update-checkbox" id="check-all" value="check-all" data-table="{$controller}">
                        <i class="material-icons-outlined">check_box</i><span class="hidden-sm hidden-md"> {#check_all#|ucfirst}</span>
                    </button>
                    <button class="btn btn-link btn-icon update-checkbox" id="uncheck-all" value="uncheck-all" data-table="{$controller}">
                        <i class="material-icons">check_box_outline_blank</i><span class="hidden-sm hidden-md"> {#uncheck_all#|ucfirst}</span>
                    </button>
                    {/if}
                    {if $activation}
                        &mdash;
                    <button class="btn btn-link btn-icon" type="submit" name="action" value="active-selected">
                        <span class="text-success"><i class="material-icons">power_settings_new</i></span><span class="hidden-sm hidden-md"> {#active_selected#|ucfirst}</span>
                    </button>
                    <button class="btn btn-link btn-icon" type="submit" name="action" value="unactive-selected">
                        <span class="text-danger"><i class="material-icons">power_settings_new</i></span><span class="hidden-sm hidden-md"> {#unactive_selected#|ucfirst}</span>
                    </button>
                    {/if}
                    {if {employee_access type="del" class_name=$cClass} eq 1}
                    {if $dlt}
                        &mdash;
                    <button class="btn btn-link btn-icon modal_action" data-target="#delete_modal" data-controller="{$controller}"{if $subcontroller} data-sub="{$subcontroller}"{/if}>
                        <i class="material-icons">delete</i><span class="hidden-sm hidden-md"> {#delete_selected#|ucfirst}</span>
                    </button>
                    {/if}
                    {/if}
                </p>
            </div>
            <div class="dropup visible-ph visible-xs">
                <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    {#recursive_actions#|ucfirst}
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenu2">
                    {if $checkbox}
                    <li>
                        <button class="btn btn-link update-checkbox" type="submit" value="check-all" data-table="{$controller}">
                            <i class="material-icons-outlined">check_box</i><span> {#check_all#|ucfirst}</span>
                        </button>
                    </li>
                    <li>
                        <button class="btn btn-link update-checkbox" type="submit" value="uncheck-all" data-table="{$controller}">
                            <i class="material-icons">check_box_outline_blank</i><span> {#uncheck_all#|ucfirst}</span>
                        </button>
                    </li>
                    <li role="separator" class="divider"></li>
                    {/if}
                    {if $activation}
                    <li>
                        <button class="btn btn-link" type="submit" name="action" value="active-selected">
                            <span class="text-success"><i class="material-icons">power_settings_new</i></span><span> {#active_selected#|ucfirst}</span>
                        </button>
                    </li>
                    <li>
                        <button class="btn btn-link" type="submit" name="action" value="unactive-selected">
                            <span class="text-danger"><i class="material-icons">power_settings_new</i></span><span> {#unactive_selected#|ucfirst}</span>
                        </button>
                    </li>
                    <li role="separator" class="divider"></li>
                    {/if}
                    {if {employee_access type="del" class_name=$cClass} eq 1}
                    {if $dlt}
                    <li>
                        <button class="btn btn-link modal_action" data-target="#delete_modal" data-controller="{$controller}"{if $subcontroller} data-sub="{$subcontroller}"{/if}>
                            <i class="material-icons">delete</i><span> {#delete_selected#|ucfirst}</span>
                        </button>
                    </li>
                    {/if}
                    {/if}
                </ul>
            </div>
        </form>
    </div>
{/if}
<p class="no-entry alert alert-warning{if ((!empty($data) || count($data)) && !$smarty.get.search) || $smarty.get.search} hide{/if}">
    <i class="material-icons">info</i>{#no_entry#|ucfirst}
</p>