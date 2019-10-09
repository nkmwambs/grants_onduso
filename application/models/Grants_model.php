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
  }

  function index(){

  }

  function list($lookup_tables,$table_name = "",$id = ""){
    // This $this->controller is a public parameter of the MY_Controller
    $table = $table_name == ""?strtolower($this->controller):$table_name;

    $this->select_columns($table);

    if(is_array($lookup_tables) && count($lookup_tables) > 0 ){
      foreach ($lookup_tables as $lookup_table) {
          $lookup_table_id = $lookup_table.'_id';
          $this->db->join($lookup_table,$lookup_table.'.'.$lookup_table_id.'='.$table.'.fk_'.$lookup_table_id);
      }
    }

    //Allow a list result with an id condition
    if($id !== ""){
      $this->db->where(array($table.'_id'=> hash_id($id,'decode') ));
    }

    return $this->db->get($table)->result_array();
  }

  function select_columns($table = "",$table_as_master = false){

    $table = $table == ""?$this->controller:$table;

    $table_columns = $this->grants->table_columns($table,$this->grants->table_hidden_columns($table));

    if($table_as_master){
      if(is_array($this->grants->table_visible_columns($table,true)) && count($this->grants->table_visible_columns($table,true)) > 0 ){
        $table_columns = $this->grants->table_visible_columns($table,true);
      }else{
        $table_columns = $this->grants->table_columns($table,$this->grants->table_hidden_columns($table,true));
      }
    }else{
      if(is_array($this->grants->table_visible_columns($table)) && count($this->grants->table_visible_columns($table)) > 0 ){
        $table_columns = $this->grants->table_visible_columns($table);
      }
    }


    $this->db->select($table_columns);
  }

  function view($detail_tables = array()){

    // This $this->controller is a public parameter of the MY_Controller
    $table = strtolower($this->controller);

    $model = $this->current_model;

    $data = array();

    $this->select_columns($table,true);

    $data['master'] = (array)$this->db->get_where($table,array($table.'_id'=> hash_id($this->uri->segment(3,0),'decode') ))->row();

    if(is_array($detail_tables) && count($detail_tables) > 0 ){
      foreach ($detail_tables as $detail_table) {
          //$this->select_columns($detail_table);
          $data['detail'][$detail_table]= $this->grants->list_result($detail_table,'list');//return second arg as list and resolve the error
      }
    }

    return $data;
  }

  function get_all_table_fields($table_name = ""){
    $table = $table_name == ""?$this->controller:$table_name;
    return $this->db->table_exists($table)?$this->db->list_fields($table):array();
  }

}
