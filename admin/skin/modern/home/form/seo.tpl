<div class="tab-content">
	{foreach $langs as $id => $iso}
	<fieldset role="tabpanel" class="tab-pane lang-{$id}{if $iso@first} active{/if}">
		<div class="form-group">
			<label for="content[{$id}][seo_title_page]">{#seo_title_page#}&nbsp;:</label>
			<textarea class="form-control" id="content[{$id}][seo_title_page]" name="content[{$id}][seo_title_page]" placeholder="{#seo_title_page_ph#}" cols="70" rows="3">{$page.content[{$id}].seo_title_page}</textarea>
		</div>
		<div class="form-group">
			<label for="content[{$id}][seo_desc_page]">{#seo_desc_page#}&nbsp;:</label>
			<textarea class="form-control" id="content[{$id}][seo_desc_page]" name="content[{$id}][seo_desc_page]" placeholder="{#seo_desc_page_ph#}" cols="70" rows="3">{$page.content[{$id}].seo_desc_page}</textarea>
		</div>
	</fieldset>
	{/foreach}
</div>