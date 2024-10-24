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


function LoadCustomerGroup(startLetter)
{
	try
	{
	 	var status = document.getElementById('status').value;
	 	var division = document.getElementById('division').value;
		var url = "../marketing?actionS=LoadCustomerName&startLetter="+escape(startLetter)+"&status="+status+"&division="+division;
	 	var tob=document.getElementById('divscroll');
		tob.innerHTML="<br><br><center> <img src='../images/loading_gif.gif' width='508' height='381'></center>" ;
		initRequest(url);
		req.onreadystatechange=LoadCustomerGroupRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}
 

function LoadCustomerGroups(ctr)
{
	try
	{
	 	var status = document.getElementById('status').value;
	 	var division = document.getElementById('division').value;
		var url = "../marketing?actionS=LoadCustomerName&startLetter="+escape(ctr.value)+"&status="+status+"&division="+division;
	 	var tob=document.getElementById('divscroll');
		tob.innerHTML="<br><br><center> <img src='../images/loading_gif.gif' width='508' height='381'></center>" ;
		initRequest(url);
		req.onreadystatechange=LoadCustomerGroupRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}



 function LoadCustomerGroupRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	
	        ClearTable('divscroll');  
	        ClearTabler('totRec');  
	    	if (req.status == 200) 
	        {		  	
	    		LoadCustomerGroupMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
 
 
function LoadCustomerGroupMessages() 
{	 
 try
 {
	  
	 var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	 var str=""; 
	 str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	 str=str+"<tr class='MRow1'>";
	 str=str+"<td  class='boldEleven' align='center'><b>S.No</b></td>";
	 str=str+"<td  class='boldEleven' align='center'><b>Customer Name</b></td>";
	 str=str+"<td  class='boldEleven' align='center'><b>Short</b></td>";
	 str=str+"<td  class='boldEleven' align='center'><b>Division</b></td>";
	 str=str+"<td  class='boldEleven' align='center'><b>Entry By</b></td>";
	 //str=str+"<td  class='boldEleven' align='center'><b>Status</b></td>";
	 str=str+"<td  class='boldEleven' align='center'><b>&nbsp;</b></td>";
	 str=str+"</tr>";
	 for(loop = 0; loop < batchs.childNodes.length; loop++) 
	 {	     
        var batch = batchs.childNodes[loop];
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Short = batch.getElementsByTagName("Short")[0].childNodes[0].nodeValue;
	    var Verify = batch.getElementsByTagName("Verify")[0].childNodes[0].nodeValue;
	    var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
	    var Entryby = batch.getElementsByTagName("Entryby")[0].childNodes[0].nodeValue;
	    var usertype = batch.getElementsByTagName("usertype")[0].childNodes[0].nodeValue;
	     
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td  class='boldEleven'><input id='rowid' name='rowid' type='checkbox' value='"+Rowid+"' />"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven'> "+Name+"</td>";
		str=str+"<td  class='boldEleven'> "+Short+"</td>";
		str=str+"<td  class='boldEleven'> "+Division+"</td>";
		str=str+"<td  class='boldEleven'> "+Entryby+"</td>";
		
		
		/*if(Verify == "Y")
			str=str+"<td  class='boldEleven'><font class='boldgreen'>Verified</font></td>";
		else if(Verify == "R")
			str=str+"<td  class='boldEleven'><font class='bolddeepred'>Reject </font>";
		else	
		{	
			str=str+"<td  class='boldEleven'><font class='bolddeepred'>Pending </font>";
			if (usertype == "F" || usertype == "B")
				str=str+"/ <a href='CustomerNameAction.jsp?rowid="+Rowid+"&action1=a'><font class='boldgreen'>Click to verify</font></a>";
			str=str+"</td>";
		}	*/
		
		
		if(Verify != "R")
			str=str+"<td  class='boldEleven' align='center'><a href='CustomerInfoAction.jsp?action1=Add&customerrowid="+Rowid+"'><font class='boldgreen'>Add Address</font></a></td>";
		else
			str=str+"<td  class='boldEleven'>&nbsp;</td>";
		str=str+"</tr>";
		window.status=(loop+1);
	 }
      
	 if(batchs.childNodes.length <1)
		str=str+"<td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
	 str=str+"</table>";
    
	 var tb=document.getElementById('divscroll');
  	 tb.innerHTML=str   ;
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  	}
 	catch(err)
 	{
 		alert(err.description);
 	}    	
}


