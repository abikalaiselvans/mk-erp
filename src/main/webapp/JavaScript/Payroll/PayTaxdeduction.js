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
 
 

function LoadPayTaxdeduction(startLetter) 
{
    var taxid=document.getElementById('tax').value;
    var month=document.getElementById('month').value;
    var year=document.getElementById('year').value;
    var Office=document.getElementById('Office').value;
    var url = "../Payroll?actionS=LoadPayTaxdeduction&startLetter="+startLetter+"&year="+year+"&month="+month+"&taxid="+taxid+"&Office="+Office;
	initRequest(url);
	req.onreadystatechange = PayTaxdeductionRequest;
    req.open("GET", url, true);
    req.send(null);
}

function PayTaxdeductionRequest() {
    if(req.readyState == 4) {    	
        ClearTable('PayTaxtable');
        ClearTabler('totalrecord');
        document.getElementById('Delete').disabled=true;
	    document.getElementById('Edit').disabled=true;
        if (req.status == 200) {		  	
          PayTaxdeductionMessages();
        }
    }
}

function PayTaxdeductionMessages() 
{   
	try
	{   
    	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
		var str=""; 
	    //Id,Name,Description
	    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  		                        
	    for(loop = 0; loop < batchs.childNodes.length; loop++) 
	    {           		                           
		    var batch = batchs.childNodes[loop];
	        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    	var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    	var Tax = batch.getElementsByTagName("Tax")[0].childNodes[0].nodeValue;
	    	var Empid = batch.getElementsByTagName("Empid")[0].childNodes[0].nodeValue;
	    	var Month = batch.getElementsByTagName("Month")[0].childNodes[0].nodeValue;
	    	var Year = batch.getElementsByTagName("Year")[0].childNodes[0].nodeValue;
	    	//Id,Name,Tax,Empid,Month,Year
	    	
	    	if(loop%2==1)
				str=str+"<tr class='MRow2'>";
			else
			    str=str+"<tr  class='MRow1'>";		
			
			str=str+"<td width='138'><input type='checkbox' name='id'  name='id' value='"+Id+"'>"+(loop+1);
			str=str+"<td width='125' class='boldEleven'>"+Empid+"</td>";
			str=str+"<td width='200' class='boldEleven'>"+Name+"</td>";
			str=str+"<td width='125' class='boldEleven'>"+Tax+"</td>";
			str=str+"<td width='125' class='boldEleven'>"+Month+"</td>";
			str=str+"<td width='125' class='boldEleven'>"+Year+"</td>";
			str=str+"</td></tr>";
	     }
	     
	  	 if(batchs.childNodes.length >0)
	  	 {
	  	 	document.getElementById('Delete').disabled=false;
	     	document.getElementById('Edit').disabled=false;
	     }
	     else
	     {
	     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
	     	document.getElementById('Delete').disabled=true;
	     	document.getElementById('Edit').disabled=true;
	     
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

