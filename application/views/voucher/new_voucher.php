
<hr />

<div id="load_voucher">

<div class="row">
	<div class="col-sm-6">
		<div class="form-group">
			<label class="control-label col-sm-3">Search a Voucher</label>
			<div class="col-sm-6">
				<input type="text" class="form-control" id="Tracking_voucher_number_search" placeholder="Enter a voucher number" />
			</div>
			<div class="col-sm-2">
				
				<div id="search_btn" class="btn btn-primary"><i class="entypo-search"></i>Search</div>
				
			</div>
		</div>
	</div>
</div>

<hr />
	
<div class="row">
	<div class="col-sm-12">
	
	<div class="panel panel-primary" data-collapsed="0">
       	<div class="panel-heading">
           	<div class="panel-title" >
           		<i class="entypo-plus-circled"></i>
					<?php echo get_phrase('new_voucher');?>
           	</div>
        </div>
	<div class="panel-body"  style="max-width:50; overflow: auto;">	
		
		
		
		<?php echo form_open("" , array('id'=>'frm_voucher','class' => 'form-horizontal form-groups-bordered validate', 'enctype' => 'multipart/form-data'));?>
		
			<div class="row">	
			<div class="col-sm-12">		
			            <input type="hidden" value="<?php echo 'Cntr-001';?>" id="center_number" name="center_number"/>
			            
			            <table id='table_voucher' class='table'>
			            	<thead>
				                <tr>
				                    <th colspan="8"  style="text-align: center;"><?php echo '<b><u>PAYMENT VOUCHER</u></b>'; ?><br><b>CNTR-001</b></th>
				                </tr>
							</thead>
							
							<tbody>
								<tr>
									<td id="error_msg" style="color:red;text-align: center;">
										<?php
											if(isset($msg)) echo $msg;
										?>
									</td>
								</tr>
			                <tr>		               
					            <td colspan="2">
					            	<div class="form-group">
										<label class="control-label"><span style="font-weight: bold;"><?php echo get_phrase('date');?>: </span></label>
										
											<div class="input-group">
												<input type="text" name="voucher_date" id="voucher_date" class="form-control datepicker " data-validate="required" data-message-required="<?php echo get_phrase('value_required');?>" 
													data-format="yyyy-mm-dd" data-start-date="" 
														data-end-date="" readonly="readonly">
												
												<div class="input-group-addon">
													<a href="#"><i class="entypo-calendar"></i></a>
												</div>
											</div>
										
									</div>
					            </td>
					            <td colspan="">
					            	<div class="col-xs-12 form-group" >
			                    		<label for="voucher_type_label" class="control-label"><span style="font-weight: bold;"><?php echo get_phrase('voucher_type');?>:</span></label>
					                        <select name="voucher_type" id="voucher_type" class="form-control" data-validate="required" data-message-required="<?php echo get_phrase('value_required');?>">
					                            <option value="#"><?php echo get_phrase('select_voucher_type');?></option>
					                            <option value="PC"><?php echo get_phrase('payment_by_cash');?></option>
					                            <option value="CHQ"><?php echo get_phrase('payment_by_cheque');?></option>
					                            <option value="BCHG"><?php echo get_phrase('bank_adjustments');?></option>
					                            <option value="CR"><?php echo get_phrase('cash_received');?></option>					                            
					                            <option value="PCR"><?php echo get_phrase('petty_cash_rebanking');?></option>
					                        </select>
			                        </div>
			                        </td>
			                        
			                     <td colspan="2">
			                    	<div id='cheque_no_div' hidden class="col-xs-10 form-group">
			                    		<label for="voucher_cheque_number" class="control-label"><span style="font-weight: bold;"><?php echo get_phrase('cheque_number');?>:</span></label>
			                    			<input class="form-control" type="text" id="voucher_cheque_number" name="voucher_cheque_number" data-validate="number,minlength[2]"  readonly="readonly"/>
			                    	</div>
			                    </td>
			                    <td colspan="2">
			                    	<div hidden id="label-toggle-switch" for="reversal" class="col-xs-8"><span style="font-weight:Bold;"><?php echo get_phrase('cheque_reversal');?></span> 
										<div class="make-switch switch-small" data-on-label="Yes" data-off-label="No">
												<input type="checkbox" id="reversal" name="reversal"/>
										</div>
									</div>		
			                    </td>
					            <td colspan="">
					            	<div class="form-group">
					            		<label for='tracking_voucher_number' class="control-label"><span style="font-weight: bold;"><?php echo get_phrase('voucher_number');?></span></label>	
					            		<input value='VCR-8671'type="text" class="form-control accNos" id="tracking_voucher_number" name="tracking_voucher_number" data-validate="required" data-message-required="<?php echo get_phrase('value_required');?>" value="" readonly/>
					            	</div>
					            </td>
			
			                </tr>
			                <tr>
			                    <td colspan="8">
			                    	<div class="form-group">
			                    		<label for="voucher_vendor" class="control-label"><span style="font-weight: bold;"><?php echo get_phrase('pay_to_(vendor)');?>: </span></label>
			                    		<input type="text" class="form-control" data-validate="required" data-message-required="<?php echo get_phrase('value_required');?>" id="voucher_vendor" name="voucher_vendor"/>
			                    	</div>
			                    </td>
			                </tr>
			                  
			                <tr>
			                    
			                </tr>
			                
			                <tr>
			                   
			                    <td colspan="8">
			                    	<div class="form-group">
			                    			<label for="voucher_description" class="control-label"><span style="font-weight: bold;"><?php echo get_phrase('payment_description');?></span></label>
			                    		<input type="text" class="form-control" data-validate="required" data-message-required="<?php echo get_phrase('value_required');?>" id="voucher_description" name="voucher_description"/>
			                    	</div>
			                    	
			                    </td>
			                </tr>
			                
			                </tbody>
			            </table>
		    
		    	</div>
		    </div>
		    
		    
		    
		    
		    <div class="row">
		    	<div class="col-xs-12">   
			        <table id="voucher_detail_table" class="table table-bordered">
			        	<thead>
				            <tr style="font-weight: bold;">
				                <!-- <th><?php echo get_phrase('check');?></th> -->
				                <th><?php echo get_phrase('particulars_ /_details');?></th><th><?php echo get_phrase('quantity');?></th><th><?php echo get_phrase('unit_cost');?></th><th><?php echo get_phrase('subtotal');?></th><th><?php echo get_phrase('account');?></th><th><?php echo get_phrase('special_code_if_any');?></th>
				                <th class='hidden-print'><?php echo get_phrase('Action');?></th>
				            </tr>
				         </thead>
				         <tbody>
				         	<!--This is the first row-->
				         	 <tr>
				                <!-- <td><input type="checkbox"  name="remove_row[]"/> </td> -->
				                <td><input class="form-control first_control" type="text"  name="description[]" readonly="readonly"/></td>
				                <td><input class="form-control first_control" type="text"  name="quantity[]" readonly="readonly"/></td>
				                <td><input class="form-control first_control" type="text"  name="unit_cost[]" readonly="readonly"/></td>
				                <td><input class="form-control first_control" type="text"  name="total_cost[]" readonly="readonly"/></td>
				                <td class='col-xs-2'>
				                	<select class="form-control first_control" name="income_expense_account[]" readonly="readonly">
				                	   <option value='0'>Select Acc</option>
				                	   <option value='1'>Acc-500</option>
				                	   <option value='2'>Acc-400</option>
				                	   <option value='3'>Acc-760</option>
				                	   <option value='4'>Acc-800</option>
				                	   <option value='5'>Acc-750</option>
				                	   <option value='6'>Acc-780</option>
				                	</select>
				                </td>
				                <td><input class="form-control first_control" type="text"  name="special_code[]" readonly="readonly"/></td>
				                <td class='hidden-print'><a class="add_a_row btn btn-primary" href="javascript:void(0);" disabled="disabled">Add Row</a></td>
				            </tr>
				         </tbody>   
			        </table>
			    </div>
			</div> 
		    
		    
		 <div class="row">
		        <div class="col-sm-12">
			        <table id="" class="table">
			            <tr>
			            	<td colspan="5">
			            		<div class="form-group pull-right">
			            			<label for='grand_total' class="control-label"><span style="font-weight: bold;">Grand Total:</span></label>
			            			<input class="form-control" type="text" id="grand_total" name="grand_total" readonly/>
			            		</div>
			            	</td>
			            </tr>
			        </table>
			    </div> 
		   </div>
		   
		   <div class="row">
			<div class="col-sm-12">
				<a href="#"   id="resetBtn" class="btn btn-default btn-icon icon-left hidden-print pull-left">
				      <?php echo get_phrase('reset');?>
				     <i class="entypo-cancel-circled"></i>
				</a>
						
				<button type="submit" id="btn_post_voucher" class="btn btn-default btn-icon icon-left hidden-print pull-left">
				     <?php echo get_phrase('post_voucher');?>
				     <i class="entypo-thumbs-up"></i>
				</button>
				
		
				<div style="display: none" id='btnDelRow' class="btn btn-default btn-icon icon-left hidden-print pull-left">
				      <?php echo get_phrase('remove_item_row');?>
				     <i class="entypo-minus-circled"></i>
				</div>					
						
				<!-- <div id='addrow' class="btn btn-default btn-icon icon-left hidden-print pull-left">
				      <?php echo get_phrase('new_item_row');?>
				     <i class="entypo-plus-circled"></i>
				</div> -->
					
			</div>
		
		</div>
		    
				

		</form>    
	</div>
	
