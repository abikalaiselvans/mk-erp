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
	var url = "../inventory?actionS=INVUniqueId&tablename="+escape(tablename);
	url = url +"&fieldname="+fieldname+"&value="+search;
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
 
 

  