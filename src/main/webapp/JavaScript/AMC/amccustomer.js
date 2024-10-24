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

 

function LoadAMCCustomers()
{
	var sr=document.getElementById('search').value; 
	LoadAMCCustomer(sr);
	 
} 
   

 
function LoadAMCCustomer(startLetter)
 {
 	try
 	{
 		var  branch = document.getElementById('branch').value;
 		var servicecenter=document.getElementById('servicecenter').value;
 		var group=document.getElementById('group').value;
 		var url = "../AMC?actionS=LoadAMCCustomer&group="+escape(group)+"&startLetter="+escape(startLetter)+"&servicecenter="+servicecenter+"&branch="+branch;
 		initRequest(url);
 		req.onreadystatechange=NoncustomerRequest;
 		req.open("GET", url, true);
 		req.send(null);
 	}
 	catch(err)
 	{
 		akert(err);
 	}
   
}
 
 function NoncustomerRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	
	        ClearTable('divscrolls');  
	        ClearTabler('totRec');  
	        document.getElementById('Edit').disabled=true;  
	  		 if (req.status == 200) 
	        {		  	
	        	NoncustomerMessagess() 
	        }
	        else
	        {
	        	var tb=document.getElementById('divscrolls');
	  	 		tb.innerHTML="<br><br><br><center><font  class='bolddeepred'>Data not found...</font><center>" ;
	  	 	
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}

function NoncustomerMessagess() 
{	 
     	var batchs = req.responseXML.getElementsByTagName("Fieldsss")[0];
     	var str=""; 
 		str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	 	for(loop = 0; loop < batchs.childNodes.length; loop++) 
  	 	{	     
      	
  	 		var batch = batchs.childNodes[loop];
  	 		var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
  	 		var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
  	 		var Phone = batch.getElementsByTagName("Phone")[0].childNodes[0].nodeValue;
  	 		var Mobile = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
  	 		var Email = batch.getElementsByTagName("Email")[0].childNodes[0].nodeValue;
	    
	        if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";		
			   
			str=str+"<td  class='boldEleven'><input name='custid' id='custid' type='checkbox' value='"+Id+"'>&nbsp;"+(loop+1);
			str=str+"<td  class='boldEleven'  >&nbsp;"+Name;
			str=str+"<td  class='boldEleven'  >&nbsp;"+Phone;
			str=str+"<td  class='boldEleven'  >&nbsp;"+Mobile;
			str=str+"<td  class='boldEleven' align='right'  >&nbsp;"+Email;
			
		
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
        var tb=document.getElementById('divscrolls');
        tb.innerHTML=str   ;
        tb=document.getElementById('totRec');
     	 tb.innerHTML= "<font  class='bolddeepred'>Total no of Records :: "+batchs.childNodes.length+"</font>"; 
 	
}