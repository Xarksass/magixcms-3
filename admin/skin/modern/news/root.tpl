{extends file="news/index.tpl"}
{block name='head:title'}{#edit_news_root#}{/block}
{block name='body:id'}news{/block}
{block name="body:class"}{/block}

{block name='header:title'}
	<a href="{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}&action=editroot" title="{#edit_news_root#}">{#edit_news_root#}</a>
{/block}
{block name="header:toolbar"}{/block}

{if {employee_access type="append" class_name=$cClass} eq 1}
	{block name='main:content'}
		<div class="container-fluid">
			{capture name="post_action"}{$smarty.server.SCRIPT_NAME}?controller={$smarty.get.controller}&amp;action=editroot{/capture}
			{$conf = [
				'action' => $smarty.capture.post_action,
				'method' => 'post',
				'handlers' => 'edit',
				'controller' => 'news',
				'subcontroller' => 'root',
				'sections' => [
					'content' => 'content',
					'seo' => 'seo'
				],
				'page' => $page,
				'footer' => [
					'menu' => false,
					'publish' => true,
					'save' => true,
					'leave' => false,
					'section' => "",
					'input' => true,
					'edit' => $page.id_page
				]
			]}
			{include file="form/form.tpl" form_config=$conf}
		</div>
	{/block}
	{block name="footer"}<footer id="footer"></footer>{/block}
	{include file="brick/editor.tpl"}
{else}
	{block name='main:content'}
		{include file="section/brick/viewperms.tpl"}
	{/block}
{/if}