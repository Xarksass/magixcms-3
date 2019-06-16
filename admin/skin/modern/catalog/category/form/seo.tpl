<div class="tab-content">
	{foreach $langs as $id => $iso}
	<fieldset role="tabpanel" class="tab-pane lang-{$id}{if $iso@first} active{/if}">
		<div class="form-group">
			<label for="content[{$id}][seo_title_cat]">{#seo_title_cat#}&nbsp;:</label>
			<textarea class="form-control" id="content[{$id}][seo_title_cat]" name="content[{$id}][seo_title_cat]" placeholder="{#seo_title_cat_ph#}" cols="70" rows="3">{$page.content[{$id}].seo_title_cat}</textarea>
		</div>
		<div class="form-group">
			<label for="content[{$id}][seo_desc_cat]">{#seo_desc_cat#}&nbsp;:</label>
			<textarea class="form-control" id="content[{$id}][seo_desc_cat]" name="content[{$id}][seo_desc_cat]" placeholder="{#seo_desc_cat_ph#}" cols="70" rows="3">{$page.content[{$id}].seo_desc_cat}</textarea>
		</div>
	</fieldset>
	{/foreach}
</div>