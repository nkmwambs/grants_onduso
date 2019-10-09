<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *	@author 	: Nicodemus Karisa
 *	@date		: 27th September, 2018
 *	Finance management system for NGOs
 *	https://techsysnow.com
 *	NKarisa@ke.ci.org
 */

class Funder_model extends MY_Model implements CrudModelInterface, TableRelationshipInterface
{
  public $table = 'funder';
  public $hidden_columns = array();
  private $lookup_tables = array();

  function __construct(){
    parent::__construct();

  }

  function index(){}

  function details_lookup_tables(){
    return array('detail_tables'=>array('project'));
  }

  function list_columns(){

  }

  //This method overrides the My_Model table_hidden_columns. Calling it with empty body entirely does away with the
  //set default hidden columns i.e. all columns will be vieable as it is from the table.
  function table_hidden_columns(){
    $default_hidden_columns = parent::table_hidden_columns();
    $columns_to_show =  array('funder_created_date','funder_last_modified_date');
    //Unset default hidden columns
    return $this->grants->unset_default_hidden_columns($default_hidden_columns,$columns_to_show);
  }

  // This method when implemented overwites the any implementation of table_hidden_columns and allows the
  // setting of columns to be shown on tables
  function table_visible_columns(){
    return array('funder_description','funder_name','funder_created_date');
  }

  function master_table_visible_columns(){
    return array('funder_track_number','funder_name','funder_description','funder_created_date');
  }

//Not working yet. Should allow hidding columns by default from the My Model method or overide it here
  function master_table_hidden_columns(){
    //return array('funder_deleted_at');
  }

  function lookup_tables(){

  }

  function detail_tables(){
    return array('project');
  }

  function list(){
    //return $this->grants_model->list_query($this->details_lookup_tables());
    //return $this->db->get('funder',array('funder_id'=>1))->result_array();
  }

  function view(){
    //return $this->grants_model->view_query($this->details_lookup_tables());
  }
}
