<tr>
	<td>
		<p>{$item.name_cat}</p>
		<a href="{$url}/{baseadmin}/index.php?controller=category&action=edit&edit={$item.id_cat}" class="all-hover">{$item.name_cat}</a>
	</td>
	<td>
		<p class="text-right">{$item.date_register|date_format:"%d/%m/%Y"}</p>
	</td>
</tr>