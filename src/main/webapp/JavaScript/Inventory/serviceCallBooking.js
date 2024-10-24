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
	 var str="<BR><BR><center><font color='red'><b>Nothing  found</b></font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}


function LoadAMCCallBooking(startLetter) 
{
	var customerid=document.getElementById('customerid').value; 
	var bookingtype = document.getElementById('bookingtype').value;   
	var bookingunder=document.getElementById('bookingunder').value; 
	var callstatus = document.getElementById('callstatus').value;   
	var year=document.getElementById('year').value; 
	var month = document.getElementById('month').value;  
	var branch=document.getElementById('branch').value;	 
	var url = "../inventory?actionS=LoadAMCCallBooking&StartLetter="+escape(startLetter)+"&year="+escape(year)+"&month="+escape(month)+"&customerid="+customerid+"&bookingtype="+bookingtype+"&bookingunder="+bookingunder	+"&callstatus="+callstatus+"&branch="+branch;;
	//alert(url);
	initRequest(url);
	req.onreadystatechange =AMCCallBookingRequest;
    req.open("GET", url, true);
    req.send(null);
    
    
    
}
function AMCCallBookingRequest() 
{
    if(req.readyState == 4) 
    {  
    	ClearTable('divscroll');
    	document.getElementById('Delete').disabled=true;
     	document.getElementById('Edit').disabled=true;
    	if (req.status == 200) 
    	{		
    		AMCCallBookingMessages();
        }
    }
}


function AMCCallBookingMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("Bookings")[0];  
		 
    	var str="<center><table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >"; 
    	str = str+"<tr class='MRow2'><td   class='boldEleven'><b>S.No</td>";
    	str = str+"<td   class='boldEleven'><b>Booking Id</td>";
    	str = str+"<td   class='boldEleven'><b>Customer Name</td>";
    	str = str+"<td   class='boldEleven'><b>Serial Number</td>";
    	str = str+"<td   class='boldEleven'><b>Booking Date</td>";
    	str = str+"<td   class='boldEleven'><b>Closing Date</td>";
    	str = str+"<td   class='boldEleven'><b>Booking Type</td>";
    	str = str+"<td   class='boldEleven'><b>Booking Under</td>";
    	str = str+"<td   class='boldEleven'><b>Call Status</td>";
    	str = str+"<td   class='boldEleven'><b>Engg Status</td>";
    	str = str+"<td   class='boldEleven'><b>Booked By</td>";
    	str = str+"<td   class='boldEleven'><b>Cancell</td>";
    	str = str+"<td   class='boldEleven'><b>Email</td>";
    	str = str+"</tr>";
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Bookingid= batch.getElementsByTagName("Bookingid")[0];
 			Name= batch.getElementsByTagName("Name")[0];
 			Serial= batch.getElementsByTagName("Serial")[0];
 			Bdate = batch.getElementsByTagName("Bdate")[0];
 			Cdate = batch.getElementsByTagName("Cdate")[0];
 			Btype = batch.getElementsByTagName("Btype")[0];
 			Bunder = batch.getElementsByTagName("Bunder")[0];
 			CallStatus = batch.getElementsByTagName("CallStatus")[0];
 			EnggStatus = batch.getElementsByTagName("EnggStatus")[0];
 			Bookedby = batch.getElementsByTagName("Bookedby")[0];
 			Staff = batch.getElementsByTagName("Staff")[0];
 			
 			if(loop%2==1)
        		str = str+"<tr class='MRow2'>";
        	else
        		str = str+"<tr class='MRow1'>";
        	str = str+"<td   class='boldEleven' onmouseover='this.bgColor=color1' onmouseout='this.bgColor=color2'>"+(loop+1);
        	str = str+"<td   class='boldEleven' onmouseover='this.bgColor=color1' onmouseout='this.bgColor=color2'><input type='checkbox' name='Bookingid' id='Bookingid' value='"+Bookingid.childNodes[0].nodeValue+"'>"+Bookingid.childNodes[0].nodeValue;
        	str = str+"<td class='boldEleven' onmouseover='this.bgColor=color1' onmouseout='this.bgColor=color2'>"+Name.childNodes[0].nodeValue;
        	str = str+"<td class='boldEleven' onmouseover='this.bgColor=color1' onmouseout='this.bgColor=color2'>"+Serial.childNodes[0].nodeValue;
        	str = str+"<td class='boldEleven' onmouseover='this.bgColor=color1' onmouseout='this.bgColor=color2'>"+Bdate.childNodes[0].nodeValue;
        	str = str+"<td class='boldEleven' onmouseover='this.bgColor=color1' onmouseout='this.bgColor=color2'>"+Cdate.childNodes[0].nodeValue;
        	//Booking Type
        	if(Btype.childNodes[0].nodeValue == "D")
        	{
        		str = str+"<td class='boldEleven'>Direct";
        	}
        	else if(Btype.childNodes[0].nodeValue == "P")
        	{
        		str = str+"<td class='boldEleven'>Phone";
        	}
        	else
        	{
	        	str = str+"<td class='boldEleven'>Others";
        	}
        	
        	//Booking Under
        	if(Bunder.childNodes[0].nodeValue == "W")
        	{
        		str = str+"<td class='boldEleven'>Warranty";
        	}
        	else if(Bunder.childNodes[0].nodeValue == "A")
        	{
        		str = str+"<td class='boldEleven'>AMC";
        	}
        	else
        	{
	        	str = str+"<td class='boldEleven'>On Call";
        	}
        	
        	
        	//Call Status
        	if(CallStatus.childNodes[0].nodeValue == "N")
        	{
        		str = str+"<td class='boldEleven'>New Call ";
        	}
        	else if(CallStatus.childNodes[0].nodeValue == "P")
        	{
        		str = str+"<td class='boldEleven'>Pending ";
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
        	else
        	{
	        	str = str+"<td class='boldEleven'>Assigned";
        	}
        	
        	str = str+"<td class='boldEleven'><b><font class='boldgreen'>"+Bookedby.childNodes[0].nodeValue +" / "+Staff.childNodes[0].nodeValue ;
        	
        	if(CallStatus.childNodes[0].nodeValue == "P")
        		str = str+"<td class='boldEleven'><a href='../SmartLoginAuth?filename=ServiceCallAssign&actionS=INVServiceCallAssignHistoryCancell&Bookingid="+Bookingid.childNodes[0].nodeValue+"'><font class='boldEleven'> Call Cancell Here</font></a>";
        	else
        		str = str+"<td class='boldEleven'>&nbsp;";
        		
        	str = str+"<td class='boldEleven'><a href='../SmartLoginAuth?filename=ServiceCall&actionS=INVServiceCallBookingSendaMail&servicecall="+Bookingid.childNodes[0].nodeValue+"'><font class='boldEleven'>Send a Mail</font></a></td>";	
        	
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

  