

$('#equipmentTypeAdd').unbind("click").on("click",function() 
	{
		$("#name").val("");
		$("#description").val("");
		$("#addNewEquipmentTypeModal").modal('show');
});


$('#equipmentTypeEdit').unbind("click").on("click",function() 
		{
	var selectedEquTypeId = getSelectedEquTypeId().toString();
	checkboxesLength = checkCheckboxesLength();
	var countSelectedCheckLength = getSelectedEquTypeId().length;
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
  		var param = {"rowid":selectedEquTypeId};
  		callAjaxMethod("POST","equipmentTypeEdit",param,bindEquTypeEditList);
   }
});
 

$('#equipmentTypeDelete').unbind("click").on("click",function() 
  {
	var selectedEquTypesIdLength = getSelectedEquTypeId().toString().length;
  	var checkboxesLength = checkCheckboxesLength();
  	if(checkboxesLength === 0) 
  	{
		 
		alertBox("Alert Information","Delete not avalable","alert-danger");
	}
  	else if(selectedEquTypesIdLength != null &&  selectedEquTypesIdLength > 0)
  	{
  		$('#equTypeConformDeleteModal').modal('show');
  	}
  	else 
  	{
  		 
  		alertBox("Alert Information","Please select atleast One value","alert-danger");
  	}
});
 

$('#equipmentTypeClose').unbind("click").on("click",function() 
		{
	
	$('#equTypeConformCloseModal').modal('show');
});



$('#equTypeDeleteProceed').unbind("click").on("click",function()
		{
	var selectedEquTypeId = getSelectedEquTypeId().toString();
	var param = {"equTypeIds":selectedEquTypeId};
	callAjaxMethod("POST","DeleteEquipmentType",param,bindNewEquTypeList);
});


$('#equTypeCloseProceed').unbind("click").on("click",function()
		{
	 
	window.location.href = "Spareindex";
	uncheckCheckBoxes();
});



function uncheckCheckBoxes() {
	$('#equTypeTable').find("input[type = 'checkbox']").prop("checked",false);
}



function checkCheckboxesLength() 
{
	var checkboxesLength = $('#equTypeTable').find("input[type = 'checkbox']").length;
	return checkboxesLength;
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




/* This function used for sorting based on the letter */
function loadEquipementTypeStartwith(letter) 
{
	var param = {"startLetter":letter};
   	callAjaxMethod("POST","sortEquipmentType",param,startwithEquipmentType);
}



/* Success method for startLetter as well as to replace the sorted content on table */   	
function startwithEquipmentType(result) 
{
	try
	{
		var rowLength =  result.length;
		var content="";
	   	var id,name;
		if(rowLength === 0) 
		{
			content +=  "<tr><td colspan='2' class = 'star'><center><b>Data not found...</b></center></td></tr>";
		}
		else 
		{
	   		for (var index = 0;index<rowLength;index++) 
	   		{
	   			id = result[index].rowid;
	   			name = result[index].name;
				content += "<tr>";
				content += "<td>"+(index+1)+". <input type='checkbox'  name='equTypeId' class ='checkList' value= '"+id+"'></td>";
				content += "<td>"+name+"</td>";
				content += "</tr>";
	   	    }
	   	}
		$('#equTypeTable tbody').html(content);
	}
	catch(err)
	{
		alert(err.desc);
	}
}

 
/* This function will used for get the select the checked check box contents */
function getSelectedEquTypeId() 
{
	var selectedEquTypeIdArr = [];
   	$('#equTypeTable').find("input[type = 'checkbox']").each(function(index,element)
   			{
   		if($(this).prop('checked'))
   			selectedEquTypeIdArr.push($(this).val());
   	});
   	return selectedEquTypeIdArr;
}
  

/* AJAX success method for DELETED records */
function bindNewEquTypeList(result) 
{
	if(result == "success") 
	{
		window.location.href = "EquipmentType";
   	}
}



function bindEquTypeEditList(result) 
{
	try
	{
		$("#ename").val(result[0].name);
		$("#edescription").val(result[0].description);
		$("#erowid").val(result[0].rowid);
		$('#editEquipmentTypeModal').modal('show');
	}
	catch(err)
	{
		alert(err)
	}
}



$('.madalClose').unbind("click").on("click",function() {
	uncheckCheckBoxes();
});


