<div class="tab-content">
	{foreach $langs as $id => $iso}
	<fieldset role="tabpanel" class="tab-pane lang-{$id}{if $iso@first} active{/if}">
		<div class="form-group">
			<label for="content[{$id}][seo_title_p]">{#seo_title_p#}&nbsp;:</label>
			<textarea class="form-control" id="content[{$id}][seo_title_p]" name="content[{$id}][seo_title_p]" placeholder="{#seo_title_p_ph#}" cols="70" rows="3">{$page.content[{$id}].seo_title_p}</textarea>
		</div>
		<div class="form-group">
			<label for="content[{$id}][seo_desc_p]">{#seo_desc_p#}&nbsp;:</label>
			<textarea class="form-control" id="content[{$id}][seo_desc_p]" name="content[{$id}][seo_desc_p]" placeholder="{#seo_desc_p_ph#}" cols="70" rows="3">{$page.content[{$id}].seo_desc_p}</textarea>
		</div>
	</fieldset>
	{/foreach}
</div>