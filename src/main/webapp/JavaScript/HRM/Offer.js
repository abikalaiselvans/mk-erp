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
 
 

function LoadOfferview(startLetter)
 {
 	var mon=document.getElementById('month').value; 	
	var yr=document.getElementById('year').value;  
 	var   finalstatus = document.getElementById('finalstatus').value;
 	var office=document.getElementById('office').value; 
 	var offerstatus=document.getElementById('offerstatus').value; 
 	var url = "../SmartHRM?actionS=LoadOfferview&month="+escape(mon)+"&year="+escape(yr)+"&startLetter="+escape(startLetter)+"&finalstatus="+finalstatus+"&office="+office+"&offerstatus="+offerstatus ; ;
	initRequest(url);
	req.onreadystatechange=LoadOfferviewRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function LoadOfferviewRequest() 
 {
    if(req.readyState == 4) 
    {    	
        ClearTable('ResultTable');  
        ClearTabler('totalRec');
		if (req.status == 200) 
        {		  	
         	var tb=document.getElementById('ResultTable');
  	 		tb.innerHTML="<center>Loading Data</center>" ;
		  	LoadOfferviewMessages();
        }
    }
}

function LoadOfferviewMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];      
	
	var str=""; 
    str=str+"<table width='100%' id='myTable' align=center    cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    str=str+"<tr class='MRow1'>";
    str=str+"<td class='bold1'  >S.No</td>";  
    str=str+"<td class='bold1'  >Application Code</td>";  
    str=str+"<td class='bold1' >Applicant Name</td> ";  
    str=str+"<td class='bold1'  >Job Grade</td>";  
    str=str+"<td class='bold1' >Job Code</td>";  
    str=str+"<td class='bold1'  >Job Title</td>";  
	str=str+"<td class='bold1'  >DOI</td>";  
	str=str+"<td class='bold1'  >Position </td>";  
	str=str+"<td class='bold1'  >C.Salary </td>";  
	str=str+"<td class='bold1'  >E.Salary</td>";  
	str=str+"<td class='bold1'  >2nd Int.Status</td>"; 
	str=str+"<td class='bold1'  >Final Status</td>";
	str=str+"<td class='bold1'  >Offer Status</td>";
	str=str+"<td class='bold1'  >Mail / Pdf</td>";
	str=str+"<td class='bold1'  >Offer Accept</td>";
	 
	str=str+"</tr>";
	 
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
		 var Offer = batch.getElementsByTagName("Offer")[0].childNodes[0].nodeValue;
		 var ApplicantId = batch.getElementsByTagName("ApplicantId")[0].childNodes[0].nodeValue;
		 var Mail = batch.getElementsByTagName("Mail")[0].childNodes[0].nodeValue;
		 var OfferAccept = batch.getElementsByTagName("OfferAccept")[0].childNodes[0].nodeValue;
		
       if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	

	     
	    str=str+"<td align='left' class='boldEleven'> <input type='checkbox' name='rowid'  id='rowid' value='"+ApplicantId+"'>&nbsp;"+(loop+1)+"</td>";
	    str=str+"<td align='left' class='boldEleven'>"+Code+"  </td>";  
		
		str=str+"<td align='left' class='boldEleven'>"+Name+"  </td>"; 
		str=str+"<td align='left' class='boldEleven'>"+Jobgrade+"  </td>";  
		str=str+"<td align='left' class='boldEleven'>"+Jobcode+"  </td>";  
		str=str+"<td align='left' class='boldEleven'>"+Jobtitle+"  </td>";  
		str=str+"<td align='left' class='boldEleven'>"+Dateofinterview+"  </td>";  
		str=str+"<td align='left' class='boldEleven'>"+Position+"  </td>";  
		str=str+"<td align='left' class='boldEleven'>"+Csalary+"  </td>";  
		str=str+"<td align='left' class='boldEleven'>"+Esalary+"  </td>"; 
		 
		if("S" == SInterviewedstatus)
			str=str+"<td align='left' class='boldEleven'><font class='boldgreen'>SHORTLIST</font></td>";
		else if("H" == SInterviewedstatus)
			str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>HOLD</font></td>";
		else if("R" == SInterviewedstatus)
			str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>REJECTED</font></td>";
		else 
			str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>Not Attended</font></td>";
		
		
		
		if("Y"==Finalstatus )
			str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>Selected</font></td>";
		else
			str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>Not Selected</font></td>";	
		 
		 
		 if("Y"==Offer )
			str=str+"<td align='left' class='boldEleven'><font class='boldgreen'>Offer Issued  <a href='HRMOfferLetter.jsp?applicantid="+ApplicantId+"'>View</a> </font></td>";
		else
			str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>Offer not Issued</font></td>";	
		 
		if("Y"==Offer && OfferAccept == "N")
			str=str+"<td align='left' class='boldEleven'><a href='../SmartLoginAuth?filename=OfferLetter&actionS=HRMSendOfferLettertoMail&applicantid="+ApplicantId+"'><font class='boldgreen'>Send a mail to "+Mail+" </a>   </font></td>";
		else
		 	str=str+"<td align='left' class='boldEleven'><a href=\"javascript:Printquery('../SmartLoginAuth?filename=OfferLetter&actionS=HRMOfferLettertoPDF&applicantid="+ApplicantId+"')\" >Pdf</a></font></td>";
		 	
		
		if(OfferAccept == "Y")
		 	str=str+"<td align='left' class='boldEleven'><font class='boldgreen'>OfferAccept</font></td>"; 	
		else
			str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>OfferAccept  Pending..</font>&nbsp;&nbsp;/&nbsp;&nbsp;<a target='_blank' href='OfferAccept_Admin.jsp?applicantid="+ApplicantId+"'><font class='boldgreen'>Accept</font></a></td>"; 	
		 	
		 	
		str=str+"</tr>";
		 
	   
	   
     }

     str=str+"</table>";
	 
     var tb=document.getElementById('ResultTable');
  	 tb.innerHTML=str  
  	 
  	if(batchs.childNodes.length >0)
	 {  	 	
	var tb=document.getElementById('totalRec');
	 	tb.innerHTML="<center> <font  class='bolddeepred'>Total No of Records : "+batchs.childNodes.length+"</font></center>" ;
		
		
}
else
{
	str=str+"<tr class='MRow1'><td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td></tr>";
	 
}	
  	  
}



