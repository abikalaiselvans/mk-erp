/*THE FOLLOWING ALL FUNCTIONS ARE USED FOR EQUIPMENT MAKE MODULE*/

 
 

/* Action for Equipment type CLOSE button */
$('#Close').unbind("click").on("click",function() {
	
	showConformDialog("Are you really want to close ?","If you close, you can't add your new record.","proceedCloseAction") 
	  
});


function showConformDialog(content,subContent,proceedId) 
{
	 
	$("#content").html(content);
	$('#subContent').html(subContent);
    $('.proceedId').attr("id",proceedId);
    $('.conformDialog').modal('show');
   $('#'+proceedId).unbind("click").on("click",function()
		   {
			   if(proceedId === "proceedCloseAction")
			   {
				CloseProceed();
			    }
	});
}

 
function CloseProceed()
{
	try
	{
		window.location.href = "Spareindex";
		uncheckCheckBoxes();
	}
	catch(err)
	{
		alert(err);
	}
}


/* Global method for AJAX call */
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




//Loading data
/* This function used for sorting based on the letter */
function loadDemand(letter) 
{
	var param = {"startLetter":letter ,
			"day":$("#day").val(),
			"month":$("#month").val(),
			"year":$("#year").val(),
			"status":$("#status").val()
			};
	 		callAjaxMethod("POST","sortloadDemand",param,loadDemandMessage);
}


/* Success method for startLetter as well as to replace the sorted content on table */   	
function loadDemandMessage(result) 
{
	try
	{
		 
		var rowLength =  result.length;
		var content="";
	   	if(rowLength === 0) 
		{
			content +=  "<tr><td colspan='12' class = 'star'><center><b>Data not found...</b></center></td></tr>";
		}
		else 
		{
	   		for (var index = 0;index<rowLength;index++) 
	   		{
	   			if( result[index].cancel === "Cancel" || result[index].status != "N")
	   			{
	   				content += "<tr  class='danger'>";
	   				content += "<td>"+(index+1)+".</td>";
	   			}
	   			else
	   			{
	   				content += "<tr>";
	   				content += "<td>"+(index+1)+". <input type='checkbox'  name='rowid' class ='checkList' value= '"+result[index].rowid+"'></td>";
	   			}	
				content += "<td>"+result[index].demandno+"</td>";
				content += "<td>"+result[index].callnumber+"</td>";
				content += "<td>"+result[index].customername+"</td>";
				content += "<td>"+result[index].customeraddress+"</td>";
				content += "<td>"+result[index].creationtime+"</td>";
				
				if( result[index].cancel === "Cancel")
					content += "<td>Cancelled</td>";
				else 
					content += "<td>&nbsp;</td>";
				
				
				if(result[index].status == "Y")
					content += "<td><b>Issued</b></td>";
				else if(result[index].status == "P")
					content += "<td><b>Partially Issued</b></td>";
				else 
					content += "<td><b>Pending</b></td>";

				content += "<td>"+result[index].createdby+"</td>";
				content += "<td> ";
				content += "<span class='badge'>"+result[index].demandage+" -days ago </span>&nbsp;";
				//content += "<a target='_blank' href='DemandPrint/"+result[index].rowid+"'><span class='glyphicon glyphicon-print'></span>&nbsp;Print</a> "; 
				 
				if( result[index].cancel != "Cancel" && result[index].status != "Y" ) 
					content += "<a href='DemandIssue/"+result[index].rowid+"'><span class='glyphicon glyphicon-upload'></span>&nbsp;Issue</a>  ";
				
				content += "</td>";
								
				content += "</tr>";
	   	    }
	   	}
		$('#contentTable tbody').html(content);
	}
	catch(err)
	{
		alert(err.desc);
	}
	
}


 





$('.madalClose').unbind("click").on("click",function() {
	uncheckCheckBoxes();
});



 
 

