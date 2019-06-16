<tr>
	<td>
		<p>{$item.name_pages}</p>
		<a href="{$url}/{baseadmin}/index.php?controller=pages&action=edit&edit={$item.id_pages}" class="all-hover">{$item.name_pages}</a>
	</td>
	<td>
		<p class="text-right">{$item.date_register|date_format:"%d/%m/%Y"}</p>
	</td>
</tr>