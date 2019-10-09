<?php  if (!defined('BASEPATH')) exit('No direct script access allowed');
print_r($result);

//Remove the primary key field from the master table
unset($result['master'][$this->controller.'_id']);

// Make the master detail table have columns as per the config
$columns = array_chunk($result['master'],$this->config->item('master_table_columns'),true);

print_r($result);

?>

<div class="row">
  <div class="col-xs-12">
    <table class="table table-striped">
      <thead>
        <tr><th colspan="3" style="text-align:center;"><?=ucfirst($this->uri->segment(1));?> Master Record</th></tr>
      </thead>
      <tbody>
        <?php

            foreach ($columns as $row) {
          ?>
            <tr>
          <?php
              foreach ($row as $column_label => $column_value) {
                // if($column_label == $this->controller.'_id'){
                //   continue;
                // }
          ?>
                <td>
                  <span style="font-weight:bold;"><?=ucwords(str_replace("_"," ",$column_label));?>:</span> &nbsp;
                  <?=$column_value;?>
                </td>
          <?php
              }
          ?>
              </tr>
          <?php
            }
          ?>

      </tbody>
    </table>
    <?php

      foreach ($result['detail'] as $detail_name => $details) {
        ?>
          <table class="table table-striped datatable_details">
            <thead>
              <tr><th colspan="<?=count($details['table_header']);?>"><?=ucfirst($detail_name);?></th></tr>
              <?php
              //  $header = array_keys(array_slice($details['table_header'],count($result['master'])));
              ?>
              <tr>
                  <?php
                    foreach ($details['table_header'] as $key) {
                      ?>
                        <th><?=$key;?></th>
                      <?php
                    }
                  ?>
              </tr>
            </thead>
            <tbody>

            </tbody>
          </table>
        <?php
      }
    ?>
  </div>
</div>
