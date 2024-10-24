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


function LoadConveyanceAdvance(startLetter)
{
	try
	{
	 	var Office =document.getElementById('Office').value;
	 	var month =document.getElementById('month').value;
	 	var year =document.getElementById('year').value;
	 	
		var url = "../Conveyance?actionS=ConveyanceManual&startLetter="+escape(startLetter)+"&office="+Office+"&month="+month+"&year="+year;
	 	var tob=document.getElementById('divscroll');
		tob.innerHTML="<br><br><center> <img src='../images/loading_gif.gif' width='508' height='381'></center>" ;
		initRequest(url);
		req.onreadystatechange=LoadConveyanceAdvanceRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}
 
 function LoadConveyanceAdvanceRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	
	        ClearTable('divscroll');  
	        ClearTabler('totRec');  
	    	if (req.status == 200) 
	        {		  	
	    		LoadConveyanceAdvanceMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
 
 
function LoadConveyanceAdvanceMessages() 
{	 
 try
 {
	  
	 var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   
	 var str=""; 
	 str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	 str=str+"<tr class='MRow1'>";
	 str=str+"<td  class='boldEleven' align='center'><b>S.NO</b></td>";
	 str=str+"<td  class='boldEleven' align='center'><b>ID</b></td>";
	 str=str+"<td  class='boldEleven' align='center'><b>Name</b></td>";
	 str=str+"<td  class='boldEleven' align='center'><b>Month</b></td>";
	 str=str+"<td  class='boldEleven' align='center'><b>Year</b></td>";
	 str=str+"<td  class='boldEleven' align='center'><b>Amount</b></td>";
	 str=str+"<td  class='boldEleven' align='center'><b>Upload</b></td>";
	 str=str+"<td  class='boldEleven' align='center'><b>Download</b></td>";
	 str=str+"</tr>";
	 for(loop = 0; loop < batchs.childNodes.length; loop++) 
	 {	     
        var batch = batchs.childNodes[loop];
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
	    var EmpId = batch.getElementsByTagName("EmpId")[0].childNodes[0].nodeValue;
	    var EmpName = batch.getElementsByTagName("EmpName")[0].childNodes[0].nodeValue;
	    var Month = batch.getElementsByTagName("Month")[0].childNodes[0].nodeValue;
	    var Year = batch.getElementsByTagName("Year")[0].childNodes[0].nodeValue;
	    
	    var Amount = batch.getElementsByTagName("Amount")[0].childNodes[0].nodeValue;
	    var Entryby = batch.getElementsByTagName("Entryby")[0].childNodes[0].nodeValue;
	    var Upload = batch.getElementsByTagName("Upload")[0].childNodes[0].nodeValue;
	    var F = batch.getElementsByTagName("F")[0].childNodes[0].nodeValue;
	    
	    
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
	    
	    if(Upload =="N")
	       	str=str+"<td  class='boldEleven'><input id='rowid' name='rowid' type='checkbox' value='"+Rowid+"' />"+(loop+1)+"</td>";
	    else
	    	str=str+"<td  class='boldEleven'>"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven'> "+EmpId+"</td>";
		str=str+"<td  class='boldEleven'> "+EmpName+"</td>";
		str=str+"<td  class='boldEleven'> "+Month+"</td>";
		str=str+"<td  class='boldEleven'> "+Year+"</td>";
		str=str+"<td  class='boldEleven'> "+Amount+"</td>";
		  
		 
		 
		str=str+"<td  class='boldEleven'><a href=\"javascript:Printquery('UploadConveyance_File.jsp?Rowid="+Rowid+"')\" title='Upload scanned copy' ><font class='boldgreen'>Upload</font></a></td>";
		if(F =="Y")
			str=str+"<td  class='boldEleven'> <a target='_blank' href='../uploadfiles/Conveyance_File/"+Rowid+".pdf' download='"+Rowid+".pdf' ><font class='boldgreen'>Download</font></a> ";
		else
			str=str+"<td  class='boldEleven'>&nbsp;</td>";
		
	 	
		
		str=str+"</tr>";
		window.status=(loop+1);
	 }
	 str=str+"</table>";
	 
	 
	 if(batchs.childNodes.length <1)
		str= " <br><br><br><center><font  class='bolddeepred'>Data not found</font></center> ";
	 
    
	 var tb=document.getElementById('divscroll');
  	 tb.innerHTML=str   ;
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  	}
 	catch(err)
 	{
 		alert(err.description);
 	}    	
}


