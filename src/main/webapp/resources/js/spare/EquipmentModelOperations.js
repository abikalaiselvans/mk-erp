/*THE FOLLOWING ALL FUNCTIONS ARE USED FOR EQUIPMENT TYPE MODULE*/


/* Action for Equipment type ADD button */
$('#Add').unbind("click").on("click",function() 
	{
		
		document.getElementById("eequipementtypeid").selectedIndex = "";
		document.getElementById("eequipementmakeid").selectedIndex = "";
		$("#name").val("");
		$("#description").val("");
		$("#erowid").val("0");
		showActionModal("AddEquipementModel","Add");
});




/* Action for Equipment type EDIT button */
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
  		callAjaxMethod("POST","editEquipementModel",param,bindEquTypeEditList);
   }
});
 

function bindEquTypeEditList(result) 
{
	try
	{
		$("#name").val(result[0].name);
		$("#description").val(result[0].description);
		$("#erowid").val(result[0].rowid);
		$("#eequipementtypeid").val(result[0].equipementtypeid);
		$("#eequipementmakeid").val(result[0].equipementmakeid);
		showActionModal("UpdateEquipementModel","Update");
		
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



function DeleteProceed()
{
	try
	{
		var selectedEquTypeId = getSelectedRowIds().toString();
		var param = {"rowids":selectedEquTypeId};
		callAjaxMethod("POST","deleteEquipmentModel",param,bindNewEquTypeList);	
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
		 
		window.location.href = "Spareindex";
		uncheckCheckBoxes();
	}
	catch(err)
	{
		alert(err);
	}
}


 

/* This function is used for uncheck the all checkboxes if checked */
function uncheckCheckBoxes() {
	$('#EquipmentModelTable').find("input[type = 'checkbox']").prop("checked",false);
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
function loadEquipementModelStartwith(letter) 
{
	try
	{
		
		var param = {"startLetter":letter,"typeid":document.getElementById('equipementtypeid').value,
			"equipementmakeid":document.getElementById('equipementmakeid').value};
		callAjaxMethod("POST","sortEquipmentModel",param,startwithEquipmentModel);
	}
	catch(err)
	{
		alert(err);
	}
}
/* Success method for startLetter as well as to replace the sorted content on table */   	
function startwithEquipmentModel(result) 
{
	try
	{
		var rowLength =  result.length;
		var content="";
	   	var id,name,typename,make;
	   
	   	if(rowLength === 0) 
		{
			content +=  "<tr><td colspan='4' class = 'star'><center><b>Data not found...</b></center></td></tr>";
		}
		else 
		{
	   		for (var index = 0;index<rowLength;index++) 
	   		{
	   			try
	   			{
		   			id = result[index].rowid;
		   			typename = result[index].equipementtypename;
		   			make = result[index].equipementmake;
		   			name = result[index].name;
		   			 
		   			
					content += "<tr>";
					content += "<td>"+(index+1)+". <input type='checkbox'  name='equTypeId' class ='checkList' value= '"+id+"'></td>";
					content += "<td>"+typename+"</td>";
					content += "<td>"+make+"</td>";
					content += "<td>"+name+"</td>";
					content += "</tr>";
	   			}
	   			catch(err)
	   			{
	   				alert(err.desc);
	   			}
	   	    }
	   	}
		$('#EquipmentModelTable tbody').html(content);
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
   	$('#EquipmentModelTable').find("input[type = 'checkbox']").each(function(index,element){
   		if($(this).prop('checked'))
   			selectedEquTypeIdArray.push($(this).val());
   	});
   	return selectedEquTypeIdArray;
}
   

function checkCheckboxesLength() 
{
	var checkboxesLength = $('#EquipmentModelTable').find("input[type = 'checkbox']").length;
	return checkboxesLength;
}



/* AJAX success method for DELETED records */
function bindNewEquTypeList(result) 
{
	if(result == "success") 
	{
		window.location.href = "EquipmentModel";
   	}
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




