<div class="dropzone" data-type="{$type}" data-multiple="{$multiple}"{if $type === 'img' && isset($ratio)} data-ratio="{$ratio}"{/if}>
	{if $progressbar}
		<div class="progress">
			<div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
				<div class="progress-bar-state">
					<span class="state">{#connect_to_server#}</span>
				</div>
			</div>
			<span class="state">{#connect_to_server#}</span>
		</div>
	{/if}
	<div class="drop-zone{if $type === 'img'} img-drop{if !isset($src) || empty($src)} no-img{/if}{/if}">
		<span class="placeholder">{if $type === 'img'}{if $multiple}{#drop_imgs_here#}{else}{#drop_img_here#}{/if}{/if}</span>
		<div class="form-group drop-buttons">
			<label class="drop-btn btn btn-default">
				{#or_click_here#} <i class="material-icons">publish</i>
				<input type="hidden" name="MAX_FILE_SIZE" value="4048576" />
				{if $multiple}
					<input type="file" class="drop-input-{$type}-multiple" name="{$name}" value="" multiple />
				{else}
					<input type="file" class="drop-input-{$type}" name="{$name}" />
				{/if}
				{*<input type="hidden" name="id" value="{$id}">*}
			</label>
			{if $submit}
			<button class="btn btn-main-theme" type="submit" name="action" value="{$type}" disabled>{#send#|ucfirst}</button>
			{/if}
			{if $delete}
			<button class="btn btn-danger" type="submit" name="action" value="{$type}">{#remove#|ucfirst}</button>
			{/if}
		</div>
		{if $type === 'img' && !$multiple}
		<div class="preview-img">
			<img src="{if isset($src) && !empty($src)}/upload/{$folder}/{$id}/{$src['original'].img}{else}{$baseadmin}/skin/{$theme}/img/blank.gif{/if}"
			     alt="{#drop_img_here#}"
			     class="preview{if !isset($src) || empty($src)} no-img{/if} img-responsive" />
		</div>
		{/if}
	</div>
</div>