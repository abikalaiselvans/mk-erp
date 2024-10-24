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
 
 
function LoadingTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 
 
function loadComplaints(startLetter)
{
	var status = document.getElementById('status').value;
	var day = document.getElementById('day').value;
	var month = document.getElementById('month').value;
	var year = document.getElementById('year').value;
	var priority = document.getElementById('priority').value;
	
	var url = "../management?actionS=loadComplaints&startLetter="+escape(startLetter)+"&status="+status+"&day="+day+"&month="+month+"&year="+year+"&priority="+priority;  
	initRequest(url);
   	req.onreadystatechange = loadComplaintsRequest;
    req.open("GET", url, true);
    req.send(null);    
}	
 

function loadComplaintsRequest()
 {
     
    if(req.readyState == 4) 
    {
        ClearTable('ContractstaffTable');
		ClearTabler('totRec');  
        if (req.status == 200) 
        {
        	 loadComplaintsMessage();
        }
    }
}

function loadComplaintsMessage() 
{	
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  
    str=str+" <tr class='MRow1'> ";
    str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Branch</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Complaint No</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Subject</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Date</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Priority</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Status</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Solved by</b></td>";
    
    str=str+" </tr>"; 
    for(loop=0; loop<batchs.childNodes.length; loop++)
     {
	    var batch = batchs.childNodes[loop];
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
        var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue; 
		var Complaint = batch.getElementsByTagName("Complaint")[0].childNodes[0].nodeValue; 
        var Subject = batch.getElementsByTagName("Subject")[0].childNodes[0].nodeValue; 
        var Cdate = batch.getElementsByTagName("Cdate")[0].childNodes[0].nodeValue; 
        var Priority = batch.getElementsByTagName("Priority")[0].childNodes[0].nodeValue;
        var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue; 
        var Cancel = batch.getElementsByTagName("Cancel")[0].childNodes[0].nodeValue; 
        var Solved = batch.getElementsByTagName("Solved")[0].childNodes[0].nodeValue;
        
       	if(Cancel =="Y")
       	{
       		str=str+"<tr class='MRow4'>";
       	}	
       	else
       	{	
	        if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";	
       	}	
       	
       	if(Status == "Y")
       		str=str+"<td class='boldEleven'>"+(loop+1)+"</td>";
       	else
       		str=str+"<td class='boldEleven'><input type='checkbox' name='rowid' id='rowid' value="+Rowid+">"+(loop+1)+"</td>";
       	
        str=str+"<td class='boldEleven'>"+Branch+"</td>";
		str=str+"<td class='boldEleven'>"+Complaint+"</td>";
		str=str+"<td class='boldEleven'>"+Subject+"</td>";
		str=str+"<td class='boldEleven'>"+Cdate+"</td>";
		if(Priority == "1")
        	str=str+"<td class='boldEleven'>Normal</td>";
        else if(Priority == "2")
        	str=str+"<td class='boldEleven'>Medium</td>";
        else if(Priority == "3")
       	 	str=str+"<td class='boldEleven'>Urgent</td>";
        else if(Priority == "4")
       	 	str=str+"<td class='boldEleven'>Most Urgent</td>";
		
		if(Cancel == "N")
		{
			if(Status == "Y")
				str=str+"<td class='boldEleven'><font class='boldgreen'>Solved</font></td>";
			else
				str=str+"<td class='boldEleven'><font class='bolddeepred'>Pending</font></td>";
				
		}	
		else
			str=str+"<td class='boldEleven'><font class='bolddeepred'>Cancelled</font></td>";
		
		str=str+"<td class='boldEleven'>"+Solved+"</td>";
		str=str+"</tr>";
     }
      	 
 	 str=str+"</table>";     
  	 var tb=document.getElementById('ContractstaffTable');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML="<center><font class='bolddeepred'>Total no of Staffs :: "+batchs.childNodes.length+"</font></center>"; 
 
     
}  

