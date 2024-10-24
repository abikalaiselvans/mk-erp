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

 
function LoadNDCFinalAccept(startLetter) 
{         
   
    var month = document.getElementById('month').value;
    var year = document.getElementById('year').value;
    var status = document.getElementById('status').value;
    var url = "../Payroll?actionS=LoadNDCFinalAccept&startLetter="+startLetter+"&type=1&month="+month+"&year="+year+"&status="+status;
	initRequest(url);
    req.onreadystatechange = LoadNDCStoreRequest;
    req.open("GET", url, true);
    req.send(null);
}
  

function LoadNDCFinalAccepts() 
{         
	var startLetter = document.getElementById('search').value;
    var month = document.getElementById('month').value;
    var year = document.getElementById('year').value;
    var status = document.getElementById('status').value;
    var url = "../Payroll?actionS=LoadNDCFinalAccept&startLetter="+startLetter+"&type=2&month="+month+"&year="+year+"&status="+status;
	initRequest(url);
    req.onreadystatechange = LoadNDCStoreRequest;
    req.open("GET", url, true);
    req.send(null);
}


function LoadNDCStoreRequest() 
{
	 
    if(req.readyState == 4) 
    {
        ClearTable('RecordTable');
        ClearTabler('totRec'); 
        if (req.status == 200) 
        {		  	
        	LoadNDCStoreMessages();
        }
    }
}

function LoadNDCStoreMessages() 
{   
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  		                        
    
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {           		                           
	    var batch = batchs.childNodes[loop];
	    var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
	    var Staffid = batch.getElementsByTagName("Staffid")[0].childNodes[0].nodeValue; 
    	var Staffname = batch.getElementsByTagName("Staffname")[0].childNodes[0].nodeValue;
    	var Companyame = batch.getElementsByTagName("Companyame")[0].childNodes[0].nodeValue;
    	var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
    	var Depart = batch.getElementsByTagName("Depart")[0].childNodes[0].nodeValue;
    	var Desig = batch.getElementsByTagName("Desig")[0].childNodes[0].nodeValue;  
    	var EDate = batch.getElementsByTagName("EDate")[0].childNodes[0].nodeValue;
    	var FStatus = batch.getElementsByTagName("FStatus")[0].childNodes[0].nodeValue;
    	var AStatus = batch.getElementsByTagName("AStatus")[0].childNodes[0].nodeValue;
    	var HStatus = batch.getElementsByTagName("HStatus")[0].childNodes[0].nodeValue;
    	var GStatus = batch.getElementsByTagName("GStatus")[0].childNodes[0].nodeValue;
    	 
    	
    	if(loop%2==1)
			str=str+"<tr class='MRow2'>";
		else
		    str=str+"<tr  class='MRow1'>";
    	if(FStatus =="Y")
    	{
    		str= str+"<td width='50' class='boldEleven'>"+(loop+1)+". </td>";
    		str=str+"<td width='80'  class='boldEleven'>"+Staffid+"</td>";
    	}	
    	else
    	{
    		str= str+"<td width='50' class='boldEleven'><input type='checkbox' id='Rowid'   name='Rowid' value='"+Rowid+"'>"+(loop+1)+". </td>";
    		str=str+"<td width='80'  class='boldEleven'>"+Staffid+"</td>";
    	}
    	  		
		str=str+"<td width='175' class='boldEleven'>"+Staffname+"</td>";
			
	    //str=str+"<td width='175' class='boldEleven'><a href='CessationEdit.jsp?Rowid="+Rowid+"'>"+Staffname+"</a> </td>";
				
		str=str+"<td width='150' class='boldEleven'>"+Companyame+"</td>";
		str=str+"<td width='75' class='boldEleven'>"+Branch+"</td>";
		str=str+"<td width='100' class='boldEleven'>"+Depart+"</td>";
		str=str+"<td width='200' class='boldEleven'>"+Desig+"</td>";
		str=str+"<td width='100' class='boldEleven'>"+EDate+"</td>";
		 
		
		if(FStatus =="Y")
		{
			str=str+"<td width='200' class='boldEleven'><font class='boldgreen'>CLOSED </font>";
			str=str+"</td>";
		}
		else
		{
			str=str+"<td width='200' class='boldEleven'><font class='bolddeepred'>NOT CLOSED </font>";
		}
		
		
		if(FStatus =="Y")
			str=str+"<td width='200' class='boldEleven'><a  href=\"javascript:Printquery('../SmartLoginAuth?actionS=PAYRept_JNDC&filename=Rept_JNDC&rptfilename=Rept_JNDC&reportType=pdf&rowid="+Rowid+"&edate="+EDate+"')\"><font class='boldgreen'>Print </font></a> /<a href='PrintNDC.jsp?rowid="+Rowid+"' target='_blank'> view </a></td>";
		else
			str=str+"<td width='200' class='boldEleven'>&nbsp;</td>";
		
		if(FStatus =="Y")
			str=str+"<td width='200' class='boldEleven'><a href=\"javascript:Printquery('UploadNDC.jsp?rowid="+Rowid+"')\"<font class='boldgreen'>Upload Scanned Copy</font></a> &nbsp;/&nbsp;<a href='../uploadfiles/Staff_NDC/"+Staffid+".pdf' target='_blank'><font class='boldgreen'>View </font></a></td>";
		else
			str=str+"<td width='200' class='boldEleven'>&nbsp;</td>";
		
		
		str=str+"</tr>";
     }     
  	if(batchs.childNodes.length<1)
    	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
    str=str+"</table>";
    var tb=document.getElementById('RecordTable');
  	tb.innerHTML=str; 
 	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 

}

  