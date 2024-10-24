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

function LoadingTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function ClearTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Data not found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


//Start -Kalaiselvan--------------------------UserName--------------------
function LoadTicket() 
{
	var package = document.getElementById('package').value;
	var Status = document.getElementById('Status').value;
	var month = document.getElementById('month').value;
	var year = document.getElementById('year').value;
	var url = "../Common?actionS=Ticket&package="+package+"&Status="+Status+"&month="+month+"&year="+year;
    initRequest(url);
	req.onreadystatechange = TicketRequest;
    req.open("GET", url, true);
    req.send(null);
}

function TicketRequest() 
{
    if(req.readyState == 4) 
    {  
    	ClearTables('ticket');
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
        	var Problem = batch.getElementsByTagName("Problem")[0];
        	var Status = batch.getElementsByTagName("Status")[0];
        	var Link = batch.getElementsByTagName("Link")[0];
        	if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
		    	str=str+"<tr  class='MRow2'>";	
        	str = str+"<td width=100 class='boldEleven'><input type='checkbox' name='Ticketid' value='"+Ticketid.childNodes[0].nodeValue+"' />"+Ticketid.childNodes[0].nodeValue+"</td>";
        	str = str+"<td width=200  class='boldEleven'>"+Name.childNodes[0].nodeValue+"</td>";
        	str = str+"<td  width=100 class='boldEleven'>"+Date.childNodes[0].nodeValue+"</td>";
        	str = str+"<td  width=400 class='boldEleven'>"+Problem.childNodes[0].nodeValue+"</td>";
        	str = str+"<td  width=100 class='boldEleven'>"+Status.childNodes[0].nodeValue;
        	if(Link.childNodes[0].nodeValue == "TRUE")
        		str= str+"&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;<a href='TicketReply.jsp?Ticketid="+Ticketid.childNodes[0].nodeValue+"'><font class='boldgreen'> Reply </font> </a>";
        	str = str+"</td>";
    	}
	 	str=str+"</table>";
	 	var tb=document.getElementById('ticket');
  	 	tb.innerHTML=str  ; 
  	 
 }
//End -Kalaiselvan--------------------------UserName---------------------

  