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
 

function loadTransfer(startLetter) 
{
    
    var url = "../Payroll?actionS=PAYTransfer&type=1&startLetter="+startLetter;
	initRequest(url);
    req.onreadystatechange = loadTransferRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadTransfers(startLetter) 
{
    
    var url = "../Payroll?actionS=PAYTransfer&type=2&startLetter="+document.getElementById('search').value;
	initRequest(url);
    req.onreadystatechange = loadTransferRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadTransferRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('TransferTable');   
        ClearTabler('totalrecord');
        if (req.status == 200) 
        {		  	
          loadTransferMessages();
        }
    }
}


function loadTransferMessages() 
{   
    var batchs = req.responseXML.getElementsByTagName("Transfers")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  		                        
    
   	str=str+" <tr  class='MRow1'> ";
	str=str+"<td align='center' ><b>S.no</b></td> ";
	str=str+"<td align='center' ><b>Staff Id</b></td> ";
	str=str+"<td align='center' ><b>Staff Name</b></td> ";
	str=str+"<td align='center' ><b>Company</b></td> ";
	str=str+"<td align='center' ><b>Branch</b></td> ";
	str=str+"<td align='center' ><b>Department</b></td> ";
	str=str+"<td align='center' ><b>Designation</b></td> ";
	str=str+"<td align='center' ><b>No.of.Transfer</b></td> ";
	str=str+"</tr> ";
    
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {           		                           
	    var batch = batchs.childNodes[loop];
        var Staffid = batch.getElementsByTagName("Staffid")[0].childNodes[0].nodeValue; 
    	var Staffname = batch.getElementsByTagName("Staffname")[0].childNodes[0].nodeValue;
    	var Companyame = batch.getElementsByTagName("Companyame")[0].childNodes[0].nodeValue;
    	var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
    	var Depart = batch.getElementsByTagName("Depart")[0].childNodes[0].nodeValue;
    	var Desig = batch.getElementsByTagName("Desig")[0].childNodes[0].nodeValue;    
    	var NoofTransfer = batch.getElementsByTagName("NoofTransfer")[0].childNodes[0].nodeValue;
    		
    	if(loop%2==1)
			str=str+"<tr class='MRow3'>";
		else
		    str=str+"<tr  class='MRow1'>";
		str=str+"<td   class='boldEleven'><input type='checkbox' id='staffid'  name='staffid' value='"+Staffid+"'>"+(loop+1)+"</td>";
		
		
		str=str+"<td   class='boldEleven'>"+Staffid+"</td>";
		str=str+"<td   class='boldEleven'>"+Staffname+"</td>";
		
		//str=str+"<td   class='boldEleven'><a href='EmployeTransferEdit.jsp?staffid="+Staffid+"'>"+Staffname+"</a> </td>";
		str=str+"<td   class='boldEleven'>"+Companyame+"</td>";
		str=str+"<td  class='boldEleven'>"+Branch+"</td>";
		str=str+"<td  class='boldEleven'>"+Depart+"</td>";
		str=str+"<td  class='boldEleven'>"+Desig+"</td>";
		str=str+"<td   class='boldEleven'>"+NoofTransfer+"</td>";
		
		
		
		str=str+" </tr>";
     }     
  	if(batchs.childNodes.length<1)
   		 str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
    str=str+"</table>";
    var tb=document.getElementById('TransferTable');
  	tb.innerHTML=str;  
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Records :: "+batchs.childNodes.length+"</font><br>"  ; 
  	 
}