 $(document).ready(function()
{		 
	 //Upper case
	$('.uCaptilized').keyup(function(){
	    this.value = this.value.toUpperCase();
	});

	//Lower case
	$('.uLowercase').keyup(function(){
	    this.value = this.value.toLowerCase();
	});
	
});
 
 

 function alertBox(title,content,bgClass)
 {
 	$('#alert-title').html(title+"!");
 	$('#alert-content').html(" "+content);
 	$('#alertBox').addClass(bgClass);
 	$('#alertBox').show();
 	$('#alertBox').delay(3000).fadeOut('slow');
 	
 }
 
 
 
 function clear_form_elements(class_name)
 {
	  jQuery("."+class_name).find(':input').each(function() 
			  {
		  		switch(this.type) 
		  		{
			        case 'password':
			        case 'text':
			        case 'textarea':
			        case 'file':
			        case 'select-one':
			        case 'select-multiple':
			            jQuery(this).val('');
			            break;
			        case 'checkbox':
			        case 'radio':
			            this.checked = false;
		  		}
			  });
	}
 
 
  