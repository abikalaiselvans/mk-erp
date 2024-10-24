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
 
 
 
//loadTemporarysuspension
function loadTemporarysuspension(startLetter) 
{
	try
	{
	 var office = document.getElementById('office').value;
	 var month = document.getElementById('month').value;
	 var year = document.getElementById('year').value;
	 var ndc = document.getElementById('ndc').value;
	 //loadStaffHold
	 var url = "../Payroll?actionS=loadTemporarysuspension&startLetter="+startLetter+"&office="+office+"&month="+month+"&year="+year+"&ndc="+ndc;
	 initRequest(url);
	 req.onreadystatechange = loadTemporarysuspensionRequest;
	 req.open("GET", url, true);
	 req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}

 
function loadTemporarysuspensionRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('StaffHoldTable');   
        ClearTabler('totalrecord');
        if (req.status == 200) 
        {		  	
        	loadTemporarysuspensionMessages();
        }
    }
}



function loadTemporarysuspensionMessages() 
{   
    var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  		                        
    
   	str=str+" <tr  class='MRow1'> ";
	str=str+"<td  ><div align='center'><b>S.No</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Staff Id</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Staff Name</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Office</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Month</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Year</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Description</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Last Working Day</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Authorisedby</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Replacement</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Status</b></div></td> ";
	str=str+"<td  ><div align='center'><b>ResiginationPost</b></div></td> ";
	str=str+"</tr> ";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {           		                           
	    var batch = batchs.childNodes[loop];
	    var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Empid = batch.getElementsByTagName("Empid")[0].childNodes[0].nodeValue;
    	var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
    	var Office = batch.getElementsByTagName("Office")[0].childNodes[0].nodeValue;
    	var Month = batch.getElementsByTagName("Month")[0].childNodes[0].nodeValue;
    	var Year = batch.getElementsByTagName("Year")[0].childNodes[0].nodeValue;
    	var description = batch.getElementsByTagName("description")[0].childNodes[0].nodeValue;
    	var LOW = batch.getElementsByTagName("LOW")[0].childNodes[0].nodeValue;
    	var Authorisedby = batch.getElementsByTagName("Authorisedby")[0].childNodes[0].nodeValue;
    	
    	var NDC = batch.getElementsByTagName("NDC")[0].childNodes[0].nodeValue;
    	var Replacement = batch.getElementsByTagName("Replacement")[0].childNodes[0].nodeValue;
    	var ResiginationPost = batch.getElementsByTagName("ResiginationPost")[0].childNodes[0].nodeValue;
    	
    	if(loop%2==1)
			str=str+"<tr class='MRow2'>";
		else
		    str=str+"<tr  class='MRow1'>";
		

    	if(NDC =="N")
    		str=str+"<td   class='boldEleven'><input type='checkbox' id='rowid'  name='rowid' value='"+Id+"'>"+(loop+1)+".</td>";
    	else
    		str=str+"<td   class='boldEleven'>"+(loop+1)+".</td>";
		str=str+"<td   class='boldEleven'>"+Empid+"</td>";
		str=str+"<td   class='boldEleven'>"+Name+"</td>";
		str=str+"<td   class='boldEleven'>"+Office+"</td>";
		str=str+"<td   class='boldEleven'>"+Month+"</td>";
		str=str+"<td   class='boldEleven'>"+Year+"</td>";
		str=str+"<td   class='boldEleven'>"+description+"</td>";
		str=str+"<td   class='boldEleven'>"+LOW+"</td>";
		str=str+"<td   class='boldEleven'>"+Authorisedby+"</td>";
		
		if(Replacement =="Y")
			str=str+"<td   class='boldEleven'><font class='boldgreen'>Required</font></td>";
		else
			str=str+"<td   class='boldEleven'><font class='bolddeepred'>Not Require</font> </td>";
		
		
		if(NDC =="Y")
			str=str+"<td   class='boldEleven'><font class='boldgreen'>Approved</font></td>";
		else
			str=str+"<td   class='boldEleven'><font class='bolddeepred'>Pending</font> /<a href=\"javascript:Printquery('TemporarysuspensionApprovedReceived.jsp?rowid="+Id+"')\"><font class='boldgreen'>Approved</font></a></td>";
		 
		
		if(NDC =="Y" && ResiginationPost =="N" )
		{	
			str=str+"<td   class='boldEleven'><a href=\"../SmartLoginAuth?filename=Temporarysuspension&actionS=PAYTemporarysuspensionMoved&empid="+Empid +" \"><font class='boldgreen'>Want to Moved</font></a>&nbsp;/&nbsp;" ;
			str=str+" <a href=\"../SmartLoginAuth?filename=Temporarysuspension&actionS=PAYTemporarysuspensionDeleteAfterApproval&empid="+Empid +" \"><font class='boldgreen'>Want to Delete</font></a></td>" ;
		}
		else if(NDC =="Y" && ResiginationPost =="Y" )	
			str=str+"<td   class='boldEleven'><font class='boldgreen'>Moved</font></td>";
		else
			str=str+"<td   class='boldEleven'><font class='boldgreen'>&nbsp;</font></td>";
		str=str+" </tr>";
     }     
  	if(batchs.childNodes.length<1)
   		 str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
    str=str+"</table>";
    var tb=document.getElementById('StaffHoldTable');
  	tb.innerHTML=str;  
  	
  	tb=document.getElementById('totalrecord');
 	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Records :: "+batchs.childNodes.length+"</font><br>"  ; 
 	  
 	 
}


function moveCessation(empid)
{  
	
	var name=confirm("Are you Sure Confirm, Move to cessation")
	if (name==true)
	{
		var query = "../SmartLoginAuth&filename=Temporarysuspension&actionS=PAYTemporarysuspensionDelete&empid="+empid;
		location = query;
		
	}	
}
