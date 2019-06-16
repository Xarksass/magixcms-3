{extends file="layout.tpl"}
{block name='head:title'}{#dashboard#}{/block}
{block name='body:id'}dashboard{/block}
{block name="body:class"} root{/block}
{block name='header:title'}{#dashboard#}{/block}
{block name="main:content"}
    <div id="sections" class="container-fluid">
        <div class="row">
            {if {employee_access type="view" class_name="backend_controller_news"} eq 1}
                {include file="dashboard/brick/folder.tpl" data=$lastNews icon='event' controller='news' title={#last_news#}}
            {/if}
            {if {employee_access type="view" class_name="backend_controller_pages"} eq 1}
                {include file="dashboard/brick/folder.tpl" data=$lastPages icon='description' controller='pages' title={#last_pages#}}
            {/if}
            {if {employee_access type="view" class_name="backend_controller_category"} eq 1}
                {include file="dashboard/brick/folder.tpl" data=$lastCats icon='folder' controller='category' title={#last_categories#}}
            {/if}
            {if {employee_access type="view" class_name="backend_controller_product"} eq 1}
                {include file="dashboard/brick/folder.tpl" data=$lastProducts icon='local_offer' controller='product' title={#last_products#}}
            {/if}
            {*{if {employee_access type="view" class_name="backend_controller_product"} eq 1}*}
            <div class="col-12">
                <section class="analytics">
                    <header>
                        <h2 class="h3 title_section">
                            <i class="material-icons">show_chart</i><a href="{$url}/{baseadmin}/index.php?controller=analytics">{#analytics#}</a>
                        </h2>
                    </header>
                    <div>
                        <div id="auth-button"></div>
                        <div id="DateRangeSelector_container" class="hide">
                            <div class="DateRangeSelector">
                                <label for="Period">{#period#}</label>
                                <div id="daterange">
                                    <div id="reportrange">
                                        <i class="material-icons">date_range</i>&nbsp;
                                        <span></span> <i class="material-icons">arrow_drop_down</i>
                                    </div>
                                </div>
                                <input id="start-date" type="hidden" name="start-date" />
                                <input id="end-date" type="hidden" name="end-date" />
                            </div>
                        </div>
                        <div id="timeline"></div>
                    </div>
                </section>
            </div>
            {*{/if}*}
        </div>
    </div>
{/block}
{block name="main:after"}
    <div id="quick-add-menu" class="hidden-xl">
        <a class="menu-trigger" href="#">
            <span class="show-more"><i class="material-icons">add</i></span>
            <span class="show-less"><i class="material-icons">close</i></span>
        </a>
        <ul>
            <li>
                <a href="{$url}/{baseadmin}/index.php?controller=news&action=add">
                    <i class="material-icons">event</i><span class="add-type">{#quick_add_news#}</span>
                </a>
            </li>
            <li>
                <a href="{$url}/{baseadmin}/index.php?controller=pages&action=add">
                    <i class="material-icons">description</i><span class="add-type">{#quick_add_page#}</span>
                </a>
            </li>
            <li>
                <a href="{$url}/{baseadmin}/index.php?controller=category&action=add">
                    <i class="material-icons">folder</i><span class="add-type">{#quick_add_cat#}</span>
                </a>
            </li>
            <li>
                <a href="{$url}/{baseadmin}/index.php?controller=product&action=add">
                    <i class="material-icons">local_offer</i><span class="add-type">{#quick_add_product#}</span>
                </a>
            </li>
        </ul>
    </div>
{/block}
{block name="jscontroller"}{/block}
{block name="foot" append}
    {$viewId = '55526284'}
    {$clientId = '454274961491-s8jv6iu9c17q3c50igl1cq0c2dm9j3ma.apps.googleusercontent.com'}
    <script>
        const VIEW_ID = "{$viewId}";
        const CLIENT_ID = "{$clientId}";
    </script>
    <script src="/{$baseadmin}/skin/modern/js/locales/{$lang}.js"></script>
    <script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    {literal}
    <script>
        (function(w,d,s,g,js,fjs){
            g=w.gapi||(w.gapi={});g.analytics={q:[],ready:function(cb){this.q.push(cb)}};
            js=d.createElement(s);fjs=d.getElementsByTagName(s)[0];
            js.src='https://apis.google.com/js/platform.js';
            fjs.parentNode.insertBefore(js,fjs);js.onload=function(){g.load('analytics')};
        }(window,document,'script'));
    </script>
    {/literal}
    <script src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="/{$baseadmin}/min/?f=/{$baseadmin}/skin/modern/js/analytics.materialchart.min.js,/{$baseadmin}/skin/modern/js/analytics.daterangeselector.min.js,/{$baseadmin}/skin/modern/js/analytics.min.js,/{$baseadmin}/skin/modern/js/dashboard.min.js"></script>
{/block}
{block name="stylesheets" append}
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
{/block}
