<?php
/**
 * Groups configuration for default Minify implementation
 * @package Minify
 */

/**
 * You may wish to use the Minify URI Builder app to suggest
 * changes. http://yourdomain/min/builder/
 *
 * See https://github.com/mrclay/minify/blob/master/docs/CustomServer.wiki.md for other ideas
 **/

return array(
    'publicjs' => array(
        '//libjs/vendor/jquery-3.0.0.min.js',
        '//'.PATHADMIN.'/template/js/vendor/bootstrap.min.js',
        '//libjs/vendor/Chart.bundle.min.js',
        '//libjs/vendor/bootstrap-toggle.min.js',
        '//libjs/vendor/bootstrap-colorpicker.min.js',
        '//libjs/vendor/jquery.form.4.2.1.min.js',
        '//libjs/vendor/jquery.validate.1.17.0.min.js',
        '//'.PATHADMIN.'/template/js/vendor/jquery.fancybox.min.js',
        '//'.PATHADMIN.'/template/js/vendor/bootstrap-tagsinput.js',
        '//'.PATHADMIN.'/template/js/fancybox.init.min.js',
        '//libjs/vendor/redirect.min.js'
    ),
    'jimagine' => array(
        '//libjs/vendor/jimagine/plugins/jquery.jmRequest.js',
        '//libjs/vendor/jimagine/plugins/jquery.jmInsertCaret.js'
    ),
    'globalize'=> array(
        '//libjs/vendor/cldr.js',
        '//libjs/vendor/globalize.js',
        '//libjs/vendor/globalize/message.js'
    ),
    'modernjs' => array(
        '//'.PATHADMIN.'/libjs/bootstrap.min.js',
        '//libjs/vendor/jquery.form.4.2.1.min.js',
        '//libjs/vendor/jquery.validate.1.17.0.min.js',
        '//libjs/vendor/redirect.min.js',
        '//libjs/vendor/jimagine/plugins/jquery.jmRequest.min.js',
        '//'.PATHADMIN.'/libjs/iscroll.min.js',
        '//'.PATHADMIN.'/libjs/loader.min.js',
        '//'.PATHADMIN.'/libjs/overlay.min.js',
        '//'.PATHADMIN.'/libjs/form.min.js'
    ),
    'inputjs' => array(
        '//libjs/vendor/moment.min.js',
        '//libjs/vendor/typeahead.bundle.js',
        '//libjs/vendor/bootstrap-tagsinput.js',
        '//libjs/vendor/bootstrap-toggle.min.js',
        '//libjs/vendor/bootstrap-colorpicker.min.js',
        '//libjs/vendor/jquery.formatter.min.js'
    ),
    'inputcss' => array(
        '//libcss/bootstrap-datetimepicker.min.css',
        '//libcss/bootstrap-colorpicker.min.css',
        '//libcss/bootstrap-tagsinput.css',
        '//libcss/bootstrap-tagsinput-typeahead.css'
    ),
    'publiccss' => array(
        //'//'.PATHADMIN.'/template/css/bootstrap/critical.min.css',
        //'//'.PATHADMIN.'/template/css/bootstrap/bootstrap.min.css',
        '//'.PATHADMIN.'/template/css/desktop.min.css',
        '//'.PATHADMIN.'/template/css/bootstrap-toggle.min.css',
        '//'.PATHADMIN.'/template/css/bootstrap-colorpicker.min.css',
        '//'.PATHADMIN.'/template/css/fancybox/jquery.fancybox.min.css',
        '//'.PATHADMIN.'/template/css/bootstrap-tagsinput.css',
        '//'.PATHADMIN.'/template/css/bootstrap-tagsinput-typeahead.css',
    ),
    'tinymce' => array(
        '//'.PATHADMIN.'/libjs/vendors/tiny_mce.'.VERSION_EDITOR.'/jquery.tinymce.min.js',
        '//'.PATHADMIN.'/libjs/tinymce-config.slim.min.js'
    ),
    'pdfcss' => array(
        '//'.PATHADMIN.'/template/css/pdf/print.min.css',
    ),
    'maxAge' => 31536000,
    'setExpires' => time() + 86400 * 365
);
