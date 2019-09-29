<?php

class Access{

  private $CI;

  function __construct(){
    $this->CI =& get_instance();
    //$this->CI->load->database();
  }

  function getAccess($controller_method){

    $user_id = $this->CI->session->user_id;

    //Check if the the method access is available user_access_level

    //$controller_method is a uniquie database key to be inserted if only missing in database
    $data['controller_method'] = strtolower($controller_method);
    $this->CI->db->insert('user_access_level',$data);

    $user_priviledges = $this->CI->session->user_priviledges;

    print_r($user_priviledges);
    //if( !in_array(strtolower($controller_method),$user_priviledges) ){
        //redirect(base_url()."login/access_denied_error", 'refresh');
    //}


  }
}
