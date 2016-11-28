<?php
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
/**
 * Author: Gerits Aurelien <aurelien[at]magix-cms[point]com>
 * Copyright: MAGIX CMS
 * Date: 13/12/13
 * Time: 00:32
 * License: Dual licensed under the MIT or GPL Version
 */
class component_core_system{
    /**
     * Retourne le dossier base(ROOT) de Magix CMS
     */
    public static function basePath(){
        try{
            return filter_path::basePath(array('lib','magepattern'));
        }catch(Exception $e) {
            $logger = new debug_logger(MP_LOG_DIR);
            $logger->log('php', 'error', 'An error has occured : '.$e->getMessage(), debug_logger::LOG_MONTH);
        }
    }
    /**
     * @access public
     * @static
     * getUrlConcat Retourne la concaténation de la minification de fichiers
     * @param $options
     * @return string
     * @throws Exception
     * @author Gérits Aurelien and JB Demonte (http://jb.demonte.fr/)
     */
    public static function getUrlConcat($options){
        if(is_array($options)){
            if(array_key_exists('caches', $options)){
                $min_cachePath = $options['caches'];
            }else{
                throw new Exception("Error caches dir is not defined");
            }
            if(array_key_exists('href', $options)){
                $url = $options["href"];
                $ext = 'css';
            }elseif(array_key_exists('src', $options)){
                $url = $options["src"];
                $ext = 'js';
            }
            if(array_key_exists('filesgroups', $options)){
                $filesgroups = $options['filesgroups'];
            }else{
                $filesgroups = 'min/groupsConfig.php';
            }
            if(array_key_exists('minDir', $options)){
                $minDir = $options['minDir'];
            }else{
                $minDir = '/min/';
            }
            if(array_key_exists('callback', $options)){
                $callback = $options['callback'];
            }else{
                $callback = '';
            }
        }else{
            throw new Exception("Error options is not array");
        }

        $name = "";
        //Parse a URL and return its components
        $parseurl = parse_url($url);

        //return position
        $position = strpos($parseurl['query'], '=');

        //return first query
        $query = substr($parseurl['query'],0,$position);

        //return url after query
        $filesPath = substr(strrchr($parseurl['query'], '='), 1);
        // Group
        if($query === 'g'){
            $filesCollection = array();
            if(file_exists($filesgroups)){
                $groups = (require $filesgroups);
                foreach(explode(",", $filesPath) as $group){
                    $filesCollection = array_merge($filesCollection, isset($groups[$group]) ? $groups[$group] : array());
                }
            }else{
                throw new Exception("filesgroups is not exist");
            }
            // Files
        }elseif($query === 'f'){
            $filesCollection = explode(",", $filesPath);
        }
        foreach($filesCollection as &$file){
            $file = ltrim($file, "/");
            $name .= $file . "|" . filemtime(self::basePath().$file) . "|" . filesize(self::basePath().$file) . "/";
        };
        $sha1name = sha1($name) . "." . $ext;
        if(file_exists($min_cachePath) AND is_writable($min_cachePath)){
            $filepath = realpath(".") . "/" . $min_cachePath . "/" . $sha1name;
            if (!file_exists($filepath)){
                $content = file_get_contents(http_url::getUrl().$minDir.'?f=' . implode(",", $filesCollection));
                file_put_contents($filepath, $content);
            }
            return $callback."/" . $min_cachePath . "/" . $sha1name;
        }else{
            throw new Exception("Error ".$min_cachePath." is not writable");
        }
    }
}