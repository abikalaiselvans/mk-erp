var isIE;
var req;
var names;
 
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
	 var str="<center><br><br><br><font class='bolddeepred'>Total No of Records : 0</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 

function  loadloanCredit(startLetter) 
{
	var off= document.getElementById('Office').value;
	var loantype= document.getElementById('loantype').value;
	var url = "../Payroll?actionS=loadLoanDebit&startLetter="+startLetter+"&Office="+off+"&loantype="+loantype;
	initRequest(url);
	req.onreadystatechange = loanCreditRequest;
    req.open("GET", url, true);
    req.send(null);
   
}

function loanCreditRequest() 
{
    
		ClearTable ('loanCreditTable');
		ClearTabler('totrec');  

	if(req.readyState == 4) 
    {    	
         
        if (req.status== 200) 
        {		  	
        	loanCreditMessages();
        }
    }
}

function loanCreditMessages() 
{	 
	var batchs = req.responseXML.getElementsByTagName("DRowsLoan")[0];   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++){
	    var batch = batchs.childNodes[loop];
	    var IdLoand = batch.getElementsByTagName("IdLoand")[0].childNodes[0].nodeValue;
	    var DEMPID = batch.getElementsByTagName("DEMPID")[0].childNodes[0].nodeValue;
	    var DCREDIT = batch.getElementsByTagName("DCREDIT")[0].childNodes[0].nodeValue;
		var LOANNAME = batch.getElementsByTagName("LOANNAME")[0].childNodes[0].nodeValue;
		var DAMOUNT = batch.getElementsByTagName("DAMOUNT")[0].childNodes[0].nodeValue;
		var DSTAFFNAME = batch.getElementsByTagName("DSTAFFNAME")[0].childNodes[0].nodeValue;
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td width='5%'  class='boldEleven'><input name='id' id='id' type='checkbox' value='"+IdLoand+"' />"+(loop+1)+".</td>";
		str=str+"<td width='17%'  class='boldEleven'>&nbsp;"+DEMPID+"</td>";
		str=str+"<td width='17%' class='boldEleven'>&nbsp;"+DSTAFFNAME+"</td>";
		str=str+"<td width='17%' class='boldEleven'>&nbsp;"+DCREDIT+"</td>";
		str=str+"<td width='17%' class='boldEleven'>&nbsp;"+LOANNAME+"</td>";
		str=str+"<td width='17%' class='boldEleven'>&nbsp;"+DAMOUNT+"</td>";
		str=str+" </tr>";
    }
   
    if(batchs.childNodes.length<1){
    	str=str+"<tr  class='MRow1'><td class='bolddeepred'><center>Data not found...</center></td></tr>";
    	 
    }
    
    	
     var tb=document.getElementById('loanCreditTable');
  	 tb.innerHTML=str  ; 
  	  tb=document.getElementById('totrec');
  	 tb.innerHTML= " <center><font class='bolddeepred'>Total No of Record : "+batchs.childNodes.length  +"</font></center>"; 
  	
  	     str=str+"</table>";

  	
}

  