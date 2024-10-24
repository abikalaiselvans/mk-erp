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
function loadIssueSlip(letter) 
{
	
	var param = {"startLetter":letter ,
			"day":$("#day").val(),
			"month":$("#month").val(),
			"year":$("#year").val(),
			"status":$("#status").val()
			
			};
	callAjaxMethod("POST","sortIssueSlip",param,loadIssueSlipMessage);
}
/* Success method for startLetter as well as to replace the sorted content on table */   	
function loadIssueSlipMessage(result) 
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
   				 
	   			/*if(index%2 == 0)
   					content += "<tr class='even' role='row'  >";
   				else
   					content += "<tr class='odd' role='row'  >";
	   			*/
	   			content += "<tr>";
   				content += "<td>"+(index+1)+".</td>";
				content += "<td>"+result[index].isueslipno+"</td>";
				content += "<td>"+result[index].customer+"</td>";
				content += "<td>"+result[index].callnumber+"</td>";
				content += "<td>"+result[index].machinenumber+"</td>";
				content += "<td>"+result[index].issuedate+"</td>";
				if(result[index].returnstatus == "Y")
					content += "<td class='success'><b>Returned</b></td>";
				else
					content += "<td class='danger'><b>Pending</b></td>";
				
				content += "<td> ";
				content += "<a target='_blank' href='isueslipnoPrint?id="+result[index].isueslipno+"'><span class='glyphicon glyphicon-print'></span>&nbsp;Print</a> &nbsp;&nbsp; ";
				if(result[index].returnstatus == "N")
					content += "<a target='_blank' href='IssueSlipReturn/"+result[index].rowid+"'><span class='glyphicon glyphicon-random'></span>&nbsp;Return</a> &nbsp;&nbsp; ";
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



 
 

/* Action for Equipment type CLOSE button */
$('#Close').unbind("click").on("click",function() {
	
	showConformDialog("Are you really want to close ?","If you close, you can't add your new record.","proceedCloseAction") 
	  
});


  
function uncheckCheckBoxes() {
	$('#contentTable').find("input[type = 'checkbox']").prop("checked",false);
}



 
function getSelectedRowIds() 
{
	var selectedEquTypeIdArray = [];
   	$('#contentTable').find("input[type = 'checkbox']").each(function(index,element){
   		if($(this).prop('checked'))
   			selectedEquTypeIdArray.push($(this).val());
   	});
   	return selectedEquTypeIdArray;
}
   

function checkCheckboxesLength() 
{
	var checkboxesLength = $('#contentTable').find("input[type = 'checkbox']").length;
	return checkboxesLength;
}







$('.madalClose').unbind("click").on("click",function() {
	uncheckCheckBoxes();
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

