/*
 # -- BEGIN LICENSE BLOCK ----------------------------------
 #
 # This file is part of MAGIX CMS.
 # MAGIX CMS, The content management system optimized for users
 # Copyright (C) 2008 - 2013 magix-cms.com <support@magix-cms.com>
 #
 # OFFICIAL TEAM :
 #
 #   * Gerits Aurelien (Author - Developer) <aurelien@magix-cms.com> <contact@aurelien-gerits.be>
 #
 # Redistributions of files must retain the above copyright notice.
 # This program is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.

 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 # -- END LICENSE BLOCK -----------------------------------

 # DISCLAIMER

 # Do not edit or add to this file if you wish to upgrade MAGIX CMS to newer
 # versions in the future. If you wish to customize MAGIX CMS for your
 # needs please refer to http://www.magix-cms.com for more information.
 */

tinymce.PluginManager.requireLangPack('mc_product');
tinymce.PluginManager.add('mc_product', function(editor, url) {
    function showDialog() {
        var win, 
        data = {}, 
        dom = editor.dom;
        // Open URL based window
        //var i18Tab = [i18.translate('mc_product Title'),i18.translate('search')];
        win = editor.windowManager.open({
            title: "mc_product Title",
            file: tinyMCE.baseURL + '/plugins/mc_product/product.php',
            width: 800,
            height: 550,
            inline: 1,
            resizable: true,
            maximizable: true
        });
    }

    // Add a button that opens a window
    editor.addButton('mc_product', {
        //text: 'mc_product',
        //icon: true,
        //image: url+'/img/search_product.png',
        icon: 'fa fas fa-box',
        tooltip: "mc_product Title",
        onclick: showDialog,
        onPostRender: function() {
            var ctrl = this;
            editor.on('NodeChange', function(e) {
                ctrl.active(e.element.nodeName == 'IMG');
            });
        }
    });

    // Add a button into the menu bar
    editor.addMenuItem('mc_product', {
        text: tinymce.util.I18n.translate("mc_product menu"),
        icon: 'fa fas fa-box',
        onclick: showDialog,
        context: 'insert'
    });
});