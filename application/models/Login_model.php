<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *	@author 	: Nicodemus Karisa
 *	@date		: 27th September, 2018
 *	Finance management system for NGOs
 *	https://techsysnow.com
 *	NKarisa@ke.ci.org
 */

class Login_model extends CI_Model
{

  function __construct(){
    parent::__construct();
    $this->load->database();

  }

  function index(){

  }

  function get_user_priviledges(){

    $user_id = $this->session->user_id;

    //Get current/logged in user priviledges
    $this->db->join('user_access_level','user_access_level.user_access_level_id=user_priviledge.user_access_level_id');
    $arr = $this->db->get_where('user_priviledge',array('user_id'=>$user_id))->result_object();

    $user_session_priviledges = array_column($arr,'controller_method');

    $this->session->set_userdata('user_priviledges',$user_session_priviledges);
    //return $user_session_priviledges;
  }

}
