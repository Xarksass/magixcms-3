<div class="form-group">
	<label for="parent">{#parent_pages#|ucfirst}&nbsp;:</label>
	<div id="parent" class="btn-group btn-block selectpicker" data-clear="true" data-live="true">
		<a href="#" class="clear"><span class="fa fa-times"></span><span class="sr-only">{#bss_cancel#}</span></a>
		<button data-id="parent" type="button" class="btn btn-block btn-default dropdown-toggle">
			<span class="placeholder">{#parent_pages_ph#|ucfirst}</span>
			<span class="caret"></span>
		</button>
		<div class="dropdown-menu">
			<div class="live-filtering" data-clear="true" data-autocomplete="true" data-keys="true">
				<label class="sr-only" for="input-pages">{#bss_search#}</label>
				<div class="search-box">
					<div class="input-group">
                        <span class="input-group-addon" id="search-pages">
                            <span class="fa fa-search"></span>
                            <a href="#" class="fa fa-times hide filter-clear"><span class="sr-only">{#bss_clear#}</span></a>
                        </span>
						<input type="text" placeholder="Rechercher dans la liste" id="input-pages" class="form-control live-search" aria-describedby="search-pages" tabindex="1" />
					</div>
				</div>
				<div id="filter-pages" class="list-to-filter">
					<ul class="list-unstyled">
						{$incorrectParents=array($page.id_pages)}
						{foreach $pagesSelect as $items}
							{if isset($page.id_pages) && in_array($items.id_parent,$incorrectParents)}
								{if !in_array($items.id_pages,$incorrectParents)}{$incorrectParents[] = $page.id_pages}{/if}
							{elseif $items.id_pages != $page.id_pages}
								<li class="filter-item items{if isset($page.id_parent) && $items.id_pages == $page.id_parent} selected{/if}" data-filter="{$items.name_pages}" data-value="{$items.id_pages}" data-id="{$items.id_pages}">
									{$items.name_pages}&nbsp;<small>({$items.id_pages})</small>
								</li>
							{/if}
						{/foreach}
					</ul>
					<div class="no-search-results">
						<div class="alert alert-warning" role="alert"><i class="fa fa-warning margin-right-sm"></i>{#bss_no_result#}</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" name="parent_id" id="parent_id" value="{$smarty.get.parent_id}" />
</div>
<div class="tab-content">
	{foreach $langs as $id => $iso}
	<fieldset role="tabpanel" class="tab-pane lang-{$id}{if $iso@first} active{/if}">
		<div class="form-group">
			<label for="content[{$id}][name_pages]">{#name_pages#}&nbsp;*:</label>
			<input type="text" class="form-control" id="content[{$id}][name_pages]" name="content[{$id}][name_pages]" placeholder="{#name_pages_ph#}" value="{$page.content[{$id}].name_pages}" size="50" />
		</div>
		<div class="row">
			<div class="col-12 col-lg-6">
				<div class="form-group">
					<label for="content[{$id}][url_pages]">{#url_rewriting#|ucfirst}</label>
					<div class="input-group">
						<input type="text" class="form-control locked" id="content[{$id}][url_pages]" name="content[{$id}][url_pages]" readonly="readonly" size="30" value="{$page.content[{$id}].url_pages}" />
						<span class="input-group-addon input-icon-mi unlocked">
					<i class="material-icons">lock_open</i>
                </span>
					</div>
				</div>
			</div>
			<div class="col-12 col-lg-6">
				<div class="form-group">
					<label for="public_url[{$id}]">URL</label>
					<input type="text" class="form-control public-url" data-lang="{$id}" id="public_url[{$id}]" data-uri="content[{$id}][url_pages]" name="public_url[{$id}]" readonly="readonly" size="50" value="{$page.content[{$id}].public_url}" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="content[{$id}][resume_pages]">{#resume_pages#}&nbsp;:</label>
			<textarea name="content[{$id}][resume_pages]" id="content[{$id}][resume_pages]" class="form-control" placeholder="{#resume_pages_ph#}">{$page.content[{$id}].resume_pages}</textarea>
		</div>
		<div class="form-group">
			<label for="content[{$id}][content_pages]">{#content_pages#}&nbsp;:</label>
			<textarea name="content[{$id}][content_pages]" id="content[{$id}][content_pages]" class="form-control mceEditor" placeholder="{#content_pages_ph#}">{$page.content[{$id}].content_page}</textarea>
		</div>
	</fieldset>
	{/foreach}
</div>