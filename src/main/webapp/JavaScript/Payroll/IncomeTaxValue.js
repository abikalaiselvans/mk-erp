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
	 var str="<center><br><font class='bolddeepred'>Total No of Records : 0</font></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function LoadIncomeTaxValue(startLetter) 
{
    try
    {
	    var Year = document.getElementById('Year').value;
		 var url = "../Payroll?actionS=IncomeLoadTaxValue&startLetter="+startLetter+"&AccYear="+Year;
	    initRequest(url);
		req.onreadystatechange = IncomeTaxValueRequest;
	    req.open("GET", url, true);
	    req.send(null);
		 
	 }
	 catch(err)   
	 {
	 	alert(err.description);
	 }
}

function IncomeTaxValueRequest() {
		ClearTabler('totalrec');
        ClearTable('IncomeTaxvaluetable');
    if(req.readyState == 4) {    	
         if (req.status == 200) {		  	
          IncomeTaxValueMessages();
        }
    }
}

function IncomeTaxValueMessages() 
{   
	try
	{   
    	var batchs = req.responseXML.getElementsByTagName("IncomeIds")[0];   	    
		var str=""; 
	    str=str+"<table width='100%'  class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  		                        
	    for(loop = 0; loop < batchs.childNodes.length; loop++) 
	    {           		                           
		    var batch = batchs.childNodes[loop];
	        var Id = batch.getElementsByTagName("Id")[0];
	    	var Accountyear = batch.getElementsByTagName("Accountyear")[0];
			var Gender = batch.getElementsByTagName("Gender")[0];
	    	var To = batch.getElementsByTagName("To")[0];
	    	var From = batch.getElementsByTagName("From")[0];
	    	var Percent = batch.getElementsByTagName("Percent")[0];
	    	var Description = batch.getElementsByTagName("Description")[0];
	    	if(loop%2==1)
				str=str+"<tr class='MRow2'>";
			else
			    str=str+"<tr  class='MRow1'>";		
			
			str=str+"<td width='138'><input type='checkbox' name='Incometaxvalueid'  id='Incometaxvalueid' value='"+Id.childNodes[0].nodeValue+"'>"+(loop+1)+"</td>";
			str=str+"<td width='200' class='boldEleven'>"+Accountyear.childNodes[0].nodeValue+"</td>";
			str=str+"<td width='200' class='boldEleven'>"+Gender.childNodes[0].nodeValue+"</td>";
			str=str+"<td width='125' class='boldEleven'>"+From.childNodes[0].nodeValue+"</td>";
			str=str+"<td width='125' class='boldEleven'>"+To.childNodes[0].nodeValue+"</td>";
			str=str+"<td width='125' class='boldEleven'>"+Percent.childNodes[0].nodeValue+"</td>";
			str=str+"<td width='125' class='boldEleven'>"+Description.childNodes[0].nodeValue+"</td>";
			str=str+" </tr>";
	     }
		 
	 var tb=document.getElementById('IncomeTaxvaluetable');
  	 tb.innerHTML=str   ;
  	 
  	 tb=document.getElementById('totalrec');
  	 tb.innerHTML= "<center><font class='bolddeepred'>Total no of Records ::"+batchs.childNodes.length+"</font></center>";

	     
	  	 if(batchs.childNodes.length >0)
	  	 {
	  	 	//document.getElementById('Delete').disabled=false;
	     	//document.getElementById('Edit').disabled=false;
	     }
	     else
	     {
	     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
	     	//document.getElementById('Delete').disabled=true;
	     	//document.getElementById('Edit').disabled=true;
	     
	     }	
	     str=str+"</table>";
	     //var tb=document.getElementById('PayTaxvaluetable');
	  	 //tb.innerHTML=str   ; 	 
	  }
	  catch(err)
	  {
	  	alert(err.description);
	  }
}

