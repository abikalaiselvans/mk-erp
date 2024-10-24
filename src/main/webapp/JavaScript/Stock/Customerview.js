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
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    ;
  	 
}
 
function Clear(ctr1)
{
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 


function LoadCustomer(startletter) 
{	
	var customergroup=document.getElementById('customergroup').value;
	var url = "../Stock?actionS=LoadCustomer&startletter="+escape(startletter)+"&customergroup="+customergroup;
   	initRequest(url);
    req.onreadystatechange = CustomerRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function CustomerRequest() {
    if(req.readyState == 4) {
        Clear('divscroll');
        var tb=document.getElementById('totalrecord');
  	 	tb.innerHTML= "";
        if (req.status == 200) 
        {
          CustomerMessages();
        }
    }
}
function CustomerMessages() 
{
	 var batchs = req.responseXML.getElementsByTagName("Customers")[0];   	    
	var str=""; 
	str=str+"<table width='100%'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0];
        var Name = batch.getElementsByTagName("Name")[0];
        var Mobile = batch.getElementsByTagName("Mobile")[0];
        var Mail = batch.getElementsByTagName("Mail")[0];
        var Active = batch.getElementsByTagName("Active")[0];
        var Tin = batch.getElementsByTagName("Tin")[0];
        var Cmobile = batch.getElementsByTagName("Cmobile")[0];
        var Cperson = batch.getElementsByTagName("Cperson")[0];
       
       
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";
		  
		str=str+"<td  class='boldEleven'><input  name='Customerid'  id='Customerid'  type='checkbox' value='"+Id.childNodes[0].nodeValue+"' /> "+(loop+1);
		str=str+"<td  class='boldEleven'>"+Name.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Mobile.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Mail.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Active.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Tin.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Cmobile.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Cperson.childNodes[0].nodeValue;
	 
	 }
     str=str+"</table>";
     
     var tb=document.getElementById('divscroll');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML= "<font color='red'>Total no of Records ::"+batchs.childNodes.length +"</font>"; 
  	 
}

 