</div>
</div>
</div>

</div>

<script type="text/javascript">

    //Fuction to disable or enable controls
    function disableOrEnableControls(bolean_passed){
    	//Disable the inputs
        $('.first_control').each(function (){
           
            $(this).attr('readonly',bolean_passed);
        });
        	//Disable 'Add Row' button
        $('.add_a_row').attr('disabled',bolean_passed);
    }

    //Check first if the DOM has loaded before finding elements
	$(document).ready(function()
	{
		
		$("#voucher_type").change(function(){
			
		//Enable the add row button and other input controls (textbox and select) only when value other zero is selected
		if($(this).val()!='#'){
			
			disableOrEnableControls(false);
        }
        else{
        	
        	disableOrEnableControls(true);
        }
						
		//Check if the value selected is 'CHQ' and then unhide the div
		if($(this).val()=='CHQ')
		{
		 //Find the cheque no and switch divs and remove hidden
		 $('#cheque_no_div').attr('hidden',false);
		 
		 $('#label-toggle-switch').attr('hidden',false);
		 
		 $('#voucher_cheque_number').attr('readonly', false);
		 
		 //Clear the text in voucher cheque number first if any value
		 
		 $('#voucher_cheque_number').val('');
		 
			
			
		}
		else{
		//Find the cheque no and switch divs and remove hidden
		 $('#cheque_no_div').attr('hidden',true);
		 
		 $('#label-toggle-switch').attr('hidden',true);
		 
		 $('#voucher_cheque_number').attr('readonly', true);
			
		}
	});
	
	//Cloning the tr in  a table
	
	$(function() {
    $(".add_a_row").click(function(){
       var clone = $(this).closest('tr').clone(true);
       //modfy the dom
       $("td:last-child", clone).html('<a  href="javascript:void(0);" class="remove_a_row btn btn-primary hidden-print">Remove</a>');
       clone.insertAfter( $(this).closest('tr'));
    });
    $("table.table").on('click','.remove_a_row',function(){
        $(this).parent().parent().remove();
    });
   });
});
	
	
	
</script>


<!-- <script type="text/javascript">

$(document).ready(function(){
	$("#go_btn").click(function(){
		//var VNum = $("#VNumber").val();
		alert('hello');
		
		//showAjaxModal('<?php //echo base_url();?>ifms.php/modal/popup/modal_search_voucher/'//+VNum);
	});
	
	
	// $('.datepicker').datepicker({
		// //format: 'yyyy-mm-dd',
		// //startDate:'<?php //echo $this->finance_model->next_voucher($this->session->userdata('center_id'))->current_voucher_date;?>',
		// //endDate:'<?php //echo $this->finance_model->next_voucher($this->session->userdata('center_id'))->end_month_date;?>'
	// });
	
$("#voucherType").live('change', function() {
    alert('The option with value ' + $(this).val());
});

</script> -->