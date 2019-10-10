<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *	@author 	: Nicodemus Karisa
 *	@date		: 27th September, 2018
 *	Finance management system for NGOs
 *	https://techsysnow.com
 *	NKarisa@ke.ci.org
 */

class Voucher_model extends MY_Model implements CrudModelInterface, TableRelationshipInterface
{
  public $table = 'voucher'; // you MUST mention the table name
  public $primary_key = 'voucher_id'; // you MUST mention the primary key
  public $fillable = array(); // If you want, you can set an array with the fields that can be filled by insert/update
  public $protected = array(); // ...Or you can set an array with the fields that cannot be filled by insert/update

  function __construct(){
    parent::__construct();
    $this->load->database();

  }

  function index(){

  }

  
  
  function lookup_tables(){
    return array('voucher_type','center');
  }
  
  public function detail_tables(){
    return array('voucher_detail');
  }

  public function table_visible_columns(){}

  public function table_hidden_columns(){
  	
	$hidden_columns = array($this->table.'_last_modified_date',$this->table.'_created_date',
    $this->table.'_last_modified_by',$this->table.'_created_by',$this->table.'_deleted_at',$this->table.'_allow_edit');

    return $hidden_columns;
  }

  public function master_table_visible_columns(){}

  public function master_table_hidden_columns(){}
  
  public function list(){}
  public function view(){}

}
