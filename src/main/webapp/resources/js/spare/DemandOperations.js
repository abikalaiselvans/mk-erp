/*THE FOLLOWING ALL FUNCTIONS ARE USED FOR EQUIPMENT MAKE MODULE*/


/* Action for Equipment Make ADD button */
 


$('#Add').unbind("click").on("click",function() 
	{
		clear_form_elements('clear_form_elements');
		showActionModal("AddDemand","Add");
		
		var sessionofficeid =$('#sessionofficeid').val();
		setOptionValue('location',sessionofficeid);
		
		$('#storagelocation').val('TOS');
		var y = $('#mytable tr').size();
		for(u=1;u<y;u++)
		{
			if($('#mytable tr').size()>1)
			{
			    $('#mytable tr:last-child').remove();
			    document.getElementById('rowcount').value = $('#mytable tr').size()-1;
			}
		}
});




/* Action for Equipment Make EDIT button */
$('#Edit').unbind("click").on("click",function() 
	{
	var selectedId = getSelectedRowIds().toString();
	checkboxesLength = checkCheckboxesLength();
	var countSelectedCheckLength = getSelectedRowIds().length;
	if(checkboxesLength === 0) 
	{
		alertBox("Alert Information","Edit not available","alert-danger");
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
  		callAjaxMethod("POST","editDemand",param,bindEditValues);
   }
});
 

function bindEditValues(result) 
{
	try
	{
		 
		$("#storagelocation").val(result[0].storagelocation);
		$("#customername").val(result[0].customername);
		setOptionValue('location',result[0].location);
		$("#documenttype").val(result[0].documenttype);
		$("#customeraddress").val(result[0].customeraddress);
		$("#contactname").val(result[0].contactname);
		$("#contactnumber").val(result[0].contactnumber);
		$("#callnumber").val(result[0].callnumber);
		$("#machineserialnumber").val(result[0].machineserialnumber);
		
		$("#erowid").val(result[0].rowid);
		$("#demandno").val(result[0].demandno);
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
			$("#generalgroup"+u).val(result[0].items[u].generalgroupid);
			loadpartCodedropdown(u);
			//alert("You want to edi the Issueslip");
			alert(result[0].items[u].partcode)
			$("#idescription"+u).val(result[0].items[u].idescription);
			$("#idefectiveserialnumber"+u).val( result[0].items[u].idefectiveserialnumber);
			$("#partcode"+u).val(result[0].items[u].partcode); 
			
			
		}	
		showActionModal("UpdateDemand","Update");
		
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



/* Action for Equipment type DELETE button */
$('#Delete').unbind("click").on("click",function() 
  {
	var selectedIds = getSelectedRowIds().toString().length;
  	var checkboxesLength = checkCheckboxesLength();
  	if(checkboxesLength === 0) 
  	{
		 
		alertBox("Alert Information","Delete not avalable","alert-danger");
	}
  	else if(selectedIds != null &&  selectedIds > 0)
  	{
  		//$('#showDeleteModal').modal('show');
  		showConformDialog("Are you really want to delete ?","If you delete, you loss the selected records","proceedDeleteAction") 
  		
  	}
  	else 
  	{
  		alertBox("Alert Information","Please select atleast One value","alert-danger");
  	}
});
 

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
				content += "<a target='_blank' href='DemandPrint/"+result[index].rowid+"'><span class='glyphicon glyphicon-print'></span>&nbsp;Print</a> "; 
				if( result[index].cancel != "Cancel"    && (result[index].status == "N") )
					content += "<a href='DemandCancel/"+result[index].rowid+"'><span class='glyphicon glyphicon-trash'></span>&nbsp;Cancel</a> ";
				
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


function DeleteProceed()
{
	try
	{
		var selectedIds = getSelectedRowIds().toString();
		var param = {"rowids":selectedIds};
		callAjaxMethod("POST","deleteDemand",param,bindModifiedList);	
	}
	catch(err)
	{
		alert(err);
	}
}

/* AJAX success method for DELETED records */
function bindModifiedList(result) 
{
	if(result == "success") 
	{
		window.location.href = "Demand";
   	}
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

