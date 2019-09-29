<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *	@author 	: Nicodemus Karisa
 *	@date		: 27th September, 2018
 *	Finance management system for NGOs
 *	https://techsysnow.com
 *	NKarisa@ke.ci.org
 */

class Login extends CI_Controller
{

  function __construct(){
    parent::__construct();

  }

  function index(){

    print_r($this->menulist->getMenuItems());

  }


}
