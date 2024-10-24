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

function  loadOffice(str) 
{
	var url = "../SmartCommonAjax?actionS=loadOffice&str="+str;
	initRequest(url);
	req.onreadystatechange = OfficeRequest;
    req.open("GET", url, true);
    req.send(null);
   
}

function OfficeRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('OfficeTable');
        ClearTabler('totrec');
        if (req.status== 200) 
        {		  	
        	OfficeMessages();
        }
    }
}

function OfficeMessages() 
{	 
	var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    str=str+"<tr class='MRow1'>";
    str=str+"<td  class='boldEleven' align='center'><b>S.NO</b></td>";
    str=str+"<td  class='boldEleven' align='center'><b>NAME</b></td>";
    str=str+"<td  class='boldEleven' align='center'><b>SHORT</b></td>";
    str=str+"<td  class='boldEleven' align='center'><b>STATE</b></td>";
    str=str+"<td  class='boldEleven' align='center'><b>DESCRIPTION</b></td>";
    str=str+"<td  class='boldEleven' align='center'><b>Email</b></td>";
    str=str+"<td  class='boldEleven' align='center'><b>ACTIVE</b></td>";
    str=str+"</tr>"; 
    
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
	    var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var ShortName = batch.getElementsByTagName("ShortName")[0].childNodes[0].nodeValue;
	    var Desc = batch.getElementsByTagName("Desc")[0].childNodes[0].nodeValue;
	    var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
	    var State = batch.getElementsByTagName("State")[0].childNodes[0].nodeValue;
	    var Email = batch.getElementsByTagName("Email")[0].childNodes[0].nodeValue;
	    
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"' />"+(loop+1)+".</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Name+" </td>";
		str=str+"<td class='boldEleven'>&nbsp;"+ShortName+" </td>";
		str=str+"<td class='boldEleven'>&nbsp;"+State+" </td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Desc+" </td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Email+" </td>";
		if(Status == "Y")
			str=str+"<td   class='boldEleven'><font class='boldgreen'>Active</font></td>";
		else
			str=str+"<td   class='boldEleven'><font class='bolddeepred'>Inactive</font></td>";
  
    }
   
    if(batchs.childNodes.length<1)
    {
    	str=str+"<tr class='MRow1'><td class='bolddeepred'><center>Data not found...</center></td></tr>";
    	 
    }
    
    	
    str=str+"</table>";
    var tb=document.getElementById('OfficeTable');
  	tb.innerHTML=str  ; 
  	tb=document.getElementById('totrec');
  	tb.innerHTML= " <center><font class='bolddeepred'>Total No of Record : "+batchs.childNodes.length  +"</font></center>"; 
  	
  	 
  	
}

  