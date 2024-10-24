var isIE;
var req;
var names;
var target1;
var ctrl;
 


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
 
 
 

function loadAdvance(startLetter) 
{
    var off= document.getElementById('Office').value;       
    var url = "../Payroll?actionS=PAYAdvance&startLetter="+startLetter+"&Office="+off;
	initRequest(url);
    req.onreadystatechange = loadAdvanceRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadAdvanceRequest() 
{
    if(req.readyState == 4) 
    {    	
    	ClearTable('AdvanceTable');
    	ClearTabler('totalrecord');
        if (req.status == 200) {		  	
          loadAdvanceMessages();
        }
    }
}
function loadAdvanceMessages() {   
    var batchs = req.responseXML.getElementsByTagName("Advances")[0];   	    
	var str=""; 
    var sum =0;
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  		                        
    for(loop = 0; loop < batchs.childNodes.length; loop++) {           		                           
	    var batch = batchs.childNodes[loop];
        var Staffid = batch.getElementsByTagName("Staffid")[0]; 
    	var Staffname = batch.getElementsByTagName("Staffname")[0];
    	var Balance = batch.getElementsByTagName("Balance")[0];
    	if(loop%2==1)
			str=str+"<tr class='MRow2'>";
		else
		    str=str+"<tr  class='MRow1'>";
		str=str+"<td width='10%'  class='boldEleven'>"+(loop+1)+".<input type='checkbox' name='staffid' value='"+Staffid.childNodes[0].nodeValue+"'>";    		
		str=str+"<td   width='30%'  class='boldEleven'>"+Staffid.childNodes[0].nodeValue;
		str=str+"<td   width='30%'  class='boldEleven'>"+Staffname.childNodes[0].nodeValue;
		str=str+"<td   width='30%'  class='boldEleven' align='right'>"+Balance.childNodes[0].nodeValue;
		str=str+"</td></tr>";
		sum = sum+parseFloat(Balance.childNodes[0].nodeValue);
     }
     str=str+"<tr  class='MRow1'>";
	 str=str+"<td    class='boldEleven' align='right' colspan='3'><font color='red'>Total Balance</font></td>"; 
	 str=str+"<td    class='boldEleven' align='right'><font color='red'>"+sum+"</font></td>"; 
	 str=str+"</table><br>";
    var tb=document.getElementById('AdvanceTable');
  	tb.innerHTML=str;   
  	
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Records :: "+batchs.childNodes.length+"</font><br>"  ; 
  	  
}
