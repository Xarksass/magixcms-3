<div class="tab-content">
	{foreach $langs as $id => $iso}
	<fieldset role="tabpanel" class="tab-pane lang-{$id}{if $iso@first} active{/if}">
		<div class="form-group">
			<label for="content[{$id}][title_page]">{#title_news_page#}&nbsp;:</label>
			<input type="text" class="form-control" id="content[{$id}][title_page]" name="content[{$id}][title_page]" placeholder="{#title_page_ph#}" value="{$page.content[{$id}].title_page}" size="50" />
		</div>
		<div class="form-group">
			<label for="content[{$id}][content_page]">{#content_news_page#}&nbsp;:</label>
			<textarea name="content[{$id}][content_page]" id="content[{$id}][content_page]" class="form-control mceEditor" placeholder="{#content_page_ph#}">{$page.content[{$id}].content_page}</textarea>
		</div>
	</fieldset>
	{/foreach}
</div>