<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class MY_Controller extends CI_Controller implements CrudModelInterface
{

  private $list_result;
  private $controller_library;

  function __construct(){
    parent::__construct();
    $this->controller_library = $this->uri->segment(1, 0).'_library';
    $this->load->library($this->controller_library);
  }


  function list_result(){
      $lib = $this->controller_library;
      return $this->list_result = $this->$lib->list_result();
  }

  function list_page_name(){
    //return "list";
    return $this->uri->segment(2, 0);
  }

  function list_page_title(){
    return "List";
  }

  function list_views_dir(){
    $view_path = $this->uri->segment(1, 0);

    if(!file_exists(VIEWPATH.$view_path.'/'.$this->list_page_name().'.php')){
      $view_path =  'templates';
    }

    return $view_path;

  }

  function load_list_template($page_data = array()){
    return $this->load->view('general/index',$page_data);
  }

  function list(){

    // Can be overrode in a speicific controller
    $result = $this->list_result();

    // Page name, Page title and views_dir can be overrode in a controller
    $page_data['page_name'] = $this->list_page_name();
    $page_data['page_title'] = $this->list_page_title();
    $page_data['views_dir'] = $this->list_views_dir();
    $page_data['result'] = $result;

    // Can be overrode in a specific controller
    $this->load_list_template($page_data);
  }

  function view(){

  }
}
