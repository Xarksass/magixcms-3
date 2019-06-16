{if !isset($publish)}{$publish = true}{/if}
{if !isset($menu)}{$menu = true}{/if}
{if !isset($save)}{$save = true}{/if}
{if !isset($leave)}{$leave = true}{/if}
{if !isset($input)}{$input = true}{/if}
{if !isset($input_name)}{$input_name = 'id'}{/if}
{if !isset($edit)}{$edit = null}{/if}
{if !isset($section)}{$section = 'page'}{/if}
<form id="form-footer" action="{$form_config.action}"
      method="{if isset($form_config.method)}{$form_config.method}{else}post{/if}"
      class="validate_form form-footer"
      data-handlers="{if isset($form_config.handlers)}{$form_config.handlers}{else}edit{/if}">
	{if $publish || $menu}
	{if $menu}
	<div class="switch-menu" data-toggle="popover" data-trigger="hover focus" data-content="{#menu_hint#}" data-placement="top">
		<div class="switch">
			{capture name="menu_name"}menu{if !empty($section)}_{$section}{/if}{/capture}
			<input type="checkbox" id="menu{if !empty($section)}_{$section}{/if}" name="menu{if !empty($section)}_{$section}{/if}" class="switch-native-control"{if $form_config.page[$smarty.capture.menu_name] || !isset($form_config.page)} checked{/if}/>
			<div class="switch-bg">
				<div class="switch-knob"></div>
			</div>
		</div>
		<label for="menu{if !empty($section)}_{$section}{/if}">{#menu#}</label>
	</div>
	{/if}
	{if $publish}
	<div class="tab-content" data-toggle="popover" data-trigger="hover focus" data-content="{#oublish_hint#}" data-placement="top">
		{capture name="publish_name"}published{if !empty($section)}_{$section}{/if}{/capture}
		{foreach $langs as $id => $iso}
			<fieldset role="tabpanel" class="tab-pane lang-{$id}{if $iso@first} active{/if}">
				<div class="switch">
					<input type="checkbox" id="content[{$id}][published]" name="content[{$id}][{$smarty.capture.publish_name}]" class="switch-native-control"{if $form_config.page.content[$id][$smarty.capture.publish_name]} checked{/if}/>
					<div class="switch-bg">
						<div class="switch-knob"></div>
					</div>
				</div>
				<label for="content[{$id}][published]">{#published#}</label>
			</fieldset>
		{/foreach}
	</div>
	{/if}
	{/if}
	{if $save || $leave}
	<div class="submit">
		{if $input}<input type="hidden" name="{$input_name}" value="{$edit}" />{/if}
		{if $save}
		<button type="submit" href="#" class="btn btn-lg btn-box btn-main-theme" data-type="save">{#save#|ucfirst}</button>
		{/if}
		{if $leave}
		<button type="submit" href="#" class="btn btn-lg btn-box btn-main-theme" data-type="leave">{#add#|ucfirst}</button>
		{/if}
	</div>
	{/if}
</form>