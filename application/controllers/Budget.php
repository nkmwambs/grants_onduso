<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *	@author 	: Nicodemus Karisa
 *	@date		: 27th September, 2018
 *	Finance management system for NGOs
 *	https://techsysnow.com
 *	NKarisa@ke.ci.org
 */


class Budget extends MY_Controller
{

  function __construct(){
    parent::__construct();

  }
  function index(){}
  
  public function new_budget_item()
  {
      //if ($this->session->userdata('login') != 1)
           // redirect(base_url(), 'refresh');
		
	  $page_data['page_name'] = "new_budget_item";
      $page_data['page_title'] = "Budget";
      $page_data['views_dir'] = "budget";

      $this->load->view('budget/new_budget_item',$page_data);
  }


  static function get_menu_list(){

  }

}
