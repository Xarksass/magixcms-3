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
 * @package frontend
 * @name frontend_model_template
 * @copyright  MAGIX CMS Copyright (c) 2010 Gerits Aurelien,
 * http://www.magix-cms.com, http://www.magix-cjquery.com
 * @license Dual licensed under the MIT or GPL Version 3 licenses.
 * @version 1.0
 * @author Gérits Aurélien <aurelien@magix-cms.com> | <gerits.aurelien@gmail.com>
 * @contributor Salvatore Di Salvo <disalvo.infographiste@gmail.com>
 *
 */
class frontend_model_template extends component_core_template {
    /**
     * @var bool
     */
	protected $amp;

    /**
     * @var component_collections_setting
     */
    public $cLangs;

    /**
     * frontend_model_template constructor.
     */
    public function __construct(){
        $this->cLangs = new component_collections_language();
        parent::__construct();
        $this->smarty = new frontend_model_smarty($this);
		$this->amp = (http_request::isGet('amp') && (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') && $this->ssl['value'])? true : false;
	}

	/**
	 * Get the available languages
     * @return array
	 */
	public function langsAvailable()
	{
		$langs = null;
		if($this->domain != null) {
			$data = $this->DBDomain->fetchData(array('context' => 'all', 'type' => 'languages'), array('id' => $this->domain['id_domain']));
			if($data != null) $langs = $data;
		}
		if(!$langs) $langs = $this->cLangs->fetchData(array('context'=>'all','type'=>'active'));

		$arr = array();
		foreach ($langs as $lang) {
			$arr[$lang['iso_lang']] = $lang;
		}
		return $arr;
    }

    /**
     * Return the default language
     * @return string|null
     */
    public function setDefaultLanguage(){
    	$lang = null;
        if($this->domain['id_domain'] != null) {
			$data = $this->DBDomain->fetchData(array('context' => 'one', 'type' => 'language'), array('id' => $this->domain['id_domain']));
			if($data != null) $lang = $data['iso_lang'];
		}

        if(!$lang) {
			$data = $this->cLangs->fetchData(array('context'=>'one','type'=>'default'));
			$lang = $data['iso_lang'];
		}
        return $lang;
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

        $defaultLang = $this->setDefaultLanguage();

        $this->lang = $defaultLang ? $defaultLang : $this->lang;
        $this->lang = http_request::isGet($index) ? $_GET[$index] : $this->lang;

        $this->defaultLang = $this->lang;
        return $this->lang;
	}

	/**
	 * Charge le theme selectionné ou le theme par défaut
	 */
	public function loadTheme(){
        $theme = 'default';
		$db = $this->collectionsSetting->fetchData(array('context' => 'one','type' => 'setting'),array('name' => 'theme'));

		if($db['value'] !== null && file_exists(component_core_system::basePath().'/skin/'.$db['value'].'/')) {
		    $theme = $db['value'];
        }
        else {
            try {
                throw new Exception('template ' . $db['value'] . ' is not found');
            } catch (Exception $e) {
                $logger = new debug_logger(MP_LOG_DIR);
                $logger->log('php', 'error', 'An error has occured : ' . $e->getMessage(), debug_logger::LOG_MONTH);
            }
        }

		return $theme;
	}

    /**
     * Chargement du type de cache
     * @param $smarty
     * @throws Exception
     * @return void
     */
    public function setCache($smarty){
        //$config = $this->collectionsSetting->fetch('cache');
        $config = $this->collectionsSetting->fetchData(array('context'=>'one','type'=>'setting'),array('name'=>'cache'));
        switch($config['value']){
            case 'none':
                $smarty->setCaching(false);
                break;
            case 'files':
                $smarty->setCaching(true);
                $smarty->setCachingType('file');
                break;
            case 'apc':
                $smarty->setCaching(true);
                $smarty->setCachingType('apc');
                break;
        }
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
    	if($this->amp) {
			$theme = $this->theme;
			if(file_exists(component_core_system::basePath().'/skin/'.$theme.'/amp/'.$template)){
				$template = 'amp/'.$template;
			}
		}

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
        if($this->amp) {
            $theme = $this->theme;
            if(file_exists(component_core_system::basePath().'/skin/'.$theme.'/amp/'.$template)){
                $template = 'amp/'.$template;
            }
        }

        return parent::fetch($template, $cache_id, $compile_id, $parent);
    }
}