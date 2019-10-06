<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *	@author 	: Nicodemus Karisa
 *	@date		: 27th September, 2018
 *	Finance management system for NGOs
 *	https://techsysnow.com
 *	NKarisa@ke.ci.org
 */

class Approval_model extends MY_Model implements CrudModelInterface
{
  public $table = 'approval'; // you MUST mention the table name
  public $primary_key = 'approval_id'; // you MUST mention the primary key
  public $fillable = array(); // If you want, you can set an array with the fields that can be filled by insert/update
  public $protected = array(); // ...Or you can set an array with the fields that cannot be filled by insert/update

  public $hidden_columns = array();
  private $lookup_tables = array();

  function __construct(){
    parent::__construct();
    $this->load->database();
    //$this->has_many['approveable_item'] = 'Approveable_item_model';
    //$this->has_many['approval_status'] = 'Approval_status_model';
		$this->return_as = 'array';
		$this->timestamps = TRUE;
		$this->soft_deletes = TRUE;

  }

  function index(){}

  function list(){
    $table = "approval";
    $this->lookup_tables = array('approval_status','approveable_item');
    return $this->grants_model->list_query($this->lookup_tables);
  }

function view(){
  
}

}
