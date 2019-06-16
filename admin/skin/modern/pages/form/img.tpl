{foreach $langs as $id => $iso}
	{if $iso@first}{$default = $id}{break}{/if}
{/foreach}
<div class="row">
	<div class="col-12 img-settings">
		<fieldset>
			<legend>{#img_file#}</legend>
			<div class="form-group">
				<label for="name_img_{$id}">{#name_img#|ucfirst}&nbsp;:</label>
				<input type="text" class="form-control" placeholder="{#ph_name_img#}" id="name_img_{$id}" name="name_img" value="{if isset($page.img_pages)}{$page.img_pages}{else}{$page.content[$default].url_pages}{/if}" />
			</div>
			{include file="form/brick/dropzone.tpl" type='img' ratio=$imgRatio multiple=false src=$page.imgSrc id=$page.id_pages name='img' folder='pages' progressbar=false submit=false delete=(isset($page.img_pages))}
			<p class="help-block">
				minimum {$minImgSize.width_img}px {#width#} {if $minImgSize.resize_img === 'adaptative'} x {$minImgSize.height_img}px {#height#}{/if}
			</p>
		</fieldset>
		<div class="tab-content">
			{foreach $langs as $id => $iso}
				<div role="tabpanel" class="tab-pane{if $iso@first} active{/if} lang-{$id}">
					<fieldset>
						<legend>{#img_seo#}</legend>
						<div class="row">
							<div class="col-12 col-md-6">
								<div class="form-group">
									<label for="alt_img_{$id}">{#alt_img#|ucfirst}&nbsp;:</label>
									<input type="text" class="form-control" id="alt_img_{$id}" name="content[{$id}][img][alt_img]" placeholder="{#ph_alt_img#}" value="{$page.content[{$id}].alt_img}" />
								</div>
							</div>
							<div class="col-12 col-md-6">
								<div class="form-group">
									<label for="title_img_{$id}">{#title_img#|ucfirst}&nbsp;:</label>
									<input type="text" class="form-control" id="title_img_{$id}" name="content[{$id}][img][title_img]" placeholder="{#ph_title_img#}" value="{$page.content[{$id}].title_img}" />
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="caption_img_{$id}">{#caption_img#|ucfirst}&nbsp;:</label>
							<textarea class="form-control" id="caption_img_{$id}" name="content[{$id}][img][caption_img]" placeholder="{#ph_caption_img#}" cols="65" rows="3">{$page.content[{$id}].caption_img}</textarea>
						</div>
					</fieldset>
				</div>
			{/foreach}
		</div>
	</div>
	<div class="col-12 img-preview">
		<fieldset>
			<legend>{#img_sizes#}</legend>
			<div class="block-img">
				{if $page.imgSrc != null}
					{include file="form/loop/img.tpl" controller="pages" data=['id' => $page.id_pages, 'imgSrc' => $page.imgSrc]}
				{/if}
			</div>
		</fieldset>
	</div>
</div>