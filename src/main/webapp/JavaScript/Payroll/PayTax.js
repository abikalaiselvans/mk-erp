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
	 var str="<center><br><br><br><font class='bolddeepred'>Data not found...</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function ClearTabler(ctr1)
{
	 var str="<center><br><br><br><font class='bolddeepred'>Total No of Records : 0</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function LoadPayTax(startLetter) {
    var url = "../Payroll?actionS=PAYLoadTax&startLetter="+startLetter;
	initRequest(url);
	req.onreadystatechange = PayTaxRequest;
    req.open("GET", url, true);
    req.send(null);
}

function PayTaxRequest() {
    if(req.readyState == 4) {    	
        ClearTable('PayTaxtable');
        ClearTabler('totalrecord');
         
        if (req.status == 200) {		  	
          PayTaxMessages();
        }
    }
}

function PayTaxMessages() 
{   
	try
	{   
    	var batchs = req.responseXML.getElementsByTagName("TaxIdss")[0];   	    
		var str=""; 
	    //Id,Name,Description
	    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  		                        
	    for(loop = 0; loop < batchs.childNodes.length; loop++) 
	    {           		                           
		    var batch = batchs.childNodes[loop];
	        var Id = batch.getElementsByTagName("Id")[0];
	    	var Name = batch.getElementsByTagName("Name")[0];
	    	var Description = batch.getElementsByTagName("Description")[0];
	    	if(loop%2==1)
				str=str+"<tr class='MRow2'>";
			else
			    str=str+"<tr  class='MRow1'>";		
			
			str=str+"<td class='boldEleven' width='30%'><input type='checkbox' name='Paytaxid'  name='Paytaxid' value='"+Id.childNodes[0].nodeValue+"'>"+(loop+1);
			str=str+"<td class='boldEleven' width='30%'> "+Name.childNodes[0].nodeValue+" ";
			str=str+"<td class='boldEleven' width='30%'>"+Description.childNodes[0].nodeValue;
			str=str+"</td></tr>";
	     }
	     
	  	  
	     str=str+"</table>";
	     var tb=document.getElementById('PayTaxtable');
	  	 tb.innerHTML=str  
	  	 tb=document.getElementById('totalrecord');
	  	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Records :: "+batchs.childNodes.length+"</font><br>"  ; 
	  	  
	  	 
	  }
	  catch(err)
	  {
	  	alert(err.description);
	  }
}

