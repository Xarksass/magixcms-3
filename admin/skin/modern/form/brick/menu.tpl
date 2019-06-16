<ul>
	{foreach $sections as $k => $section}
		{if $section === 'plugins'}
		{if !empty($setTabsPlugins)}
			{foreach $setTabsPlugins as $key => $value}
				<li{if $smarty.get.plugin eq $value.name} class="active"{/if}>
					<a href="{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}&plugin={$value.name}" aria-controls="plugins-{$value.name}" data-toggle="tab">{$value.name}</a>
				</li>
			{/foreach}
		{/if}
		{else}
		<li{if $section@first} class="active"{/if}>
			{if is_array($section)}{$section_id = $section.id}{elseif is_string($section)}{$section_id = $section}{/if}
			<a href="#{$section_id}" data-toggle="tab">{if is_string($k)}{#$k#|ucfirst}{else}{#$section_id#|ucfirst}{/if}</a>
		</li>
		{/if}
	{/foreach}
</ul>