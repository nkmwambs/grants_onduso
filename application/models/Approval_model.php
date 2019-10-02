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

  public $hidden_columns = array('approval_last_modified_date','approval_created_date',
  'approval_last_modified_by','approval_created_by');


  function __construct(){
    parent::__construct();
    $this->load->library('general_library');
    $this->load->database();
    //$this->has_many['approveable_item'] = 'Approveable_item_model';
    //$this->has_many['approval_status'] = 'Approval_status_model';
		$this->return_as = 'array';
		$this->timestamps = TRUE;
		$this->soft_deletes = TRUE;

  }

  function index(){}

  function list(){
    $table_columns = $this->general_library->table_columns('approval',$this->hidden_columns);
    $this->db->select($table_columns);
    $this->db->join('approval_status','approval_status.approval_status_id=approval.fk_approval_status_id');
    $this->db->join('approveable_item','approveable_item.approveable_item_id=approval.fk_approveable_item_id');
    return $this->db->get('approval')->result_array();
  }



}
