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
 * MAGIX CMS
 * @category   config 
 * @package    backend
 * @copyright  MAGIX CMS Copyright (c) 2013 Gerits Aurelien,
 * http://www.magix-cms.com, http://www.magix-cjquery.com
 * @license    Dual licensed under the MIT or GPL Version 3 licenses.
 * @version    2.0
 * Update : 18/03/2013
 * Configuration / extends smarty with class
 * @author Gérits Aurélien <aurelien@magix-cms.com> <aurelien@magix-dev.be>
 * @name smarty
 *
 */
/**
 * Extend class smarty
 *
 */
class backend_model_smarty extends component_core_smarty {
	/**
	 * backend_model_smarty constructor.
	 */
	public function __construct($t = null){
	    $this->template = $t;
		/**
		 * include parent component_core_smarty
		 */
		parent::__construct(); 
		//self::setParams();
	}

    public function setPath(){
		return parent::setPath().PATHADMIN.DIRECTORY_SEPARATOR;
	}

	/**
	 * Les paramètres pour la configuration de smarty 3
	 */
	protected function setParams(){
        /**
         * Path -> compile
         */
        $this->setCompileDir(
            $this->setPath().'/caching/templates_c/'
        );

        /**
         * caching (true/false)
         */
        $this->setCaching(false);

        /**
         * cache_dir -> cache
         */
        $this->setCacheDir($this->setPath().'/caching/tpl_caches/');

	    parent::setParams();
	}

	/**
	 * @return backend_model_smarty|component_core_smarty
	 */
	public static function getInstance(){
        if (!isset(self::$instance))
      {
         self::$instance = new backend_model_smarty();
      }
    	return self::$instance;
    }
}