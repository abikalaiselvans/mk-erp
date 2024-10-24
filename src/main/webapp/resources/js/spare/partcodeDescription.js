
var position="";


function callAjaxMethod(type,url,param,successMethod) 
{
	
	$.ajax({
		url:url,
		type:type,
		data:param,
		success:function(result)
		{
			successMethod(result);
			
		}
	});
}

function loadpartCodedropdown(idposition) 
{
	var param = { "generalgroup":document.getElementById("generalgroup"+idposition).value };
	position = idposition;
	callAjaxMethod("POST","loadpartCodedropdown",param,loadpartCodedropdownMessage);
}


function loadpartCodedropdownMessage(result) 
{
	try
	{
		
		var rowLength =  result.length;
		var _targ=document.getElementsByName('partcode'+position)[0];
		
		if(rowLength === 0) 
		{
			     _targ.options.length=0;
			     _targ.options[0]=new Option('Select Part code','0');  	
		}	
		else 
		{
			 _targ.options.length=0;
		     _targ.options[0]=new Option('Select Part code','0');  	
			for (var index = 0;index<rowLength;index++) 
	   		{
				_targ.options[index+1]=new Option(result[index].code,result[index].id);
	   	    }
	   	}
		
	}
	catch(err)
	{
		alert(err.desc);
	}
	
}



function loadpartCodeDescription(idposition) 
{
	var param = { "partcode":document.getElementById("partcode"+idposition).value };
	position = idposition;
	callAjaxMethod("POST","loadpartCodeDescription",param,loadpartCodeDescriptionrMessage);
}


function loadpartCodeDescriptionrMessage(result) 
{
	try
	{
		var rowLength =  result.length;
		var  gdescription ;
		if(rowLength === 0) 
			$("#idescription"+position).val("");
			
		else 
		{
	   		for (var index = 0;index<rowLength;index++) 
	   		{
	   			$("#idescription"+position).val(result[index].description);
	   	    }
	   	}
		
	}
	catch(err)
	{
		alert(err.desc);
	}
	
}
