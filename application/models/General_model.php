<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *	@author 	: Nicodemus Karisa
 *	@date		: 27th September, 2018
 *	Finance management system for NGOs
 *	https://techsysnow.com
 *	NKarisa@ke.ci.org
 */

class General_model extends CI_Model
{

  function __construct(){
    parent::__construct();
    $this->load->database();

  }

  function index(){

  }

  // function get_foreign_keys_source_tables($foreign_table = 'approval'){
  //   /**
  //   *SELECT i.TABLE_NAME, i.CONSTRAINT_TYPE, i.CONSTRAINT_NAME, k.REFERENCED_TABLE_NAME, k.REFERENCED_COLUMN_NAME
  //   *FROM information_schema.TABLE_CONSTRAINTS i
  //   *LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME
  //   *WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY'
  //   *AND i.TABLE_NAME = "'.$foreign_table.'";
  //   **/
  //   $sql = '
  //     SELECT k.REFERENCED_TABLE_NAME
  //     FROM information_schema.TABLE_CONSTRAINTS i
  //     LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME
  //     WHERE i.CONSTRAINT_TYPE = "FOREIGN KEY"
  //     AND i.TABLE_NAME = "'.$foreign_table.'";
  //   ';
  //
  //   return $this->db->query($sql)->result_array();
  //
  // }

  function get_all_table_fields($table = 'approval'){
    return $this->db->list_fields($table);

  }

}
