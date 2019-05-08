<div id="breadcrumb-container">
    {strip}{$length = $bread|count}{/strip}
    <nav id="breadcrumb" class="breadcrumb container" itemprop="breadcrumb" itemscope itemtype="http://schema.org/BreadcrumbList">
        <ol>
        {foreach from=$bread item=breadcrumb key=i}
            {if $length > 3 && $i == 1 && $mobile}
            <li id="hellipsis">
                <div class="dropdown">
                    <amp-accordion disable-session-states>
                        <section>
                            <header>
                                <button class="btn btn-box btn-default" type="button">
                                    <span class="sr-only">{#toggle_nav#|ucfirst}</span>
                                    <span class="fa fa-ellipsis-h"></span>
                                </button>
                            </header>
                            <div id="breadcrumb-collapse">
                                <ol>
            {/if}
            <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                {strip}{if isset($breadcrumb.url)}
                <a href="{$breadcrumb.url}" title="{$breadcrumb.title|ucfirst}">
                    <span itemprop="name">{$breadcrumb.name|ucfirst}</span>
                    <meta itemprop="position" content="{($breadcrumb@index + 1)}" />
                    <meta itemprop="item" content="{$breadcrumb.url}" />
                </a>
                {else}
                <span>
                    <meta itemprop="item" content="{$url}{$smarty.server.REQUEST_URI}" />
                    <span itemprop="name">{$breadcrumb.name|ucfirst}</span>
                    <meta itemprop="position" content="{($breadcrumb@index + 1)}" />
                </span>
                {/if}{/strip}
            </li>
            {if $length > 3 && $i == $length-2 && $mobile}
                </ol>
                </div>
                </section>
                </amp-accordion>
                </div>
            </li>
            {/if}
        {/foreach}
        </ol>
    </nav>
</div>