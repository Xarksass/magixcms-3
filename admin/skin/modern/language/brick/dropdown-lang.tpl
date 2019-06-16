{if !isset($drop)}{$drop = 'down'}{/if}
{if !isset($label)}{$label = true}{/if}
{if !isset($onclass)}{$onclass = false}{/if}
{*{if count($langs) > 1}*}
<div{if isset($container_class)} class="{$container_class}"{/if}>
    <label{if !$label} class="sr-only"{/if} for="id_lang">{#language#|ucfirst}&nbsp;*</label>
    <div class="drop{$drop} dropdown-lang">
        <button class="btn btn-box btn-default dropdown-toggle{if $custom_class} {$custom_class}{/if}" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
            {foreach $langs as $id => $lg}
                {if $lg@first}{$default = $id}{break}{/if}
            {/foreach}
            <span class="lang">{$langs[$default]['iso']|upper}</span>
            <span class="{if $drop === 'down'}show-more{else}show-less{/if}"><i class="material-icons">arrow_drop_down</i></span>
            <span class="{if $drop === 'down'}show-less{else}show-more{/if}"><i class="material-icons">arrow_drop_up</i></span>
        </button>
        <ul class="dropdown-menu">
            {foreach $langs as $id => $lg}
                <li role="presentation"{if $lg@first} class="active"{/if}>
                    <a data-target="{if $onclass}.{else}#{/if}lang-{$id}" aria-controls="lang-{$id}" role="tab" data-toggle="tab" data-iso="{$lg['iso']|upper}">{$lg['name']}</a>
                </li>
            {/foreach}
        </ul>
    </div>
</div>
{*{/if}*}