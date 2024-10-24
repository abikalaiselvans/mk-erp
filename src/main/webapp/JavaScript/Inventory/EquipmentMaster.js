var isIE;
var req;
var names;

 
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
 

function ClearTable(ctr1)
{
	 var str="<center><br><br><br><font class='bolddeepred'>Data not found...</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 
function ClearTabler(ctr1)
{
	 var str="<center><br><font class='bolddeepred'>Total No of Records : 0</font></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function loadEquipmentMaster(startLetter)
{
 	var Type = document.getElementById('Type').value;
 	var equipmenttype = document.getElementById('equipmenttype').value;
 	var model = document.getElementById('model').value;
 	var location = document.getElementById('location').value;
 	var status = document.getElementById('status').value;
	var url = "../inventory?actionS=loadEquipmentMaster&type=1&startLetter="+escape(startLetter)+"&Type="+Type+"&equipmenttype="+equipmenttype+"&location="+location+"&status="+status+"&model="+model;;
    initRequest(url);
	req.onreadystatechange=loadEquipmentMasterRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function loadEquipmentMasters(ctr)
{
 	var Type = document.getElementById('Type').value;
 	var equipmenttype = document.getElementById('equipmenttype').value;
 	var model = document.getElementById('model').value;
 	var location = document.getElementById('location').value;
 	var status = document.getElementById('status').value;
 	var url = "../inventory?actionS=loadEquipmentMaster&type=2&startLetter="+ctr.value+"&Type="+Type+"&equipmenttype="+equipmenttype+"&location="+location+"&status="+status+"&model="+model;;
   	initRequest(url);
	req.onreadystatechange=loadEquipmentMasterRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function loadEquipmentMasterRequest() 
 {
	if(req.readyState == 4) 
    {    	
		ClearTabler('totRec');
	    ClearTable('ServiceTable');
		if (req.status == 200) 
        {		  	
          	var tb=document.getElementById('ServiceTable');
		  	tb.innerHTML="<font class='bolddeepred'> Loading Data</font>";
		  	loadEquipmentMasterMessages();
        }
    }
}

function loadEquipmentMasterMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<tr class='MRow1'>";
	str=str+"<tr  class='MRow1'> ";
	str=str+"<td align='center'><b>S.No</b></td> ";
	str=str+"<td align='center'><b>Customer</b></td> ";
	str=str+"<td align='center'><b>Location</b></td> ";
	str=str+"<td align='center'><b>Unit</b></td> ";
	str=str+"<td align='center'><b>Model</b></td> ";
	str=str+"<td align='center'><b>Category</b></td> ";
	str=str+"<td align='center'><b>Serial Number</b></td> ";
	str=str+"<td align='center'><b>Starting Date</b></td> ";
	str=str+"<td align='center'><b>Ending Date</b></td> ";
	str=str+"<td align='center'><b>Status</b></td> ";
	str=str+"<td align='center'><b>Call Assign</b></td> ";
	str=str+"</tr> ";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("CustomerName")[0].childNodes[0].nodeValue;
	    var location = batch.getElementsByTagName("location")[0].childNodes[0].nodeValue;
	    var Utype = batch.getElementsByTagName("Utype")[0].childNodes[0].nodeValue;
	    var Model = batch.getElementsByTagName("Model")[0].childNodes[0].nodeValue;
	    var Category = batch.getElementsByTagName("Category")[0].childNodes[0].nodeValue;
	    var serialno = batch.getElementsByTagName("Serialno")[0].childNodes[0].nodeValue;
	   	var SDate = batch.getElementsByTagName("SDate")[0].childNodes[0].nodeValue;
	    var EDate = batch.getElementsByTagName("EDate")[0].childNodes[0].nodeValue;
	    var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;

	    if(Category=='A')
	    	Category="Amc";
		else if (Category=='W')
			Category="Warranty";
	    else
	    	Category="Oncall";
	    
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";

		str=str+"<td  class='boldEleven' ><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven' >"+Name +"</td>";
		str=str+"<td  class='boldEleven' >"+location +"</td>";
		str=str+"<td  class='boldEleven' >"+Utype+"</td>";
		str=str+"<td  class='boldEleven' >"+Model+"</td>";
		str=str+"<td  class='boldEleven' >"+Category+"</td>";
		str=str+"<td  class='MRow4' ><b>"+serialno+"</b></td>";
		str=str+"<td  class='boldEleven' >"+SDate+"</td>";
		str=str+"<td  class='boldEleven' >"+EDate+"</td>";
		if("Live"==Status)
			str=str+"<td  class='boldEleven' ><font class='boldgreen'>"+Status+"</font></td>";
		else
			str=str+"<td  class='boldEleven' ><font class='bolddeepred'>"+Status+"</font>&nbsp;/&nbsp;<a href='EquipmentMasterEdit.jsp?id="+Id+"'><font class='bolddeepred'>Renewal</font></a></td>";
		str=str+"<td  class='boldEleven' ><a href='SpareCallAssign.jsp?rowid="+Id+"'><font class='boldgreen'>Call Assign</font></a></td>";
		str=str+"</tr>";
		
    }
   	 if(batchs.childNodes.length <1)
 		str=str+"<td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
  	 
	 str=str+"</table>";
	 var tb=document.getElementById('ServiceTable');
  	 tb.innerHTML=str   ;
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<center><font class='bolddeepred'>Total no of Records ::"+batchs.childNodes.length+"</font></center>"; 
}