var isIE;
var req;
var names;
var target1;
var ctrl;

function getElementY(element)
{
	var target1Top = 0;
	if (element.offsetParent) 
	{
		while (element.offsetParent) 
		{
			target1Top += element.offsetTop;
            element = element.offsetParent;
		}
	} 
	else if (element.y) 
	{
		target1Top += element.y;
    }
	return target1Top;
}


function initRequest(url) 
{
    if (window.XMLHttpRequest) 
    {
        req = new XMLHttpRequest();
    } 
    else if (window.ActiveXObject) 
    {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}

function LoadingTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function ClearTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Data not found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function clearSelect() {
    for (var i = 0; i < arguments.length; i++) {
        var element = arguments[i];

        if (typeof element == 'string')
            element = document.getElementsByName(element)[0];

        if (element && element.options) {
            element.options.length = 0;
            element.selectedIndex = -1;
        }
    }
}



//Start -Elam-----------------------District List-----------------------
function loadDistrict(startletter)
 {
	var id=document.getElementById('state').value;  
	var search = document.getElementById('txtSer').value;  
    var url = "../management?actionS=MGTdistrict&search="+escape(search)+"&id="+escape(id)+"&startletter="+escape(startletter);
	initRequest(url);
	req.onreadystatechange = searchDistrictRequest;
    req.open("GET", url, true);
    req.send(null);
}
function searchDistrictRequest()
 {
    if(req.readyState == 4) {
        ClearTables('districtTable');
         if (req.status == 200) {
          searchDistrictMessages();
        }
    }
}
function searchDistrictMessages() {
	var id=document.getElementById('state').value;  
    var batchs = req.responseXML.getElementsByTagName("districts")[0];   	    
	var str="";     
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var district = batch.getElementsByTagName("districtId")[0];
        var districtName = batch.getElementsByTagName("districtName")[0];                               
		var editlink=""; 
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr class='MRow2'>";		
		str=str+"<td width='15px' align='right' class='boldEleven'>"+(loop+1);		
		tempId=district.childNodes[0].nodeValue;
		str=str+"<td width='125px'><input type='checkbox' name='districtId' value='"+tempId+"'>";
		editlink="DistrictAction.jsp?action1=Edit&districtId="+tempId+"&state="+id+"&path="+path+"&qp="+qp;				
		str=str+"<a href='"+editlink+"'><font class='boldEleven'>"+districtName.childNodes[0].nodeValue;
		str=str+"</font></a>";		
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     if(batchs.childNodes.length<1)
     {
     	document.getElementById('btnDelete').disabled=true;
     	document.getElementById('btnEdit').disabled=true; 	 
     }
     else
     {
     	document.getElementById('btnDelete').disabled=false;
    	document.getElementById('btnEdit').disabled=false ; 	 
     }
     var tb=document.getElementById('districtTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str     	 
}
//-------------------District values--------------
function loadDistrictValues(dval) {	
    stateId=dval.value;      
	if (stateId=="0"){
			var dis = document.getElementById('district');
			dis.length="0"
			dis.options[0]=new Option("Select", "0");
			dis.onchange();
	}else {
	    var search="";
    	var startletter="";
	  	var url="../management?actionS=MGTdistrict&search="+escape(search)+"&id="+escape(stateId)+"&startletter="+escape(startletter);

    	initRequest(url);
		req.onreadystatechange = districtValueRequest;
    	req.open("GET", url, true);
	    req.send(null);
	 }
}
function districtValueRequest() {
//	alert(req.readyState);
    if (req.readyState == 4) {
//      	clearSelect('district');

    		var dis = document.getElementById('district');
			dis.length="0";
			dis.options[0]=new Option("Select", "0");
			dis.onchange();

        if (req.status == 200) {
          districtValueMessages();
        } 
    }
    
}

function districtValueMessages() {
    var batchs = req.responseXML.getElementsByTagName("districts")[0];
    var _targ=document.getElementsByName('district')[0];
    _targ.options.length=0;	  
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var firstName = batch.getElementsByTagName("districtName")[0];               
        var batchId = batch.getElementsByTagName("districtId")[0];
         _targ.options[loop]=new Option(firstName.childNodes[0].nodeValue,batchId.childNodes[0].nodeValue);
     }        
//     _targ.options.length=loop;
//	 _targ.selectedIndex=0;
	 _targ.onchange(); 
}

//Start -Elam-----------------------staff-----------------------
function loadStaff(startletter)
 {
 	var districtId=document.getElementById('district').value;  

 	if (districtId=="0") {
		 var str="<font class='bolddeepred'><center> Data not found...</font></center>";
		 var tb=document.getElementById('staffTable');	 
	  	 tb.innerHTML=str     
	  	 document.getElementById('btnDelete').disabled=true;
     	 document.getElementById('btnEdit').disabled=true; 	 
 	}else {
		var catId=document.getElementById('category').value;
		var id=document.getElementById('state').value;  
		var url = "../management?actionS=MGTstaff&id="+escape(id)+"&startletter="+escape(startletter)+"&districtId="+districtId+"&catId="+catId;

		initRequest(url);
		req.onreadystatechange = searchStaffRequest;
    	req.open("GET", url, true);
	    req.send(null);
	}
}

function searchStaffRequest()
 {
    if(req.readyState == 4) {
		 var str="<font class='bolddeepred'><center> Data not found...</font></center>";
		 var tb=document.getElementById('staffTable');	 
	  	 tb.innerHTML=str     
     	 document.getElementById('btnDelete').disabled=true;
     	 document.getElementById('btnEdit').disabled=true; 	 


         if (req.status == 200) {
          searchStaffMessages();
        }
    }
}
function searchStaffMessages() {
    var batchs = req.responseXML.getElementsByTagName("staffs")[0];   	    
	var str="";     
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var staffId = batch.getElementsByTagName("staffId")[0];
        var staffName = batch.getElementsByTagName("staffName")[0].childNodes[0].nodeValue;
        var staffAddress = batch.getElementsByTagName("staffAddress")[0];             
        var staffEmail = batch.getElementsByTagName("staffEmail")[0];             
        var staffMobile = batch.getElementsByTagName("staffMobile")[0];                                            
		var editlink=""; 
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		tempId=staffId.childNodes[0].nodeValue;
		str=str+"<td width='40px' align='left' class='boldEleven'><input type='checkbox' name='staffid' value='"+tempId+"'>&nbsp;"+staffId.childNodes[0].nodeValue;		
		str=str+"<td width='200px' align='left'>&nbsp;";
		str=str+"<a href=StaffEdit.jsp?staffid="+staffId.childNodes[0].nodeValue+"><font color='blue'>"+staffName+"</font></a>";	
		str=str+"<td width='100px' align='left' class='boldEleven'>&nbsp;"+staffAddress.childNodes[0].nodeValue;		
		str=str+"<td width='75px' align='left' class='boldEleven'>&nbsp;"+staffEmail.childNodes[0].nodeValue;							
		str=str+"<td width='50px' align='left' class='boldEleven'>&nbsp;"+staffMobile.childNodes[0].nodeValue;							
		
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     if(batchs.childNodes.length<1)
     {
     	document.getElementById('btnDelete').disabled=true;
     	document.getElementById('btnEdit').disabled=true; 	 
     }
     else
     {
     	document.getElementById('btnDelete').disabled=false;
    	document.getElementById('btnEdit').disabled=false ; 	 
     }
     var tb=document.getElementById('staffTable');
  	 tb.innerHTML=str     	
}
