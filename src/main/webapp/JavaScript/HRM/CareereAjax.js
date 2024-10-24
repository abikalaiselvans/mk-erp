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


//k a l a i s e l v a n k a r u p p a i a h 

function loadResume(search)
 {
 	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value; 
    var day=document.getElementById('day').value; 
    var experience=document.getElementById('yearofexperience').value;
    
    var url = "../SmartHRM?actionS=loadResume&month="+escape(mon)+"&year="+escape(yea)+"&day="+day+"&search="+search+"&experience="+experience ;
	
	initRequest(url);
	req.onreadystatechange=loadResumeRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function loadResumeRequest() 
 {
    if(req.readyState == 4) 
    {    	
        ClearTable('CareerTable');  
        ClearTabler('totalRec');  
		if (req.status == 200) 
        {		  	
         	 
		  	loadResumeMessages();
        }
    }
}

function loadResumeMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    
    var str=""; 
    var query="";
	str=str+"<table width='100%' class='table table-bordered'   id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<tr class='MRow2'><td class='boldEleven'><b>S.No</b></td>";
	str=str+"<td class='boldEleven'><b>NAME</b></td>";
	str=str+"<td class='boldEleven'><b>GENDER</b></td>";
	str=str+"<td class='boldEleven'><b>QUALIFICATION</b></td>";
	str=str+"<td class='boldEleven'><b>EMAIL</b></td>";
	str=str+"<td class='boldEleven'><b>MOBILE</b></td>";
	str=str+"<td class='boldEleven'><b>EXPERIENCE</b></td>"; 
	str=str+"<td class='boldEleven'><b>APPLIED POST</b></td>";
	str=str+"<td class='boldEleven'><b>MAIL</b></td>";
	str=str+"<td class='boldEleven'><b>DOWNLOAD</b></td> ";
	 
	
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var CareID = batch.getElementsByTagName("CareID")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Father = batch.getElementsByTagName("Father")[0].childNodes[0].nodeValue;
	    var DOB = batch.getElementsByTagName("DOB")[0].childNodes[0].nodeValue;
	    var Gender = batch.getElementsByTagName("Gender")[0].childNodes[0].nodeValue;
	    var Qualification = batch.getElementsByTagName("Qualification")[0].childNodes[0].nodeValue;
	    var Email = batch.getElementsByTagName("Email")[0].childNodes[0].nodeValue;
	    var Mobile = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
	    var Experience = batch.getElementsByTagName("Experience")[0].childNodes[0].nodeValue;
	    var AppliedPost = batch.getElementsByTagName("AppliedPost")[0].childNodes[0].nodeValue;
	    var DateofReg = batch.getElementsByTagName("DateofReg")[0].childNodes[0].nodeValue;
	    var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
	    var Download = batch.getElementsByTagName("Download")[0].childNodes[0].nodeValue;
	    
	    if(loop%2==0)
			str=str+"<tr class='active'>";
		else
		    str=str+"<tr  class='success'>";		
		   
		str=str+"<td  class='boldEleven'>"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Name+"</td>";
		if("M" == Gender)
			str=str+"<td  class='boldEleven'>&nbsp;Male</td>";
		else
			str=str+"<td  class='boldEleven'>&nbsp;Female</td>";	
		
		str=str+"<td  class='boldEleven'>&nbsp;"+Qualification+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Email+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Mobile+"</td>";
		
		if("-1" == Experience)
			str=str+"<td  class='boldEleven'>Below one year</td>";
		else if("-2" == Experience)
			str=str+"<td  class='boldEleven'>Below 6 months</td>";
		else if("-3" == Experience)	
			str=str+"<td  class='boldEleven'>Freshers</td>";
		else
			str=str+"<td  class='boldEleven'>&nbsp;"+Experience+"</td>";
		
		
		str=str+"<td  class='boldEleven'>&nbsp;"+AppliedPost+"</td>";
		query = "../SmartLoginAuth?filename=Career&actionS=HRMCareersSendaResume&careid="+CareID+"&name="+Name.toUpperCase();
		
		if("Y"==Status)
			str=str+"<td  class='boldEleven'><a   href=\"javascript:careersSendMail('"+Name+"','"+query+"')\"> <font class='bolddeepred'> Mail</font> </a> </td>";
		else
			str=str+"<td  class='boldEleven'>&nbsp; </td>";
			
			
		 
		if("Y"==Status)
		{
			if(Download=="Y")
			{	
				str=str+"<td class='boldEleven'>";
				//str=str+"<a href='../CareerProfiles?myid="+CareID+"' target='_blank' >Download </a>  /";
				str=str+" <a href='../uploadfiles/CareersResume/"+CareID+".doc' target='blank'><span class='badge'>Download</span></a>";
				//<img src='../Image/report/MS.GIF' border='0' />
				str=str+"</td>";
			}	
			else
				str=str+"<td  class='boldEleven'>&nbsp; </td>";
		}
		else
		{
			str=str+"<td  class='boldEleven'>&nbsp; </td>";
		}
		
		str=str+"</tr>";
    }
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	var tb=document.getElementById('totalRec');
  	 	tb.innerHTML="<center> <font  class='bolddeepred'>Total No of Records : "+batchs.childNodes.length+"</font></center>" ;
		
		
     }
     else
     {
     	str=str+"<tr class='MRow1'><td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td></tr>";
     	document.getElementById('Edit').disabled=true;
     }	
	 str=str+"</table>";
     var tb=document.getElementById('CareerTable');
  	 tb.innerHTML=str  
  	 
  	 
  	  
}



