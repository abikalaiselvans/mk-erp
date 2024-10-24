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
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}

 
function checkLeaveBalance(empid,date)
 {
 	var leavetype=document.getElementById('leavetype').value;   
    var url = "../attendance?actionS=checkLeaveBalance&empid="+escape(empid)+"&leavetype="+leavetype+"&date="+date;
	initRequest(url);
	req.onreadystatechange=checkLeaveBalanceRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function checkLeaveBalanceRequest() 
 {
    if(req.readyState == 4) 
    {    	
        if (req.status == 200) 
        {		  	
          checkLeaveBalanceMessages();
        }
    }
}


function checkLeaveBalanceMessages() 
{	 
     
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];  
    var str=""; 
	
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Leave = batch.getElementsByTagName("Leave")[0].childNodes[0].nodeValue;
	    var Eligible = batch.getElementsByTagName("Eligible")[0].childNodes[0].nodeValue;
	    var Taken = batch.getElementsByTagName("Taken")[0].childNodes[0].nodeValue;
	    var Balance = batch.getElementsByTagName("Balance")[0].childNodes[0].nodeValue;
	    document.getElementById('leavebalance').value=Balance;   
    }
	 
      	
}