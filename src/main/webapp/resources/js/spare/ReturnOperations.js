$('#BulkReceived').unbind("click").on("click",function() 
	{
		clear_form_elements('clear_form_elements');
		showActionModal("BulkReceived","Submit");
});


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
function loadReturn(letter) 
{
	
	var param = {"startLetter":letter ,
			"day":$("#day").val(),
			"month":$("#month").val(),
			"year":$("#year").val(),
			"status":$("#status").val()
			
			};
	callAjaxMethod("POST","sortReturn",param,loadReturnMessage);
}
/* Success method for startLetter as well as to replace the sorted content on table */   	
function loadReturnMessage(result) 
{
	try
	{
		var rowLength =  result.length;
		var content="";
	   	if(rowLength === 0) 
		{
			content +=  "<tr><td colspan='9' class = 'star'><center><b>Data not found...</b></center></td></tr>";
		}
		else 
		{
	   		for (var index = 0;index<rowLength;index++) 
	   		{
   				content += "<tr>";
   				content += "<td>"+(index+1)+".</td>";
				content += "<td>"+result[index].returnno+"</td>";
				content += "<td>"+result[index].issuenumber+"</td>";
				content += "<td>"+result[index].issueserialnumber+"</td>";
				
				if(result[index].serialnumber=="null")
					content += "<td><a href=''><span class='label label-danger'>Need SerialNumber</span></</a></td>";
				else
				{
					if(result[index].issueserialnumber == result[index].serialnumber)
						content += "<td>"+result[index].serialnumber+"</td>";
					else
						content += "<td><span class='label label-danger'>"+result[index].serialnumber+"</span></td>";
					
				}
				
					
				
				content += "<td>"+result[index].returndate+"</td>";
				if(result[index].receivedstatus == "N")
					content += "<td><span class='label label-danger'>Pending</span></td>";
				else
					content += "<td><span class=''label label-primary''>Received</span></td>";
				
				content += "<td> ";
				if(result[index].receivedstatus == "N")
					content += "<a  href='ReturnserialNumberreceived/"+result[index].rowid+"'><span class='glyphicon glyphicon-cog'></span>&nbsp;Receive</a> &nbsp;&nbsp; ";
				content += "</td>";
				
				//Quality status
				content += "<td>&nbsp;";
				if(result[index].receivedstatus == "Y")
				{
					if(result[index].qualitystatus == "N")
						content += "<span class='label label-danger'>Quality Test Pending</span>";
					else if(result[index].qualitystatus == "Y")
						content += "<span class='label label-primary'>Good</span>";
					else
						content += "<span class='label label-danger'>Bad</span>";
					
				}
				else	
					content += "&nbsp;";
				content += "</td>";
				
				
				content += "<td>&nbsp;";
				if(result[index].receivedstatus == "Y")
				{
					if(result[index].qualitystatus == "N")
						content += "<a  href='Javascript:QualityStatus("+result[index].rowid+")'><span class='glyphicon glyphicon-cog'></span>&nbsp;Quality Status</a> ";
					else
						content += "&nbsp;";
					
				}
				else	
					content += "&nbsp;";
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



function QualityStatus(rowid)
{
	try
	{
		var person = prompt("Please enter your status Y-Good, B - Bad ", "Y");
		if (person != null  && person != "") 
		{
			if(person.length >1)
			{
				alert("Kindly give the correct input")
			}
			else
			{
				var desc = prompt("Please enter your description", "");
				window.location.href = "QualityStatus/"+rowid+"/"+person+"/"+desc;
			}
		}
		
	 
		
	}
	catch(err)
	{
		alert(err);
	}

}
 

/* Action for Equipment type CLOSE button */
$('#Close').unbind("click").on("click",function() {
	
	showConformDialog("Are you really want to close ?","If you close, you can't add your new record.","proceedCloseAction") 
	  
});


 

 

function showActionModal(actionName,buttonName) 
{
	try
	{
		$("#AddEditFormModel").attr("action",actionName);
		$('#formButton').html("<span class='glyphicon glyphicon-ok'></span>&nbsp;"+buttonName);
		$('#showAddEditModel').modal('show');
		 
	}
	catch(err)
	{
		alert(err);
	}
}



function showConformDialog(content,subContent,proceedId) 
{
	try
	{
		$("#content").html(content);
		$('#subContent').html(subContent);
	    $('.proceedId').attr("id",proceedId);
	    $('.conformDialog').modal('show');
	   $('#'+proceedId).unbind("click").on("click",function()
			   {
			if(proceedId === "proceedDeleteAction") 
			{
				DeleteProceed();
			}
			else if(proceedId === "proceedCloseAction")
			{
				CloseProceed();
			}
		});
	}
	catch(err)
	{
		alert(err);
	}
}

 


function CloseProceed()
{
	try
	{
		alert("")
		window.location.href = "Spareindex";
		 
	}
	catch(err)
	{
		alert(err);
	}
}

