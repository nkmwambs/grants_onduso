<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *	@author 	: Nicodemus Karisa
 *	@date		: 27th September, 2018
 *	Finance management system for NGOs
 *	https://techsysnow.com
 *	NKarisa@ke.ci.org
 */


class Bank extends MY_Controller implements CrudModelInterface
{

  function __construct(){
    parent::__construct();
    $this->load->library('bank_library');
  }

  function index(){}

  function create(){}

  function view(){}

  function update(){}

  function delete(){}

  //function list(){}

  static function get_menu_list(){
    return array('list_banks'=>array('view','arg1','arg2','arg3'));
  }

}
