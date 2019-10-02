<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

if ( ! function_exists('fk_to_name_field'))
{
	function fk_to_name_field($fk_field = '') {
		$xlpd = explode('_',substr($fk_field,0,-3));
    unset($xlpd[0]);
    return implode("_",$xlpd)."_name";
	}
}
