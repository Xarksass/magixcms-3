<div class="col-12 col-md-6">
	<section>
		<header>
			<h2 class="h3 title_section">
				<i class="material-icons">{$icon}</i><a href="{$url}/{$baseadmin}/index.php?controller={$controller}">{$title}</a>
			</h2>
		</header>
		<table class="folder-box">
			<tbody>
			{if is_array($data) && !empty($data)}
				{foreach $data as $item}
					{include file="dashboard/loop/$controller.tpl"}
				{/foreach}
			{/if}
			</tbody>
		</table>
		<footer class="visible-xl">
			{$add_txt = 'add_'|cat:$controller}
			<a href="{$url}/{$baseadmin}/index.php?controller={$controller}&action=add" class="btn btn-icon"><i class="material-icons">add</i>{#$add_txt#}</a>
		</footer>
	</section>
</div>