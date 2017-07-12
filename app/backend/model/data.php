<?php
class backend_model_data extends backend_db_scheme{
	protected $template, $db, $caller;
	public $search;

	/**
	 * backend_model_data constructor.
	 * @param object $caller - object class of the class that called the model
	 */
	public function __construct($caller)
	{
		$this->db = (new ReflectionClass(get_parent_class($caller)))->newInstance();
		$this->template = new backend_model_template();
		$formClean = new form_inputEscape();

		// --- Search
		if (http_request::isGet('search')) {
			$this->search = $formClean->arrayClean($_GET['search']);
		}
	}

	/**
	 * Retrieve data
	 * @param string $context
	 * @param string $type
	 * @param string|int|null $id
	 * @return mixed
	 */
	private function setItems(&$context, $type, $id = null) {
		if($id) {
			if(is_array($id)) {
				$params = $id;
			}
			else {
				$params = array(':id' => $id);
			}
			$context = $context ? $context : 'unique';
		} else {
			$params = null;
			$context = $context ? $context : 'all';
		}
		return $this->db->fetchData(array('context'=>$context,'type'=>$type,'search'=>$this->search),$params);
	}

	/**
	 * Assign data to the defined variable or return the data
	 * @param string $context
	 * @param string $type
	 * @param string|int|null $id
	 * @return mixed
	 */
	public function getItems($type, $id = null, $context = null) {
		$data = $this->setItems($context, $type, $id);
		switch ($context) {
			case 'return':
			case 'last':
				return $data;
				break;
			default:
				$varName = $type;
				$this->template->assign($varName,$data);
		}
	}

	/**
	 * @param array $sch
	 * @return array
	 */
	public function parseScheme($sch, $cols)
	{
		$arr = array();
		$scheme = array();
		foreach ($sch as $col) {
			$arr[$col['column']] = $col['type'];
		}
		$sch = $arr;

		foreach ($cols as $col) {
			$type = $sch[$col];
			$pre = strstr($col, '_', true);

			$column = array(
				'type' => 'text',
				'class' => '',
				'title' => $pre,
				'input' => array(
					'type' => 'text'
				)/*,
				'info' => $col*/
			);

			if (strpos($type, 'int') !== false) {
				$sl = strpos($type,'(') + 1;
				$el = strpos($type,')');
				$limit = substr($type, $sl, ($el - $sl));

				if($limit > 1) {
					$column['type'] =  'text';
					$column['class'] =  'fixed-td-md text-center';

					if(preg_match('/^id/i', $type)) {
						$scheme[$col]['title'] = 'id';
					}
				}
				else {
					$column['type'] = 'bin';
					$column['enum'] = 'bin_';
					$column['class'] = 'fixed-td-md text-center';
					$column['input'] = array(
						'type' => 'select',
						'var' => true,
						'values' => array(
							array('v' => 0),
							array('v' => 1)
						)
					);
				}

			}
			else if(preg_match('/^varchar/i', $type)) {
				$sl = strpos($type,'(') + 1;
				$el = strpos($type,')');
				$limit = substr($type, $sl, ($el - $sl));

				if($limit <= 100) {
					$column['class'] =  'th-25';
				}
				else {
					$column['class'] =  'th-35';
				}
			}
			else if(preg_match('/^text/i', $type)) {
				$column['type'] =  'content';
				$column['input'] = null;
			}
			else if(preg_match('/^datetime/i', $type)
			|| preg_match('/^timestamp/i', $type)) {
				$column['class'] =  'th-25';
				$column['type'] =  'date';

				if(preg_match('/^date/i', $pre)) {
					$column['input'] =  array('type' => 'text', 'class' => 'date-input');
				}
				else if(preg_match('/^time/i', $pre)){
					$column['input'] =  array('type' => 'text', 'class' => 'time-input');
				}
			}

			$scheme[$col] = $column;
		}

		return $scheme;
	}

	/**
	 * Get Columns types
	 * @param array $tables
	 * @param array $columns
	 */
	public function getScheme($tables, $columns)
	{
		$tables = "'".implode("','", $tables)."'";
		$cols = "'".implode("','", $columns)."'";
		$params = array(':dbname' => MP_DBNAME, 'table' => $tables, 'columns' => $cols);
		$scheme = parent::fetchData(array('context'=>'all','type'=>'scheme'),$params);
		$this->template->assign('scheme',$this->parseScheme($scheme, $columns));
	}
}
?>