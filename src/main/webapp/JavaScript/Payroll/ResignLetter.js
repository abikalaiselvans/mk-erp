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

 function loadResignation(startLetter) 
 {    
 		var month=document.getElementById("month").value;
 		var year=document.getElementById("year").value;     
 		var url = "../Payroll?actionS=PAYResignation&startLetter="+startLetter;
 		url=url+"&month="+month+"&year="+year;
 		initRequest(url);
 		req.onreadystatechange = loadResignationRequest;
 		req.open("GET", url, true);
 		req.send(null);
 }
	 
 function loadResignationRequest() 
 {
 	 if(req.readyState == 4) 
     {
         ClearTable('CessationTable');
         ClearTabler('totRec'); 
         if (req.status == 200) 
         {		  	
           loadResignationMessages();
         }
     }
 }
 
 function loadResignationMessages() 
 {   
	 var batchs = req.responseXML.getElementsByTagName("Terms")[0];   	    
	 var str=""; 
	 str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  		                        
	 str=str+"<tr  class='MRow1'> ";
     str=str+"<td align='center' class='boldEleven'><b>Staff Id</b></td> ";
     str=str+"<td align='center' class='boldEleven'><b>Staff Name</b></td> ";
     str=str+"<td align='Center' class='boldEleven'><b>Company</b></td> ";
     str=str+"<td align='Center' class='boldEleven'><b>Branch</b></td> ";
     str=str+"<td align='Center' class='boldEleven'><b>Department</b></td> ";
     str=str+"<td align='Center' class='boldEleven'><b>Designation</b></td> ";
     str=str+"<td align='Center' class='boldEleven'><b>Status</b></td> ";
     str=str+" </tr> ";
	
     for(loop = 0; loop < batchs.childNodes.length; loop++) 
     {           		                           
    	 var batch = batchs.childNodes[loop];
         var Staffid = batch.getElementsByTagName("Staffid")[0].childNodes[0].nodeValue; 
         var Staffname = batch.getElementsByTagName("Staffname")[0].childNodes[0].nodeValue;
         var Companyame = batch.getElementsByTagName("Companyame")[0].childNodes[0].nodeValue;
         var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
         var Depart = batch.getElementsByTagName("Depart")[0].childNodes[0].nodeValue;
         var Desig = batch.getElementsByTagName("Desig")[0].childNodes[0].nodeValue;    	
         var exitid = batch.getElementsByTagName("ExitId")[0].childNodes[0].nodeValue;
         var status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
         var Cessation = batch.getElementsByTagName("Cessation")[0].childNodes[0].nodeValue;
         
         if(loop%2==1)
 			str=str+"<tr class='MRow2'>";
         else
 		    str=str+"<tr  class='MRow1'>";
 		    		
         if(status =="Y")
        	 str=str+"<td  class='boldEleven'>"+Staffid +"</td>";
         else	
   			str=str+"<td class='boldEleven'><input type='checkbox' name='staffid' value='"+exitid +"'>"+Staffid +"</td>";
         if(status != "Y")
        	 str=str+"<td class='boldEleven'><a href='ResignationEdit.jsp?staffid="+exitid +"'>"+Staffname +"</a>"+"</td>";
         else
        	 str=str+"<td class='boldEleven'> "+Staffname +" "+"</td>";
         
         str=str+"<td class='boldEleven'>"+Companyame+"</td>";
         str=str+"<td class='boldEleven'>"+Branch +"</td>";
         str=str+"<td class='boldEleven'>"+Depart +"</td>";
         str=str+"<td class='boldEleven'>"+Desig +"</td>";
         
         if(status =="N")
        	 str=str+"<td class='boldEleven'>Pending</td>";
         else if(status =="Y")
        	 str=str+"<td class='boldEleven'>Accepted</td>";
         else if(status =="R")
        	 str=str+"<td class='boldEleven'>Rejected</td>";
         
        
 		 str=str+"</tr>";
      } 
           
     if(batchs.childNodes.length<1)
    	 str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
     str=str+"</table>";
     var tb=document.getElementById('CessationTable');
     tb.innerHTML=str;  
     tb=document.getElementById('totRec');
     tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
 }  