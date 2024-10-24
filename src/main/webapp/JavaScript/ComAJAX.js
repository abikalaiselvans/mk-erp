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
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    ;
}
 
function Clear(ctr1)
{
	 var str="";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

 //Start -Kalaiselvan--------------------------UniqueIdValidate--------------------
function UniqueId(tablename,fieldname,value) 
{
	var search =document.getElementById(value).value;
	var url = "../Common?actionS=ATTUniqueId&tablename="+escape(tablename);
	url = url +"&fieldname="+fieldname+"&value="+search;
	alert(url);
	initRequest(url);
	req.onreadystatechange = UniqueIdRequest;
    req.open("GET", url, true);
    req.send(null);
}
function UniqueIdRequest() 
{
    if(req.readyState == 4) 
    {  
    	Clear('UniqueId');
		document.getElementById('Submit').disabled=true;
    	if (req.status == 200) 
    	{		  	
         	UniqueIdMessages();
        }
    }
}

function UniqueIdMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("UniqueIds")[0];   
    	var str=""; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Exsist= batch.getElementsByTagName("Exsist")[0];
	    	
	    	if(Exsist.childNodes[0].nodeValue == "TRUE")
	    	{
	    		str = str+"<font class='bolddeepred'>Exist</font>";
	    		document.getElementById('Submit').disabled=true;
	    	}	
	    	if(Exsist.childNodes[0].nodeValue == "FALSE")
	    	{
	    		str = str+"<font class='changePos'>Valid</font>";	
	    		document.getElementById('Submit').disabled=false;
	    	}	
        
	 	}
	 	var tb=document.getElementById('UniqueId');
  	 	tb.innerHTML=str  ; 
 }
 //End -Kalaiselvan--------------------------UniqueIdValidate--------------------
 
 
 
 
 
 
//CheckUnique(this,'soValid','com_m_staff','CHR_EMPID')
var dId;

function HomeCheckUnique(sval,divId,tableName,filedName) 
{
	var id = sval.value;
	var url = "../Common?actionS=CheckUnique";
	url=url+"&id="+escape(id);
	url=url+"&tableName="+escape(tableName)+"&fieldName="+escape(filedName);	
	alert(url)
	initRequest(url);	
	 
	dId=divId;	
	req.onreadystatechange = CheckUniqueRequest;
    req.open("GET", url, true);
    req.send(null);
}

var fctr="";


function appCheckUnique(ctr,divId,tableName,filedName) 
{
	var id = document.getElementById(ctr).value;
	var url = "../Common?actionS=CheckUnique";
	url=url+"&id="+id;
	url=url+"&tableName="+escape(tableName)+"&fieldName="+escape(filedName);	
	initRequest(url);
	dId=divId;	
	req.onreadystatechange = CheckUniqueRequest;
    req.open("GET", url, true);
    req.send(null);
}


function CheckUnique(sval,divId,tableName,filedName) 
{
	var id = ""+sval.value;
	fctr=sval;
	var url = "../Common?actionS=CheckUnique";
	url=url+"&id="+id;
	url=url+"&tableName="+escape(tableName)+"&fieldName="+escape(filedName);
	//alert(url);
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
        		fctr.focus();
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
 
 
