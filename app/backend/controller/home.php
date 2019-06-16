<?php
class backend_controller_home extends backend_db_home{

    public $edit, $action, $tabs;
    protected $controller, $message, $template, $header, $data, $modelLanguage, $modelPlugins, $plugin;
    public $content, $id_page;

	/**
	 * backend_controller_home constructor.
	 * @param backend_controller_template $t
	 */
    public function __construct($t = null)
    {
        $this->template = $t ? $t : new backend_model_template;
        $this->message = new component_core_message($this->template);
        $this->header = new http_header();
        $this->data = new backend_model_data($this, $this->template);
        $formClean = new form_inputEscape();
        $this->modelLanguage = new backend_model_language($this->template);
        $this->modelPlugins = new backend_model_plugins();

        // --- GET
        if(http_request::isGet('controller')) {
            $this->controller = $formClean->simpleClean($_GET['controller']);
        }
        if (http_request::isGet('edit')) {
            $this->edit = $formClean->numeric($_GET['edit']);
        }
        if (http_request::isGet('action')) {
            $this->action = $formClean->simpleClean($_GET['action']);
        } elseif (http_request::isPost('action')) {
            $this->action = $formClean->simpleClean($_POST['action']);
        }
        if (http_request::isGet('tabs')) {
            $this->tabs = $formClean->simpleClean($_GET['tabs']);
        }
        if (http_request::isPost('content')) $this->content = (array)$formClean->arrayClean($_POST['content']);
        if (http_request::isPost('id')) {
            $this->id_page = $formClean->numeric($_POST['id']);
        }

        if(http_request::isGet('plugin')){
            $this->plugin = $formClean->simpleClean($_GET['plugin']);
        }
    }

	/**
	 * Assign data to the defined variable or return the data
	 * @param string $type
	 * @param string|int|null $id
	 * @param string $context
	 * @param boolean $assign
	 * @return mixed
	 */
	private function getItems($type, $id = null, $context = null, $assign = true) {
		return $this->data->getItems($type, $id, $context, $assign);
	}

    /**
     * @return array
     */
    private function setItemsData($id){
        $data = $this->getItems('pages',null,'all',false);
        $arr = array();
        foreach ($data as $page) {
            if($page['id_page'] === $id) {
                if (!array_key_exists($id, $arr)) {
                    $arr[$id] = array();
                    $arr[$id]['id_page'] = $page['id_page'];
                    $arr[$id]['date_register'] = $page['date_register'];
                }
                $arr[$id]['content'][$page['id_lang']] = array(
                    'id_lang' => $page['id_lang'],
                    'title_page' => $page['title_page'],
                    'content_page' => $page['content_page'],
                    'seo_title_page' => $page['seo_title_page'],
                    'seo_desc_page' => $page['seo_desc_page'],
                    'published' => $page['published']
                );
            }
        }
        return $arr[$id];
    }

    /**
     * Update data
     * @param $data
     */
    private function add($data)
    {
        switch ($data['type']) {
            case 'home':
                parent::insert(array('type' => $data['type']));
                break;
            case 'content':
                parent::insert(
                    array(
                        'type' => $data['type']
                    ),
                    $data['data']
                );
                break;
        }
    }

    /**
     * Mise a jour des données
     * @param $data
     */
    private function upd($data)
    {
        switch ($data['type']) {
            case 'content':
                parent::update(
                    array(
                        'context' => $data['context'],
                        'type' => $data['type']
                    ),
                    $data['data']
                );
                break;
        }
    }

    public function run(){
        // Initialise l'API menu des plugins core
        $this->modelPlugins->getItems(
            array(
                'type'      =>  'tabs',
                'controller'=>  $this->controller
            )
        );

        if(isset($this->plugin)){
            // Execute un plugin core
            $this->modelPlugins->getCoreItem();
        }else{
            if(isset($this->action)) {
                switch ($this->action) {
                    case 'edit':
                        if(!$this->id_page) {
                            $this->add(array('type' => 'home'));
                            $home = $this->getItems('root',null,'one',false);
                            $this->id_page = $home['id_page'];
                        }

                        if($this->id_page) {
                            foreach ($this->content as $lang => $content) {
                                $content['id_page'] = $this->id_page;
                                $content['id_lang'] = $lang;
                                $content['published'] = (!isset($content['published']) ? 0 : 1);
                                $config = array(
                                    'type' => 'content',
                                    'data' => $content
                                );

                                $contentLang = $this->getItems('content',array('id_page' => $this->id_page, 'id_lang' => $lang),'one',false);

                                if (!$contentLang)
                                    $this->add($config);
                                else
                                    $this->upd($config);
                            }
                            $this->message->json_post_response(true, 'update', $this->id_page);
                        }
                        break;
                }
            }
            else {
                $this->modelLanguage->getLanguage();
                $home = $this->getItems('root',null,'one',false);
                $this->template->assign('page',$this->setItemsData($home['id_page']));
                $this->template->display('home/edit.tpl');
            }
        }
    }

}