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
 
 
 

function LoadPayTaxValue(startLetter) 
{
    try
    {
	    var Taxid = document.getElementById('Taxid').value;
	    var url = "../Payroll?actionS=PAYLoadTaxValue&startLetter="+startLetter+"&Taxid="+Taxid;
	    initRequest(url);
		req.onreadystatechange = PayTaxValueRequest;
	    req.open("GET", url, true);
	    req.send(null);
	 }
	 catch(err)   
	 {
	 	alert(err.description);
	 }
}

function PayTaxValueRequest() {
    if(req.readyState == 4) {    	
        ClearTable('PayTaxvaluetable');
        ClearTabler('totalrecord');
         
        if (req.status == 200) {		  	
          PayTaxValueMessages();
        }
    }
}

function PayTaxValueMessages() 
{   
	try
	{   
    	var batchs = req.responseXML.getElementsByTagName("TaxIdss")[0];   	    
		var str=""; 
	    //Id,Name,Greater,Lesser,Percent,Amount,Description
	    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	    
	    str=str+"<tr class='MRow1'>";
	    str=str+"<td class='boldEleven'><b>S.NO</b></td>";
	    str=str+"<td class='boldEleven'><b>TAX NAME</b></td>";
	    str=str+"<td class='boldEleven'><b> >=  </b></td>";
	    str=str+"<td class='boldEleven'><b> <=  </b></td>";
	    str=str+"<td class='boldEleven'><b> ( % ) </b></td>";
	    str=str+"<td class='boldEleven'><b> VALUE  </b></td>";
	    str=str+"<td class='boldEleven'><b> DESCRIPTION  </b></td>";
	    str=str+"</tr>";
	    
	    
	    for(loop = 0; loop < batchs.childNodes.length; loop++) 
	    {           		                           
		    var batch = batchs.childNodes[loop];
	        var Id = batch.getElementsByTagName("Id")[0];
	    	var Name = batch.getElementsByTagName("Name")[0];
	    	var Greater = batch.getElementsByTagName("Greater")[0];
	    	var Lesser = batch.getElementsByTagName("Lesser")[0];
	    	var Percent = batch.getElementsByTagName("Percent")[0];
	    	var Amount = batch.getElementsByTagName("Amount")[0];
	    	var Description = batch.getElementsByTagName("Description")[0];
	    	if(loop%2==1)
				str=str+"<tr class='MRow2'>";
			else
			    str=str+"<tr  class='MRow1'>";		
			
			str=str+"<td width='138'><input type='checkbox' name='Paytaxvalueid'  name='Paytaxvalueid' value='"+Id.childNodes[0].nodeValue+"'>"+(loop+1)+"</td>";
			str=str+"<td width='200' class='boldEleven'> "+Name.childNodes[0].nodeValue+" </td>";
			str=str+"<td width='125' class='boldEleven'>"+Greater.childNodes[0].nodeValue+"</td>";
			str=str+"<td width='125' class='boldEleven'>"+Lesser.childNodes[0].nodeValue+"</td>";
			str=str+"<td width='125' class='boldEleven'>"+Percent.childNodes[0].nodeValue+"</td>";
			str=str+"<td width='125' class='boldEleven'>"+Amount.childNodes[0].nodeValue+"</td>";
			str=str+"<td width='125' class='boldEleven'>"+Description.childNodes[0].nodeValue+"</td>";
			str=str+" </tr>";
	     }
	     
	  	 if(batchs.childNodes.length >0)
	  	 {
	  	 	 
	     }
	     else
	     {
	     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
	     	 
	     
	     }	
	     str=str+"</table>";
	     var tb=document.getElementById('PayTaxvaluetable');
	  	 tb.innerHTML=str   ; 	
	  	 tb=document.getElementById('totalrecord');
	  	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Records :: "+batchs.childNodes.length+"</font><br>"  ; 
	  	  
	     
	  }
	  catch(err)
	  {
	  	alert(err.description);
	  }
}

