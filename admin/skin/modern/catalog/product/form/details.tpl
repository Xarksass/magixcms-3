<div class="form-horizontal">
	<div class="form-group">
		<label for="width_p" class="col-6 col-sm-4 control-label">{#width_p#}</label>
		<div class="input-group col-6 col-sm-4">
			<input type="number" min="0" step="0.1" class="form-control text-right" id="width_p" name="productData[width_p]" value="{$page.width_p}" placeholder="{#width_p_ph#}">
			<span class="input-group-addon">cm</span>
		</div>
	</div>
	<div class="form-group">
		<label for="height_p" class="col-6 col-sm-4 control-label">{#height_p#}</label>
		<div class="input-group col-6 col-sm-4">
			<input type="number" min="0" step="0.1" class="form-control text-right" id="height_p" name="productData[height_p]" value="{$page.height_p}" placeholder="{#height_p_ph#}">
			<span class="input-group-addon">cm</span>
		</div>
	</div>
	<div class="form-group">
		<label for="depth_p" class="col-6 col-sm-4 control-label">{#depth_p#}</label>
		<div class="input-group col-6 col-sm-4">
			<input type="number" min="0" step="0.1" class="form-control text-right" id="depth_p" name="productData[depth_p]" value="{$page.depth_p}" placeholder="{#depth_p_ph#}">
			<span class="input-group-addon">cm</span>
		</div>
	</div>
	<div class="form-group">
		<label for="weight_p" class="col-6 col-sm-4 control-label">{#weight_p#}</label>
		<div class="input-group col-6 col-sm-4">
			<input type="number" min="0" step="0.001" class="form-control text-right" id="weight_p" name="productData[weight_p]" value="{$page.weight_p}" placeholder="{#weight_p_ph#}">
			<span class="input-group-addon">kg</span>
		</div>
	</div>
</div>