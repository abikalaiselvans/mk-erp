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


function LoadAMCPersonalinfo(ctr) 
{
	var url = "../inventory?actionS=LoadAMCPersonalinfo&id="+escape(ctr.value);
	initRequest(url);
	req.onreadystatechange =AMCPersonalinfoRequest;
    req.open("GET", url, true);
    req.send(null);
    
    
    
}
function AMCPersonalinfoRequest() 
{
    if(req.readyState == 4) 
    {  
    	ClearTable('infos');
    	document.getElementById('submit').disabled=true;
     	if (req.status == 200) 
    	{		
    		AMCPersonalinfoMessages();
        }
    }
}


function AMCPersonalinfoMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("Detailss")[0];   
    	var str="<center><table width='100%'  class='boldEleven'       cellpadding=2 cellspacing=1 bgcolor='#9900CC' >"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Name= batch.getElementsByTagName("Name")[0];
 			Street= batch.getElementsByTagName("Street")[0];
 			City= batch.getElementsByTagName("City")[0];
 			State = batch.getElementsByTagName("State")[0];
 			Phone = batch.getElementsByTagName("Phone")[0];
 			Mobile = batch.getElementsByTagName("Mobile")[0];
 			Email = batch.getElementsByTagName("Email")[0];
 			str = str+"<tr class='MRow2'><td class='boldEleven' colspan='2'><center><b>Customer Information</b></center>";
        	str = str+"<tr class='MRow2'><td class='boldEleven'><b>Name</b><td class='boldEleven'>"+Name.childNodes[0].nodeValue;
        	str = str+"<tr class='MRow1'><td class='boldEleven'><b>Street</b><td class='boldEleven'>"+Street.childNodes[0].nodeValue;
        	str = str+"<tr class='MRow2'><td class='boldEleven'><b>City</b><td class='boldEleven'>"+City.childNodes[0].nodeValue;
        	str = str+"<tr class='MRow1'><td class='boldEleven'><b>State</b><td class='boldEleven'>"+State.childNodes[0].nodeValue;
        	str = str+"<tr class='MRow2'><td class='boldEleven'><b>Phone</b><td class='boldEleven'>"+Phone.childNodes[0].nodeValue;
        	str = str+"<tr class='MRow1'><td class='boldEleven'><b>Mobile</b><td class='boldEleven'>"+Mobile.childNodes[0].nodeValue;
        	str = str+"<tr class='MRow2'><td class='boldEleven'><b>Email</b><td class='boldEleven'>"+Email.childNodes[0].nodeValue;
       }
	 	
	 	if(batchs.childNodes.length<1)
	 	{
	 		str = str+"<tr><td colspan=8 class='errormessage'>Data not found....</td>";
	 		document.getElementById('submit').disabled=true;
     		
	 	}
	 	else
	 	{
	 	document.getElementById('submit').disabled=false;
     	
	 	}	
	 	str=str+"</table></center>";
	 	 
	 	var tb=document.getElementById('infos');
  	 	tb.innerHTML=str  ; 
 }

  