<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

interface TableRelationshipInterface {

  public function lookup_tables();

  public function detail_tables();

  public function table_visible_columns();

  public function table_hidden_columns();

}
