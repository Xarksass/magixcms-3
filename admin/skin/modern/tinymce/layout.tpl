<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>{block name="head:title"}{/block}</title>
    <link href="/{$baseadmin}/skin/{$theme}/css/tinyplugins.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons|Material+Icons+Outlined|Roboto:300,500,700" rel="stylesheet">
{*    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">*}
    <!--<link href="css/mc_pages.css" rel="stylesheet">-->
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="/libjs/html5shiv.js" type="text/javascript"></script>
    <script src="/libjs/respond.min.js" type="text/javascript"></script>
    <![endif]-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <script type="text/javascript" src="/{$baseadmin}/min/?g=modernjs"></script>
    <script type="text/javascript" src="/{$baseadmin}/min/?f=/libjs/vendor/bootstrap-select.min.js,/libjs/vendor/livefilter.min.js,/libjs/vendor/tabcomplete.min.js"></script>
    {*<script src="js/vendor/mustache.js"></script>*}
    <script type="text/javascript">let baseadmin = "{$baseadmin}";</script>
    <script type="text/javascript" src="/{$baseadmin}/skin/{$theme}/tinymce/{block name="head:script"}{/block}"></script>
</head>
<body>
<main>
    {block name="main:content"}{/block}
</main>
</body>
</html>