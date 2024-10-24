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
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}

 
function LoadDailyEngineerReport(startLetter)
 {
 	var month = document.getElementById('month').value;
 	var year = document.getElementById('year').value;
 	var day = document.getElementById('day').value;
 	var calltype = document.getElementById('calltype').value;
 	var callstatus = document.getElementById('callstatus').value;
 	var url = "../StaffCommon?actionS=LoadDailyEngineerReport&startLetter="+escape(startLetter)+"&year="+year+"&month="+month+"&calltype="+calltype+"&callstatus="+callstatus+"&day="+day;
 	initRequest(url);
	req.onreadystatechange=LoadDailyEngineerReportRequest;
    req.open("GET", url, true);
    req.send(null);
    	
}
 
 function LoadDailyEngineerReportRequest() 
 {
    if(req.readyState == 4) 
    {    	
        ClearTable('GroupTable');  
        var tb=document.getElementById('GroupTable');
  	 	tb.innerHTML="" ;
  	 	
  	 	var tb1=document.getElementById('totalrec');
  	 	tb1.innerHTML=" " ;
  	    if (req.status == 200) 
        {		  	
          LoadDailyEngineerReportMessages();
        }
    }
}


function LoadDailyEngineerReportMessages() 
{	 
    
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
   	 
   	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	str=str+"<tr  class='MRow1'>";
    str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
    str=str+"<td class='boldEleven' align='center'><bEmp ID</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Emp Name</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Call Number</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Date</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Customer</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Location</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Call Type</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Call Status</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Hand Hour</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Hand Minutes</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Travel Hour</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Travel Minutes</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Travel KM</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>No of Spare</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Day Closed</b></td>";
    
  	str=str+"</tr>";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Empid = batch.getElementsByTagName("Empid")[0].childNodes[0].nodeValue;
	    var Empname = batch.getElementsByTagName("Empname")[0].childNodes[0].nodeValue;
	   
	    
	    var Date = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
	    var Callno = batch.getElementsByTagName("Callno")[0].childNodes[0].nodeValue;
	    var Customername = batch.getElementsByTagName("Customername")[0].childNodes[0].nodeValue;
	    var Location = batch.getElementsByTagName("Location")[0].childNodes[0].nodeValue;
	    var Calltype = batch.getElementsByTagName("Calltype")[0].childNodes[0].nodeValue;
	    var Callstatus = batch.getElementsByTagName("Callstatus")[0].childNodes[0].nodeValue;
	    var Hhour = batch.getElementsByTagName("Hhour")[0].childNodes[0].nodeValue;
	    var Hminute = batch.getElementsByTagName("Hminute")[0].childNodes[0].nodeValue;
	    var TRH = batch.getElementsByTagName("TRH")[0].childNodes[0].nodeValue;
	    var TRM = batch.getElementsByTagName("TRM")[0].childNodes[0].nodeValue;
	    var TKM = batch.getElementsByTagName("TKM")[0].childNodes[0].nodeValue;
	    var Spare = batch.getElementsByTagName("Spare")[0].childNodes[0].nodeValue;
	    var Day = batch.getElementsByTagName("Day")[0].childNodes[0].nodeValue;
	    
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2''>";		
		   
		str=str+"<td  class='boldEleven'><input type='checkbox' name='callid'  name='callid' value='"+Id+"'>&nbsp;"+(loop+1) +"</td>";
		str=str+"<td  class='boldEleven'>"+Empid +"</td>";
		str=str+"<td  class='boldEleven'>"+Empname +"</td>";
		str=str+"<td  class='boldEleven'>"+Callno +"</td>";
		str=str+"<td  class='boldEleven'>"+Date +"</td>";
		str=str+"<td  class='boldEleven'>"+Customername+"</td>";
		str=str+"<td  class='boldEleven'>"+Location+"</td>";
		if("1"==Calltype)
			str=str+"<td  class='boldEleven'>'01' Calls</td>";
		else
			str=str+"<td  class='boldEleven'>'02' Calls</td>";
			
		if("C"==Callstatus)
			str=str+"<td  class='boldEleven'>Closed";
		else
			str=str+"<td  class='boldEleven'><font class='bolddeepred'>Pending</font></td>";
		
		
		 
		str=str+"<td  class='boldEleven'>"+Hhour;
		str=str+"<td  class='boldEleven'>"+Hminute;
		str=str+"<td  class='boldEleven'>"+TRH;
		str=str+"<td  class='boldEleven'>"+TRM;
		str=str+"<td  class='boldEleven'>"+TKM;
		str=str+"<td  class='boldEleven'>"+Spare;
		if("Y"==Day)
			str=str+"<td  class='boldEleven'>Yes";
		else
			str=str+"<td  class='boldEleven'><font class='bolddeepred'>No</font></td>";
		
		
		 
		 
		
		
  }
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	 
     }
     else
     {
     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
     	 
     
     }	
	 str=str+"</table>";
     var tb=document.getElementById('GroupTable');
  	 tb.innerHTML=str   ;
  	 
  	 tb=document.getElementById('totalrec');
  	 tb.innerHTML= "<center><font color='red'>Total no of Records ::</font>"+batchs.childNodes.length+"</center>"; 
     	
}