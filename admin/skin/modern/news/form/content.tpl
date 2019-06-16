<div class="tab-content">
	{foreach $langs as $id => $iso}
	<fieldset role="tabpanel" class="tab-pane lang-{$id}{if $iso@first} active{/if}">
		<div class="form-group">
			<label for="content[{$id}][name_news]">{#name_news#}&nbsp;*:</label>
			<input type="text" class="form-control" id="content[{$id}][name_news]" name="content[{$id}][name_news]" placeholder="{#name_news_ph#}" value="{$page.content[{$id}].name_news}" size="50" />
		</div>
		<div class="row">
			<div class="col-12 col-lg-6">
				<div class="form-group">
					<label for="content[{$id}][url_news]">{#url_rewriting#|ucfirst}</label>
					<div class="input-group">
						<input type="text" class="form-control locked" id="content[{$id}][url_news]" name="content[{$id}][url_news]" readonly="readonly" size="30" value="{$page.content[{$id}].url_news}" />
						<span class="input-group-addon input-icon-mi unlocked">
					<i class="material-icons">lock_open</i>
                </span>
					</div>
				</div>
			</div>
			<div class="col-12 col-lg-6">
				<div class="form-group">
					<label for="public_url[{$id}]">URL</label>
					<input type="text" class="form-control public-url" data-lang="{$id}" id="public_url[{$id}]" data-uri="content[{$id}][url_news]" name="public_url[{$id}]" readonly="readonly" size="50" value="{$page.content[{$id}].public_url}" />
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12 col-lg-6">
				<div class="form-group">
					<label for="content[{$id}][date_publish]">{#date_publish_news#}&nbsp;:</label>
					<div class="input-group date date-input-picker">
						<input type="text" class="form-control" id="content[{$id}][date_publish]" name="content[{$id}][date_publish]" placeholder="{#date_publish_news_ph#}" value="{$page.content[{$id}].date_publish}" size="50" />
						<span class="input-group-addon input-icon-mi">
                            <i class="material-icons">event_available</i>
                        </span>
					</div>
				</div>
			</div>
			<div class="col-12 col-lg-6">
				<div class="form-group">
					<label for="content[{$id}][tag_news]">{#tag_news#|ucfirst}&nbsp;:</label>
					<input type="text" class="tags-input" value="{$page.content[{$id}].tags_news}" data-lang="{$id}" {*data-role="tagsinput"*} name="content[{$id}][tag_news]" id="tag-news-{$id}"/>
					<input type="hidden" id="auto-tag-{$id}" disabled="disabled" value="{$page.content[{$id}].tags}" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="content[{$id}][resume_news]">{#resume_news#}&nbsp;:</label>
			<textarea name="content[{$id}][resume_news]" id="content[{$id}][resume_news]" class="form-control" placeholder="{#resume_news_ph#}">{$page.content[{$id}].resume_news}</textarea>
		</div>
		<div class="form-group">
			<label for="content[{$id}][content_news]">{#content_news#}&nbsp;:</label>
			<textarea name="content[{$id}][content_news]" id="content[{$id}][content_news]" class="form-control mceEditor" placeholder="{#content_news_ph#}">{$page.content[{$id}].content_page}</textarea>
		</div>
	</fieldset>
	{/foreach}
</div>