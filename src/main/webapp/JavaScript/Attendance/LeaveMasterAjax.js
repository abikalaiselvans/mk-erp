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

function loadLeaveEntry(startLetter) 
{
	document.getElementById('Delete').disabled=true;
    var yea=document.getElementById('year').value;  
	var Office=document.getElementById('Office').value;   
	var dept=document.getElementById('dept').value;  
	var Category=document.getElementById('Category').value;
	var url = "../attendance?actionS=AttLeave&year="+escape(yea)+"&startLetter="+escape(startLetter)+"&Office="+Office+"&dept="+dept+"&Category="+Category;
	initRequest(url);
	req.onreadystatechange = LeaveRequest;
    req.open("GET", url, true);
    req.send(null);
}

function LeaveRequest() 
{
    if(req.readyState == 4) 
    {  
    	ClearTable('LeaveTable');  	
    	ClearTabler('totalrecord');
        if (req.status == 200) 
        {		  	
         	LeaveMessages();
        }
    }
}


function LeaveMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Leaves")[0];   
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Empid = batch.getElementsByTagName("Empid")[0].childNodes[0].nodeValue;
	    var Staffname = batch.getElementsByTagName("Staffname")[0].childNodes[0].nodeValue;
	    var usertype = batch.getElementsByTagName("usertype")[0].childNodes[0].nodeValue;
	    
	    var leavelength =document.getElementById('leavelength').value
	    if(loop%2==1)
			str=str+"<tr class='MRow2'>";
		else
		    str=str+"<tr  class='MRow1'>";
		    		
		
	     
	    //<input type='checkbox' name='staffid' id='staffid' value='"+Empid+"' />
	    str=str+"<td width='50' class='boldEleven'>"+(loop+1)+".</td>";
	    str=str+"<td width='130' class='boldEleven'>"+Empid +"</td>";
		 
	   if( "F" == usertype)
			  str=str+"<td width='130' class='boldEleven'><a href='StaffLeaveEdit.jsp?staffid="+Empid +"'>"+Staffname +"</a></td>";
		 else
			 str=str+"<td width='130' class='boldEleven'>"+Staffname +"</td>";
	    
		for(u=0;u<leavelength;u++)
		{
			var e = batch.getElementsByTagName("Eligible"+(u+1))[0].childNodes[0].nodeValue;
			str=str+"<td width='10' class='boldEleven'><font color='#0000FF'>"+e +"</font></td>";
			var a = batch.getElementsByTagName("Available"+(u+1))[0].childNodes[0].nodeValue;
			str=str+"<td width='10' class='boldEleven'><font class='bolddeepred'>"+a +"</font></td>";
		}
     }
     if(batchs.childNodes.length >0)
  	 {
  		document.getElementById('Delete').disabled=false;
     	 	 
     }
     else
     {
    	document.getElementById('Delete').disabled=true;
     	  
     }
     if(batchs.childNodes.length<1)
    	str=str+"<tr><td class='bolddeepred'><center>Data not found...</center></td></tr>";
     str=str+"</table>";
     var tb=document.getElementById('LeaveTable');
  	 tb.innerHTML=str  ;
	 
    	tb=document.getElementById('totalrecord');
   	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records ::"+batchs.childNodes.length +"</font>"; 
 	
}
