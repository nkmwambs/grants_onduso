<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *	@author 	: Nicodemus Karisa
 *	@date		: 27th September, 2018
 *	Finance management system for NGOs
 *	https://techsysnow.com
 *	NKarisa@ke.ci.org
 */

class Approval_model extends MY_Model implements CrudModelInterface, TableRelationshipInterface
{
  public $table = 'approval'; // you MUST mention the table name

  public $hidden_columns = array();
  private $lookup_tables = array();

  function __construct(){
    parent::__construct();
  }

  function index(){}

  function lookup_tables(){
    return array('approval_status','approveable_item');
  }

  function detail_tables(){

  }

  //This method overrides the My_Model table_hidden_columns
  function table_hidden_columns(){
    //Only use this table to indicate the models table which is a parameter in this class
    $hidden_columns = array($this->table.'_last_modified_date',$this->table.'_created_date',
    $this->table.'_last_modified_by',$this->table.'_created_by',$this->table.'_deleted_at');

    return $hidden_columns;
  }

  function table_visible_columns(){

  }

  function master_table_visible_columns(){
    //return array('approval_track_number','approval_approveable_table_primary_key');
  }

//Not working yet. Should allow hidding columns by default from the My Model method or overide it here
  function master_table_hidden_columns(){
    //return array('funder_deleted_at');
  }

  function list(){

  }

  function view(){

  }

}
