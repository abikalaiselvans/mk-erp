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
	 var str="<center><br><br><br><font class='bolddeepred'>Total No of Records : 0</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


function  loadReportingHead(search) 
{
	var url = "../SmartCommonAjax?stype=1&actionS=loadReportingHead&search="+search;
	initRequest(url);
	req.onreadystatechange = loadReportingHeadRequest;
    req.open("GET", url, true);
    req.send(null);
   
}

function  loadReportingHeads() 
{
	var search=document.getElementById('searchstaff').value; 
	var url = "../SmartCommonAjax?stype=2&actionS=loadReportingHead&search="+search;
	initRequest(url);
	req.onreadystatechange = loadReportingHeadRequest;
    req.open("GET", url, true);
    req.send(null);
   
}


function loadReportingHeadRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('loadReportingHeadTable');
        ClearTabler('totrec');
        if (req.status== 200) 
        {		  	
        	loadReportingHeadMessages();
        }
    }
}

function loadReportingHeadMessages() 
{	 
	var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
	    var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Office = batch.getElementsByTagName("Office")[0].childNodes[0].nodeValue;
	    var Rid = batch.getElementsByTagName("Rid")[0].childNodes[0].nodeValue;
	    var Rname = batch.getElementsByTagName("Rname")[0].childNodes[0].nodeValue;
	    var Rtype = batch.getElementsByTagName("Rtype")[0].childNodes[0].nodeValue;
	    if(Rtype == "T")
	    {
	    	str=str+"<tr bgcolor='red'>";
	    }
	    else
	    {	
	    	if(loop%2==1)
	    		str=str+"<tr class='MRow1'>";
	    	else
	    		str=str+"<tr  class='MRow2'>";	
	    }	 
		str=str+"<td class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"' />"+(loop+1)+".</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Id+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Name+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Office+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Rid+ " / " +Rname+"</td>";
		 
    }
   
    if(batchs.childNodes.length<1)
    {
    	str=str+"<tr  class='MRow1'><td class='bolddeepred'><center>Data not found...</center></td></tr>";
    	document.getElementById('Edit').disabled=true;
    }
    else
    	document.getElementById('Edit').disabled=false;	
    	
    str=str+"</table>";
     var tb=document.getElementById('loadReportingHeadTable');
  	 tb.innerHTML=str  ; 
  	  tb=document.getElementById('totrec');
  	 tb.innerHTML= " <center><font class='bolddeepred'>Total No of Record : "+batchs.childNodes.length  +"</font></center>"; 
  	
  	 
  	
}

  