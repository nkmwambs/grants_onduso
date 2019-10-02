<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *	@author 	: Nicodemus Karisa
 *	@date		: 27th September, 2018
 *	Finance management system for NGOs
 *	https://techsysnow.com
 *	NKarisa@ke.ci.org
 */

class General_library
{

  private $CI;

  function __construct(){
    $this->CI =& get_instance();
    $this->CI->load->model('General_model');
  }

  function index(){

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

    $all_columns = $this->CI->General_model->get_all_table_fields($table);

    $columns_to_display = array();

    if(count($hidden_columns)>0){

      foreach ($all_columns as $column) {
        if(!in_array($column,$hidden_columns)){
          $columns_to_display[] = $column;
        }

        if(substr($column,0,3) == 'fk_'){
            $columns_to_display[] = fk_to_name_field($column);
        }
      }

    }else{
      $columns_to_display = $all_columns;
    }

    return $columns_to_display;
  }

}
