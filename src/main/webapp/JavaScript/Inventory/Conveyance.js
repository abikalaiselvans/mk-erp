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
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 
}
  

function loadConveyance() 
{
	 
	var fromdate=document.getElementById('fromdate').value;
	alert(fromdate);
    var todate=document.getElementById('todate').value; 
    alert(todate);
    var url = "../inventory?actionS=INVConveyance&fromdate="+escape(fromdate)+"&todate="+escape(todate);
	
    initRequest(url);
    req.onreadystatechange = ConveyanceRequest;
    req.open("GET", url, true);
    req.send(null);
    
}
function ConveyanceRequest() {
    if(req.readyState == 4) {    	
        ClearTable('Conveyance');
        if (req.status == 200) {		  	
          ConveyanceMessages();
        }
    }
}
function ConveyanceMessages() {
    var batchs = req.responseXML.getElementsByTagName("Conveyances")[0];   	    
	var str=""; 
	var loop;
	var fromdate=document.getElementById('fromdate').value;
    var todate=document.getElementById('todate').value; 
    var link="";
    var link1="";
	str=str+"<table width='100%' border='0' bgcolor='#CCCCC0' class='boldEleven' cellpadding=3 cellspacing=1>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    link="";
    	link1="";
	    var batch = batchs.childNodes[loop];
        var Staffname = batch.getElementsByTagName("Staffname")[0];
        var Staffid = batch.getElementsByTagName("Staffid")[0];
        var noofentry = batch.getElementsByTagName("noofentry")[0];
        var amount = batch.getElementsByTagName("amount")[0];
        
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		link = "Conveyanceaccrej.jsp?todate="+todate+"&fromdate="+fromdate+"&empid="+Staffid.childNodes[0].nodeValue;
		link1 = "Conveyancelistall.jsp?todate="+todate+"&fromdate="+fromdate+"&empid="+Staffid.childNodes[0].nodeValue;		
		str=str+"<td width='10' class='boldEleven'>"+(loop+1);
		str=str+"<td width='140' class='boldEleven'>"+Staffid.childNodes[0].nodeValue;
		str=str+"<td width='150' class='boldEleven'>"+Staffname.childNodes[0].nodeValue;
		str=str+"<td width='150' class='boldEleven'>"+noofentry.childNodes[0].nodeValue;
		str=str+"<td width='150' class='boldEleven'>"+amount.childNodes[0].nodeValue;
		str=str+"<td width='150' class='boldEleven'><a href='"+link +"'><font class='boldgreen'>Accept/Reject<font></a>";
		str=str+"<td width='150' class='boldEleven'><a href='"+link1 +"'><font class='boldgreen'>List</font></a>";
	 }
     str=str+"</table>";
     if(batchs.childNodes.length<1)
     {
        var tb=document.getElementById('Conveyance');
  	 	tb.innerHTML="<center class='boldEleven'>Data not found<center>"; 
  	 }
  	 else
  	 {
  	    var tb=document.getElementById('Conveyance');
  	 	tb.innerHTML=str ;  
  	 }
}		

  
