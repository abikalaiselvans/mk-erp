var isIE;
var req;
var names;
var target1;
var ctrl;
 

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
	 var str="<center><br><font class='bolddeepred'>Total No of Records : 0</font></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

 function LoadTicket(startLetter) 
{
	var package = document.getElementById('package').value;
	var Status = document.getElementById('Status').value;
	var month = document.getElementById('Month').value;
	var year = document.getElementById('Year').value;
	var url = "../Debug?actionS=Ticket&startLetter="+escape(startLetter)+"&package="+package+"&Status="+Status+"&month="+month+"&year="+year;
    initRequest(url);
	req.onreadystatechange = TicketRequest;
    req.open("GET", url, true);
    req.send(null);
}

function TicketRequest() 
{
    ClearTabler('totalrec');
    ClearTable('ticket');
	if(req.readyState == 4) 
    {  
    	
		
		//ClearTables('ticket');
    	if (req.status == 200) 
    	{		  	
         	TicketMessages();
        }
    }
}


function TicketMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("Tickets")[0];   
    	var str= "<table width='100%' bgcolor='#cccccc' border='0' class='boldEleven' cellpadding=2 cellspacing=1 >"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Ticketid = batch.getElementsByTagName("Ticketid")[0];
        	var Name = batch.getElementsByTagName("Name")[0];
        	var Date = batch.getElementsByTagName("Date")[0];
        	var Status = batch.getElementsByTagName("Status")[0];
        	var Link = batch.getElementsByTagName("Link")[0];
        	var Package = batch.getElementsByTagName("Packages")[0].childNodes[0].nodeValue;
        	var Problem = batch.getElementsByTagName("Problem")[0].childNodes[0].nodeValue;
        	
        	Problem=Problem.replace( "9865043008" ,"&");
        	 
        	 
        	if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
		    	str=str+"<tr  class='MRow2'>";	
        	
        	if(Status.childNodes[0].nodeValue =="Y")
        		str = str+"<td width=100 class='boldEleven'>"+Ticketid.childNodes[0].nodeValue+"</td>";
        	else	
        		str = str+"<td width=100 class='boldEleven'><input type='checkbox' name='Ticketid' value='"+Ticketid.childNodes[0].nodeValue+"' />"+Ticketid.childNodes[0].nodeValue+"</td>";
        	str = str+"<td width=200  class='boldEleven'>"+Package+"</td>";
        	str = str+"<td width=200  class='boldEleven'>"+Name.childNodes[0].nodeValue+"</td>";
        	str = str+"<td  width=100 class='boldEleven'>"+Date.childNodes[0].nodeValue+"</td>";
        	str = str+"<td  width=400 class='boldEleven'>"+Problem+"</td>";
        	if(Status.childNodes[0].nodeValue =="Y")
        		str = str+"<td  width=100 class='boldEleven'><font class='boldgreen'> Completed...</font>" ;
        	else
        		str = str+"<td  width=100 class='boldEleven'> <font class='bolddeepred'> Not Completed...</font>" ;
        		
        	if(Link.childNodes[0].nodeValue == "TRUE" && Status.childNodes[0].nodeValue =="N")
        		str= str+"&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;<a href='TicketReply.jsp?Ticketid="+Ticketid.childNodes[0].nodeValue+"'><font class='boldgreen'> Reply </font> </a>";
        	str = str+"</td>";
    	}
		
		var tb=document.getElementById('ticket');
  	 	tb.innerHTML=str  ; 
  	 
  	 	tb=document.getElementById('totalrec');
  	 	tb.innerHTML= "<center><font class='bolddeepred'>Total no of Records ::"+batchs.childNodes.length+"</font></center>";
	 	if(batchs.childNodes.length >0)
  		{  	 	
     		document.getElementById('Edit').disabled=false;
     		document.getElementById('Delete').disabled=false;
    	}
    else
    	{
     		str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
     		document.getElementById('Edit').disabled=true;
     		document.getElementById('Delete').disabled=true;
     
    	}	
	 str=str+"</table>";
	 
 }
 
  