{foreach $sections as $k => $section}
	{if $section === 'plugins'}
	{if !empty($setTabsPlugins)}
		{foreach $setTabsPlugins as $key => $value}
			<section id="plugins-{$value.name}" class="tab-pane fade{if $smarty.get.plugin eq $value.name} in active open{/if}">
				<header>
					{include file="language/brick/dropdown-lang.tpl" label=false onclass=true container_class="select-lang"}
					<div class="header-title">
						{$value.name}
						<div class="arrow">
							<span class="show-more"><i class="material-icons">arrow_drop_down</i></span>
							<span class="show-less"><i class="material-icons">arrow_drop_up</i></span>
						</div>
					</div>
				</header>
				<div class="collapse{if $smarty.get.plugin eq $value.name} in{/if}">
					{block name="plugin:content"}{/block}
				</div>
			</section>
		{/foreach}
	{/if}
	{else}
	{if is_array($section)}{$section_id = $section.id}{elseif is_string($section)}{$section_id = $section}{/if}
	<section id="{$section_id}" class="tab-pane fade{if $section@first} in active open{/if}">
		<header>
			{include file="language/brick/dropdown-lang.tpl" label=false onclass=true container_class="select-lang"}
			<div class="header-title">
				{if is_string($k)}{#$k#|ucfirst}{else}{#$section_id#|ucfirst}{/if}
				<div class="arrow">
					<span class="show-more"><i class="material-icons">arrow_drop_down</i></span>
					<span class="show-less"><i class="material-icons">arrow_drop_up</i></span>
				</div>
			</div>
		</header>
		<div class="collapse{if $section@first} in{/if}">
			{if is_string($section) || (is_array($section) && $section.form)}<form
			      action="#"
			      method="{if isset($form_config.method)}{$form_config.method}{else}post{/if}"
			      class="validate_form form-section">{/if}
			{capture name="fields"}{$controller}{if $subcontroller}/{$subcontroller}{/if}/form/{$section_id}.tpl{/capture}
			{include file=$smarty.capture.fields}
			{if is_string($section) || (is_array($section) && $section.form)}</form>{/if}
		</div>
	</section>
	{/if}
{/foreach}