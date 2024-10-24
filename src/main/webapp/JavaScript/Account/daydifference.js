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
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    ;
  	 
}
 
 
function Clear(ctr1)
{
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 


function LoadDayDiff() 
{
    var d1 = document.getElementById("From").value;
	var d2 = document.getElementById("To").value;
	var url = "../Account?actionS=LoadDayDifference&d1="+d1+"&d2="+d2;
	initRequest(url);
    req.onreadystatechange = DayDiffRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 
function DayDiffRequest() 
{
    if(req.readyState == 4) 
    {
      
        if (req.status == 200) 
        {
          DayDiffMessages();
        }
    }
}


function DayDiffMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("daydiffs")[0];   	    
	var str=""; 
	  for(loop = 0; loop < batchs.childNodes.length; loop++) 
	  {
	    var batch = batchs.childNodes[loop];
        var values = batch.getElementsByTagName("values")[0];
        if(values.childNodes[0].nodeValue=="True")
     		document.getElementById('daydiff').value="true";
     	else    	
			document.getElementById('daydiff').value="false";
	 }
	 
     	
  	  
}

 