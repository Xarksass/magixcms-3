{block name="fontawesome"}
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">
{/block}
{block name="vendors" append}
    <script type="text/javascript">
        {capture name="tinyMCEstyleSheet"}/{$baseadmin}/skin/{$theme}/css/tinymce-content.min.css{/capture}
        var content_css = "{$smarty.capture.tinyMCEstyleSheet}{if $setting.content_css.value != ''},{$setting.content_css.value}{/if}";
    </script>
{/block}
{block name="jsgrouplist" append},tinymce{/block}