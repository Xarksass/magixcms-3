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
 * @category   DB CLass 
 * @package    Magix CMS
 * @copyright  MAGIX CMS Copyright (c) 2010 Gerits Aurelien, 
 * http://www.magix-cms.com, http://www.magix-cjquery.com
 * @license    Dual licensed under the MIT or GPL Version 3 licenses.
 * @version    1.2.0
 * @author Gérits Aurélien <aurelien@magix-cms.com> <aurelien@magix-dev.be>
 *
 */
class backend_db_theme{
    /**
     * @param $config
     * @param bool $data
     * @return mixed
     * @throws Exception
     */
    public function fetchData($config,$data = false){
        $sql = '';
        $params = false;

        if(is_array($config)) {
            if($config['context'] === 'all') {
				if ($config['type'] === 'links') {
					$sql = "SELECT 
								m.id_link as id_link, 
								m.type_link as type_link, 
								m.mode_link as mode_link, 
								mc.id_lang, 
								COALESCE(mc.name_link, pc.name_pages, apc.name_pages, cc.name_cat) as name_link, 
								mc.title_link as title_link,
								COALESCE(mc.url_link, pc.url_pages, apc.url_pages, cc.url_cat) as url_link,
								COALESCE(pc.published_pages, apc.published_pages, cc.published_cat, 1) as active_link
							FROM mc_menu as m
							LEFT JOIN mc_menu_content as mc ON m.id_link = mc.id_link
							LEFT JOIN mc_lang as l ON mc.id_lang = l.id_lang
							LEFT JOIN mc_cms_page as p ON m.id_page = p.id_pages AND m.type_link = 'pages'
							LEFT JOIN mc_cms_page_content as pc ON p.id_pages = pc.id_pages AND pc.id_lang = l.id_lang
							LEFT JOIN mc_about_page as ap ON m.id_page = ap.id_pages AND m.type_link = 'about_page'
							LEFT JOIN mc_about_page_content as apc ON ap.id_pages = apc.id_pages AND apc.id_lang = l.id_lang
							LEFT JOIN mc_catalog_cat as c ON m.id_page = c.id_cat AND m.type_link = 'category'
							LEFT JOIN mc_catalog_cat_content as cc ON c.id_cat = cc.id_cat AND cc.id_lang = l.id_lang
							ORDER BY m.order_link ASC";
				}
				elseif ($config['type'] === 'link') {
					//Return current skin
					$sql = "SELECT 
								m.id_link as id_link, 
								m.type_link as type_link, 
								m.mode_link as mode_link, 
								mc.id_lang, 
								COALESCE(mc.name_link, pc.name_pages, apc.name_pages, cc.name_cat) as name_link, 
								mc.title_link as title_link,
								COALESCE(mc.url_link, pc.url_pages, apc.url_pages, cc.url_cat) as url_link,
								COALESCE(pc.published_pages, apc.published_pages, cc.published_cat, 1) as active_link
							FROM mc_menu as m
							LEFT JOIN mc_menu_content as mc ON m.id_link = mc.id_link
							LEFT JOIN mc_lang as l ON mc.id_lang = l.id_lang
							LEFT JOIN mc_cms_page as p ON m.id_page = p.id_pages AND m.type_link = 'pages'
							LEFT JOIN mc_cms_page_content as pc ON p.id_pages = pc.id_pages AND pc.id_lang = l.id_lang
							LEFT JOIN mc_about_page as ap ON m.id_page = ap.id_pages AND m.type_link = 'about_page'
							LEFT JOIN mc_about_page_content as apc ON ap.id_pages = apc.id_pages AND apc.id_lang = l.id_lang
							LEFT JOIN mc_catalog_cat as c ON m.id_page = c.id_cat AND m.type_link = 'category'
							LEFT JOIN mc_catalog_cat_content as cc ON c.id_cat = cc.id_cat AND cc.id_lang = l.id_lang
							WHERE m.id_link = :id";
					$params = $data;
				}
				elseif ($config['type'] === 'pages') {
					$sql = 'SELECT * FROM (
							SELECT p.id_pages AS id, p.id_parent AS parent, pc.name_pages AS name
							FROM mc_cms_page AS p
							LEFT JOIN mc_cms_page_content AS pc
							USING ( id_pages ) 
							LEFT JOIN mc_lang AS l ON pc.id_lang = l.id_lang
							WHERE p.menu_pages =1
							AND pc.published_pages =1
							ORDER BY p.id_pages ASC , l.default_lang ASC
							) as pt
							GROUP BY pt.id';
					// $params = $data;
				}
				elseif ($config['type'] === 'about_page') {
					$sql = 'SELECT * FROM (
							SELECT p.id_pages as id, p.id_parent as parent, pc.name_pages as name
							FROM mc_about_page as p
							LEFT JOIN mc_about_page_content as pc
							USING(id_pages)
							LEFT JOIN mc_lang AS l ON pc.id_lang = l.id_lang
							WHERE p.menu_pages =1
							AND pc.published_pages =1
							ORDER BY p.id_pages ASC , l.default_lang ASC
							) as pt
							GROUP BY pt.id';
					// $params = $data;
				}
				elseif ($config['type'] === 'category') {
					$sql = 'SELECT * FROM (
							SELECT p.id_cat as id, p.id_parent as parent, pc.name_cat as name
							FROM mc_catalog_cat as p
							LEFT JOIN mc_catalog_cat_content as pc
							USING(id_cat)
							LEFT JOIN mc_lang AS l ON pc.id_lang = l.id_lang
							WHERE pc.published_cat =1
							ORDER BY p.id_cat ASC , l.default_lang ASC
							) as pt
							GROUP BY pt.id';
					// $params = $data;
				}

