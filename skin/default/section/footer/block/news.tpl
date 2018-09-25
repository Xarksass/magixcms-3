<div id="block-last-news" class="col-12 col-sm-4 block">
    {widget_news_data
        conf = [
            'context' => 'all',
            'limit' => 2
            ]
        assign="newsFooterData"
    }
    <h4><a href="{$url}/{$lang}/{#nav_news_uri#}/" title="{#show_news#|ucfirst}">{#last_news#|ucfirst}</a></h4>
    <div class="news-list-last">
        {include file="news/loop/footer.tpl" data=$newsFooterData}
    </div>
</div>