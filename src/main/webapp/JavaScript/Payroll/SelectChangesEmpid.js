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
	 var str="";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}

function ClearTables(ctr1)
{
	 var str="<font class='bolddeepred'>0</font>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function LoadSelectEmpid()
 {
 	var Empid = document.getElementById('Empid').value;
	var loantype = document.getElementById('loantype').value;
	var url = "../Payroll?actionS=LoadSelectEmpid&Empid="+Empid+"&loantype="+loantype;
 	initRequest(url);
	req.onreadystatechange=LoadSelectEmpidRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function LoadSelectEmpidRequest() 
 {
   
 ClearTables('AmtTable');
   if(req.readyState == 4) 
    { 
		 if (req.status == 200) 
	     {		  	
			LoadSelectEmpidMessages();
       	}
    }
}

function LoadSelectEmpidMessages() 
{	 
    var str=""; 
    var sum =0;
    var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    var str=""; 
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
		var creditamt = batch.getElementsByTagName("creditamt")[0].childNodes[0].nodeValue;
		sum = sum+parseFloat(creditamt);
    }
		str=str+"<font color='red'>"+sum+"</font>";
		str=str+"<input type='hidden' name='amt' id='amt' value='"+sum+"'>";
	var tb=document.getElementById('AmtTable');
  	tb.innerHTML=str;   	
	 	
}


