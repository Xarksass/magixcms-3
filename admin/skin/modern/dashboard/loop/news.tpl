<tr>
	<td>
		<p>{$item.name_news}</p>
		<a href="{$url}/{baseadmin}/index.php?controller=news&action=edit&edit={$item.id_news}" class="all-hover">{$item.name_news}</a>
	</td>
	<td>
		<p class="text-right">{$item.date_register|date_format:"%d/%m/%Y"}</p>
	</td>
</tr>