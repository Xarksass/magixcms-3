<div class="tab-content">
	{foreach $langs as $id => $iso}
	<fieldset role="tabpanel" class="tab-pane lang-{$id}{if $iso@first} active{/if}">
		<div class="form-group">
			<label for="content[{$id}][seo_title]">{#seo_title_page#}&nbsp;:</label>
			<textarea class="form-control" id="content[{$id}][seo_title]" name="content[{$id}][seo_title]" placeholder="{#seo_title_page_ph#}" cols="70" rows="3">{$contentData[{$id}].seo_title}</textarea>
		</div>
		<div class="form-group">
			<label for="content[{$id}][seo_desc]">{#seo_desc_page#}&nbsp;:</label>
			<textarea class="form-control" id="content[{$id}][seo_desc]" name="content[{$id}][seo_desc]" placeholder="{#seo_desc_page_ph#}" cols="70" rows="3">{$contentData[{$id}].seo_desc}</textarea>
		</div>
	</fieldset>
	{/foreach}
</div>