

var isIE;
var req;
var names;
var target1;
var ctrl;
 

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

 

function LoadJobGrade(startLetter) 
{
    var id=document.getElementById('jobGrade').value;
    var url = "../SmartHRM?actionS=JobGradeId&id="+escape(id)+"&startLetter="+escape(startLetter); 
    initRequest(url);
    req.onreadystatechange = jobRequest;
    req.open("GET", url, true);
    req.send(null);
}



function jobRequest() 
{
    if(req.readyState == 4) 
    {    
    	ClearTable('GradeTable');
    	ClearTabler('totRec');
        if (req.status == 200) 
        {
	          jobDetails();
        }
        else
        {
    	    var str="<font color='red'>Total no of Records :: 0</font>";
	  		 var tb=document.getElementById('totRec');
	  		tb.innerHTML=str   
        }
    }
}


function jobDetails() 
{
    var batchs = req.responseXML.getElementsByTagName("jobs")[0];      
	var str=""; 
	var disp = batchs.childNodes.length;
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var jobId = batch.getElementsByTagName("id")[0];        
        var jobcode = batch.getElementsByTagName("code")[0];        
        var title = batch.getElementsByTagName("title")[0];    
        var education = batch.getElementsByTagName ("education")[0];
        var scale = batch.getElementsByTagName ("scale")[0];
        var experience = batch.getElementsByTagName ("experience")[0];
		var jval = jobId.childNodes[0].nodeValue;
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";				

		str=str+"<td   width='20%' align=left class='boldEleven'>";
		str= str+ "<input type='checkbox' name='rowid'  id='rowid' value='"+jval+"'>&nbsp;";
		
		//str= str+"<a href=JobDesignAction.jsp?action1=Edit&rowid="+jval+"><font color='blue'>"+ jobcode.childNodes[0].nodeValue+"</font></a> </td>";
		str= str+jobcode.childNodes[0].nodeValue+" </td>";
		str=str+"<td   width='20%' align=left class='boldEleven'>&nbsp;"+title.childNodes[0].nodeValue+"</td>";
		str= str+"<td   width='20%' align=left class='boldEleven'>&nbsp;"+education.childNodes[0].nodeValue+"</td>";		
		str=str+"<td   width='20%' align=left class='boldEleven'>INR Rs."+scale.childNodes[0].nodeValue+"/- </td>";
		if("-1" == experience.childNodes[0].nodeValue)
			str=str+"<td   width='20%' align=left class='boldEleven'>Below one year</td>";
		else if("-2" == experience.childNodes[0].nodeValue)
			str=str+"<td   width='20%' align=left class='boldEleven'>Below 6-months</td>";
		else if("-3" == experience.childNodes[0].nodeValue)
			str=str+"<td    width='20%'align=left class='boldEleven'>Fresher</td>";
		else 
		  str=str+"<td   width='20%' align=left class='boldEleven'>"+experience.childNodes[0].nodeValue+"-Yrs</td>";
		str=str+" </tr>";
     }
     str=str+"</table>";
     var tb=document.getElementById('GradeTable');
  	 tb.innerHTML=str   
	 var str="<font class='bolddeepred'>Total no of Records :: "+disp+"</font>";
	 var tb=document.getElementById('totRec');
  	tb.innerHTML=str   
 } 	
 