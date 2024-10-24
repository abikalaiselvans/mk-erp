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
 
 
 
  
function loadOnlineTestDetails (startLetter) 
{    
	var mon=document.getElementById('month').value; 	
	var yr=document.getElementById('year').value;  
	var jobtitle=document.getElementById('jobtitle').value; 
	var jobgrade=document.getElementById('jobgrade').value; 
	var result=document.getElementById('result').value; 
	var day=document.getElementById('day').value; 
	var url = "../SmartHRM?actionS=loadOnlineTestDetails&mon="+escape(mon)+"&yr="+escape(yr)+"&startLetter="+escape(startLetter)+"&jobtitle="+jobtitle+"&jobgrade="+jobgrade+"&result="+result+"&day="+day; 
   	initRequest(url);
    req.onreadystatechange = loadOnlineTestDetailsRequest;
    req.open("GET", url, true);
    req.send(null);
}
function loadOnlineTestDetailsRequest() 
{
    if(req.readyState == 4) 
    {    
        ClearTable('applicationTable');
        ClearTabler('totalRec');  
        if (req.status == 200) 
        {
			loadOnlineTestDetailsDetails();
        }
		 
		
    }
}
function loadOnlineTestDetailsDetails()
 {
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];  
    
	var str=""; 
    str=str+"<table width='100%' id='myTable' align=center    cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
			
			
			 
              str=str+"<tr  class='MRow1'> ";
                str=str+"<td class='bold1' >S.No</td> ";
                str=str+"<td class='bold1' >Application Code</td> ";
                str=str+"<td class='bold1' >Applicant Name</td>  ";
                str=str+"<td class='bold1' >Job Grade</td> ";
				str=str+"<td class='bold1' >Job Title</td> ";
				str=str+"<td class='bold1'   >DOB</td> ";
				str=str+"<td class='bold1'   >Email</td> ";
				str=str+"<td class='bold1'   >Mobile</td> ";
				str=str+"<td class='bold1'   >Online Test</td> ";
				str=str+"<td class='bold1'  >Result </td> ";
              str=str+"</tr> ";
             
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var ApplicantId = batch.getElementsByTagName("ApplicantId")[0].childNodes[0].nodeValue;
	    var ApplicantCode = batch.getElementsByTagName("ApplicantCode")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Grade = batch.getElementsByTagName("Grade")[0].childNodes[0].nodeValue;
	    var Title = batch.getElementsByTagName("Title")[0].childNodes[0].nodeValue;
	    var Date = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
	    var Month = batch.getElementsByTagName("Month")[0].childNodes[0].nodeValue;
	    var Year = batch.getElementsByTagName("Year")[0].childNodes[0].nodeValue;
	    
	    var dob = batch.getElementsByTagName("dob")[0].childNodes[0].nodeValue;; 
		var email= batch.getElementsByTagName("email")[0].childNodes[0].nodeValue;; 
		var mobile= batch.getElementsByTagName("mobile")[0].childNodes[0].nodeValue;; 
		var onlinetest= batch.getElementsByTagName("onlinetest")[0].childNodes[0].nodeValue;;               
		var result = batch.getElementsByTagName("result")[0].childNodes[0].nodeValue;;
		
	 	
	 	
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	

	    str=str+"<td align='left' class='boldEleven'>";
	    str=str+"<input type='checkbox' name='applicantid'  id='applicantid' value='"+ApplicantId+"'>&nbsp;"+(loop+1)+"</td>";
		str=str+"<td align='left' class='boldEleven'>&nbsp;"+ApplicantCode+"</td>";
		str=str+"<td align='left' class='boldEleven'>&nbsp;"+Name+"</td>";//<a href='OnlineTestResult.jsp?applicantid="+ApplicantId+"'></td>
		str=str+"<td align='left' class='boldEleven'>&nbsp;"+Grade+"</td>";		
	    str=str+"<td align='left' class='boldEleven'>&nbsp;"+Title+"</td>";		
	    str=str+"<td align='left' class='boldEleven'>&nbsp;"+Date+"</td>";
		str=str+"<td align='left' class='boldEleven'>&nbsp;"+email +"</td>";
	    str=str+"<td align='left' class='boldEleven'>&nbsp;"+mobile +"</td>";
	    if("Y" == onlinetest )
	    	str=str+"<td align='left' class='boldEleven'><font class='boldgreen'>COMPLETED</font></td>" ;
	    else
	    	str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>NOT COMPLETED</font></td>" ;	
	    
	   if("P" == result )
	   		str=str+"<td align='left' class='boldEleven'><font class='boldgreen'>PASS</font></td>" ;
	   else if("F" == result )
	    	str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>FAIL</font></td>" ;	
	    else
	    	str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>&nbps;</font></td>" ;	
	    
	}

     str=str+"</table>";
     var tb=document.getElementById('applicationTable');
  	 tb.innerHTML=str   
	
  	var tb=document.getElementById('totalRec');
  	if(batchs.childNodes.length >0)
 		tb.innerHTML="<center> <font  class='bolddeepred'>Total No of Records : "+batchs.childNodes.length+"</font></center>" ;
	else
    	str=str+"<tr class='MRow1'><td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td></tr>";
    
 } 	
 
 
  