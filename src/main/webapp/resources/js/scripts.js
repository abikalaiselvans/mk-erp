
$(document).ready(function() 
		{
	
    /*
        Fullscreen background
    */
    $.backstretch("resources/img/backgrounds/1.jpg");
    
    $('#top-navbar-1').on('shown.bs.collapse', function(){
    	$.backstretch("resize");
    });
    $('#top-navbar-1').on('hidden.bs.collapse', function(){
    	$.backstretch("resize");
    });
    
   
    /*
        Form validation
    */
    $('.registration-form input[type="text"],.registration-form input[type="password"],.registration-form textarea').on('focus', function() 
    		{
    		$(this).removeClass('input-error');
    });
    
    $('.registration-form').on('submit', function(e) {
    	
    	$(this).find('input[type="text"],input[type="password"], textarea').each(function(){
    		if( $(this).val() == "" ) {
    			e.preventDefault();
    			$(this).addClass('input-error');
    		}
    		else {
    			$(this).removeClass('input-error');
    		}
    	});
    	
    });
	/* 
		Tooltip 
	*/
    $('input[rel="txtTooltip"]').tooltip(); 
	$('select[rel="txtTooltip"]').tooltip(); 
	$('textarea[rel="txtTooltip"]').tooltip(); 
	
    /*
		Clear modal values
	*/	
	clearModalValues("career");
	clearModalValues("forget");
	clearModalValues("verification");
	function clearModalValues(modalId){
				//alert("......."+modalId);
				$('#'+modalId).on('hidden.bs.modal',function(){
					$('input:text').val("");
					$('textarea').val("");
					$("select").val("0");
					//$('input[type='checkbox']').attr("checked",false);
					$("#career input[type='checkbox']").prop("checked",false);
					//$("input[type='radio']").attr("checked",false);//
					//$("#forget input[type='radio']").prop("checked",false);
					
				});
			}
			//$('a').on("click",function(e){
				//e.preventDefault();
			//});
			
	/*
		Date Time Picker
	*/
	$('.form_date').datetimepicker({
				language:  'fr',
				weekStart: 1,
				todayBtn:  1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				minView: 2,
				forceParse: 0
			});
		
	/*
		Toggle buttons
	*/	
	$('.btn-toggle').click(function() {
		$(this).find('.btn').toggleClass('active');  
		
		if ($(this).find('.btn-primary').size()>0) {
			$(this).find('.btn').toggleClass('btn-primary');
		}
		if ($(this).find('.btn-danger').size()>0) {
			$(this).find('.btn').toggleClass('btn-danger');
		}
		if ($(this).find('.btn-success').size()>0) {
			$(this).find('.btn').toggleClass('btn-success');
		}
		if ($(this).find('.btn-info').size()>0) {
			$(this).find('.btn').toggleClass('btn-info');
		}
		
		$(this).find('.btn').toggleClass('btn-default');
		   
	});
	/*
		Caps Lock on alert
	*/
	$('[type=password]').keypress(function(e) {
  var $password = $(this),
      tooltipVisible = $('.tooltip').is(':visible'),
      s = String.fromCharCode(e.which);
  
  //Check if capslock is on. 
  //Tests if letter is upper case and the shift key is NOT pressed.
  if ( s.toUpperCase() === s && s.toLowerCase() !== s && !e.shiftKey ) {
    if (!tooltipVisible)
    	$password.tooltip('show');
  } else {
    if (tooltipVisible)
    	$password.tooltip('hide');
  }
  
  //Hide the tooltip when moving away from the password field
  $password.blur(function(e) {
    $password.tooltip('hide');
  });
});

});

