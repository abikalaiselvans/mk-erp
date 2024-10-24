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
 

function loadPayrollRevision(startLetter) 
{
    var month = document.getElementById('month').value;
    var year = document.getElementById('year').value;
    var status = document.getElementById('status').value;
    var url = "../Payroll?actionS=loadPayrollRevisionAccep&type=1&startLetter="+startLetter+"&month="+month+"&year="+year+"&status="+status;
	initRequest(url);
    req.onreadystatechange = loadPayrollRevisionRequest;
    req.open("GET", url, true);
    req.send(null);
}

var amonth="";
var ayear ="";

function loadPayrollRevisions(startLetter) 
{
    amonth = document.getElementById('month').value;
    ayear = document.getElementById('year').value;
    var url = "../Payroll?actionS=loadPayrollRevisionAccep&type=2&startLetter="+document.getElementById('search').value+"&month="+amonth+"&year="+ayear;
	initRequest(url);
	req.onreadystatechange = loadPayrollRevisionRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadPayrollRevisionRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('PayrollRevisionTable'); 
        ClearTabler('totalrecord');
        if (req.status == 200) 
        {		  	
          loadPayrollRevisionMessages();
        }
    }
}


function loadPayrollRevisionMessages() 
{   
    var batchs = req.responseXML.getElementsByTagName("Revisions")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'  class='tablesorter'   cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  		                        
    str=str+"<tr  class='MRow2'> ";
    str=str+"<td> <div align='center'><b>S.no</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Staff Id</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Staff Name</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Company</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Branch</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Office</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Department</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Designation</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Category</b></div></td> ";
	str=str+"<td  ><div align='center'><b>DOJ</b></div></td> ";
	str=str+"<td  ><div align='center'><b>Next DOR</b></div></td> ";
    str=str+"<td  ><div align='center'><b>Approval</b></div></td> ";
	str=str+"</tr> ";
					
    
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {           		                           
	    var batch = batchs.childNodes[loop];
	    var Staffid = batch.getElementsByTagName("Staffid")[0].childNodes[0].nodeValue;
	    var Staffname = batch.getElementsByTagName("Staffname")[0].childNodes[0].nodeValue;
	    var Companyame = batch.getElementsByTagName("Companyame")[0].childNodes[0].nodeValue;
	    var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
	    var Office = batch.getElementsByTagName("Office")[0].childNodes[0].nodeValue;
	    var Depart = batch.getElementsByTagName("Depart")[0].childNodes[0].nodeValue;
	    var Desig = batch.getElementsByTagName("Desig")[0].childNodes[0].nodeValue;
	    var Cat = batch.getElementsByTagName("Cat")[0].childNodes[0].nodeValue;
	    var DOJ = batch.getElementsByTagName("DOJ")[0].childNodes[0].nodeValue;
	    var DOR = batch.getElementsByTagName("DOR")[0].childNodes[0].nodeValue;
	    var Accept = batch.getElementsByTagName("Accept")[0].childNodes[0].nodeValue;
	    var Apparaisalid = batch.getElementsByTagName("Apparaisalid")[0].childNodes[0].nodeValue;
	    
    	if(loop%2==1)
			str=str+"<tr class='MRow2'>";
		else
		    str=str+"<tr  class='MRow1'>";
		
    	if(Accept == "N")
    		str=str+"<td class='boldEleven'>"+(loop+1)+".<input type='checkbox' name='Apparaisalid'   id='Apparaisalid' value='"+Apparaisalid+"'></td>";
    	else
    		str=str+"<td class='boldEleven'>"+(loop+1)+".</td>";
		str=str+"<td   class='boldEleven'>"+Staffid+"</td>";
		str=str+"<td   class='boldEleven'>"+Staffname+"</td>";
		str=str+"<td   class='boldEleven'>"+Companyame+"</td>";
		str=str+"<td   class='boldEleven'>"+Branch+"</td>";
		str=str+"<td   class='boldEleven'>"+Office+"</td>";
		str=str+"<td   class='boldEleven'>"+Depart+"</td>";
		str=str+"<td   class='boldEleven'>"+Desig+"</td>";
		str=str+"<td   class='boldEleven'>"+Cat+"</td>";
		str=str+"<td   class='boldEleven'>"+DOJ+"</td>";
		str=str+"<td   class='boldEleven'>"+DOR+"</td>";
		if(Accept == "Y")
		{
			amonth = document.getElementById('month').value;
		    ayear = document.getElementById('year').value;
			str=str+"<td   class='boldEleven'><font class='boldgreen'>Approved</font>";
			str=str+"&nbsp;&nbsp;/&nbsp;&nbsp; <a href='Rept_JAppraisalLetter.jsp?month="+amonth+"&staffid="+Staffid+"&year="+ayear+"&apparaisalid="+Apparaisalid+"' >PDF</a> ";//onClick='return vali()'
			str=str+"</td>";
		}
		else
			str=str+"<td   class='boldEleven'><font class='bolddeepred'>Pending</font></td>";
		str=str+" </tr>";
     }     
  	if(batchs.childNodes.length<1)
   		 str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
    str=str+"</table>";
    var tb=document.getElementById('PayrollRevisionTable');
  	tb.innerHTML=str;  
  	
  	tb=document.getElementById('totalrecord');
 	tb.innerHTML="<br><font class='bolddeepred'>Total no of Records :: "+batchs.childNodes.length+"</font><br>"  ; 
 	 
}

 