<div class="switch-group">
	<div class="switch-about" data-toggle="popover" data-trigger="hover focus" data-content="{if $aboutpageset && ($aboutpageset !== $page.id_pages || !isset($page.id_pages))}{#about_disabled_hint#}{else}{#about_hint#}{/if}" data-placement="right">
		<div class="switch">
			<input type="checkbox"
			       id="about_pages"
			       name="about_pages"
			       class="switch-native-control{if $aboutpageset && ($aboutpageset !== $page.id_pages || !isset($page.id_pages))} disabled{/if}"
					{if $aboutpageset && ($aboutpageset !== $page.id_pages || !isset($page.id_pages))} disabled{/if}
					{if $page.about_pages} checked{/if}/>
			<div class="switch-bg">
				<div class="switch-knob"></div>
			</div>
		</div>
		<label for="about_pages">{#about_pages#}</label>
	</div>
</div>
<div class="tab-content">
	{foreach $langs as $id => $iso}
	<fieldset role="tabpanel" class="tab-pane lang-{$id}{if $iso@first} active{/if}">
		<div class="form-group">
			<label for="content[{$id}][seo_title_pages]">{#seo_title_pages#}&nbsp;:</label>
			<textarea class="form-control" id="content[{$id}][seo_title_pages]" name="content[{$id}][seo_title_pages]" placeholder="{#seo_title_pages_ph#}" cols="70" rows="3">{$page.content[{$id}].seo_title_pages}</textarea>
		</div>
		<div class="form-group">
			<label for="content[{$id}][seo_desc_pages]">{#seo_desc_pages#}&nbsp;:</label>
			<textarea class="form-control" id="content[{$id}][seo_desc_pages]" name="content[{$id}][seo_desc_pages]" placeholder="{#seo_desc_pages_ph#}" cols="70" rows="3">{$page.content[{$id}].seo_desc_pages}</textarea>
		</div>
	</fieldset>
	{/foreach}
</div>