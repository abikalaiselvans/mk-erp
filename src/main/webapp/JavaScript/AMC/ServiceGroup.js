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

 
function LoadServiceGroup(startLetter)
 {
 	var  branch = document.getElementById('branch').value;
 	var url = "../AMC?actionS=LoadServiceGroup&startLetter="+escape(startLetter)+"&branch="+branch;
    initRequest(url);
	req.onreadystatechange=ServiceGroupRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function ServiceGroupRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	
	        ClearTable('divscroll'); 
	        ClearTabler('totRec');  
	        document.getElementById('Edit').disabled=true;  
	  		if (req.status == 200) 
	        {		  	
	          ServiceGroupMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
function ServiceGroupMessages() 
{	 
 try
 {
 	var batchs = req.responseXML.getElementsByTagName("Groups")[0];   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	
  	
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
      
        var batch = batchs.childNodes[loop];
        var Field1 = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Field2 = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td  class='boldEleven' ><input name='id' id='id' type='checkbox' value='"+Field1+"'/>&nbsp;"+(loop+1);
		str=str+"<td  class='boldEleven'>&nbsp;"+Field2;
		
		
    }
      
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	document.getElementById('Edit').disabled=false;
     }
     else
     {
     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
     	document.getElementById('Edit').disabled=true;
     
     }	
   
	 str=str+"</table>";
     var tb=document.getElementById('divscroll');
  	 tb.innerHTML=str   ;
  	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font  class='bolddeepred'>Total no of Records :: "+batchs.childNodes.length+"</font>"; 
  }
  catch(err)
  {
	alert(err.description);
  }    	
}