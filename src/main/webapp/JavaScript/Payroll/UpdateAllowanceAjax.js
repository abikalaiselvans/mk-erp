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
 
var divname="";
var txtid="";
var tid="";
var focusdiv="";
function UpdateAllowance(empid,month,year,column,elemt,divs,tableid,tablename,rowdiv) 
{
	var emp=empid;
    var mon=month;
    var yea=year;        
    var col=column;
    var ele=elemt;
    divname=divs;
    focusdiv=rowdiv;
    txtid=elemt;
    tid=tableid;
    var val = document.getElementById(elemt).value;
    var r=confirm("Update Allowance ")
    if (r==true)
	{
	
	    var url = "../Payroll?actionS=ALLOWANCEUPDATE&month="+escape(mon)+"&year="+escape(yea);
	    url = url+"&empid="+emp+"&column="+col+"&value="+val+"&tablename="+tablename;
	    initRequest(url);
	    req.onreadystatechange = UpdateAllowanceRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	else
	{
		document.getElementById('Close').focus();//rowdiv
	}  
}

 
function UpdateAllowanceRequest() 
{
    if(req.readyState == 4) 
    {    	
        if (req.status == 200) 
        {		  	
          UpdateAllowanceMessages();
        }
    }
    
}
 
function UpdateAllowanceMessages() 
{   
    var batchs = req.responseXML.getElementsByTagName("Updates")[0];   	    
    var str=""; 
    var s="";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {           		                           
	    var batch = batchs.childNodes[loop];
        var Status = batch.getElementsByTagName("Status")[0]; 
     	s =Status.childNodes[0].nodeValue; 
    }	
	if(s = "TRUE")
	{
  		document.getElementById(txtid).disabled=true; 	
	    document.getElementById(tid).bgColor="#9900CC";
  		 
  	}	
  	else
  	{
  		document.getElementById(txtid).disabled=false; 	 
	}
   	
  	document.getElementById('Close').focus();//focusdiv
}
  