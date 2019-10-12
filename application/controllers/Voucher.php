<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *	@author 	: Nicodemus Karisa
 *	@date		: 27th September, 2018
 *	Finance management system for NGOs
 *	https://techsysnow.com
 *	NKarisa@ke.ci.org
 */


class Voucher extends MY_Controller
{

  function __construct(){
    parent::__construct();
	
	//$this->load->helper('form');

  }
  
     function index(){
      //$this->access->getAccess(__METHOD__);
      
      
      
    }


    function list_page_name(){
      return 'new_voucher';
    }

    function list_page_title(){
      return "Voucher";
    }

  static function get_menu_list(){

  }
  
  
  function new_voucher(){
		//if ($this->session->userdata('login') != 1)
           // redirect(base_url(), 'refresh');
		
	  $page_data['page_name'] = "new_voucher";
      $page_data['page_title'] = "Voucher";
      $page_data['views_dir'] = "voucher";

      $this->load->view('general/index',$page_data);			
	}
  function view(){
  	
  }

}
