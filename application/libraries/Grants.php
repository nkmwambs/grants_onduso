<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Grants{
private $CI;
private $current_library;
private $current_model;
private $controller;
private $action;

function __construct(){
  $this->CI =& get_instance();

  $this->controller = $this->CI->uri->segment(1, 'approval');

  $current_library = $this->controller.'_library';
  $this->current_model = $this->controller.'_model';
  $this->action = $this->CI->uri->segment(2,'list');

  $this->CI->load->model($this->current_model);

  //The autoloaded grants model does work in library context and has to loaded here
  $this->CI->load->model('grants_model');
}

//This function allows unsetting default hidden columns. It's callable from specific model
//Example:
//$columns_to_show =  array('funder_created_date','funder_last_modified_date');
//Unset default hidden columns
//return $this->grants->unset_default_hidden_columns($default_hidden_columns,$columns_to_show);

function unset_default_hidden_columns($default_hidden_columns,$columns_to_unset){
  foreach ($columns_to_unset as $column_to_unset) {
    $unset_default_hidden_column = in_array('funder_created_date',$default_hidden_columns);
    unset($default_hidden_columns[$unset_default_hidden_column]);
  }

  return $default_hidden_columns;
}

//This function allows to add more hidden columns. Callable from a specific model
//Example:
//$columns_to_hide = array('funder_description');
//return $this->grants->add_default_hidden_columns($default_hidden_columns,$columns_to_hide)
function add_default_hidden_columns($default_hidden_columns,$columns_to_hide){
  foreach ($columns_to_hide as $column_to_hide) {
    array_push($default_hidden_columns,$column_to_hide);
  }

  return $default_hidden_columns;
}

function table_hidden_columns($table_name = "", $table_as_master = false){
  $model = $this->load_detail_model($table_name);

  if($table_as_master){
    return $this->CI->$model->master_table_hidden_columns();
  }else{
    return $this->CI->$model->table_hidden_columns();
  }

}

function table_visible_columns($table_name = "", $table_as_master = false){
  $model = $this->load_detail_model($table_name);
  $visible_columns = $this->CI->$model->table_visible_columns();

  if($table_as_master){
    $master = $this->CI->$model->master_table_visible_columns();

    if(is_array($master) && count($master)>0){
        $visible_columns = $this->CI->$model->master_table_visible_columns();
    }else{
        $visible_columns = $this->get_all_table_fields($table_name);
    }

  }

  //These are columns that must exists for listing tables to work i.e.
  // All list table MUST have a track_number and id columns
  // Add these to the array if not present in the $visible_columns array
  $mandatory_columns = array($table_name.'_track_number',$table_name.'_id');

  if(is_array($visible_columns)){
    foreach ($mandatory_columns as $mandatory_column) {
      if(!in_array($mandatory_column,$visible_columns)){
        //Add the mandatory columns at the beginning of an array
        array_unshift($visible_columns,$mandatory_column);
      }
    }
  }

  return $visible_columns;
}

function get_all_table_fields($table_name = ""){
  return $this->CI->grants_model->get_all_table_fields($table_name);
}

function camel_case_header($table,$hidden_columns = array()){

  $headers = $this->table_columns($table,$hidden_columns);

  $sanitized_headers = array();

  foreach ($headers as $header) {
      //check if _id is part of the last part of the string and remove the _id
      if(substr($header,-3) == '_id'){
          $header = substr($header, 0, -3);
      }

      $sanitized_headers[] = ucwords(str_replace('_',' ',$header));
  }

  return $sanitized_headers;

}

function table_columns($table,$hidden_columns = array()){

  $all_columns = $this->CI->grants_model->get_all_table_fields($table);

  if( is_array($this->table_visible_columns($table)) && count($this->table_visible_columns($table)) > 0){
      $all_columns = $this->table_visible_columns($table);
  }

  $columns_to_display = array();


  foreach ($all_columns as $column) {

    if(is_array($hidden_columns) && count($hidden_columns)>0){
        if(!in_array($column,$hidden_columns)){
          if(substr($column,0,3) == 'fk_'){
              $columns_to_display[] = fk_to_name_field($column);
          }else{
              $columns_to_display[] = $column;
          }
        }

    }else{
      if(substr($column,0,3) == 'fk_'){
          $columns_to_display[] = fk_to_name_field($column);
      }else{
          $columns_to_display[] = $column;
      }
    }
  }

  return $columns_to_display;
}

function load_detail_model($table_name = ""){
  $model =  $this->current_model;

  if($table_name !== ""){
    $model = $table_name.'_model';
    $this->CI->load->model($model);
  }

  return $model;
}

function switch_query_result_source($table_name = "",$force_action_to = ""){
  //$model = $table_name == ""?$this->current_model:$table_name.'_model';
  $model = $this->load_detail_model($table_name);

  $action = $force_action_to == ""?$this->action:$force_action_to;

  $relationship_tables = $action == 'list'?"lookup_tables":"detail_tables";

  $result = array();

  if($force_action_to == 'list'){
    //is_array($this->CI->$model->$action()) && count($this->CI->$model->$action()) > 0
    //Use the user defined results in the specific model
    //$result = $this->CI->$model->$action();
    $result = $this->CI->db->get('project')->result_array();//$this->CI->grants_model->$action($this->CI->$model->$relationship_tables(),$table_name);
  }else{
    //Use the array results produced from the grants model
    $result = $this->CI->grants_model->$action($this->CI->$model->$relationship_tables(),$table_name);
  }

  return $result;
}

function list_result($table_name = "",$force_action_to = ""){
      $table = $table_name == ""?$this->controller:$table_name;

      $result = $this->switch_query_result_source($table,$force_action_to);

        $table_array = array(
          'keys'=> $this->table_columns($table,$this->table_hidden_columns($table)),
          'table_header'=>$this->camel_case_header($table,$this->table_hidden_columns($table)),
          'table_body'=>$result,
          'test_key'=>$table
        );

        return $table_array;
  }


function view_result(){
    return $this->switch_query_result_source();
  }
}
