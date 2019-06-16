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
 * @category COMPONENT
 * @package core
 * @name component_core_template
 * @version 1.0
 * @copyright MAGIX CMS Copyright (c) 2010 Gerits Aurelien,
 * @website http://www.magix-cms.com
 * @license Dual licensed under the MIT or GPL Version 3 licenses.
 * @author Gérits Aurélien <aurelien@magix-cms.com> | <gerits.aurelien@gmail.com>
 * @contributor Salvatore Di Salvo <disalvo.infographiste@gmail.com>
 * @description template class used as based for frontend and backen template model
 *
 */
class component_core_template {
    /**
     * Constante pour le chemin vers le dossier de configuration des langues statiques pour le contenu
     * @access private
     * @var string
     */
    private $ConfigFile;

    /**
     * @access protected
     */
    protected
        $smarty,
        $collectionsSetting,
        $DBDomain,
        $settings,
        $ssl;

    /**
     * @access public
     */
    public
        $logger,
        $theme,
        $defaultLang,
        $lang = 'fr',
        $langs,
        $user_langs,
        $domain,
        $cLangs,
        $defaultDomain,
        $indexLang;

    /**
     * component_core_template constructor.
     */
    public function __construct(){
        $this->logger = new debug_logger(MP_LOG_DIR);
        $this->ConfigFile = 'local_';
        $this->collectionsSetting = new component_collections_setting();
        $this->settings = $this->collectionsSetting->getSetting();
        $this->DBDomain = new component_collections_domain();
        $this->domain = isset($_SERVER['HTTP_HOST']) ? $this->DBDomain->fetchData(array('context'=>'one','type'=>'currentDomain'),array('url'=>$_SERVER['HTTP_HOST'])) : null;
        $this->ssl = $this->settings['ssl'];
        $this->defaultDomain = $this->setDefaultDomain();
        $this->langs = $this->langsAvailable();
        $this->theme = $this->loadTheme();
    }

    /**
     * @return array
     */
    public function getReleaseData()
    {
        $basePath = component_core_system::basePath().DIRECTORY_SEPARATOR;
        $XMLFiles = $basePath . 'release.xml';
        if (file_exists($XMLFiles)) {
            try {
                if ($stream = fopen($XMLFiles, 'r')) {
                    $streamData = stream_get_contents($stream, -1, 0);
                    $streamData = urldecode($streamData);
                    $xml = simplexml_load_string($streamData, null, LIBXML_NOCDATA);
                    $newData = array();
                    foreach ($xml->children() as $item => $value) {
                        $newData[$item] = $value->__toString();
                    }
                    fclose($stream);
                    return $newData;
                }
            } catch (Exception $e) {
                $this->logger->log('php', 'error', 'An error has occured : ' . $e->getMessage(), debug_logger::LOG_MONTH);
            }
        }
        return array();
    }

    /**
     * @return mixed
     * @throws Exception
     */
    public function setDefaultDomain(){
        $data = $this->DBDomain->fetchData(array('context' => 'one', 'type' => 'defaultDomain'));
        return $data['url_domain'];
    }

    /**
     * Get the available languages
     */
    public function langsAvailable(){}

    /**
     * @param string $index
     * @return string
     * @access public
     * @static
     */
    public function currentLanguage($index){
        $this->indexLang = $index;
        $this->user_langs = explode(",",$_SERVER['HTTP_ACCEPT_LANGUAGE']);

        foreach($this->user_langs as $ul) {
            $iso = strtolower(substr(chop($ul),0,2));

            if(array_key_exists($iso, $this->langs)) {
                $this->lang = $iso;
                break;
            }
        }

        $this->lang = http_request::isSession($index) ? $_SESSION[$index] : $this->lang;
    }

    /**
     * @access protected
     * return void
     * Le chemin du dossier des plugins
     */
    public function pluginsBasePath(){
        return component_core_system::basePath().DIRECTORY_SEPARATOR.'plugins'.DIRECTORY_SEPARATOR;;
    }

    /**
     * Chargement du fichier de configuration suivant la langue en cours de session.
     * @access protected
     * @param (string) $configfile
     * @return string|void
     */
    protected function pathConfigLoad($configfile){
        try {
            return $configfile.$this->lang.'.conf';
        }catch(Exception $e) {
            $this->logger->log('php', 'error', 'An error has occured : '.$e->getMessage(), debug_logger::LOG_MONTH);
        }
    }

    /**
     *
     * Initialise la fonction configLoad de smarty
     * @param string $section
     */
    public function configLoad($section = ''){
        try {
            $this->smarty->configLoad($this->pathConfigLoad($this->ConfigFile), $section);
            if (file_exists($this->smarty->setPath().'skin/'.$this->theme.'/i18n/')) {
                $this->smarty->configLoad($this->pathConfigLoad('theme_'));
            }
        }catch(Exception $e) {
            $this->logger->log('php', 'error', 'An error has occured : '.$e->getMessage(), debug_logger::LOG_MONTH);
        }
    }

