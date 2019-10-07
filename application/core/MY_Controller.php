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


  function result(){
    $action = $this->uri->segment(2,'list').'_result';
    $lib = $this->controller_library;
    return $this->list_result = $this->$lib->$action();
  }

  function page_name(){
    //return "list";
    return $this->uri->segment(2, 0);
  }

  function page_title(){
    return ucfirst($this->uri->segment(2, 0));
  }

  function views_dir(){
    $view_path = $this->uri->segment(1, 0);

    if(!file_exists(VIEWPATH.$view_path.'/'.$this->page_name().'.php')){
      $view_path =  'templates';
    }

    return $view_path;

  }

  function load_template($page_data = array()){
    return $this->load->view('general/index',$page_data);
  }

  // A specific controller can override crud method

  function crud_views(){
    $result = $this->result();

    // Page name, Page title and views_dir can be overrode in a controller
    $page_data['page_name'] = $this->page_name();
    $page_data['page_title'] = $this->page_title();
    $page_data['views_dir'] = $this->views_dir();
    $page_data['result'] = $result;

    // Can be overrode in a specific controller
    $this->load_template($page_data);
  }

  // Can be overrode in a speicific controller
  function list(){
    $this->crud_views();
  }

  // Can be overrode in a speicific controller
  function view(){
    $this->crud_views();
  }
}
