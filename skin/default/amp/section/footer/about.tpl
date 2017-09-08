<div class="footer-colophon container" itemprop="isPartOf" itemscope itemtype="http://schema.org/WebSite">
    <div itemprop="copyrightHolder" itemscope itemtype="http://schema.org/{$companyData.type}"{if $smarty.get.magixmod == 'contact' && $companyData.openinghours} itemref="schedule"{/if}>
        <meta itemprop="name" content="{$companyData.name}"/>
        <meta itemprop="url" content="{geturl}"/>
        <meta itemprop="brand" content="{$companyData.name}"/>
        {if $companyData.tva}<meta itemprop="vatID" content="{$companyData.tva}">{/if}
        {if $about != null}
            <meta itemprop="sameAs" content="{geturl}/{getlang}/about/"/>
        {/if}
        {if $gmap}
            <meta itemprop="hasMap" content="{geturl}/{getlang}/gmap/"/>
        {/if}
        <div itemprop="logo image" itemscope itemtype="https://schema.org/ImageObject">
            <meta itemprop="url" content="{geturl}/skin/{template}/img/logo/{#logo_img#}">
            <meta itemprop="width" content="269">
            <meta itemprop="height" content="50">
        </div>
        {if $companyData.contact.phone}
            <meta itemprop="telephone" content="{$companyData.contact.phone}"/>
        {/if}
        {if $companyData.socials != null}
            {if $companyData.socials.facebook != null || $companyData.socials.google != null || $companyData.socials.linkedin != null}
                <div id="socials-links">
                    {if $companyData.socials.facebook != null}
                        <meta itemprop="sameAs" content="{$companyData.socials.facebook}"/>
                    {/if}
                    {if $companyData.socials.twitter != null}
                        <meta itemprop="sameAs" content="{$companyData.socials.twitter}"/>
                    {/if}
                    {if $companyData.socials.google != null}
                        <meta itemprop="sameAs" content="{$companyData.socials.google}"/>
                    {/if}
                    {if $companyData.socials.linkedin != null}
                        <meta itemprop="sameAs" content="{$companyData.socials.linkedin}"/>
                    {/if}
                </div>
            {/if}
        {/if}
        {if $companyData.contact.adress.street}
            <div itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
                <meta itemprop="streetAddress" content="{$companyData.contact.adress.street}"/>
                <meta itemprop="postalCode" content="{$companyData.contact.adress.postcode}"/>
                <meta itemprop="addressLocality" content="{$companyData.contact.adress.city}"/>
            </div>
        {/if}
        <div id="contactPoint" itemprop="contactPoint" itemscope itemtype="http://schema.org/ContactPoint">
            {if $companyData.contact.mail}
                <meta itemprop="email" content="{$companyData.contact.mail}"/>
            {/if}
            {if $companyData.contact.phone}
                <meta itemprop="telephone" content="{$companyData.contact.phone}"/>
            {else}
                <meta itemprop="url" content="{geturl}/{getlang}/contact/"/>
            {/if}
            {if $companyData.contact.fax}
                <meta itemprop="faxNumber" content="{$companyData.contact.fax}"/>
            {/if}
            <meta itemprop="contactType" content="customer support"/>
            {$av_langs = ','|explode:$companyData.contact.languages}
            {foreach $av_langs as $lang}
                <meta itemprop="availableLanguage" content="{$lang}"/>
            {/foreach}
        </div>
        {if $companyData.contact.mobile}
            <div id="contactPointMobile" itemprop="contactPoint" itemscope itemtype="http://schema.org/ContactPoint">
                <meta itemprop="telephone" content="{$companyData.contact.mobile}"/>
                <meta itemprop="contactType" content="customer support"/>
                {$av_langs = ','|explode:$companyData.contact.languages}
                {foreach $av_langs as $lang}
                    <meta itemprop="availableLanguage" content="{$lang}"/>
                {/foreach}
            </div>
        {/if}
    </div>
    <div class="row">
        <div class="col-ph-12 col-sm-5 col-md-4">
            <p class="footer-copyright"><span class="copyright-info"><span class="fa fa-copyright"></span> <span itemprop="copyrightYear">2017{if 'Y'|date != '2017'} - {'Y'|date}{/if}</span></span>
                | {$companyData.name}, {#footer_all_rights_reserved#|ucfirst}</p>
        </div>
        {if $companyData.tva}
            <div class="col-ph-12 col-sm-3 col-md-4">
                <p class="company-tva text-center">{#footer_tva#} {$companyData.tva}</p>
            </div>
        {/if}{*
    <div class="footer-creator powered col-xs-12 col-sm-4 col-md-5 col-lg-4 pull-right">
        {#footer_creator_info#|ucfirst}
        <a href="http://www.web-solution-way.com">
            Web Solution Way
        </a>
    </div>*}
        <div class="footer-creator powered col-ph-12 col-sm-4{if !$companyData.tva} push-sm-3 push-md-4{/if}">
            {include file="section/footer/powered.tpl"}
        </div>
    </div>
</div>