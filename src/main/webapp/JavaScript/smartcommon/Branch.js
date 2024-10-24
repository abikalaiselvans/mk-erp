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

function  loadCompany(str) 
{
	var url = "../SmartCommonAjax?actionS=loadCompany&str="+str;
	initRequest(url);
	req.onreadystatechange = loadCompanyRequest;
    req.open("GET", url, true);
    req.send(null);
   
}


function loadBranchData(startLetter) 
{
    
    var id=document.getElementById('companyId').value;   
    var url = "../SmartCommonAjax?actionS=loadBranch&companyid="+escape(id)+"&startLetter="+escape(startLetter);   
    initRequest(url);
    req.onreadystatechange = branchRequest;
    req.open("GET", url, true);
    req.send(null);
}


function branchRequest() 
{
    if(req.readyState == 4) 
    {    
    	ClearTable('branchTable');
    	ClearTabler('totRec');
         
        if (req.status == 200) 
        {
          branchDetails();
        }
    }
}

function branchDetails() 
{
    var batchs = req.responseXML.getElementsByTagName("branches")[0];      
	var str=""; 
    var id=document.getElementById('companyId').value;
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
	    var id = batch.getElementsByTagName("id")[0].childNodes[0].nodeValue;        
        var companyName = batch.getElementsByTagName("companyName")[0].childNodes[0].nodeValue;         
        var branchName = batch.getElementsByTagName("branchName")[0].childNodes[0].nodeValue;         
        var legalName  = batch.getElementsByTagName("legalName")[0].childNodes[0].nodeValue;
        var city  = batch.getElementsByTagName("city")[0].childNodes[0].nodeValue;
        var district  = batch.getElementsByTagName("district")[0].childNodes[0].nodeValue;
        var state  = batch.getElementsByTagName("state")[0].childNodes[0].nodeValue;
        var email  = batch.getElementsByTagName("email")[0].childNodes[0].nodeValue;
        var pan  = batch.getElementsByTagName("pan")[0].childNodes[0].nodeValue;
        var active  = batch.getElementsByTagName("active")[0].childNodes[0].nodeValue;
             	                                       
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";				
		
		str=str+"<td  class='boldEleven'><input type='checkbox' name='rowid'  id='rowid'  value='"+id+"'>"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven'>"+companyName+"</td>";
		str=str+"<td  class='boldEleven'>"+branchName+"</td>";
		str=str+"<td  class='boldEleven'>"+legalName+"</td>";	
		str=str+"<td  class='boldEleven'>"+city+"</td>";	
		str=str+"<td  class='boldEleven'>"+district+"</td>";	
		str=str+"<td  class='boldEleven'>"+state+"</td>";	
		str=str+"<td  class='boldEleven'>"+email+"</td>";	
		str=str+"<td  class='boldEleven'>"+pan+"</td>";	
		if(active == "1")
			str=str+"<td  class='boldEleven'><font class='boldgreen'>Active</font></td>";
		else
			str=str+"<td  class='boldEleven'><font class='bolddeepred'>Inactive</font></td>";
		str=str+"</tr>";
     }
     str=str+"</table>";
      var tb=document.getElementById('branchTable');
  	 tb.innerHTML=str   
  	 str="<br> <center><font class='bolddeepred'>Total no of Records :: "  + loop+"</font></center><br>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	
}



 