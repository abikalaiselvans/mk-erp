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
	 var str=" <center>Nothing  found</center> ";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}


function loadOfferLetter(ctr)
 {
 	var id=ctr.value; 	
	var url = "../SmartHRM?actionS=loadOfferLetter&id="+id;
	initRequest(url);
	req.onreadystatechange=loadOfferLetterRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function loadOfferLetterRequest() 
 {
    if(req.readyState == 4) 
    {    	
        ClearTable('ResultTable');  
         
		if (req.status == 200) 
        {		  	
         	var tb=document.getElementById('ResultTable');
  	 		tb.innerHTML="<center>Loading Data</center>" ;
		  	loadOfferLetterMessages();
        }
    }
}

 


 function setOptionTexts(ctr,value) 
 {
 	
 	 var x=document.getElementById(ctr);
 	 x.options[x.selectedIndex].text=value;
 														
 	 
 }
 
 
function loadOfferLetterMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];      
	var str=""; 
    str=str+"<table width='100%' id='myTable' align=center    cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    
	 
	
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	     var batch = batchs.childNodes[loop];
	     var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	     var Code = batch.getElementsByTagName("Code")[0].childNodes[0].nodeValue;
	     var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		 var Jobgrade = batch.getElementsByTagName("Jobgrade")[0].childNodes[0].nodeValue;
		 var Jobcode = batch.getElementsByTagName("Jobcode")[0].childNodes[0].nodeValue;
		 var Jobtitle = batch.getElementsByTagName("Jobtitle")[0].childNodes[0].nodeValue;
		 var Dateofinterview = batch.getElementsByTagName("Dateofinterview")[0].childNodes[0].nodeValue;
		 var Position = batch.getElementsByTagName("Position")[0].childNodes[0].nodeValue;
		 var Csalary = batch.getElementsByTagName("Csalary")[0].childNodes[0].nodeValue;
		 var Esalary = batch.getElementsByTagName("Esalary")[0].childNodes[0].nodeValue;
		 var Interviewedby = batch.getElementsByTagName("Interviewedby")[0].childNodes[0].nodeValue;
		 var Intervieweddate = batch.getElementsByTagName("Intervieweddate")[0].childNodes[0].nodeValue;
		 var Interviewedstatus = batch.getElementsByTagName("Interviewedstatus")[0].childNodes[0].nodeValue;
		 var SInterviewedby = batch.getElementsByTagName("SInterviewedby")[0].childNodes[0].nodeValue;
		 var SIntervieweddate = batch.getElementsByTagName("SIntervieweddate")[0].childNodes[0].nodeValue;
		 var SInterviewedstatus = batch.getElementsByTagName("SInterviewedstatus")[0].childNodes[0].nodeValue;
		 var Finalstatus = batch.getElementsByTagName("Finalstatus")[0].childNodes[0].nodeValue;
		 var Salary = batch.getElementsByTagName("Salary")[0].childNodes[0].nodeValue;
		 var preferedlocation = batch.getElementsByTagName("preferedlocation")[0].childNodes[0].nodeValue;
		 var noticeperiod = batch.getElementsByTagName("noticeperiod")[0].childNodes[0].nodeValue;
		 var positionid = batch.getElementsByTagName("positionid")[0].childNodes[0].nodeValue;
		 
		 setOptionValue('desigination',positionid);
		 setOptionValue('noticeperiod',noticeperiod);
		 setOptionValue('office',preferedlocation);
		 document.getElementById('fsalary').value= Salary;
		   
			
			str=str+"<tr  class='MRow2'>";
		    str=str+"<td class='bold1'  >Application Code</td><td align='left' class='boldEleven'>"+Code+"  </td>";  
		    str=str+"</tr>";
			
			str=str+"<tr  class='MRow2'>";
		    str=str+"<td class='bold1' >Applicant Name</td> <td align='left' class='boldEleven'>"+Name+"  </td>";  
		    str=str+"</tr>";
			
			str=str+"<tr  class='MRow2'>";
		    str=str+"<td class='bold1'  >Job Code</td><td align='left' class='boldEleven'>"+Jobgrade+"  </td>";  
		    str=str+"</tr>";
			
			str=str+"<tr  class='MRow2'>";
		    str=str+"<td class='bold1' >Job Grade</td><td align='left' class='boldEleven'>"+Jobcode+"  </td>";  
		    str=str+"</tr>";
			
			str=str+"<tr  class='MRow2'>";
		    str=str+"<td class='bold1'  >Job Title</td><td align='left' class='boldEleven'>"+Jobtitle+"  </td>";  
			str=str+"</tr>";
			
			str=str+"<tr  class='MRow2'>";
			str=str+"<td class='bold1'  >FIRST DOI</td><td align='left' class='boldEleven'>"+Dateofinterview+"  </td>";  
			str=str+"</tr>";
			
			str=str+"<tr  class='MRow2'>";
			str=str+"<td class='bold1'  >Position </td><td align='left' class='boldEleven'>"+Position+"  </td>";  
			str=str+"</tr>";
			
			
			str=str+"<tr  class='MRow2'>";
			str=str+"<td class='bold1'  >Current Salary </td><td align='left' class='boldEleven'>"+Csalary+"  </td>";  
			str=str+"</tr>";
			
			
			str=str+"<tr  class='MRow2'>";
			str=str+"<td class='bold1'  >Expected Salary</td><td align='left' class='boldEleven'>"+Esalary+"  </td>";  
			str=str+"</tr>";
			
			str=str+"<tr  class='MRow2'>";
			str=str+"<td class='bold1'  >Interviewed By</td><td align='left' class='boldEleven'>"+Interviewedby+"  </td>";  
			str=str+"</tr>";
			
			str=str+"<tr  class='MRow2'>";
			str=str+"<td class='bold1'  >Interview Date </td><td align='left' class='boldEleven'>"+Intervieweddate+"  </td>";  
			str=str+"</tr>";
			
			str=str+"<tr  class='MRow2'>";
			str=str+"<td class='bold1'  >First Interview Status</td>"; 
			if("Y" == Interviewedstatus)
				str=str+"<td align='left' class='boldEleven'><font class='boldgreen'>Pass</font></td>";
			else
				str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>Fail</font></td>";
			 str=str+"</tr>";
			 
			str=str+"<tr  class='MRow2'>";
			str=str+"<td class='bold1'  >Second Interviewed By</td><td align='left' class='boldEleven'>"+SInterviewedby+"  </td>";  
			str=str+"<tr  class='MRow2'>";
			str=str+"<td class='bold1'  >Second Interview Date </td><td align='left' class='boldEleven'>"+SIntervieweddate+"  </td>";  
			 str=str+"</tr>";
			 
			 
			str=str+"<tr  class='MRow2'>";
			str=str+"<td class='bold1'  >Second Interview Status</td>"; 
			if("S" == SInterviewedstatus)
				str=str+"<td align='left' class='boldEleven'><font class='boldgreen'>SHORTLIST</font></td>";
			else if("H" == SInterviewedstatus)
				str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>HOLD</font></td>";
			else if("R" == SInterviewedstatus)
				str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>REJECTED</font></td>";
			else 
				str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>Not Attended</font></td>";
			 str=str+"</tr>";
			 
			str=str+"<tr  class='MRow2'>";
			str=str+"<td class='bold1'  >Selected</td>";
			if("Y"==Finalstatus )
				str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>Selected</font></td>";
			else
				str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>Not Selected</font></td>";	
			 str=str+"</tr>";
			 
		str=str+"</tr>";
		 
	   
	   
     }

     str=str+"</table>";

     var tb=document.getElementById('ResultTable');
  	 tb.innerHTML=str  
  	 
  	 
  	  
}



