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


 
function AccountMaster(startLetter)
 {
 	try
 	{
 		var accountgroup = document.getElementById('accountgroup').value;
 		var url = "../Account?actionS=LoadAccountMaster&startLetter="+escape(startLetter)+"&accountgroup="+accountgroup;
    	initRequest(url);
    	req.onreadystatechange=AccountMasterRequest;
		req.open("GET", url, true);
    	req.send(null);
    	
    }
     
	catch(err)
	{
		
		alert(err.description);
		
	} 	
    
}
 
 function AccountMasterRequest() 
 {
 	try
 	{
 	if(req.readyState == 4) 
    {    	
        ClearTable('AccountMasterTable');  
        var tb=document.getElementById('AccountMasterTable');
  	 	tb.innerHTML="" ;
  	 	
  	 	var tb1=document.getElementById('totalrec');
  	 	tb1.innerHTML=" " ;
  	 	
		document.getElementById('Edit').disabled=true; 
		document.getElementById('Delete').disabled=true;   		
	    if (req.status == 200) 
        {		
          AccountMasterMessages();
        }
    }
    }
	catch(err)
	{
		alert(err.description);
	
	} 
}

function AccountMasterMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    var str=""; 
	str=str+"<table width=100%  border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
  	for(loop = 0; loop < batchs.childNodes.length; loop++)
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Phone = batch.getElementsByTagName("Phone")[0].childNodes[0].nodeValue;
	    var Mobile = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
	    var Email = batch.getElementsByTagName("Email")[0].childNodes[0].nodeValue;
	    var Person = batch.getElementsByTagName("Person")[0].childNodes[0].nodeValue;
	    var LST = batch.getElementsByTagName("LST")[0].childNodes[0].nodeValue;
	    var GST = batch.getElementsByTagName("GST")[0].childNodes[0].nodeValue;
	    var TIN = batch.getElementsByTagName("TIN")[0].childNodes[0].nodeValue;
	    
	           
	    //Id Name Phone Mobile Email Person LST GST TIN
	    
	    
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td  class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1);
		str=str+"<td  class='boldEleven'>&nbsp;"+Name;
		str=str+"<td  class='boldEleven'>&nbsp;"+Phone;
		str=str+"<td  class='boldEleven'>&nbsp;"+Mobile;
		str=str+"<td  class='boldEleven'>&nbsp;"+Email;
		str=str+"<td  class='boldEleven'>&nbsp;"+Person;
		str=str+"<td  class='boldEleven'>&nbsp;"+LST;
		str=str+"<td  class='boldEleven'>&nbsp;"+GST;
		str=str+"<td  class='boldEleven'>&nbsp;"+TIN;
		 
		
		
    }
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	document.getElementById('Edit').disabled=false;
     	document.getElementById('Delete').disabled=false;
     }
     else
     {
     	str=str+"<td colspan='9' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
     	document.getElementById('Edit').disabled=true;
     	document.getElementById('Delete').disabled=true;
     
     }	
	 str=str+"</table>";
	 var tb=document.getElementById('AccountMasterTable');
  	 tb.innerHTML=str   ;
  	 
  	 tb=document.getElementById('totalrec');
  	 tb.innerHTML= "<center><font color='red'>Total no of Records ::</font>"+batchs.childNodes.length+"</center>"; 
     	
}