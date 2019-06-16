/*!
 # -- BEGIN LICENSE BLOCK ----------------------------------
 #
 # This file is part of tinyMCE.
 # YouTube for tinyMCE
 # Copyright (C) 2011 - 2017  Gerits Aurelien <aurelien[at]magix-cms[dot]com>
 # This program is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 # -- END LICENSE BLOCK -----------------------------------
 */
(function (tiny) {
    tiny.PluginManager.requireLangPack("youtube");
    tiny.PluginManager.add("youtube", function (editor, url) {
        function showDialog() {
            editor.windowManager.open({
                title: tinymce.util.I18n.translate("YouTube Title"),
                file: url + "/youtube.html",
                width: 800,
                height: 550,
                inline: 1,
                resizable: true,
                maximizable: true
            });
        }

        // Add a button that opens a window
        editor.addButton("youtube", {
            icon: true,
            image: url + "/img/youtube.gif",
            tooltip:  tinymce.util.I18n.translate("YouTube Tooltip"),
            onclick: showDialog,
            onPostRender: function () {
                var self = this;
                editor.on("NodeChange", function (e) {
                    self.active(e.element.nodeName === "IMG");
                });
            }
        });

        // Add a button into the menu bar
        editor.addMenuItem('youtube', {
            text: tinymce.util.I18n.translate("YouTube Tooltip"),
            image: url + "/img/youtube.gif",
            onclick: showDialog,
            context: 'insert'
        });
    });
}(tinymce));
