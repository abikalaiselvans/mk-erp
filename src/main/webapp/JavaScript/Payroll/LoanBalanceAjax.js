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

function ClearTables(ctr1)
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


function loadAdvance(startLetter) 
{
    var off= document.getElementById('Office').value; 
	var loantype = document.getElementById('loantype').value; 
	var url = "../Payroll?actionS=PAYBalance&startLetter="+startLetter+"&Office="+off+"&loantype1="+loantype;
	initRequest(url);
    req.onreadystatechange = loadAdvanceRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadAdvanceRequest() 
{
	ClearTables('AdvanceTable');      
	ClearTabler('totrec');  
    if(req.readyState == 4) 
    {    	
        if (req.status == 200) 
        {		  	
          loadAdvanceMessages();
        }
    }
}


function loadAdvanceMessages() 
{   
    var batchs = req.responseXML.getElementsByTagName("Balance")[0];   	    
	var str=""; 
    var sum =0;
    str=str+"<table width='100%' class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>";  		                        
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {           		                         
	    var batch = batchs.childNodes[loop];
        var Staffid = batch.getElementsByTagName("Staffid")[0]; 
		var StaffName = batch.getElementsByTagName("StaffName")[0]; 
		var LoanName = batch.getElementsByTagName("LoanName")[0]; 
    	var CreditAmt = batch.getElementsByTagName("CreditAmt")[0];
		var DebitAmt = batch.getElementsByTagName("DebitAmt")[0];
    	var Balance = batch.getElementsByTagName("Balance")[0];
    	if(loop%2==1)
			str=str+"<tr class='MRow2'>";
		else
		    str=str+"<tr  class='MRow1'>";
		str=str+"<td width='4%'  class='boldEleven'>"+(loop+1)+"";    		
		str=str+"<td width='16%'  class='boldEleven'>"+Staffid.childNodes[0].nodeValue;
		str=str+"<td width='16%'  class='boldEleven'>"+StaffName.childNodes[0].nodeValue;
		str=str+"<td width='16%'  class='boldEleven'>"+LoanName.childNodes[0].nodeValue;
		str=str+"<td width='16%'  class='boldEleven'>"+CreditAmt.childNodes[0].nodeValue;
		str=str+"<td width='16%'  class='boldEleven'>"+DebitAmt.childNodes[0].nodeValue;
		str=str+"<td width='16%'  class='boldEleven'>"+Balance.childNodes[0].nodeValue;
		str=str+"</td></tr>";
		sum = sum+parseFloat(Balance.childNodes[0].nodeValue);
     }
     str=str+"<tr class='MRow1'>";
	 str=str+"<td class='boldEleven' align='right' colspan='6'><font color='red'>Total Balance</font></td>"; 
	 str=str+"<td class='boldEleven' align='right'><font color='red'>"+sum+"</font></td></tr>"; 
	 
	 var tb=document.getElementById('AdvanceTable');
  	 tb.innerHTML=str;   	
  	  
	if(batchs.childNodes.length<1)
    	str=str+"<tr class='MRow1'><td class='bolddeepred'><center> Data not found...</center></td></tr>";
     
	tb=document.getElementById('totrec');
  	tb.innerHTML= " <center><font class='bolddeepred'>Total No of Record : "+batchs.childNodes.length  +"</font></center>"; 
  	str=str+"</table>";
   
}


