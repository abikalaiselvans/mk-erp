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
	 var str="<center class='bolddeepred'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    ;
 
}
 
function Clear(ctr1)
{
	 var str="<center class='boldEleven'><font color='red'><b>Data not found</b></font><center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 


function LoadQuotation(startletter) 
{	
	var division=document.getElementById('division').value;
	var customer=document.getElementById('customer').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var url = "../Stock?actionS=LoadQuotation&startletter="+startletter+"&division="+division+"&customer="+customer+"&month="+month+"&year="+year;
   	initRequest(url);
    req.onreadystatechange = LoadQuotationRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function LoadQuotationRequest() {
    if(req.readyState == 4) {
        Clear('QuotationTable');
       
        if (req.status == 200) 
        {
          LoadQuotationMessages();
        }
    }
}
function LoadQuotationMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Quotations")[0];   	    
	 
	var str=""; 
	str=str+"<table width='100%'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var ID = batch.getElementsByTagName("ID")[0];
        var Number = batch.getElementsByTagName("Number")[0];
        var Cutomername = batch.getElementsByTagName("Cutomername")[0];
        var Date = batch.getElementsByTagName("Date")[0];
        var Amount = batch.getElementsByTagName("Amount")[0];
        var Status = batch.getElementsByTagName("Status")[0];
         
         
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";
		str=str+"<td  class='boldEleven'><input  name='ID'  id='ID'  type='checkbox' value='"+Number.childNodes[0].nodeValue+"' /> "+(loop+1);
		str=str+"<td  class='boldEleven'>"+Number.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Cutomername.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Date.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Amount.childNodes[0].nodeValue;
		if(Status =="Y")
			str=str+"<td  class='boldEleven'><font class='bold1'>Completed</font>";
		else	
			str=str+"<td  class='boldEleven'><font class='bolddeepred'>Not Completed</font>";	
		str=str+"<td  class='boldEleven'><a href='#?id="+ID+"'><font class='bold1'>View</font></a>"; 
		str=str+"<td  class='boldEleven'><a href='sendQuotationtoEmail.jsp?id="+ID+"'><font class='bold1'>Mail</font></a>"; 
		
	 }
     str=str+"</table>";
     
     var tb=document.getElementById('QuotationTable');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML= "<font color='red'>Total no of Records ::"+batchs.childNodes.length +"</font>"; 
  	 
}

 