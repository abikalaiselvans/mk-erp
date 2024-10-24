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
	 var str="<br><br><br><br><center><font color=red>Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 


function loadPFCliamStatus(startLetter) 
{
    var month = document.getElementById('month').value;
    var year = document.getElementById('year').value;
	var url = "../Payroll?actionS=PAYloadPFCliamStatus&startLetter="+startLetter+"&month="+month+"&year="+year;
	initRequest(url);
	req.onreadystatechange = loadPFCliamStatusRequest;
    req.open("GET", url, true);
    req.send(null);
}


function loadPFCliamStatusRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('PFTable');
        document.getElementById('Delete').disabled=true;
	    document.getElementById('Edit').disabled=true;
        if (req.status == 200) 
        {		  	
        	loadPFCliamStatusMessages();
        }
    }
}



function loadPFCliamStatusMessages() 
{   
	try
	{   
    	var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   	    
		 
    	var str=""; 
	    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  		                        
	    for(loop = 0; loop < batchs.childNodes.length; loop++) 
	    {           		                           
		    var batch = batchs.childNodes[loop];
	        var Id1 = batch.getElementsByTagName("Id1")[0];
	    	var Name1 = batch.getElementsByTagName("Name1")[0];
	    	var Date1 = batch.getElementsByTagName("Date1")[0];
	    	var Description1 = batch.getElementsByTagName("Description1")[0];
	    	if(loop%2==1)
				str=str+"<tr class='MRow2'>";
			else
			    str=str+"<tr  class='MRow1'>";		
			
			str=str+"<td><input type='checkbox' name='rowid'  id='rowid'  value='"+Id1.childNodes[0].nodeValue+"'>"+(loop+1)+"</td>";
			str=str+"<td class='boldEleven'>"+Id1.childNodes[0].nodeValue+"</td>";
			str=str+"<td class='boldEleven'>"+Name1.childNodes[0].nodeValue+"</td>";
			str=str+"<td class='boldEleven'>"+Date1.childNodes[0].nodeValue+"</td>";
			str=str+"<td class='boldEleven'>"+Description1.childNodes[0].nodeValue+"</td>";
			str=str+"</td></tr>";
	     }
	     
	  	 if(batchs.childNodes.length >0)
	  	 {
	  	 	document.getElementById('Delete').disabled=false;
	     	document.getElementById('Edit').disabled=false;
	     }
	     else
	     {
	     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
	     	document.getElementById('Delete').disabled=true;
	     	document.getElementById('Edit').disabled=true;
	     
	     }	
	     str=str+"</table>";
	      
	     var tb=document.getElementById('PFTable');
	  	 tb.innerHTML=str    	 
	  }
	  catch(err)
	  {
	  	alert(err.description);
	  }
}

