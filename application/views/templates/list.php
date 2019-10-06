<?php

  if (!defined('BASEPATH')) exit('No direct script access allowed');

  //$this->menu->navigation();
  //print_r($this->session->test_session);
  //$this->session->unset_userdata('user_menu');

  $primary_key_field = $this->uri->segment(1,0);

?>

<?php
  //print_r($table_body);
 ?>

<div class="row">
  <div class="col-xs-12">
    <form>
      <label for="" class="label-control col-xs-3" style="text-align:right;font-weight:bold;">Views</label>
      <div class="col-xs-6">
        <select class="form-control">
          <option>Select a view</option>
        </select>
      </div>
      <div class="col-xs-3"> <a href="#">Create View</a>  &nbsp; <a href="#">Edit View</a> &nbsp; <a href="#">Clone View</a></div>
    </form>
  </div>
</div>

<hr/>

<div class="row">
  <div class="col-xs-12">
    <table class="table table-striped datatable">
      <thead>
        <tr>
        <?php
        $counter_header = 0;
        foreach ($table_header as $th_value) {
          if(strtolower($primary_key_field) == strtolower($th_value) ||
              strpos($th_value,'Key') == true
            ) {
            $counter_header++;
            continue;
          }

        ?>
          <th><?=$th_value;?></th>
        <?php
          $counter_header++;
        }
        ?>
      </tr>
      </thead>
      <tbody>
        <?php
          $primary_key = 0;
          $primary_table = "";
          foreach ($table_body as $td_array) {
        ?>
          <tr>

              <?php
                  $counter_body = 0;
                  $primary_key = 0;
                  foreach ($td_array as $td_key => $td_value) {
                      if($td_key == strtolower($primary_key_field).'_id') {
                          $primary_key = $td_value;
                          $primary_table = strtolower($primary_key_field);//substr($td_key,0,-3);
                          $counter_body++;
                          continue;
                        }

                        if(strpos($td_key,'_key') == true){
                          continue;
                        }
                ?>
                        <td>
                          <?php

                            // if(strpos($td_key,'_name') == true){
                            //   $fk_field = 'fk_'.substr($td_key,0,-5).'_id';
                            //   $fk = $td_array[$fk_field];
                            //   $fk_name = $td_array[$fk_field];
                            //   echo '<a href="'.base_url().$primary_key_field.'/view/'.$fk.'">'.ucfirst($fk_name).'</a>';
                            // }else

                            if(strpos($td_key,'track_number') == true ){
                              echo '<a href="'.base_url().strtolower($primary_key_field).'/view/'.$primary_key.'">'.$td_value.'</a>';
                            }elseif(strpos($td_key,'is_active') == true){
                                echo $td_value == 1?"Yes":"No";
                            }else{
                              echo ucfirst($td_value);
                            }

                           ?>
                        </td>
                <?php $counter_body++;  }?>

          </tr>

        <?php } ?>

      </tbody>
    </table>
  </div>
</div>
