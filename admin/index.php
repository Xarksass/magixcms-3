<?php
$baseadmin = 'baseadmin.php';
if(file_exists($baseadmin)){
    require $baseadmin;
    if(!defined('PATHADMIN')){
        throw new Exception('PATHADMIN is not defined');
    }
}
require('../lib/backend.inc.php');
$template = new backend_model_template();
$members = new backend_controller_login($template);
$language = new component_core_language($template,'strLangue');
$language->run();
$file_finder = new file_finder();
$controllerFinder = $file_finder->scanDir(component_core_system::basePath().DIRECTORY_SEPARATOR.'app'.DIRECTORY_SEPARATOR.'backend'.DIRECTORY_SEPARATOR.'controller');
$funcBasenameFinder = function($value) {
    return basename($value,'.php');
};
$controllerCollection = array_map($funcBasenameFinder,$controllerFinder);//array('dashboard','login','employee','access','language','country','domain','setting','files','testupload','about','home','pages','news','category','catalog','product','webservice','plugins');
$formClean = new form_inputEscape();
if((http_request::isGet('controller') && $_GET['controller'] !== 'login') || !http_request::isGet('controller')) {
    $members->checkout();
}
if(http_request::isGet('controller')) {
    $controller_name = $formClean->simpleClean($_GET['controller']);
    $routes = 'backend';
    $plugins = null;

    if (http_request::isSession('keyuniqid_admin')) {
        $members->getAdminProfile();

        if (!in_array($controller_name, $controllerCollection)) {
            $routes = 'plugins';
            $plugins = 'admin';

            if (http_request::isSession('keyuniqid_admin')) {
                $pluginsSetConfig = new backend_model_plugins();
                $pluginsSetConfig->addConfigDir($routes, $template);
                $pluginsSetConfig->templateDir($routes, $template, $plugins);
            }
        }
    }

    $dispatcher = new component_routing_dispatcher($routes, $template, $plugins);
    $dispatcher->dispatch();
}