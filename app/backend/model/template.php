<?php
/*
 # -- BEGIN LICENSE BLOCK ----------------------------------
 #
 # This file is part of MAGIX CMS.
 # MAGIX CMS, The content management system optimized for users
 # Copyright (C) 2008 - 2019 magix-cms.com <support@magix-cms.com>
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
 #
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 # -- END LICENSE BLOCK -----------------------------------
 #
 # DISCLAIMER
 #
 # Do not edit or add to this file if you wish to upgrade MAGIX CMS to newer
 # versions in the future. If you wish to customize MAGIX CMS for your
 # needs please refer to http://www.magix-cms.com for more information.
 */
/**
 * MAGIX CMS
 * @category MODEL
 * @package backend
 * @name backend_model_template
 * @copyright  MAGIX CMS Copyright (c) 2010 Gerits Aurelien, 
 * http://www.magix-cms.com, http://www.magix-cjquery.com
 * @license Dual licensed under the MIT or GPL Version 3 licenses.
 * @version 1.0
 * @author Gérits Aurélien <aurelien@magix-cms.com> | <gerits.aurelien@gmail.com>
 * @contributor Salvatore Di Salvo <disalvo.infographiste@gmail.com>
 *
 */
class backend_model_template extends component_core_template {
    /**
     * backend_model_template constructor.
     */
    public function __construct(){
        parent::__construct();
        $this->smarty = new backend_model_smarty($this);
        $this->assign('releaseData',$this->getReleaseData());
        $this->assign('adminlangs',$this->langs);
    }

    /**
     * Get the available languages
     * @return array
     */
    public function langsAvailable()
    {
        return array(
            'fr' => 'français',
            'en' => 'english'
        );
    }

	/**
	 * Retourne la langue en cours de session sinon retourne fr par défaut
     * @param string $index
	 * @return string
	 * @access public 
	 * @static
	 */
	public function currentLanguage($index){
	    parent::currentLanguage($index);

        $this->lang = $_COOKIE[$index] ? $_COOKIE[$index] : $this->lang;

        $this->defaultLang = $this->lang;
        return $this->lang;
	}

	/**
	 * Charge le theme selectionné ou le theme par défaut
	 */
	public function loadTheme(){
	    $theme = http_request::isSession('theme') ? $_SESSION['theme'] : 'modern';
        if($theme === null || !file_exists(component_core_system::basePath().PATHADMIN.DIRECTORY_SEPARATOR.'skin/'.$theme.'/')) {
            try {
                throw new Exception('template ' . $theme . ' is not found');
            } catch (Exception $e) {
                $this->logger->log('php', 'error', 'An error has occured : ' . $e->getMessage(), debug_logger::LOG_MONTH);
            }
        }

        return $theme;
	}

    /**
     * @param $template_dir
     */
    public function addTemplateDir($template_dir){
        $this->smarty->addTemplateDir($template_dir);
    }

    /**
     * @access public
     * Affiche le template
     * @param string|object $template
     * @param mixed $cache_id
     * @param mixed $compile_id
     * @param object $parent
     */
    public function display($template = null, $cache_id = null, $compile_id = null, $parent = null){
        parent::display($template, $cache_id, $compile_id, $parent);
    }

    /**
     * @access public
     * Retourne le template
     * @param string|object $template
     * @param mixed $cache_id
     * @param mixed $compile_id
     * @param object $parent
     * @param bool   $display           true: display, false: fetch
     * @param bool   $merge_tpl_vars    if true parent template variables merged in to local scope
     * @param bool   $no_output_filter  if true do not run output filter
     * @return string rendered template output
     */
    public function fetch($template = null, $cache_id = null, $compile_id = null, $parent = null, $display = false, $merge_tpl_vars = true, $no_output_filter = false){
        return parent::fetch($template, $cache_id, $compile_id, $parent);
    }
}