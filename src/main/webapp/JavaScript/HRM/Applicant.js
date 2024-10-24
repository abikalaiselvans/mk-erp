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
 
function loadComboJobTitles(dval) 
 {	
    id=document.getElementById(dval).value; 
    startLetter="";       
    var url = "../SmartHRM?actionS=JobCode&id="+escape(id)+"&startLetter="+escape(startLetter) 
     initRequest(url);    
    req.onreadystatechange = jobComboTitleRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadComboJobTitle(dval) 
 {	
    id=dval.value;  
	startLetter="";       
    var url = "../SmartHRM?actionS=JobCode&id="+escape(id)+"&startLetter="+escape(startLetter); 
    initRequest(url);    
    req.onreadystatechange = jobComboTitleRequest;
    req.open("GET", url, true);
    req.send(null);
}

function jobComboTitleRequest() {
    if (req.readyState == 4) {
       	clearSelect('jobtitle');
       	 var _targ=document.getElementsByName('jobtitle')[0];
      _targ.options[0]=new Option('Select jobtitle','0'); 
        if (req.status == 200) {
          jobComboTitleMessages();
        } 
    }
}
function jobComboTitleMessages() 
{
     var batchs = req.responseXML.getElementsByTagName("jobs")[0];    		 
      
     var _targ=document.getElementsByName('jobtitle')[0];
      _targ.options[0]=new Option('Select jobtitle','0'); 
     for (loop = 0; loop < batchs.childNodes.length; loop++) 
     {
	    var batch = batchs.childNodes[loop];
	     var batchId=batch.getElementsByTagName("id")[0];     
        var firstName = batch.getElementsByTagName("name")[0];   
         _targ.options[loop]=new Option(firstName.childNodes[0].nodeValue,batchId.childNodes[0].nodeValue);
     }        
     _targ.options.length=loop;
      
}
 
 
 
 
 
 
 
 
 
 
  
function loadAppView (startLetter) 
{    
	var mon=document.getElementById('month').value; 	
	var yr=document.getElementById('year').value;  
	var jobtitle=document.getElementById('jobtitle').value; 
	var jobgrade=document.getElementById('jobgrade').value; 
	var result=document.getElementById('result').value; 
	var day=document.getElementById('day').value; 
	var office=document.getElementById('office').value;
    var url = "../SmartHRM?actionS=JobAppView&mon="+escape(mon)+"&yr="+escape(yr)+"&startLetter="+escape(startLetter)+"&jobtitle="+jobtitle+"&jobgrade="+jobgrade+"&result="+result+"&day="+day+"&office="+office;; 
    
   	initRequest(url);
    req.onreadystatechange = appViewRequest;
    req.open("GET", url, true);
    req.send(null);
}

function appViewRequest() 
{
    if(req.readyState == 4) 
    {    
        ClearTable('applicationTable');
        ClearTabler('totRec');
        if (req.status == 200) 
        {
 
            applicationDetails();
        }
		else
		{
			 
		}
		
    }
}
function applicationDetails() {
    var batchs = req.responseXML.getElementsByTagName("Applications")[0];      
	var str=""; 
    str=str+"<table width='100%' id='myTable' align=center    cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";


	 
	str=str+"<tr class='MRow3'>";
	str=str+"<td class='bold1'  align='center'>S.No</td>";
	str=str+"<td class='bold1'   align='center'>Application Code</td>";
	str=str+"<td class='bold1'  align='center'>Applicant Name</td> ";
	str=str+"<td class='bold1'   align='center'>Job Code</td>";
	str=str+"<td class='bold1'  align='center'>Job Grade</td>";
	str=str+"<td class='bold1'   align='center'>Job Title</td>";
	str=str+"<td class='bold1'   align='center'>DOB</td>";
	str=str+"<td class='bold1'   align='center'>Email </td>";
	str=str+"<td class='bold1'   align='center'>Mobile</td>";
	str=str+"<td class='bold1'   align='center'>Online Test</td>";
	str=str+"<td class='bold1'   align='center'>Result </td>";
	str=str+"<td class='bold1'   align='center'>View</td>";
	str=str+"</tr>";
	 
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var id= batch.getElementsByTagName("id")[0].childNodes[0].nodeValue;  
		var grade= batch.getElementsByTagName("grade")[0].childNodes[0].nodeValue; 
		var code = batch.getElementsByTagName("code")[0].childNodes[0].nodeValue; 
		var title= batch.getElementsByTagName("title")[0].childNodes[0].nodeValue; 
		var name= batch.getElementsByTagName("name")[0].childNodes[0].nodeValue; 
		var dt= batch.getElementsByTagName("dt")[0].childNodes[0].nodeValue;               
		var appcode = batch.getElementsByTagName("appcode")[0].childNodes[0].nodeValue;
		
		var dob = batch.getElementsByTagName("dob")[0].childNodes[0].nodeValue; 
		var email= batch.getElementsByTagName("email")[0].childNodes[0].nodeValue; 
		var mobile= batch.getElementsByTagName("mobile")[0].childNodes[0].nodeValue; 
		var onlinetest= batch.getElementsByTagName("onlinetest")[0].childNodes[0].nodeValue;               
		var result = batch.getElementsByTagName("result")[0].childNodes[0].nodeValue;
		
	 		     		

       if(loop%2==1)
			str=str+"<tr class='MRow3'>";
		else
		    str=str+"<tr  class='MRow2'>";	

	    str=str+"<td align='left' class='boldEleven'>";
	    str=str+"<input type='checkbox' name='rowid'  id='rowid' value='"+id +"'>&nbsp;"+(loop+1)+"</td>";
		
	    //str=str+"<td align='left' class='boldEleven'>";
		//str=str+"<a href=ApplicationEdit.jsp?rowid="+id +">"+appcode +"</a> </td>";  
		
	    str=str+"<td align='left' class='boldEleven'>&nbsp;"+appcode+"</td>";
		str=str+"<td align='left' class='boldEleven'>&nbsp;"+name +"</td>";
		str=str+"<td align='left' class='boldEleven'>&nbsp;"+code +"</td>";
		str=str+"<td align='left' class='boldEleven'>&nbsp;"+grade +"</td>";		
	    str=str+"<td align='left' class='boldEleven'>&nbsp;"+title +"</td>";		       
	    
	    str=str+"<td align='left' class='boldEleven'>&nbsp;"+dob +"</td>";
	    str=str+"<td align='left' class='boldEleven'>&nbsp;"+email +"</td>";
	    str=str+"<td align='left' class='boldEleven'>&nbsp;"+mobile +"</td>";
	    if("Y" == onlinetest )
	    	str=str+"<td align='left' class='boldEleven'><font class='boldgreen'>COMPLETED</font></td>" ;
	    else
	    	str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>NOT COMPLETED</font></td>" ;	
	    
	   
	    if("Y" == onlinetest )
	    {
		    if("P" == result )
		   {
		    	str=str+"<td align='left' class='boldEleven'><font class='boldgreen'>PASS</font></td>" ;
		    	str=str+"<td align='left' class='boldEleven'><a href=OnlineTestResult.jsp?applicantid="+id +">View Result</a> </td>";
		   }
		    else if("F" == result )
		    {
		    	str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>FAIL</font></td>" ;	
		    	str=str+"<td align='left' class='boldEleven'><a href=OnlineTestResult.jsp?applicantid="+id +">View Result</a> </td>";  
		    }
		    else
		    {  
		    	str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>NOT COMPLETED</font></td>" ;	
		    	str=str+"<td align='left' class='boldEleven'><a href=OnlineTestResult.jsp?applicantid="+id +">View Result</a> </td>";  
		    }	
	    }
	    else
	    {
	    	str=str+"<td align='left' class='boldEleven'>-</td>"; 
	    	str=str+"<td align='left' class='boldEleven'>-</td>"; 
	    }
	   
     }

     str=str+"</table>";
     var tb=document.getElementById('applicationTable');
  	 tb.innerHTML=str   
  	 
  	 document.getElementById('totRec').innerHTML="<font class='bolddeepred'>Total no of Records :: "+loop+"</font>";
     
	
 
 } 	
 
 
  