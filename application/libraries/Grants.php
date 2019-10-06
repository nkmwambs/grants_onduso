<?php

class Grants{
private $CI;
private $current_library;
private $current_model;
private $controller;

function __construct(){
  $this->CI =& get_instance();
  $current_library = $this->CI->uri->segment(1, 'approval').'_library';
  $this->current_model = $this->CI->uri->segment(1, 'approval').'_model';
  $this->CI->load->model($this->current_model);
  $this->controller = $this->CI->uri->segment(1, 0);
  $this->CI->load->model('grants_model');
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

  $columns_to_display = array();


  foreach ($all_columns as $column) {

    if(count($hidden_columns)>0){
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

function list_result(){
      $model = $this->current_model;

      $result = $this->CI->$model->list();
      $model = $this->current_model;

      if(!$this->CI->db->table_exists($this->controller)){
        $error_code['code'] = 1;
        return $this->CI->load->view('templates/error',$error_code,true);
      }else{

        $table_array = array(
          'table_header'=>$this->camel_case_header($this->controller,$this->CI->grants_model->set_hidden_columns()),
          'table_body'=>$result
        );

        return $this->CI->load->view('templates/list',$table_array,true);
      }


    }

}
