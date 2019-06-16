<div class="row">
	<div class="col-12 col-sm-6 col-lg-8">
		<div class="tab-content">
			{foreach $langs as $id => $iso}
				<fieldset role="tabpanel" class="tab-pane lang-{$id}{if $iso@first} active{/if}">
					<div class="form-group">
						<label for="content[{$id}][name_p]">{#name_p#}&nbsp;*:</label>
						<input type="text" class="form-control" id="content[{$id}][name_p]" name="content[{$id}][name_p]" placeholder="{#name_p_ph#}" value="{$page.content[{$id}].name_p}" size="50" />
					</div>
					<div class="form-group">
						<label for="content[{$id}][longname_p]">{#longname_p#}&nbsp;*:</label>
						<input type="text" class="form-control" id="content[{$id}][longname_p]" name="content[{$id}][longname_p]" placeholder="{#longname_p_ph#}" value="{$page.content[{$id}].longname_p}" size="50" />
					</div>
					<div class="row">
						<div class="col-12 col-lg-6">
							<div class="form-group">
								<label for="content[{$id}][url_p]">{#url_rewriting#|ucfirst}</label>
								<div class="input-group">
									<input type="text" class="form-control locked" id="content[{$id}][url_p]" name="content[{$id}][url_p]" readonly="readonly" size="30" value="{$page.content[{$id}].url_p}" />
									<span class="input-group-addon input-icon-mi unlocked">
							<i class="material-icons">lock_open</i>
		                </span>
								</div>
							</div>
						</div>
						<div class="col-12 col-lg-6">
							<div class="form-group">
								<label for="public_url[{$id}]">URL</label>
								<input type="text" class="form-control public-url" data-lang="{$id}" id="public_url[{$id}]" data-uri="content[{$id}][url_p]" name="public_url[{$id}]" readonly="readonly" size="50" value="{$page.content[{$id}].public_url}" />
							</div>
						</div>
					</div>
				</fieldset>
			{/foreach}
		</div>
	</div>
	<div class="col-12 col-sm-6 col-lg-4">
		<div class="form-group">
			<label for="reference_p">{#reference_p#}</label>
			<input type="text" class="form-control" id="reference_p" name="productData[reference]" value="{$page.reference_p}" placeholder="{#reference_p_ph#}">
		</div>
		<div class="form-group">
			<label for="price_p">{#price_p#}</label>
			<div class="input-group">
				<input type="number" min="0" step="0.01" class="form-control text-right" id="price_p" name="productData[price_p]" value="{$page.price_p}" placeholder="{#price_p_ph#}" data-vat="1.21">
				<span class="input-group-addon">€ {#ht#}</span>
			</div>
		</div>
		<div class="form-group">
			<label for="price_p_inc sr-only">{#price_p_inc#}</label>
			<div class="input-group">
				<input type="number" min="0" step="0.01" class="form-control text-right" placeholder="{#price_inc_ph#}" id="price_inc" readonly>
				<span class="input-group-addon">€ {#ttc#}</span>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div class="tab-content">
			{foreach $langs as $id => $iso}
				<fieldset role="tabpanel" class="tab-pane lang-{$id}{if $iso@first} active{/if}">
					<div class="form-group">
						<label for="content[{$id}][resume_p]">{#resume_p#}&nbsp;:</label>
						<textarea name="content[{$id}][resume_p]" id="content[{$id}][resume_p]" class="form-control" placeholder="{#resume_p_ph#}">{$page.content[{$id}].resume_p}</textarea>
					</div>
					<div class="form-group">
						<label for="content[{$id}][content_p]">{#content_p#}&nbsp;:</label>
						<textarea name="content[{$id}][content_p]" id="content[{$id}][content_p]" class="form-control mceEditor" placeholder="{#content_p_ph#}">{$page.content[{$id}].content_page}</textarea>
					</div>
				</fieldset>
			{/foreach}
		</div>
	</div>
</div>