
 
 


var position="";
function loadSerialnumberIssueslip(idposition) 
{
	var param = { "partcode":document.getElementById("partcode"+idposition).value };
	position = idposition;
	callAjaxMethod("POST","loadSerialnumberIssueslip",param,loadSerialnumberIssueslipMessage);
}


function loadSerialnumberIssueslipMessage(result) 
{
	try
	{
		var rowLength =  result.length;
		if(rowLength === 0) 
			$("#idescription"+position).val("");
			
		else 
		{
	   		for (var index = 0;index<rowLength;index++) 
	   		{
	   			$("#iindentnumber"+position).val(result[index].serial);
	   	    }
	   	}
		
	}
	catch(err)
	{
		alert(err.desc);
	}
	
}




function searchSerialNumberIssueslip(idposition) 
{
	try
	{
		var partcode = $("#partcode"+idposition).val();
		var serial = $("#iserialnumber"+idposition).val();  
		position = idposition;
		if(partcode == "") 
		{ 
			//alertBox("Alert Information","Kindly select the partcode","alert-danger");
			alert("Kindly select the part code..."); 
			$("#partcode"+idposition).focus();
			
		}
		else
		{	
			$('#iserialnumber'+position).autocomplete(
				{
					source: function( request,response ) 
					{
						$.ajax(
								{
								  	url:"loadSerialnumberIssueslip",
									type:"GET",
									data:{"partcode":partcode,"serial":serial},
									success:function(result)
									{
										SearchResult(result,response);
									} 
								});
					},
					
		            error: function (msg) 
		            {
		                   alert(msg.status + ' ' + msg.statusText);
		            },
		            
					select: function(event, ui) 
					{
						$("#ivalue"+position).val(parseFloat(ui.item.price)*2);
					}
					});
		}
	}
	catch(err)
	{
		alert(err);
	}
}	




function SearchResult(result,response) 
{
	try
	{
	 
		var searchArr = [];
		var response_length = result.length;
		if(response_length != null && response_length > 0) 
		{
			$('#formButton').show() ;
			for (var index = 0 ; index < response_length ; index++) 
			{
				searchArr.push({label: result[index].iserial , value : result[index].iserial, price : result[index].iprice });
			}
			 
		}
		else 
		{
			$('#formButton').hide();
			searchArr.push("");
			alert("Kindly check the data");
		}
		response(searchArr);
	}
	catch(err)
	{
		alert(err);
	}

}





/*

(function ($) {
	 $.widget("ui.combobox", {
	     _create: function() {
	         var wrapper = this.wrapper = $("<span />").addClass("ui-combobox")
	             , self = this;
	         this.element.wrap(wrapper);
	         this.element
	             .addClass("ui-state-default ui-combobox-input ui-widget ui-widget-content ui-corner-left")
	             .autocomplete($.extend({
	                 minLength: 0
	             }, this.options));
	         $("<span />")
	             .insertAfter(this.element)
	             .button({
	                 icons: {
	                     primary: "ui-icon-triangle-1-s"
	                 },
	                 text: false
	             })
	             .removeClass("ui-corner-all")
	             .addClass("ui-corner-right ui-combobox-toggle")
	             .click(function () {
	                 if (self.element.autocomplete("widget" ).is(":visible")) {
	                 }
	             });
	     },
	     
	     destroy: function() 
	     {
	         this.wrapper.remove();
	         $.Widget.prototype.destroy.call(this);
	     }
	 });
	 })(jQuery);


function loadPartcodeids(idposition)
{
	try
	{
		 $("#partcode"+idposition).combobox({
	         source: function( request,response ) {
	        	  $.ajax({
					  	url:"loadPartcodeids",
						type:"GET",
						data:{"partcode":request.term},
						success:function(result)
						{
							loadPartcodeidResult(result,response);
						} 
				  });
	         }
	     });
		
	}
	catch(err)
	{
		alert(err);
	}
}



function loadPartcodeidResult(result,response) 
{
	var searchArr = [];
	var response_length = result.length;
	if(response_length != null && response_length > 0) 
	{
		for (var index = 0 ; index < response_length ; index++) 
			searchArr.push(result[index].field1);
		
	}
	else 
		searchArr.push("");
	response(searchArr);
}
*/
