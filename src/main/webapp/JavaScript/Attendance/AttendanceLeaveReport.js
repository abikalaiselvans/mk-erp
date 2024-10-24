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
	 var str="<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	 str=str+"<tr class='MRow1'> <td><font class='boldEleven'><center> Nothing  found...</font></center></td></tr>";
	 str=str+"</table>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str       
}

 
 
function loadAttendanceReport( ) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../attendance?actionS=loadAttendanceReport&month="+escape(mon)+"&year="+escape(yea);
	initRequest(url);
	req.onreadystatechange = loadAttendanceReportRequest;
    req.open("GET", url, true);
    req.send(null);
}

 
function loadAttendanceReport1( ) 
{
 	var empid = document.getElementById('empid').value;
 	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../attendance?actionS=loadAttendanceReport1&month="+escape(mon)+"&year="+escape(yea)+"&empid="+empid;
 	alert(url);
    initRequest(url);
 	req.onreadystatechange = loadAttendanceReportRequest;
    req.open("GET", url, true);
    req.send(null);
}


function loadAttendanceReportRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('AttendanceReportTable');
        if (req.status== 200) 
        {		  	
          loadAttendanceReportMessages();
        }
    }
}


function loadAttendanceReportMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	str=str+"<tr class='MRow1'>";
  	str=str+"<td  class='boldEleven' align='center'><b>S.No</b></td>";	
	str=str+"<td class='boldEleven' align='center'><b>Id </b></td>";
	str=str+"<td class='boldEleven' align='center'><b> Name </b></td>";
	str=str+"<td class='boldEleven' align='center'><b> Date</b> </td>";
	str=str+"<td class='boldEleven' align='center'><b> Leave </b></td>";
	str=str+"<td class='boldEleven' align='center'><b> Type</b> </td>";
	str=str+"<td class='boldEleven' align='center'><b> Value</b> </td>";
  	str=str+"</tr>";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Date = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
	    var Leave = batch.getElementsByTagName("Leave")[0].childNodes[0].nodeValue;
        var Type = batch.getElementsByTagName("Type")[0].childNodes[0].nodeValue;
        var Value = batch.getElementsByTagName("Value")[0].childNodes[0].nodeValue;
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td  class='boldEleven'>&nbsp;"+(loop+1)+"</td>";	
		str=str+"<td class='boldEleven'>&nbsp;"+Id+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Name+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Date+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Leave+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Type+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Value+"</td>";
    }
    if(batchs.childNodes.length<1)
    {
    	str=str+"<tr class='MRow1'><td class='bolddeepred' colspan='10'><center>Data not found...</center></td></tr>";
    }
    str=str+"</table>";
    var tb=document.getElementById('AttendanceReportTable');
    tb.innerHTML=str  ; 
}
 
  