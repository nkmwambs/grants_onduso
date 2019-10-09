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


  //This method overrides the My_Model table_hidden_columns. Calling it with empty body entirely does away with the
  //set default hidden columns i.e. all columns will be vieable as it is from the table.
  // It works for the listing views for both simple and master-details

  function table_hidden_columns(){
    //$default_hidden_columns = parent::table_hidden_columns();
    //$columns_to_show =  array('funder_created_date','funder_last_modified_date');
    //Unset default hidden columns
    //return $this->grants->unset_default_hidden_columns($default_hidden_columns,$columns_to_show);
  }

  // This method when implemented overwites the any implementation of table_hidden_columns and allows the
  // setting of columns to be shown on tables
  // It works for the listing views for both simple and master-details
  function table_visible_columns(){

  }

  //List as an array all columns that should be seen in the master table of the master-detail view.
  // It has a priority over the master_table_hidden_columns method

  function master_table_visible_columns(){

  }

  //Not working yet. Should allow hidding columns by default from the My Model method or overide it here

  //List as an array all columns that should be hidden in the master table of the master-detail view.
  // Only works if master_table_visible_columns returns no array
  function master_table_hidden_columns(){

  }

  // List all tables as an array that contain a primary relationship to this $table
  function lookup_tables(){

  }

  // List all the tables as an array that contains a secondary relationship to this $table
  function detail_tables(){
    return array('project');
  }

  // Can bear a simple query result as array an overide the grants_model method
  function list(){

  }

  // Can bear a simple query results overide the grants_model view method
  function view(){

  }
}
