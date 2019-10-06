<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *	@author 	: Nicodemus Karisa
 *	@date		: 27th September, 2018
 *	Finance management system for NGOs
 *	https://techsysnow.com
 *	NKarisa@ke.ci.org
 */

class Grants_model extends CI_Model
{

  function __construct(){
    parent::__construct();
    $this->load->database();

  }

  function index(){

  }

  function list_query($table,$lookup_tables){
    $table_columns = $this->grants->table_columns($table,$this->grants_model->set_hidden_columns());
    $this->db->select($table_columns);

    foreach ($lookup_tables as $lookup_table) {
        $lookup_table_id = $lookup_table.'_id';
        $this->db->join($lookup_table,$lookup_table.'.'.$lookup_table_id.'='.$table.'.fk_'.$lookup_table_id);
    }
    return $this->db->get('approval')->result_array();
  }

  function set_hidden_columns(){
    $controller = $this->uri->segment(1,0);
    $this->hidden_columns = array($controller.'_last_modified_date',$controller.'_created_date',
    $controller.'_last_modified_by',$controller.'_created_by');

    return $this->hidden_columns;
  }

  function get_all_table_fields($table = 'approval'){
    return $this->db->list_fields($table);

  }

}
