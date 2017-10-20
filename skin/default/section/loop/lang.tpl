{if is_array($dataLang) && !empty($dataLang)}
    {if $amp}
        <link rel="canonical" href="{geturl}{$smarty.server.REQUEST_URI|replace:'amp/':''}">
    {else}
        <link rel="amphtml" href="{geturl}{$smarty.server.REQUEST_URI|replace:{$iso|cat:'/'}:{$iso|cat:'/amp/'}}">
    {/if}
    {if is_null($smarty.get.controller)}
        <link rel="alternate" href="{geturl}{if $amp}amp/{/if}" hreflang="x-default" />
    {/if}
    {foreach $dataLang as $k => $lang}
        {if isset($hreflang) && is_array($hreflang)}
            {if isset($hreflang[$lang.id_lang])}
                {$data[$k]['url'] = "{geturl}{$hreflang[$lang.id_lang]}"}
            {/if}
        {else}
        {if isset($smarty.get.controller) && $smarty.get.controller !== 'home'}
            {$data[$k]['url'] = "{geturl}/{$lang.iso_lang}/{if $amp}amp/{/if}{$smarty.get.controller}/"}
        {else}
            {$data[$k]['url'] = "{geturl}/{$lang.iso_lang}/{if $amp}amp/{/if}"}
        {/if}
        {/if}
        {if !empty($data[$k]['url'])}
            <link rel="alternate" href="{$data[$k]['url']}" hreflang="{$lang.iso_lang}" />
        {/if}
    {/foreach}
{/if}