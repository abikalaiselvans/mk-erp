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
	 var str="<br><br><center><font color=red><b>Data not found</b></font>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}


function LoadAMCCallAssign(startLetter) 
{
	var callstatus = document.getElementById('callstatus').value;   
	var year=document.getElementById('year').value; 
	var month = document.getElementById('month').value;   
	var servicecenter = document.getElementById('servicecenter').value;   
	var branch = document.getElementById('branch').value;   
	
	var url = "../inventory?actionS=LoadAMCCallAssign&StartLetter="+escape(startLetter)+"&year="+escape(year)+"&month="+escape(month)+"&callstatus="+callstatus+"&servicecenter="+servicecenter+"&branch="+branch;
	initRequest(url);
	req.onreadystatechange =AMCCallAssignRequest;
    req.open("GET", url, true);
    req.send(null);
    
    
    
}
function AMCCallAssignRequest() 
{
    if(req.readyState == 4) 
    {  
    	ClearTable('divscroll');
    	document.getElementById('Delete').disabled=true;
     	document.getElementById('Edit').disabled=true;
    	if (req.status == 200) 
    	{		
    		AMCCallAssignMessages();
        }
    }
}


function AMCCallAssignMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("Bookings")[0];   
    	//Bookingid,Name,Serial Bdate Cdate Btype Bunder CallStatus EnggStatus Bookedby
    	var usertype="";
    	var str="<center><table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >"; 
    	str = str+"<tr class='MRow2'><td   class='boldEleven'><b>S.No</td>";
    	str = str+"<td   class='boldEleven' align='center'><b>Call Id</td>";
    	str = str+"<td   class='boldEleven' align='center'><b>Service Center</td>";
    	str = str+"<td   class='boldEleven' align='center'><b>Customer Name</td>";
    	str = str+"<td   class='boldEleven' align='center'><b>Serial Number</td>";
    	str = str+"<td   class='boldEleven' align='center'><b>Contact Person</td>";
    	str = str+"<td   class='boldEleven' align='center'><b>Address</td>";
    	str = str+"<td   class='boldEleven' align='center'><b>Mobile</td>";
    	str = str+"<td   class='boldEleven' align='center'><b>Email</td>";
    	str = str+"<td   class='boldEleven' align='center'><b>Descriptions</td>";
    	
    	str = str+"<td   class='boldEleven' align='center'><b>Call Assign</td>";
    	str = str+"<td   class='boldEleven' align='center'><b>Booking Date</td>";
    	str = str+"<td   class='boldEleven' align='center'><b>Closing Date</td>";
    	str = str+"<td   class='boldEleven' align='center'><b>Call Status</td>";
    	str = str+"<td   class='boldEleven' align='center'><b>Engg Status</td>";
    	str = str+"</tr>";
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	var Bookingid= batch.getElementsByTagName("Bookingid")[0];
 			var Name= batch.getElementsByTagName("Name")[0];
 			var Serial= batch.getElementsByTagName("Serial")[0];
 			var Bdate = batch.getElementsByTagName("Bdate")[0];
 			var Cdate = batch.getElementsByTagName("Cdate")[0];
 			var Btype = batch.getElementsByTagName("Btype")[0];
 			var Bunder = batch.getElementsByTagName("Bunder")[0];
 			var CallStatus = batch.getElementsByTagName("CallStatus")[0];
 			var EnggStatus = batch.getElementsByTagName("EnggStatus")[0];
 			var Bookedby = batch.getElementsByTagName("Bookedby")[0];
 			var Cperson = batch.getElementsByTagName("Cperson")[0];
 			var Caddress = batch.getElementsByTagName("Caddress")[0];
 			var Cmobile = batch.getElementsByTagName("Cmobile")[0];
 			var Cmail = batch.getElementsByTagName("Cmail")[0];
 			var usertype = batch.getElementsByTagName("usertype")[0];
 			var Descriptions= batch.getElementsByTagName("Descriptions")[0];
 			var ServiceCenter= batch.getElementsByTagName("ServiceCenter")[0];
 			
 			//Cperson,Caddress,Cmobile,Cmail
 			if(loop%2==1)
        		str = str+"<tr class='MRow2'>";
        	else
        		str = str+"<tr class='MRow1'>";
        	str = str+"<td   class='boldEleven'>"+(loop+1);
        	
        	// ||(CallStatus.childNodes[0].nodeValue != "C")
        	//if((EnggStatus.childNodes[0].nodeValue != "N"))
        	//	str = str+"<td   class='boldEleven'><input type='checkbox' name='Bookingid' id='Bookingid' value='"+Bookingid.childNodes[0].nodeValue+"'><a href='ServiceCallAssignEdit.jsp?Bookingid="+Bookingid.childNodes[0].nodeValue+"'><font class='boldgreen'>"+Bookingid.childNodes[0].nodeValue+"</font></a>";
        	//else 
        	
        	
        	if((CallStatus.childNodes[0].nodeValue != "C") &&((EnggStatus.childNodes[0].nodeValue != "N")))
        		str = str+"<td   class='boldEleven'><input type='checkbox' name='Bookingid' id='Bookingid' value='"+Bookingid.childNodes[0].nodeValue+"'><a href='ServiceCallAssignEdit.jsp?Bookingid="+Bookingid.childNodes[0].nodeValue+"'><font class='boldgreen'>"+Bookingid.childNodes[0].nodeValue+"</font></a>";
        	else
        		str = str+"<td class='boldEleven'>"+Bookingid.childNodes[0].nodeValue ;
        	
        	str = str+"<td class='boldEleven'>"+ServiceCenter.childNodes[0].nodeValue;
        	
        	str = str+"<td class='boldEleven'>"+Name.childNodes[0].nodeValue;
        	str = str+"<td class='boldEleven'>"+Serial.childNodes[0].nodeValue;
        	
        	str = str+"<td class='boldEleven'>"+Cperson.childNodes[0].nodeValue;
        	str = str+"<td class='boldEleven'>"+Caddress.childNodes[0].nodeValue;
        	str = str+"<td class='boldEleven'>"+Cmobile.childNodes[0].nodeValue;
        	str = str+"<td class='boldEleven'>"+Cmail.childNodes[0].nodeValue;
        	str = str+"<td class='boldEleven'>"+Descriptions.childNodes[0].nodeValue;
        	if((CallStatus.childNodes[0].nodeValue == "N") || (CallStatus.childNodes[0].nodeValue == "P"))
        		str = str+"<td class='boldEleven'><a href='ServiceCallAssignAdd.jsp?callid="+Bookingid.childNodes[0].nodeValue+"'><font color='green'>Call Assign</font></a>";
        	else
        		str = str+"<td class='boldEleven'><a href=javascript:HistoryOpen('ServiceCallAssignViewHistory.jsp?callid="+Bookingid.childNodes[0].nodeValue+"')><font class='boldgreen'>View</font><a>";
        	
        	
        	if((usertype.childNodes[0].nodeValue == "F") && (CallStatus.childNodes[0].nodeValue == "C"))
        		str = str+" <font class='boldgreen'>/ </font><a href=''><font class='boldgreen'>Modify</font></a>";
        			
        	str = str+"<td class='boldEleven'>"+Bdate.childNodes[0].nodeValue;
        	str = str+"<td class='boldEleven'>"+Cdate.childNodes[0].nodeValue;
        	 
        	 
        	
        	
        	//Call Status
        	if(CallStatus.childNodes[0].nodeValue == "N")
        	{
        		str = str+"<td class='boldEleven'>New Call";
        	}
        	else if(CallStatus.childNodes[0].nodeValue == "P")
        	{
        		str = str+"<td class='boldEleven'>Pending";
        	}
        	else if(CallStatus.childNodes[0].nodeValue == "R")
        	{
        		str = str+"<td class='boldEleven'>Cancelled / Rejected";
        	}
        	else
        	{
	        	str = str+"<td class='boldEleven'>Completed";
        	}
        	
        	//Engg Assign
        	if(EnggStatus.childNodes[0].nodeValue == "N")
        	{
        		str = str+"<td class='boldEleven'>Not Assign";
        	}
        	else if(EnggStatus.childNodes[0].nodeValue == "R")
        	{
        		str = str+"<td class='boldEleven'>Reassign";
        	}
        	else
        	{
	        	str = str+"<td class='boldEleven'>Assigned";
        	}
        	
        	
	 	}
	 	
	 	if(batchs.childNodes.length<1)
	 	{
	 		str = str+"<tr><td colspan=8 class='errormessage'>Data not found....</td>";
	 		document.getElementById('Delete').disabled=true;
     		document.getElementById('Edit').disabled=true;
	 	}
	 	else
	 	{
	 	document.getElementById('Delete').disabled=false;
     	document.getElementById('Edit').disabled=false;
	 	}	
	 	str=str+"</table></center>";
	 	 
	 	var tb=document.getElementById('divscroll');
  	 	tb.innerHTML=str  ; 
 }


function HistoryOpen(query)
{  
	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+(screen.width-100)+',height='+(screen.height-100)+',left=0,top=0,screenX=0,screenY=0';
	newWindow = window.open(query,"subWind",styleStr);
	newWindow.focus( );
}

  