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

class component_core_language {
    /**
     * lang setting conf
     * @var backend_model_template|frontend_model_template $template
     */
    protected $template,
		$setLanguage,
        $getLanguage,
        $setParams = 'lang';

	/**
	 * component_core_language constructor.
	 * @param $setParams
	 */
	public function __construct($t,$setParams){
		$this->template = $t;
        if(!empty($setParams)){
            $this->setParams = $setParams;
        }
	}

    /**
     *
     */
    private function initLang(){
        $this->template->currentLanguage($this->setParams);
        $this->setTimeLocal();
	}

    /**
     * Change setlocale based on the curent language
     * Use for the format of the dates
     */
    private function setTimeLocal(){
        $locale = 'en_US.UTF8';
        $iso = 'en';

        switch ($this->template->lang) {
            case 'nl':
                $locale = 'nl_NL.UTF8'; $iso = 'nl';
                break;
            case 'fr' :
            case 'fr-ca':
                $locale = 'fr_FR.UTF8'; $iso = 'fra';
                break;
            case 'de':
                $locale = 'de_DE.UTF8'; $iso = 'de';
                break;
            case 'es':
                $locale = 'es_ES.UTF8'; $iso = 'es';
                break;
            case 'it':
                $locale = 'it_IT.UTF8'; $iso = 'it';
                break;
            default:
                continue;
        }

        setlocale(LC_TIME, $locale, $iso);
    }

    /**
     * Initialisation de la création du paramètre de session de la langue
     */
    public function run(){
        $this->initLang();
	}
}