/*THE FOLLOWING ALL FUNCTIONS ARE USED FOR EQUIPMENT MAKE MODULE*/


 

/* Action for Equipment Make EDIT button */
$('#Edit').unbind("click").on("click",function() 
	{
	var selectedId = getSelectedRowIds().toString();
	checkboxesLength = checkCheckboxesLength();
	var countSelectedCheckLength = getSelectedRowIds().length;
	if(checkboxesLength === 0) 
	{
		alertBox("Alert Information","Return not available","alert-danger");
	}
	else if(countSelectedCheckLength == 0) 
	{
  		
  		alertBox("Alert Information","Please select atleast one value","alert-danger");
  	}
  	else if(countSelectedCheckLength>=2) 
  	{
  			alertBox("Alert Information","You can select only one record","alert-danger");
  			uncheckCheckBoxes();
  	}
  	else 
  	{
  		var param = {"rowid":selectedId};
  		callAjaxMethod("POST","editIssueSlipReturn",param,bindEditValues);
   }
});
 

function bindEditValues(result) 
{
	try
	{
		$("#storagelocation").html (result[0].storagelocation);
		$("#serviceordernumber").html(result[0].serviceordernumber);
		$("#documentdate").html(result[0].documentdate);
		$("#customername").html(result[0].customername);
		$("#location").html(result[0].locationname);
		$("#documenttype").html(result[0].documenttype);
		$("#customeraddress").html(result[0].customeraddress);
		$("#erowid").val(result[0].rowid);
		$("#issuerefno").val(result[0].issuerefno);
		
		 
		$("#rowcount").val("0");
		
		for(u=0;u<result[0].items.length;u++)
			addTr();
		
		
		var x = result[0].items.length+1;
		var y = $('#mytable tr').size();
		 
		for(u=x;u<y;u++)
		{	
				if($('#mytable tr').size()>x)
					$('#mytable tr:last-child').remove();
		}
		
		 
		
		
		
		$("#rowcount").val(result[0].items.length);
		
		for(u=0;u<result[0].items.length;u++)
		{
			$("#generalgroupname"+u).html(result[0].items[u].generalgroupname);
			$("#idescription"+u).html(result[0].items[u].idescription);
			$("#iquantity"+u).html( result[0].items[u].iquantity);
			$("#ivalue"+u).html(result[0].items[u].ivalue);
			$("#iindentnumber"+u).html( result[0].items[u].iindentnumber);
			$("#iserialnumber"+u).html(result[0].items[u].iserialnumber);
			$("#ioldserialnumber"+u).val(result[0].items[u].iserialnumber);
			$("#partcodename"+u).html(result[0].items[u].partcodename); 
			
		}	
		showActionModal("UpdateIssueSlipReturn","Update");
		
	}
	catch(err)
	{
		alert(err)
	}
}


function removeTr()
{
	$('#mytable tbody tr').remove();
	 irow = 0;
	 isize=0;
}


 

/* Action for Equipment type CLOSE button */
$('#Close').unbind("click").on("click",function() {
	
	showConformDialog("Are you really want to close ?","If you close, you can't add your new record.","proceedCloseAction") 
	  
});


 

/* This function is used for uncheck the all checkboxes if checked */
function uncheckCheckBoxes() {
	$('#contentTable').find("input[type = 'checkbox']").prop("checked",false);
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
function loadIssueSlipReturn(letter) 
{
	 
	var param = {"startLetter":letter ,
			"day":$("#day").val(),
			"month":$("#month").val(),
			"year":$("#year").val(),
			"status":$("#status").val()
			};
	callAjaxMethod("POST","sortIssueSlipReturn",param,loadIssueSlipReturnMessage);
}
 	
function loadIssueSlipReturnMessage(result) 
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
	   			 
	   			
	   			if( result[index].cancel === "Cancel")
	   			{
	   				content += "<tr  class='danger'>";
	   				content += "<td>"+(index+1)+".</td>";
	   			}
	   			else
	   			{
	   				content += "<tr>";
	   				content += "<td>"+(index+1)+". <input type='checkbox'  name='rowid' class ='checkList' value= '"+result[index].rowid+"'></td>";
	   			}	
				content += "<td>"+result[index].issuerefno+"</td>";
				content += "<td>"+result[index].serviceordernumber+"</td>";
				content += "<td>"+result[index].customername+"</td>";
				content += "<td>"+result[index].documentdate+"</td>";
				content += "<td>"+result[index].cancel+"</td>";
				content += "<td>"+result[index].createdby+"</td>";
				content += "<td> ";
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


/* This function will used for get the select the checked check box contents */
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
		window.location.href = "home";
		uncheckCheckBoxes();
	}
	catch(err)
	{
		alert(err);
	}
}

