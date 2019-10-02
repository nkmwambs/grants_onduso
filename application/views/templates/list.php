<?php if (!defined('BASEPATH')) exit('No direct script access allowed');?>

<div class="row">
  <div class="col-xs-12">
    <table class="table table-striped datatable">
      <thead>
        <tr>
        <?php
        $counter_header = 0;
        foreach ($table_header as $th_value) {
          if($counter_header == 0 || strpos($th_value,'Key') == true) {
            $counter_header++;
            continue;
          }
          if(substr($th_value,0,2) == 'Fk'){
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

                  foreach ($td_array as $td_key => $td_value) {
                      if($counter_body == 0) {
                          $primary_key = $td_value;
                          $primary_table = substr($td_key,0,-3);
                          $counter_body++;
                          continue;
                        }

                        if(substr($td_key,0,3) == 'fk_' || strpos($td_key,'_key') == true){
                          continue;
                        }
                ?>
                        <td>
                          <?php

                            if(strpos($td_key,'_name') == true){
                              $lookup_table = substr($td_key,0,-5);//Remove name in the field name
                              $fk_field = 'fk_'.$lookup_table.'_id';
                              $fk = $td_array[$fk_field];
                              echo '<a href="'.base_url().$lookup_table.'/view/'.$fk.'">'.ucfirst($td_value).'</a>';
                            }elseif(strpos($td_key,'track_number') == true ){
                              echo '<a href="'.base_url().$primary_table.'/view/'.$primary_key.'">'.$td_value.'</a>';
                            }else{
                              echo $td_value;
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