    /**
     * Charge le theme selectionné ou le theme par défaut
     */
    public function loadTheme(){}

    /**
     * Chargement des widgets additionnel du template courant
     * @param void $smarty
     * @param void $rootpath
     * @param bool $debug
     * @throws Exception
     * @return void
     */
    public function addWidgetDir($smarty, $rootpath, $debug=false){
        $add_widget_dir = $rootpath."skin/".$this->theme.'/widget/';
        if(file_exists($add_widget_dir)){
            if(is_dir($add_widget_dir)){
                $smarty->addPluginsDir(array($add_widget_dir));
            }
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
        if(!$this->isCached($template, $cache_id, $compile_id, $parent)){
            $this->smarty->display($template, $cache_id, $compile_id, $parent);
        }
        else{
            $this->smarty->display($template, $cache_id, $compile_id, $parent);
        }
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
        if(!$this->isCached($template, $cache_id, $compile_id, $parent)){
            return $this->smarty->fetch($template, $cache_id, $compile_id, $parent, $display, $merge_tpl_vars, $no_output_filter);
        }else{
            return $this->smarty->fetch($template, $cache_id, $compile_id, $parent, $display, $merge_tpl_vars, $no_output_filter);
        }
    }

    /**
     * @access public
     * Assign les variables dans les fichiers phtml
     * @param string|array $tpl_var
     * @param string $value
     * @param bool $nocache
     * @return void
     */
    public function assign($tpl_var, $value = null, $nocache = false){
        try {
            if (is_array($tpl_var)) {
                $this->smarty->assign($tpl_var);
            }
            else {
                if($tpl_var) {
                    $this->smarty->assign($tpl_var,$value,$nocache);
                }
                else {
                    throw new Exception('Unable to assign a variable in template');
                }
            }
        } catch(Exception $e) {
            $this->logger->log('php', 'error', 'An error has occured : '.$e->getMessage(), debug_logger::LOG_MONTH);
        }
    }

    /**
     * Test si le cache est valide
     * @param string|object $template
     * @param mixed $cache_id
     * @param mixed $compile_id
     * @param object $parent
     */
    public function isCached($template = null, $cache_id = null, $compile_id = null, $parent = null){
        $this->smarty->isCached($template, $cache_id, $compile_id, $parent);
    }

    /**
     * Charge les variables du fichier de configuration dans le site
     * @param string $varname
     * @param bool $search_parents
     * @return string
     */
    public function getConfigVars($varname = null, $search_parents = true){
        return $this->smarty->getConfigVars($varname, $search_parents);
    }

    /**
     * Returns a single or all template variables
     *
     * @param  string  $varname        variable name or null
     * @param  string  $_ptr           optional pointer to data object
     * @param  boolean $search_parents include parent templates?
     * @return string  variable value or or array of variables
     */
    public function getTemplateVars($varname = null, $_ptr = null, $search_parents = true){
        return $this->smarty->getTemplateVars($varname, $_ptr, $search_parents);
    }

    /**
     * Get config directory
     *
     * @param mixed index of directory to get, null to get all
     * @return array|string configuration directory
     */
    public function getConfigDir($index=null){
        return $this->smarty->getConfigDir($index);
    }

    /**
     * @return array
     */
    public function setDefaultConfigDir(){
        return $this->getConfigDir();
    }

    /**
     * Ajoute un ou plusieurs dossier de configuration et charge les fichiers associés ainsi que les variables
     * @access public
     * @param array $addConfigDir
     * @param array $load_files
     * @param bool $debug
     * @throws Exception
     */
    public function addConfigFile(array $addConfigDir,array $load_files,$debug=false){
        if(is_array($addConfigDir)){
            $setDefaultConfigDir = $this->setDefaultConfigDir();
            $this->smarty->setConfigDir(array_merge($setDefaultConfigDir,$addConfigDir));
        }
        else{
            throw new Exception('Error: addConfigDir is not array');
        }

        if(is_array($load_files)){
            foreach ($load_files as $row=>$val){
                if(is_string($row)){
                    if(array_key_exists($row, $load_files)){
                        $this->smarty->configLoad($row.$this->currentLanguage().'.conf',$val);
                    }
                }else{
                    $this->smarty->configLoad($load_files[$row].$this->currentLanguage().'.conf');
                }
            }
        }else{
            throw new Exception('Error: load_files is not array');
        }
        if($debug!=false){
            $config_dir = $this->getConfigDir();
            print '<pre>';
            var_dump($config_dir);
            print '</pre>';
            print '<pre>';
            print_r($load_files);
            print '</pre>';
            print '<pre>';
            print $this->getConfigVars();
            print '</pre>';
        }
    }
}