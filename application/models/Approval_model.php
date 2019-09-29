<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *	@author 	: Nicodemus Karisa
 *	@date		: 27th September, 2018
 *	Finance management system for NGOs
 *	https://techsysnow.com
 *	NKarisa@ke.ci.org
 */

class Approval_model extends MY_Model
{
  public $table = 'approval'; // you MUST mention the table name
  public $primary_key = 'approval_id'; // you MUST mention the primary key
  public $fillable = array(); // If you want, you can set an array with the fields that can be filled by insert/update
  public $protected = array(); // ...Or you can set an array with the fields that cannot be filled by insert/update

  function __construct(){
    parent::__construct();
    $this->load->database();

  }

  function index(){}

  function list($filter = "", $filter_value = ""){
    //Approvals by item e.g. requests, vouchers, budget

    //Approvals by status

    //Approvals by approver

    //approvals by role
  }



}