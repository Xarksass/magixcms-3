<div class="tab-content">
	{foreach $langs as $id => $iso}
	<fieldset role="tabpanel" class="tab-pane lang-{$id}{if $iso@first} active{/if}">
		<div class="form-group">
			<label for="content[{$id}][catalog_name]">{#catalog_name#}&nbsp;:</label>
			<input type="text" class="form-control" id="content[{$id}][catalog_name]" name="content[{$id}][catalog_name]" placeholder="{#catalog_name_ph#}" value="{$contentData.{$id}.name}" size="50" />
		</div>
		<div class="form-group">
			<label for="content[{$id}][catalog_content]">{#content_page#}&nbsp;:</label>
			<textarea name="content[{$id}][catalog_content]" id="content[{$id}][catalog_content]" class="form-control mceEditor" placeholder="{#content_page_ph#}">{$contentData.{$id}.content}</textarea>
		</div>
	</fieldset>
	{/foreach}
</div>