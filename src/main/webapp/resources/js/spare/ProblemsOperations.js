/*THE FOLLOWING ALL FUNCTIONS ARE USED FOR PROBLEM MODULE*/


/* Action for Equipment Make ADD button */
$('#Add').unbind("click").on("click",function() 
	{
	
		$("#name").val("");
		document.getElementById("egroupid").selectedIndex = "";
		$("#description").val("");
		$("#erowid").val("0");
		showActionModal("AddProblems","Add");
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
  		callAjaxMethod("POST","editProblems",param,bindEditValues);
   }
});
 

function bindEditValues(result) 
{
	try
	{
		$("#name").val(result[0].name);
		$("#description").val(result[0].description);
		$("#erowid").val(result[0].rowid);
		$("#egroupid").val(result[0].groupid);
		showActionModal("UpdateProblems","Update");
		
	}
	catch(err)
	{
		alert(err)
	}
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
function loadProblems(letter)  
{
	var param = {"startLetter":letter ,"groupid":document.getElementById('groupid').value};
	callAjaxMethod("POST","sortProblems",param,loadProblemsMessage);
}
/* Success method for startLetter as well as to replace the sorted content on table */   	
function loadProblemsMessage(result) 
{
	try
	{
		var rowLength =  result.length;
		var content="";
	   	var id,name,groupname;
	   	if(rowLength === 0) 
		{
			content +=  "<tr><td colspan='3' class = 'star'><center><b>Data not found...</b></center></td></tr>";
		}
		else 
		{
	   		for (var index = 0;index<rowLength;index++) 
	   		{
	   			id = result[index].rowid;
	   			name = result[index].name;
	   			groupname = result[index].groupname;
	   			content += "<tr>";
				content += "<td>"+(index+1)+". <input type='checkbox'  name='equTypeId' class ='checkList' value= '"+id+"'></td>";
				content += "<td>"+groupname+"</td>";
				content += "<td>"+name+"</td>";
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
	$("#AddEditFormModel").attr("action",actionName);
	$('#formButton').html("<span class='glyphicon glyphicon-ok'></span>&nbsp;"+buttonName);
	$('#showAddEditModel').modal('show');
	 
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
		callAjaxMethod("POST","deleteProblems",param,bindModifiedList);	
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
		window.location.href = "Problems";
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

