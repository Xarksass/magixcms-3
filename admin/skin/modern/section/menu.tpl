<ul class="nav">
    <li>
        <a href="{$url}" title="{#gotosite#}" class="targetblank">
            <i class="material-icons">desktop_windows</i><span class="tofold">{#gotosite#}</span>
        </a>
    </li>
    <li>
        <a href="{$url}/{$baseadmin}/index.php?controller=dashboard" title="{#dashboard#}">
            <i class="material-icons">dashboard</i><span class="tofold">{#dashboard#}</span>
        </a>
    </li>
</ul>
<ul class="nav">
    {if {employee_access type="view" class_name="backend_controller_home"} eq 1}
        <li class="{if $smarty.get.controller == 'home'}active{/if}">
            <a href="{$url}/{$baseadmin}/index.php?controller=home" title="{#root_home#}">
                <i class="material-icons">home</i><span class="tofold">{#root_home#}</span>
            </a>
        </li>
    {/if}
    {if {employee_access type="view" class_name="backend_controller_pages"} eq 1}
        <li class="has-submenu{if $smarty.get.controller == 'pages'} active{/if}">
            <button type="button" class="navbar-toggle{if $smarty.get.controller == 'pages'} open{else} collapsed{/if}" data-toggle="collapse" data-target="#nav-pages">
                <span class="show-more"><i class="material-icons">arrow_drop_down</i></span>
                <span class="show-less"><i class="material-icons">arrow_drop_up</i></span>
            </button>
            <a href="{$url}/{$baseadmin}/index.php?controller=pages" title="{#root_pages#}">
                <i class="material-icons">description</i><span class="tofold">{#root_pages#}</span>
            </a>
            <nav id="nav-pages" class="collapse{if $smarty.get.controller == 'pages'} in{/if}">
                <ul class="nav list-unstyled">
                    <li{if $smarty.get.controller == 'pages'} class="active"{/if}>
                        <a href="{$url}/{$baseadmin}/index.php?controller=pages" title="{#list_page#}">{#list_page#}</a>
                    </li>
                    {if {employee_access type="append" class_name="backend_controller_pages"} eq 1}
                        <li{if $smarty.get.controller == 'pages' && $smarty.get.action == 'add'} class="active"{/if}>
                            <a href="{$url}/{$baseadmin}/index.php?controller=pages&action=add" title="{#add_page#}">{#add_page#}</a>
                        </li>
                    {/if}
                </ul>
            </nav>
        </li>
    {/if}
    {if {employee_access type="view" class_name="backend_controller_news"} eq 1}
        <li class="has-submenu{if $smarty.get.controller == 'news'} active{/if}">
            <button type="button" class="navbar-toggle{if $smarty.get.controller == 'news'} open{/if}" data-toggle="collapse" data-target="#nav-news">
                <span class="show-more"><i class="material-icons">arrow_drop_down</i></span>
                <span class="show-less"><i class="material-icons">arrow_drop_up</i></span>
            </button>
            <a href="{$url}/{$baseadmin}/index.php?controller=news" title="{#root_news#}">
                <i class="material-icons">event</i><span class="tofold">{#root_news#}</span>
            </a>
            <nav id="nav-news" class="collapse{if $smarty.get.controller == 'news'} in{/if}">
                <ul class="nav list-unstyled">
                    <li{if $smarty.get.controller == 'news' && $smarty.get.action == 'editroot'} class="active"{/if}>
                        <a href="{$url}/{$baseadmin}/index.php?controller=news&action=editroot" title="{#news_root#}">{#news_root#}</a>
                    </li>
                    <li{if $smarty.get.controller == 'news' && !$smarty.get.action} class="active"{/if}>
                        <a href="{$url}/{$baseadmin}/index.php?controller=news" title="{#list_news#}">{#list_news#}</a>
                    </li>
                    {if {employee_access type="append" class_name="backend_controller_news"} eq 1}
                        <li{if $smarty.get.controller == 'news' && $smarty.get.action == 'add'} class="active"{/if}>
                            <a href="{$url}/{$baseadmin}/index.php?controller=news&action=add" title="{#add_new#}">{#add_new#}</a>
                        </li>
                    {/if}
                </ul>
            </nav>
        </li>
    {/if}
    {if {employee_access type="view" class_name="backend_controller_catalog"} eq 1}
        <li class="has-submenu{if $smarty.get.controller == 'catalog' || $smarty.get.controller == 'category' || $smarty.get.controller == 'product'} active{/if}">
            <button type="button" class="navbar-toggle{if $smarty.get.controller == 'catalog' || $smarty.get.controller == 'category' || $smarty.get.controller == 'product'} open{/if}" data-toggle="collapse" data-target="#nav-catalog">
                <span class="show-more"><i class="material-icons">arrow_drop_down</i></span>
                <span class="show-less"><i class="material-icons">arrow_drop_up</i></span>
            </button>
            <a href="{$url}/{$baseadmin}/index.php?controller=catalog" title="{#catalog#}">
                <i class="material-icons">shopping_cart</i><span class="tofold">{#catalog#}</span>
            </a>
            <nav id="nav-catalog" class="collapse{if $smarty.get.controller == 'catalog' || $smarty.get.controller == 'category' || $smarty.get.controller == 'product'} in{/if}">
                <ul class="nav list-unstyled">
                    <li{if $smarty.get.controller == 'catalog' && !$smarty.get.action} class="active"{/if}>
                        <a href="{$url}/{$baseadmin}/index.php?controller=catalog" title="{#root_catalog#}">{#root_catalog#}</a>
                    </li>
                    {if {employee_access type="view" class_name="backend_controller_category"} eq 1 || {employee_access type="view" class_name="backend_controller_product"} eq 1 }
                        {if {employee_access type="view" class_name="backend_controller_category"} eq 1}
                            <li{if $smarty.get.controller == 'category' && !$smarty.get.action} class="active"{/if}>
                                <a href="{$url}/{$baseadmin}/index.php?controller=category" title="{#list_cats#}">{#list_cats#}</a>
                            </li>
                            {if {employee_access type="append" class_name="backend_controller_category"} eq 1}
                                <li{if $smarty.get.controller == 'category' && $smarty.get.action == 'add'} class="active"{/if}>
                                    <a href="{$url}/{$baseadmin}/index.php?controller=category&action=add" title="{#add_cat#}">{#add_cat#}</a>
                                </li>
                            {/if}
                        {/if}
                        {if {employee_access type="view" class_name="backend_controller_category"} eq 1}
                            <li{if $smarty.get.controller == 'product' && !$smarty.get.action} class="active"{/if}>
                                <a href="{$url}/{$baseadmin}/index.php?controller=product" title="{#list_products#}">{#list_products#}</a>
                            </li>
                            {if {employee_access type="append" class_name="backend_controller_product"} eq 1}
                                <li{if $smarty.get.controller == 'product' && $smarty.get.action == 'add'} class="active"{/if}>
                                    <a href="{$url}/{$baseadmin}/index.php?controller=product&action=add" title="{#add_products#}">{#add_products#}</a>
                                </li>
                            {/if}
                        {/if}
                    {/if}
                </ul>
            </nav>
        </li>
    {/if}
</ul>
<ul class="nav">
    {if {employee_access type="view" class_name="backend_controller_about"} eq 1}
        <li class="has-submenu{if $smarty.get.controller == 'about'} active{/if}">
            <button type="button" class="navbar-toggle{if $smarty.get.controller == 'about'} open{/if}" data-toggle="collapse" data-target="#nav-about">
                <span class="show-more"><i class="material-icons">arrow_drop_down</i></span>
                <span class="show-less"><i class="material-icons">arrow_drop_up</i></span>
            </button>
            <a href="{$url}/{$baseadmin}/index.php?controller=about" title="{#root_about#}">
                <i class="material-icons">work</i><span class="tofold">{#root_about#}</span>
            </a>
            <nav id="nav-about" class="collapse{if $smarty.get.controller == 'about'} in{/if}">
                <ul class="nav list-unstyled">
                    <li>
                        <a href="{$url}/{$baseadmin}/index.php?controller=about&tab=company" title="{#info_company#}">
                            <i class="material-icons-outlined">info</i>{#info_company#}
                        </a>
                    </li>
                    <li>
                        <a href="{$url}/{$baseadmin}/index.php?controller=about&tab=contact" title="{#info_contact#}">
                            <i class="material-icons">phone</i>{#info_contact#}
                        </a>
                    </li>
                    <li>
                        <a href="{$url}/{$baseadmin}/index.php?controller=about&tab=socials" title="{#info_socials#}">
                            <i class="material-icons">share</i>{#info_socials#}
                        </a>
                    </li>
                    <li>
                        <a href="{$url}/{$baseadmin}/index.php?controller=about&tab=opening" title="{#info_opening#}">
                            <i class="material-icons">access_time</i>{#info_opening#}
                        </a>
                    </li>
                    {*<li>
                        <a href="{$url}/{$baseadmin}/index.php?controller=about&tab=text" title="{#text#}">
                            <i class="material-icons">help_outline</i>{#text#}
                        </a>
                    </li>
                    <li>
                        <a href="{$url}/{$baseadmin}/index.php?controller=about&tab=page" title="{#info_page#}">
                            <i class="material-icons">description</i>{#info_page#}
                        </a>
                    </li>*}
                </ul>
            </nav>
        </li>
    {/if}
    {if {employee_access type="view" class_name="backend_controller_theme"} eq 1}
        <li class="has-submenu{if $smarty.get.controller == 'theme' || $smarty.get.controller == 'logo'} active{/if}">
            <button type="button" class="navbar-toggle{if $smarty.get.controller == 'theme'} open{/if}" data-toggle="collapse" data-target="#nav-theme">
                <span class="show-more"><i class="material-icons">arrow_drop_down</i></span>
                <span class="show-less"><i class="material-icons">arrow_drop_up</i></span>
            </button>
            <a href="{$url}/{$baseadmin}/index.php?controller=theme&tab=theme" title="{#appearance#}">
                <i class="material-icons">format_paint</i><span class="tofold">{#appearance#}</span>
            </a>
            <nav id="nav-theme" class="collapse{if $smarty.get.controller == 'theme'} in{/if}">
                <ul class="nav list-unstyled">
                    <li>
                        <a href="{$url}/{$baseadmin}/index.php?controller=theme&tab=theme" title="{#info_theme#}">
                            <i class="material-icons">color_lens</i>{#info_theme#}
                        </a>
                    </li>
                    <li>
                        <a href="{$url}/{$baseadmin}/index.php?controller=theme&tab=menu" title="{#info_menu#}">
                            <i class="material-icons">menu</i>{#info_menu#}
                        </a>
                    </li>
                    <li>
                        <a href="{$url}/{$baseadmin}/index.php?controller=theme&tab=share" title="{#info_share#}">
                            <i class="material-icons">share</i>{#info_share#}
                        </a>
                    </li>
                    {if {employee_access type="view" class_name="backend_controller_logo"} eq 1}
                        <li{if $smarty.get.controller == 'logo'} class="active"{/if}>
                            <a href="{$url}/{$baseadmin}/index.php?controller=logo" title="{#logo#}">
                                <i class="material-icons">wb_iridescent</i>{#root_logo#}
                            </a>
                        </li>
                    {/if}
                </ul>
            </nav>
        </li>
    {/if}
    <li class="has-submenu{if $smarty.get.controller == 'language' || $smarty.get.controller == 'country' || $smarty.get.controller == 'translate'} active{/if}">
        <button type="button" class="navbar-toggle{if $smarty.get.controller == 'language' || $smarty.get.controller == 'country' || $smarty.get.controller == 'translate'} open{/if}" data-toggle="collapse" data-target="#nav-lang">
            <span class="show-more"><i class="material-icons">arrow_drop_down</i></span>
            <span class="show-less"><i class="material-icons">arrow_drop_up</i></span>
        </button>
        {*<a href="#">*}
        <span title="{#localisation#}"><i class="material-icons">near_me</i><span class="tofold">{#localisation#}</span></span>
        {*</a>*}
        <nav id="nav-lang" class="collapse{if $smarty.get.controller == 'language' || $smarty.get.controller == 'country' || $smarty.get.controller == 'translate'} in{/if}">
            <ul class="nav list-unstyled">
                {if {employee_access type="view" class_name="backend_controller_language"} eq 1}
                    <li{if $smarty.get.controller == 'language'} class="active"{/if}>
                        <a href="{$url}/{$baseadmin}/index.php?controller=language" title="{#language#}">
                            <i class="material-icons">flag</i>{#language#}
                        </a>
                    </li>
                {/if}
                {if {employee_access type="view" class_name="backend_controller_country"} eq 1}
                    <li{if $smarty.get.controller == 'country'} class="active"{/if}>
                        <a href="{$url}/{$baseadmin}/index.php?controller=country" title="{#country#}">
                            <i class="material-icons">public</i>{#country#}
                        </a>
                    </li>
                {/if}
                {if {employee_access type="view" class_name="backend_controller_translate"} eq 1}
                    <li{if $smarty.get.controller == 'country'} class="active"{/if}>
                        <a href="{$url}/{$baseadmin}/index.php?controller=translate" title="{#translate#}">
                            <i class="material-icons">g_translate</i>{#translate#}
                        </a>
                    </li>
                {/if}
            </ul>
        </nav>
    </li>
    {if {employee_access type="view" class_name="backend_controller_employee"} eq 1}
        <li class="has-submenu{if $smarty.get.controller == 'employee' || $smarty.get.controller == 'access'} active{/if}">
            <button type="button" class="navbar-toggle{if $smarty.get.controller == 'employee'} open{/if}" data-toggle="collapse" data-target="#nav-employee">
                <span class="show-more"><i class="material-icons">arrow_drop_down</i></span>
                <span class="show-less"><i class="material-icons">arrow_drop_up</i></span>
            </button>
            <a href="{$url}/{$baseadmin}/index.php?controller=employee" title="{#administration#}">
                <i class="material-icons">people</i><span class="tofold">{#administration#}</span>
            </a>
            <nav id="nav-employee" class="collapse{if $smarty.get.controller == 'employee'} in{/if}">
                <ul class="nav list-unstyled">
                    <li{if $smarty.get.controller == 'employee'} class="active"{/if}>
                        <a href="{$url}/{$baseadmin}/index.php?controller=employee" title="{#list_employees#}">{#list_employees#}</a>
                    </li>
                    {if {employee_access type="append" class_name="backend_controller_employee"} eq 1}
                        <li{if $smarty.get.controller == 'employee' && $smarty.get.action == 'add'} class="active"{/if}>
                            <a href="{$url}/{$baseadmin}/index.php?controller=employee&action=add" title="{#add_employees#}">{#add_employees#}</a>
                        </li>
                    {/if}
                    {if {employee_access type="view" class_name="backend_controller_access"} eq 1}
                        <li{if $smarty.get.controller == 'access'} class="active"{/if}>
                            <a href="{$url}/{$baseadmin}/index.php?controller=access" title="{#perms#}">{#perms#}</a>
                        </li>
                    {/if}
                </ul>
            </nav>
        </li>
    {/if}
    <li class="has-submenu{if $smarty.get.controller == 'setting' || $smarty.get.controller == 'files' || $smarty.get.controller == 'webservice' || $smarty.get.controller == 'domain' || $smarty.get.controller == 'seo'} active{/if}">
        <button type="button" class="navbar-toggle{if $smarty.get.controller == 'setting' || $smarty.get.controller == 'files' || $smarty.get.controller == 'webservice' || $smarty.get.controller == 'domain' || $smarty.get.controller == 'seo'} open{/if}" data-toggle="collapse" data-target="#nav-setting">
            <span class="show-more"><i class="material-icons">arrow_drop_down</i></span>
            <span class="show-less"><i class="material-icons">arrow_drop_up</i></span>
        </button>
        {*<a href="#">*}
        <span title="{#config#}"><i class="material-icons">build</i><span class="tofold">{#config#}</span></span>
        {*</a>*}
        <nav id="nav-setting" class="collapse{if $smarty.get.controller == 'setting' || $smarty.get.controller == 'files' || $smarty.get.controller == 'webservice' || $smarty.get.controller == 'domain' || $smarty.get.controller == 'seo'} in{/if}">
            <ul class="nav list-unstyled">
                {if {employee_access type="view" class_name="backend_controller_setting"} eq 1}
                    <li{if $smarty.get.controller == 'setting'} class="active"{/if}>
                        <a href="{$url}/{$baseadmin}/index.php?controller=setting" title="{#setting#}">
                            <i class="material-icons">settings</i>{#setting#}
                        </a>
                    </li>
                {/if}
                {if {employee_access type="view" class_name="backend_controller_files"} eq 1}
                    <li{if $smarty.get.controller == 'files'} class="active"{/if}>
                        <a href="{$url}/{$baseadmin}/index.php?controller=files" title="{#files_and_images#}">
                            <i class="material-icons">insert_drive_file</i>{#files_and_images#}
                        </a>
                    </li>
                {/if}
                {if {employee_access type="view" class_name="backend_controller_webservice"} eq 1}
                    <li{if $smarty.get.controller == 'webservice'} class="active"{/if}>
                        <a href="{$url}/{$baseadmin}/index.php?controller=webservice" title="{#webservice#}">
                            <i class="material-icons">cloud</i>{#webservice#}
                        </a>
                    </li>
                {/if}
                {if {employee_access type="view" class_name="backend_controller_domain"} eq 1}
                    <li{if $smarty.get.controller == 'domain'} class="active"{/if}>
                        <a href="{$url}/{$baseadmin}/index.php?controller=domain" title="{#domain_sitemap#}">
                            <i class="material-icons">http</i>{#domain_sitemap#}
                        </a>
                    </li>
                {/if}
                {if {employee_access type="view" class_name="backend_controller_seo"} eq 1}
                    <li{if $smarty.get.controller == 'seo'} class="active"{/if}>
                        <a href="{$url}/{$baseadmin}/index.php?controller=seo" title="{#seo_management#}">
                            <i class="material-icons">search</i>{#seo_management#}
                        </a>
                    </li>
                {/if}
            </ul>
        </nav>
    </li>
</ul>
<ul class="nav">
    {if {employee_access type="view" class_name="backend_controller_plugins"} eq 1}
    <li class="has-submenu {if $smarty.get.controller == 'plugins' || (!in_array($smarty.get.controller,array('dashboard','home','pages','news','catalog','category','product','about','theme','setting','files','webservice','domain','seo','language','country','translate','employee','access','logo')) && $smarty.get.controller)}active{/if}">
        {if is_array($getItemsPlugins) && !empty($getItemsPlugins)}<button type="button" class="navbar-toggle{if $smarty.get.controller == 'plugins' || (!in_array($smarty.get.controller,array('dashboard','home','pages','news','catalog','category','product','about','theme','setting','files','webservice','domain','seo','language','country','translate','employee','access','logo')))} open{/if}" data-toggle="collapse" data-target="#nav-plugins">
            <span class="show-more"><i class="material-icons">arrow_drop_down</i></span>
            <span class="show-less"><i class="material-icons">arrow_drop_up</i></span>
        </button>{/if}
        <a href="{$url}/{$baseadmin}/index.php?controller=plugins" title="{#extensions#}">
            <i class="material-icons">extension</i><span class="tofold">{#extensions#}</span>
        </a>
        {if is_array($getItemsPlugins) && !empty($getItemsPlugins)}
            <nav id="nav-plugins" class="collapse{if (!in_array($smarty.get.controller,array('dashboard','home','pages','news','catalog','category','product','about','theme','setting','files','webservice','domain','seo','language','country','translate','employee','access','logo')))} in{/if}">
                <ul class="nav list-unstyled">
                    {foreach $getItemsPlugins as $item}
                        {if {employee_access type="view" class_name="plugins_{$item.name}_admin"} eq 1}
                            <li class="{if $smarty.get.controller == {$item.name}}active{/if}">
                                <a href="{$url}/{$baseadmin}/index.php?controller={$item.name}" title="{$item.title}">
                                    <i class="material-icons">{if $smarty.get.controller == {$item.name}}arrow_right{else}arrow_drop_down{/if}"></i>{$item.title}
                                </a>
                            </li>
                        {/if}
                    {/foreach}
                </ul>
            </nav>
        {/if}
    </li>
    {/if}
</ul>