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

  private $current_model;

  function __construct(){
    parent::__construct();
    $this->load->database();
    $this->current_model = $this->uri->segment(1,'approval').'_model';
    $this->load->model($this->current_model);
  }

  function index(){

  }

  function list_query($detail_lookup_tables = array()){

    $table = strtolower($this->uri->segment(1));

    $table_columns = $this->grants->table_columns($table,$this->set_hidden_columns());
    $this->db->select($table_columns);

    if(is_array($detail_lookup_tables) && array_key_exists('lookup_tables',$detail_lookup_tables) && count($detail_lookup_tables['lookup_tables']) > 0 ){
      foreach ($detail_lookup_tables['lookup_tables'] as $lookup_table) {
          $lookup_table_id = $lookup_table.'_id';
          $this->db->join($lookup_table,$lookup_table.'.'.$lookup_table_id.'='.$table.'.fk_'.$lookup_table_id);
      }
    }

    return $this->db->get($table)->result_array();
  }

  function view_query($detail_lookup_tables = array()){

    $table = strtolower($this->uri->segment(1));

    $data = array();

    $data['master'] = (array)$this->db->get_where($table,array($table.'_id'=> hash_id($this->uri->segment(3,0),'decode') ))->row();

    if(is_array($detail_lookup_tables) && array_key_exists('detail_tables',$detail_lookup_tables) && count($detail_lookup_tables['detail_tables']) > 0 ){
      foreach ($detail_lookup_tables['detail_tables'] as $detail_table) {
          $detail_table_id = $detail_table.'_id';
          $this->db->join($detail_table,$detail_table.'.fk_'.$table.'_id='.$table.'.'.$table.'_id');
          $data['detail'][$detail_table] = $this->db->get_where($table,array($table.'_id'=> hash_id($this->uri->segment(3,0),'decode') ))->result_array();
      }
    }

    return $data;
  }

  function set_hidden_columns(){
    $controller = $this->uri->segment(1,0);
    $this->hidden_columns = array($controller.'_last_modified_date',$controller.'_created_date',
    $controller.'_last_modified_by',$controller.'_created_by',$controller.'_deleted_at');

    return $this->hidden_columns;
  }

  function get_all_table_fields($table = 'approval'){
    return $this->db->table_exists($table)?$this->db->list_fields($table):array();

  }

}
