var isIE;
var req;
var names;
 
function initRequest(url) {
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
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
	 var str="<center><br><br><br><font class='bolddeepred'>Total No of Records : 0</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


function loadStaffHold(startLetter) 
{
	 
	var Office=document.getElementById('Office').value;  
	var url = "../attendance?actionS=AttStaffHold&type=1&id="+escape(startLetter)+"&Office="+Office;
	initRequest(url);
	req.onreadystatechange = StaffHoldRequest;
    req.open("GET", url, true);
    req.send(null);
}


function loadStaffHolds(ctr) 
{
	 
	var Office=document.getElementById('Office').value;  
	var url = "../attendance?actionS=AttStaffHold&type=2&id="+escape(ctr.value)+"&Office="+Office;
	 
	initRequest(url);
	req.onreadystatechange = StaffHoldRequest;
    req.open("GET", url, true);
    req.send(null);
}


function StaffHoldRequest() 
{
    if(req.readyState == 4) 
    {    	
         
  	 	ClearTable('StaffHoldable');
  	 	ClearTabler('totalrecord');
        if (req.status== 200) 
        {		  	
        	StaffHoldMessages();
        }
    }
}
function StaffHoldMessages() 
{	 
	var batchs = req.responseXML.getElementsByTagName("ONHOLDS")[0];   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
	    var Empid = batch.getElementsByTagName("Empid")[0].childNodes[0].nodeValue;
	    var Staffname = batch.getElementsByTagName("Staffname")[0].childNodes[0].nodeValue;
	    var Companyname = batch.getElementsByTagName("Companyname")[0].childNodes[0].nodeValue;
        var Branchname = batch.getElementsByTagName("Branchname")[0].childNodes[0].nodeValue;     
        var Depart = batch.getElementsByTagName("Depart")[0].childNodes[0].nodeValue; 
        var Office = batch.getElementsByTagName("Office")[0].childNodes[0].nodeValue; 
        var Status = batch.getElementsByTagName("Status")[0]; 
		  
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td width='130' class='boldEleven'><input name='staffid' id='staffid' type='checkbox' value='"+Empid+"' />"+Empid;
		str=str+"<td width='130' class='boldEleven'> "+Staffname+" </td>";
		str=str+"<td width='130' class='boldEleven'>&nbsp;"+Companyname;
		str=str+"<td width='130' class='boldEleven'>&nbsp;"+Branchname;
		str=str+"<td width='130' class='boldEleven'>&nbsp;"+Depart;
		str=str+"<td width='130' class='boldEleven'>&nbsp;"+Office;
		str=str+"<td width='100' class='boldEleven' align='center'>"+Status.childNodes[0].nodeValue;
		 
    }
    if(batchs.childNodes.length<1)
    {
    	str=str+"<tr><td class='bolddeepred'><center>Data not found...</center></td></tr>";
    	 
    }
     	
    str=str+"</table>";
     var tb=document.getElementById('StaffHoldable');
  	 tb.innerHTML=str  ; 
  	 
  	tb=document.getElementById('totalrecord');
 	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records ::"+batchs.childNodes.length +"</font>"; 

}

  