<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

if ( ! function_exists('fk_to_name_field'))
{
	function fk_to_name_field($fk_field = '') {
		$xlpd = explode('_',substr($fk_field,0,-3));
    unset($xlpd[0]);
    return implode("_",$xlpd)."_name";
	}
}

if ( ! function_exists('elevate_array_element_to_key'))
{
	function elevate_array_element_to_key($unevelavated_array, $element_to_elevate) {
		$elevated_array = array();
	  foreach ($unevelavated_array as $item) {

			//Cast $item to array if object
			$item = is_object($item)?(array)$item:$item;

			$elevated_array[$item[$element_to_elevate]] =  $item;

			unset($elevated_array[$item[$element_to_elevate]][$element_to_elevate]);

		}

		return $elevated_array;
	}
}

if ( ! function_exists('elevate_assoc_array_element_to_key'))
{
	function elevate_assoc_array_element_to_key($unevelavated_array, $element_to_elevate) {
		$elevated_array = array();
		$cnt = 0;
	  foreach ($unevelavated_array as $item) {

			//Cast $item to array if object
			$item = is_object($item)?(array)$item:$item;

			$elevated_array[$item[$element_to_elevate]][$cnt] =  $item;

			unset($elevated_array[$item[$element_to_elevate]][$cnt][$element_to_elevate]);
			$cnt++;
		}

		return $elevated_array;
	}
}
