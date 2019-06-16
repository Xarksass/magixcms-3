{$eClass = $smarty.get.controller}
{block name='header:title'}
    {#error_root_access#|ucfirst} : {#$eClass#}
{/block}
{block name="header:toolbar"}{/block}

{block name='main:content'}
    <div class="alert alert-warning">
        <i class="material-icons">warning</i>{#class_access_denied#|sprintf:{#$eClass#}}
    </div>
{/block}