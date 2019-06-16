{if !isset($class_form)}{$class_form = "col-12 col-md-6"}{/if}
{if !isset($class_table)}{$class_table = "col-12 col-md-6"}{/if}
{if !isset($dir_controller)}{$dir_controller = $controller}{/if}
<div class="row">
    <form id="add_{$sub}" action="{$url}/{baseadmin}/index.php?controller={$smarty.get.controller}&amp;action=add&tabs={$sub}&edit={$id}" data-sub="{$sub}" method="post" class="validate_form {$class_form}" data-handlers="add:tolist">
        {include file="{$dir_controller}{if !empty($dir_controller)}/{/if}form/{$sub}.tpl"}
    </form>
    <div class="{$class_table}">
        <div class="table-responsive">
            <table class="table table-condensed{if isset($customClass)} {$customClass}{/if}">
                <tbody id="{$sub}List" class="direct-edit-table">
                {if !empty($data)}
                    {foreach $data as $row}
                        {include file="{$dir_controller}{if !empty($dir_controller)}/{/if}loop/{$sub}.tpl" first=$row@first}
                    {/foreach}
                {/if}
                </tbody>
            </table>
        </div>
    </div>
</div>