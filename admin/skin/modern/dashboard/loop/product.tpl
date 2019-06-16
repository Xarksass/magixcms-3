<tr>
	<td>
		<p>{$item.name_p}</p>
		<a href="{$url}/{$baseadmin}/index.php?controller=product&action=edit&edit={$item.id_product}" class="all-hover">{$item.name_p}</a>
	</td>
	<td>
		<p class="text-right">{$item.date_register|date_format:"%d/%m/%Y"}</p>
	</td>
</tr>