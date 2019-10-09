<?php  if (!defined('BASEPATH')) exit('No direct script access allowed');

extract($result);

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

<div class="row" style="margin-bottom:25px;">
  <div class="col-xs-12" style="text-align:center;">
    <button class="btn btn-default">Add <?=ucfirst($this->controller);?></button>
  </div>
</div>

<div class="row">
  <div class="col-xs-12">
    <table class="table table-striped datatable">
      <thead>
        <tr>
          <th><?=get_phrase('action');?></th>
        <?php
        $counter_header = 0;
        foreach ($table_header as $th_value) {
          if(strtolower($this->controller) == strtolower($th_value) ||
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
          if(isset($table_body)){
          foreach ($table_body as $td_array) {
        ?>
          <tr>
              <td>
                <a href="<?=base_url().strtolower($this->controller).'/edit/'.hash_id($primary_key);?>"><?=get_phrase('edit');?></a> &nbsp;
                <a href="<?=base_url().strtolower($this->controller).'/delete/'.hash_id($primary_key);?>"><?=get_phrase('delete');?></a>
              </td>
              <?php
                  $counter_body = 0;
                  $primary_key = 0;
                  foreach ($td_array as $td_key => $td_value) {
                      if($td_key == strtolower($this->controller).'_id') {
                          $primary_key = $td_value;
                          $primary_table = strtolower($this->controller);//substr($td_key,0,-3);
                          $counter_body++;
                          continue;
                        }

                        if(strpos($td_key,'_key') == true){
                          continue;
                        }
                ?>
                        <td>
                          <?php

                            if(strpos($td_key,'track_number') == true ){
                              echo '<a href="'.base_url().strtolower($this->controller).'/view/'.hash_id($primary_key).'">'.$td_value.'</a>';
                            }elseif(strpos($td_key,'is_active') == true){
                                echo $td_value == 1?"Yes":"No";
                            }else{
                              echo ucfirst($td_value);
                            }

                           ?>
                        </td>
                <?php $counter_body++;  }?>

          </tr>

        <?php
              }
          }
        ?>

      </tbody>
    </table>
  </div>
</div>