				return $sql ? component_routing_db::layer()->fetchAll($sql,$params) : null;
            }
            elseif($config['context'] === 'one') {
                if ($config['type'] === 'skin') {
                    //Return current skin
                    $sql = 'SELECT * FROM mc_setting WHERE name = "theme"';
                }
                elseif ($config['type'] === 'newLink') {
					//Return current skin
					$sql = 'SELECT id_link FROM mc_menu ORDER BY id_link DESC LIMIT 0,1';
				}
				elseif ($config['type'] === 'pages') {
					$sql = 'SELECT p.id_pages as id, pc.name_pages as name, pc.url_pages as url
							FROM mc_cms_page as p
							LEFT JOIN mc_cms_page_content as pc
							USING(id_pages)
							WHERE id_lang = :id_lang
							AND id_pages = :id
							AND pc.published_pages = 1';
					$params = $data;
				}
				elseif ($config['type'] === 'about_page') {
					$sql = 'SELECT p.id_pages as id, pc.name_pages as name, pc.url_pages as url
							FROM mc_about_page as p
							LEFT JOIN mc_about_page_content as pc
							USING(id_pages)
							WHERE id_lang = :id_lang
							AND id_pages = :id
							AND pc.published_pages = 1';
					$params = $data;
				}
				elseif ($config['type'] === 'category') {
					$sql = 'SELECT p.id_cat as id, pc.name_cat as name, pc.url_cat as url
							FROM mc_catalog_cat as p
							LEFT JOIN mc_catalog_cat_content as pc
							USING(id_cat)
							WHERE id_lang = :id_lang
							AND id_cat = :id
							AND pc.published_cat = 1';
					$params = $data;
				}

                return $sql ? component_routing_db::layer()->fetch($sql,$params) : null;
            }
        }
    }

	/**
	 * @param $config
	 * @param bool $data
	 */
	public function insert($config,$data = false)
	{
		if (is_array($config)) {
			$sql = '';
			$params = $data;

			if ($config['type'] === 'link') {
				$sql = "INSERT INTO `mc_menu`(type_link, id_page, order_link)  
						SELECT :type, :id_page, (MAX(order_link) + 1) FROM mc_menu";
			}
			elseif ($config['type'] === 'link_content') {
				$sql = 'INSERT INTO `mc_menu_content`(id_link,id_lang,name_link,url_link) 
						VALUES (:id,:id_lang,:name_link,:url_link)';
			}

			if($sql && $params) component_routing_db::layer()->insert($sql,$params);
		}
	}

    /**
     * @param $config
     * @param bool $data
     */
    public function update($config,$data = false)
    {
        if (is_array($config)) {
			$sql = '';
			$params = $data;

            if ($config['type'] === 'theme') {
                $sql = "UPDATE mc_setting SET value = :theme WHERE name = 'theme'";
            }
			elseif ($config['type'] === 'link') {
				$sql = 'UPDATE mc_menu 
						SET mode_link = :mode_link
						WHERE id_link = :id';
			}
			elseif ($config['type'] === 'link_content') {
				$sql = 'UPDATE mc_menu_content 
						SET 
							name_link = :name_link,
							title_link = :title_link
						WHERE id_link = :id
						AND id_lang = :id_lang';
			}
			elseif ($config['type'] === 'order') {
				$sql = 'UPDATE mc_menu 
						SET order_link = :order_link
						WHERE id_link = :id';
			}

			if($sql && $params) component_routing_db::layer()->update($sql,$params);
        }
    }

	/**
	 * @param $config
	 * @param bool $data
	 */
	public function delete($config,$data = false)
	{
		if (is_array($config)) {
			$sql = '';

			if($config['type'] === 'link'){
				$sql = 'DELETE FROM mc_menu 
						WHERE id_link IN ('.$data['id'].')';
			}

			if($sql) component_routing_db::layer()->delete($sql,array());
		}
	}
}