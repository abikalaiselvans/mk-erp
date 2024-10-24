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
	 var str="<font class='bolddeepred'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function ClearTables(ctr1)
{
	 var str="<font class='bolddeepred'><center> Data not found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


function loadBranchData(startLetter) 
{
    
    var id=document.getElementById('companyId').value;   
    var url = "../Common?actionS=ATTbranch&companyid="+escape(id)+"&startLetter="+escape(startLetter);   
    initRequest(url);
    req.onreadystatechange = branchRequest;
    req.open("GET", url, true);
    req.send(null);
}


function branchRequest() 
{
    if(req.readyState == 4) 
    {    
        ClearTables('branchTable');
        document.getElementById('Delete').disabled=true;
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
	    var branchId = batch.getElementsByTagName("id")[0].childNodes[0].nodeValue;        
        var companyName = batch.getElementsByTagName("companyName")[0].childNodes[0].nodeValue;         
        var branchName = batch.getElementsByTagName("branchName")[0].childNodes[0].nodeValue;         
        var legalName = batch.getElementsByTagName("legalName")[0];         
        var city = batch.getElementsByTagName("city")[0];       
        var country = batch.getElementsByTagName("country")[0];
       	var email = batch.getElementsByTagName("email")[0];
       	var active = batch.getElementsByTagName("active")[0];
       	          	                                       
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";				
		
		str=str+"<td  class='boldEleven'><input type='checkbox' name='branchId' value='"+branchId+"'>"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven'>"+companyName+"</td>";
		str=str+"<td  class='boldEleven'>"+branchName+"</td>";		
		str=str+"<td  class='boldEleven'>"+legalName.childNodes[0].nodeValue+"</td>";
		str=str+"<td  class='boldEleven'>"+city.childNodes[0].nodeValue+"</td>";
		str=str+"<td  class='boldEleven'>"+country.childNodes[0].nodeValue+"</td>";
		str=str+"<td  class='boldEleven'>"+email.childNodes[0].nodeValue+"</td>";
		str=str+"</tr>";
     }
     str=str+"</table>";
     if(batchs.childNodes.length<1)
     	document.getElementById('Delete').disabled = true;
     else
     	document.getElementById('Delete').disabled=false;
     var tb=document.getElementById('branchTable');
  	 tb.innerHTML=str   
  	 str="<br> <center><font class='bolddeepred'>Total no of Records :: "  + loop+"</font></center><br>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	
}



 