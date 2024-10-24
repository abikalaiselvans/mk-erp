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
	 var str="<center><br><br><br><font class='bolddeepred'>New Entry</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}



function duplicateCheck()
{
	var f =document.getElementById('duplicatecheck').value;
	
	if(document.getElementById('rejoin').checked)
	{
		return true;
	}
	else
	{
		if(f =="Y")
		{
			alert("Duplication. Kindly confirm Name, Fathername, Mothername, Date of Birth Field");
			return false;
		}
		else
			return true;
	}
}
 


function  StaffRegistrationUnique() 
{
	try
	{
		if(checkNull('name','Enter Staff Name'))
		{
			var name = document.getElementById('name').value;
			var fname = document.getElementById('fname').value;
			var mothername = document.getElementById('mothername').value;
			var dob = document.getElementById('dob').value;
			var url = "../SmartCommonAjax?actionS=StaffRegistrationUnique&name="+name+"&fname="+fname+"&mothername="+mothername+"&dob="+dob
			initRequest(url);
			req.onreadystatechange = StaffRegistrationUniqueRequest;
		    req.open("GET", url, true);
		    req.send(null);
		}
		else
		{
			ClearTable('StaffRegistrationUniquediv');
			document.getElementById('name').focus();
		}	
	}
	catch(err)
	{
		alert(err);
		
	}
}


function StaffRegistrationUniqueRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('StaffRegistrationUniquediv');
        document.getElementById('duplicatecheck').value ="N";
        if (req.status== 200) 
        {		  	
        	StaffRegistrationUniqueMessages();
        }
    }
}

function StaffRegistrationUniqueMessages() 
{	 
	var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    str=str+"<tr class='MRow1'>";
    str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>EMP ID</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>NAME</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>FATHER NAME</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>MOTHER NAME</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>DOB</b></td>";
    str=str+"</tr>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
	    var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Fname = batch.getElementsByTagName("Fname")[0].childNodes[0].nodeValue;
	    var Mname = batch.getElementsByTagName("Mname")[0].childNodes[0].nodeValue;
	    var DOB = batch.getElementsByTagName("DOB")[0].childNodes[0].nodeValue;
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		str=str+"<td class='boldEleven'>"+(loop+1)+".</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Id+" </td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Name+" </td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Fname+" </td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Mname+" </td>";
		str=str+"<td class='boldEleven'>&nbsp;"+DOB+" </td>";
		document.getElementById('duplicatecheck').value ="Y"; 
    }
   
    if(batchs.childNodes.length<1)
    {
    	str=str+"<tr class='MRow1'><td class='bolddeepred' colspan='6'><center>New Entry</center></td></tr>";
    	document.getElementById('duplicatecheck').value ="N";
    }
    str=str+"</table>";
    var tb=document.getElementById('StaffRegistrationUniquediv');
  	tb.innerHTML=str  ; 
  	  
  	
}

  