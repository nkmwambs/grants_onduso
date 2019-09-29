<?php
	$system_name        =	$this->db->get_where('settings' , array('type'=>'system_name'))->row()->description;
	$system_title       =	$this->db->get_where('settings' , array('type'=>'system_title'))->row()->description;
	$text_align         =	$this->db->get_where('settings' , array('type'=>'text_align'))->row()->description;
	//$account_type       =	$this->session->userdata('login_type');
	$message = !isset($message)? $message = "": $message = $message;
	$skin_colour        =   $this->db->get_where('settings' , array('type'=>'skin_colour'))->row()->description;
	$active_sms_service =   $this->db->get_where('settings' , array('type'=>'active_sms_service'))->row()->description;
	?>
<!DOCTYPE html>
<html lang="en" dir="<?php if ($text_align == 'right-to-left') echo 'rtl';?>">
<head>
	
	<title><?php echo $page_title;?> | <?php echo $system_title;?></title>
    
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="" />
	<meta name="author" content="FreePhpSoftwares" />
	
	

	<?php include 'includes_top.php';?>
	<?php include 'privileges.php';?>
</head>
<body class="page-body <?php if ($skin_colour != '') echo 'skin-' . $skin_colour;?> page-fade-only">
	<div class="page-container sidebar-collapsed <?php if ($text_align == 'right-to-left') echo 'right-sidebar';?>" >
		<?php include 'navigation.php';?>	
		<div class="main-content">
		
			<?php include 'header.php';?>
				<hr />
					<div class="row">
						<div class="col-xs-6">
							<h3 style="" class="pull-left">
						       <i class="entypo-right-circled"></i> 
									<?php echo $page_title;?>
						    </h3>
						  </div>
						  
						  <div class="col-xs-6 pull-right;">
						  								  		
						  		<div class="btn-group pull-right">
						  			<button class="btn btn-default" title="<?=get_phrase('back');?>" onclick="javascript:go_back();"><i class="fa fa-backward"></i></button>
						  			<button class="btn btn-default" title="<?=get_phrase('forward');?>" onclick="javascript:go_forward();"><i class="fa fa-forward"></i></button>
						  		</div>
						  </div>  
						    
						
					</div>
					
				<hr />
				<div class="page-content">	
		           <!--Showing Progress GIF. Must be available in evert form-->
					<div class="inner-progress"><?=$message;?></div>
					<?php include $view_type.'/'.$page_name.'.php';?>
				</div>
			<?php include 'footer.php';?>

		</div>
		<?php //include 'chat.php';?>
        	
	</div>
    <?php include 'modal.php';?>
    <?php include 'includes_bottom.php';?>
    <!-- <script src="<?=base_url();?>assets/js/ci-custom-ajax.js"></script> -->
</body>
</html>