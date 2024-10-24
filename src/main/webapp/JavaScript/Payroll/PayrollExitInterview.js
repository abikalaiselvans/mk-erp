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

 
function loadExit(startLetter) 
{    
	var officeid=document.getElementById("Office").value;
	var month=document.getElementById("month").value;
	var year=document.getElementById("year").value;   
	var status=document.getElementById("status").value;
	var url = "../Payroll?actionS=PAYExit&type=1&startLetter="+startLetter;
    url=url+"&Office="+officeid+"&month="+month+"&year="+year+"&status="+status;
 	initRequest(url);
    req.onreadystatechange = loadExitRequest;
    req.open("GET", url, true);
    req.send(null);
}
function loadExits(startLetter) 
{    
	var officeid=document.getElementById("Office").value;
	var month=document.getElementById("month").value;
	var year=document.getElementById("year").value;   
	var status=document.getElementById("status").value;
	var url = "../Payroll?actionS=PAYExit&type=2&startLetter="+document.getElementById('search').value;
    url=url+"&Office="+officeid+"&month="+month+"&year="+year+"&status="+status;
 	 
    initRequest(url);
    req.onreadystatechange = loadExitRequest;
    req.open("GET", url, true);
    req.send(null);
} 

function loadExitRequest() 
{
	 
	 if(req.readyState == 4) 
    {
		ClearTable('CessationTable');
		ClearTabler('totRec'); 
        if (req.status == 200) 
        {		  	
          loadExitMessages();
        }
    }
}
function loadExitMessages() 
{   
    var batchs = req.responseXML.getElementsByTagName("Terms")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  		                        
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
    	var Resign = batch.getElementsByTagName("Resign")[0].childNodes[0].nodeValue;
    	var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
    	var usertype = batch.getElementsByTagName("usertype")[0].childNodes[0].nodeValue;
    	
    	if(loop%2==1)
			str=str+"<tr class='MRow2'>";
		else
		    str=str+"<tr  class='MRow1'>";
		    		
		
    	if(Status  =="Y")
    		str=str+"<td class='boldEleven'>"+(loop+1)  +"</td>" ;
    	else
    		str=str+"<td class='boldEleven'><input type='checkbox' id='staffid' name='staffid' value='"+exitid +"'>"+(loop+1)+"</td>";
    	
    	
		str=str+"<td class='boldEleven'>"+Staffid  +"</td>" ;
		
		var link="";
		if(usertype  == "F" )
			link ="<a href='ExitInterviewEdit.jsp?staffid="+exitid +"'>"+Staffname +"</a>";
		else
			link = Staffname;
		
		if( Status  =="N" )   
			str=str+"<td class='boldEleven'>"+Staffname+"</td>" ;
		else
			str=str+"<td class='boldEleven'>"+link +"</td>";
		
		str=str+"<td class='boldEleven'>"+Companyame +"</td>";
		str=str+"<td class='boldEleven'>"+Branch +"</td>";
		str=str+"<td class='boldEleven'>"+Depart +"</td>";
		str=str+"<td class='boldEleven'>"+Desig +"</td>";
		link ="";
		if(Status  =="Y")
			str=str+"<td class='boldEleven'><font class='boldgreen'>Completed</font></td>" ;
		else
		{
			if(usertype  == "F" || usertype  == "B" )
				link =" / <a target ='_blank' href='ExitInterviewForcetoAdd.jsp?staffid="+Staffid +"'>Force to close</a>";
			
			str=str+"<td class='boldEleven'><font class='bolddeepred'>Pending "+link+"</font></td>" ;
		}
		
			
		if(Status  =="Y")
			str=str+"<td class='boldEleven'><a href='../SmartLoginAuth?actionS=PAYRept_JExitInterview&filename=Rept_JExitInterview&rptfilename=Rept_JExitInterview&reportType=pdf&staffid="+exitid+"' ><font class='boldgreen'>Print</font></a> / <a href='ExitInterviewEdit.jsp?staffid="+exitid +"'>View</a> </td>" ;
		else
			str=str+"<td class='boldEleven'><font class='bolddeepred'>&nbsp</font></td>" ;
		
		
		if(Status  =="Y")
			str=str+"<td class='boldEleven'><a href=\"javascript:Printquery('UploadExitInterview.jsp?rowid="+exitid+"')\"<font class='boldgreen'>Upload Scanned Copy</font></a></td>" ;
		else
			str=str+"<td class='boldEleven'><font class='bolddeepred'></font></td>" ;
		
		
		str=str+"</tr>";
     }
   if(batchs.childNodes.length<1)
    str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
    str=str+"</table>";
    var tb=document.getElementById('CessationTable');
  	tb.innerHTML=str;   
  	
	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  
}


 