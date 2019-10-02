<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *	@author 	: Nicodemus Karisa
 *	@date		: 27th September, 2018
 *	Finance management system for NGOs
 *	https://techsysnow.com
 *	NKarisa@ke.ci.org
 */

class Approval_library
{

  private $CI;
  private $hidden_columns = array('last_modified_date','created_date','last_modified_by','created_by');

  function __construct(){
    $this->CI =& get_instance();
    $this->CI->load->model('Approval_model');
    $this->CI->load->library('General_library');
  }

  function index(){

  }

  function list(){

    $result = $this->CI->Approval_model->list();

    $table_array = array(
      'table_header'=>$this->CI->general_library->camel_case_header('approval',$this->CI->Approval_model->hidden_columns),
      'table_body'=>$result
    );

    return $this->CI->load->view('templates/list',$table_array,true);

  }

}
