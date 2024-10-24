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
 
 
 function CheckUnique(sval,divId,tableName,filedName) 
{
	var id = sval.value;
	var url = "../Common?actionS=CheckUnique";
	url=url+"&id="+escape(id);
	url=url+"&tableName="+escape(tableName)+"&fieldName="+escape(filedName);	
	initRequest(url);	
	dId=divId;	
	req.onreadystatechange = CheckUniqueRequest;
    req.open("GET", url, true);
    req.send(null);
}
function CheckUniqueRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
			CheckUniqueMessages();
        }
    }
}
function CheckUniqueMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("Usernames")[0];   
    	var str="<table width=50 >"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Status = batch.getElementsByTagName("Status")[0];
        	if(Status.childNodes[0].nodeValue == "true")
        	{
	    		document.getElementById('Submit').disabled=true;
	    		str = str+"<tr><td><font class='bolddeepred' >Exists..</font></td></tr>";
	    	}
	    	else
	    	{
	    		document.getElementById('Submit').disabled=false;
	    		str = str+"<tr><td class='changePos'>Valid...</td></tr>";
	    	}	
	 	}
	 	str=str+"</table>";
	 	var tb=document.getElementById(dId);
  	 	tb.innerHTML=str  ; 
 }
 