<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *	@author 	: Nicodemus Karisa
 *	@date		: 27th September, 2018
 *	Finance management system for NGOs
 *	https://techsysnow.com
 *	NKarisa@ke.ci.org
 */

class Budget_model extends MY_Model
{
  public $table = 'budget'; // you MUST mention the table name
  public $primary_key = 'budget_id'; // you MUST mention the primary key
  public $fillable = array(); // If you want, you can set an array with the fields that can be filled by insert/update
  public $protected = array(); // ...Or you can set an array with the fields that cannot be filled by insert/update
  public $hidden_columns = array();

  function __construct(){
    parent::__construct();
    $this->load->database();

  }

  function index(){

  }

  function list(){
    $table_columns = $this->grants->table_columns('budget',$this->grants_model->set_hidden_columns());
     $this->db->select($table_columns);
    //$this->db->join('approval_status','approval_status.approval_status_id=approval.fk_approval_status_id');
    $this->db->join('center','center.center_id=budget.fk_center_id');
    return $this->db->get('budget')->result_array();
  }

  function view(){
    
  }

}
