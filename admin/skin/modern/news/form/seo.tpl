<div class="tab-content">
	{foreach $langs as $id => $iso}
	<fieldset role="tabpanel" class="tab-pane lang-{$id}{if $iso@first} active{/if}">
		<div class="form-group">
			<label for="content[{$id}][seo_title_news]">{#seo_title_news#}&nbsp;:</label>
			<textarea class="form-control" id="content[{$id}][seo_title_news]" name="content[{$id}][seo_title_news]" placeholder="{#seo_title_news_ph#}" cols="70" rows="3">{$page.content[{$id}].seo_title_news}</textarea>
		</div>
		<div class="form-group">
			<label for="content[{$id}][seo_desc_news]">{#seo_desc_news#}&nbsp;:</label>
			<textarea class="form-control" id="content[{$id}][seo_desc_news]" name="content[{$id}][seo_desc_news]" placeholder="{#seo_desc_news_ph#}" cols="70" rows="3">{$page.content[{$id}].seo_desc_news}</textarea>
		</div>
	</fieldset>
	{/foreach}
</div>