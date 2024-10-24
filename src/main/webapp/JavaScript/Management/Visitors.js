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
 
 
function loadVisitors(startLetter)
{
	var building = document.getElementById('building').value;
	var purpose = document.getElementById('purpose').value;
	var url = "../management?actionS=loadVisitors&type=1&startLetter="+escape(startLetter)+"&building="+building+"&purpose="+purpose;  
	initRequest(url);
   	req.onreadystatechange = loadVisitorsRequest;
    req.open("GET", url, true);
    req.send(null);    
}	

function loadVisitorss(ctr)
{
	var building = document.getElementById('building').value;
	var purpose = document.getElementById('purpose').value;
	var url = "../management?actionS=loadVisitors&type=2&startLetter="+ctr.value+"&building="+building+"&purpose="+purpose;  
	initRequest(url);
   	req.onreadystatechange = loadVisitorsRequest;
    req.open("GET", url, true);
    req.send(null);    
}	
 

function loadVisitorsRequest()
 {
     
    if(req.readyState == 4) 
    {
        ClearTable('divTable');
		ClearTabler('totRec');  
        if (req.status == 200) 
        {
        	loadVisitorsMessage();
        }
    }
}

function loadVisitorsMessage() 
{	
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  
    str=str+" <tr class='MRow1'> ";
    str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Refno</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Name</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Building</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Floor</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Purpose</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Whomtomeet</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>In</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Out</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Mobile</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Email</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Entryby</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Out Time </b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Print</b></td>"; 
    	
    str=str+" </tr>"; 
    for(loop=0; loop<batchs.childNodes.length; loop++)
     {
	    var batch = batchs.childNodes[loop];
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
        var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue; 
        var Refno = batch.getElementsByTagName("Refno")[0].childNodes[0].nodeValue; 
        var Building = batch.getElementsByTagName("Building")[0].childNodes[0].nodeValue;
        var Floor = batch.getElementsByTagName("Floor")[0].childNodes[0].nodeValue;
        var Purpose = batch.getElementsByTagName("Purpose")[0].childNodes[0].nodeValue;
        var Whomtomeet = batch.getElementsByTagName("Whomtomeet")[0].childNodes[0].nodeValue;
        var In = batch.getElementsByTagName("In")[0].childNodes[0].nodeValue;
        var Out = batch.getElementsByTagName("Out")[0].childNodes[0].nodeValue;
        var Mobile = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
        var Email = batch.getElementsByTagName("Email")[0].childNodes[0].nodeValue;
        var Entryby = batch.getElementsByTagName("Entryby")[0].childNodes[0].nodeValue;
        var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
       if(Status == "Y")
    	{
    	   str=str+"<tr  class='MRow2'>";
    	   str=str+"<td class='boldEleven'>"+(loop+1)+"</td>";
    	}  
       else
       {	   
        if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";	
        str=str+"<td class='boldEleven'><input type='checkbox' name='rowid' id='rowid' value="+Rowid+">"+(loop+1)+"</td>";
       }
        str=str+"<td class='boldEleven'>"+Refno+"</td>";
        str=str+"<td class='boldEleven'>"+Name+"</td>"; 
        str=str+"<td class='boldEleven'>"+Building+"</td>";
        str=str+"<td class='boldEleven'>"+Floor+"</td>";
        str=str+"<td class='boldEleven'>"+Purpose+"</td>";
        str=str+"<td class='boldEleven'>"+Whomtomeet+"</td>";
        str=str+"<td class='boldEleven'>"+In+"</td>";
        str=str+"<td class='boldEleven'>"+Out+"</td>";
        str=str+"<td class='boldEleven'>"+Mobile+"</td>";
        str=str+"<td class='boldEleven'>"+Email+"</td>";
        str=str+"<td class='boldEleven'>"+Entryby+"</td>";
        str=str+"<td class='boldEleven'><a href='VisitorsUpdate.jsp?rowid="+Rowid+"'><font class='bolddeepred'>Out time</font></a></td>";
        str=str+"<td class='boldEleven'><a href='../SmartLoginAuth?filename=Rept_JVisitor&actionS=MGTVisitorsPrint&rptfilename=visitor&id="+Rowid+"&reportType=pdf'><font class='bolddeepred'>Print</font></a></td>";
        
        str=str+"</tr>";
     }
      	 
 	 str=str+"</table>";     
  	 var tb=document.getElementById('divTable');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML="<center><font class='bolddeepred'>Total no of Staffs :: "+batchs.childNodes.length+"</font></center>"; 
 
     
}  

