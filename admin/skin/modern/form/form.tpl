{if isset($form_config) && is_array($form_config)}
{*<form id="edit_home"
      action="{$form_config.action}"
      method="{if isset($form_config.method)}{$form_config.method}{else}post{/if}"
      class="validate_form"
      data-handlers="{if isset($form_config.handlers)}{$form_config.handlers}{else}edit{/if}">*}
	<div class="form-sections tab-content">
		<div class="menu-sections">
			{include file="language/brick/dropdown-lang.tpl" label=false onclass=true}
			{include file="form/brick/menu.tpl" sections=$form_config.sections}
		</div>
		<div class="tab-content">
			{include file="form/loop/sections.tpl" sections=$form_config.sections controller=$form_config.controller subcontroller=$form_config.subcontroller}
		</div>
	</div>
	{include file="form/brick/footer.tpl" menu=$form_config.footer.menu publish=$form_config.footer.publish save=$form_config.footer.save leave=$form_config.footer.leave section=$form_config.footer.section input=$form_config.footer.input edit=$form_config.footer.edit}
{*</form>*}
{/if}