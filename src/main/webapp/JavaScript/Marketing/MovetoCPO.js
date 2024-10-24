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
	 var str="<center><br><font class='bolddeepred'>Total No of Records : 0</font></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

 function LoadMovetoCPO(startLetter)
 {
	var calltype = document.getElementById('calltype').value;
	var day = document.getElementById('day').value;
 	var month =document.getElementById('month').value;
 	var year =document.getElementById('year').value;
	var customer =document.getElementById('customer').value;
	var status =document.getElementById('status').value;
	var me =document.getElementById('me').value;
	var url = "../marketing?actionS=LoadMovetoCPO&me="+me+"&startLetter="+escape(startLetter)+"&day="+day+"&month="+month+"&year="+year+"&customer="+customer+"&calltype="+calltype+"&status="+status;
   	initRequest(url);
	req.onreadystatechange=LoadMovetoCPOstaff;
    req.open("GET", url, true);
    req.send(null);
    
}
 
 function LoadMovetoCPOstaff() 
 {
	if(req.readyState == 4) 
    {    	
		ClearTabler('totalrec');
	    ClearTable('GroupTable');
		if (req.status == 200) 
        {		  	
          	var tb=document.getElementById('GroupTable');
		  	tb.innerHTML="<font class='bolddeepred'> Loading Data</font>";
		  	LoadMovetoCPOMessagesstaff();
        }
    }
}

function LoadMovetoCPOMessagesstaff() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<tr  class='MRow1'>";
	str=str+"<td align='center'><b>S.No</b></td>";
	str=str+"<td align='center'><b>CustomerName</b></td>";
	str=str+"<td align='center'><b>CallType</b></td>";
	str=str+"<td align='center'><b>StartDate</b></td>";
	str=str+"<td align='center'><b>EndDate </b></td>";
	str=str+"<td align='center'><b>Age </b></td>";
	str=str+"<td align='center'><b>Status</b></td>";
	str=str+"<td align='center'><b>Follow Up</b></td>";
	str=str+"<td align='center'><b>Entry</b></td>";
	str=str+"<td align='center'><b>Upload</b></td>";
	str=str+"<td align='center'><b>Download </b></td>";
	str=str+"<td align='center'><b>Quotation</b></td>";
	str=str+"</tr>";
	var call="";
	var statusclose="",statusclose1="";
	var callN="";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		var Calltype = batch.getElementsByTagName("Calltype")[0].childNodes[0].nodeValue;
	    var SDate = batch.getElementsByTagName("SDate")[0].childNodes[0].nodeValue;
	    var EDate = batch.getElementsByTagName("EDate")[0].childNodes[0].nodeValue;
	    var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
		var Next = batch.getElementsByTagName("Next")[0].childNodes[0].nodeValue;
		var followon = batch.getElementsByTagName("DFollowon")[0].childNodes[0].nodeValue;
		var Created = batch.getElementsByTagName("Created")[0].childNodes[0].nodeValue;
		var F = batch.getElementsByTagName("F")[0].childNodes[0].nodeValue;
		var Funnel = batch.getElementsByTagName("Funnel")[0].childNodes[0].nodeValue;
		var Cverify = batch.getElementsByTagName("Cverify")[0].childNodes[0].nodeValue;
		var Age = batch.getElementsByTagName("Age")[0].childNodes[0].nodeValue;
		var Qassign = batch.getElementsByTagName("Qassign")[0].childNodes[0].nodeValue;
		var Quotation = batch.getElementsByTagName("Quotation")[0].childNodes[0].nodeValue;
		
		if(Cverify =="N")
		{
			str=str+"<tr bgcolor='#f0ad4e'>";
		}
		else
		{ 	
			if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";
		}
		
		if(Status == "Y")
			str=str+"<td  class='boldEleven'>"+(loop+1)+"</td>";
		else
			str=str+"<td  class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1)+"</td>";
			
		str=str+"<td  class='boldEleven'>"+Name+"</td>";
		str=str+"<td  class='boldEleven'>"+Calltype+"</td>";
		str=str+"<td  class='boldEleven'>"+SDate+"</td>";
		str=str+"<td  class='boldEleven'>"+EDate+"</td>";
		str=str+"<td  class='boldEleven'>"+Age+"</td>";
		if(Status == "Y")
			str=str+"<td  class='boldEleven'><font class='boldgreen'>Closed</font></td>";
		else
			str=str+"<td  class='boldEleven'><font class='bolddeepred'>Pending</font></td>";
		
		if(Next =="Y")
			str=str+"<td  class='boldEleven'>"+followon+"</td>";
		else
			str=str+"<td  class='boldEleven'>&nbsp;</td>";
		str=str+"<td  class='boldEleven'>"+Created+"</td>";
		
		/*if(Status == "Y")
			str=str+"<td  class='boldEleven'>&nbsp;</td>";
		else
			*/str=str+"<td   class='boldEleven' align='center'><a href=\"javascript:SFAUpload('"+Id+"')\"><font class=boldgreen>Upload </font></a>" ;
		
		if(F =="Y")
			str=str+"<td class='boldEleven' align='center'><a target='_blank' href='../SFA/"+Id+".pdf' download='"+Id+".pdf' ><font class='boldgreen'>Download</font></a> ";
		else
			str=str+"<td  class='boldEleven'>&nbsp;</td>";
		
			
		if(Qassign == "N")
			str=str+"<td  class='boldEleven'><a href=\"javascript:QuotationUpload('"+Id+"')\"><font class='boldgreen'>Assign Quotation</font></a></td>";
		else
			str=str+"<td  class='boldEleven'><a href='QuotationMovetoCPO.jsp?quotationnumber="+Quotation+"'  style='text-decoration:none'><font class='boldgreen'>"+Quotation+"&nbsp;/&nbsp;Convert CPO</font></a></td>";
	
		/*if(Status == "N")
		{	
		}	
		else
			str=str+"<td  class='boldEleven'>"+Quotation+"</td>";
		*/
 		
		str=str+"</tr>";	
    }
   	
  	if(batchs.childNodes.length <1)
 		str=str+"<td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
  	 
	 str=str+"</table>";
	 var tb=document.getElementById('GroupTable');
  	 tb.innerHTML=str   ;
  	 tb=document.getElementById('totalrec');
  	 tb.innerHTML= "<center><font class='bolddeepred'>Total no of Records ::"+batchs.childNodes.length+"</font></center>"; 
}


function  SFAUpload(rowid)
{
	var f ="SFAUpload.jsp?rowid="+rowid;
	newWindow = window.open(f,"subWind",",,height=400,width=600,top=0,left=0");
	newWindow.focus( );
}

 function  QuotationUpload(rowid)
{
	var f ="AssignQuotation.jsp?rowid="+rowid;
	newWindow = window.open(f,"subWind",",,height=400,width=600,top=0,left=0");
	newWindow.focus( );
}


function QuotationPrint(query)
{
	var width="800", height="400";
	var left = (screen.width/2) - width/2;
	var top = (screen.height/2) - height/2;
	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbar=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;

	var f ="QuotationOrderPrint.jsp?quotationnumber="+query;
	newWindow = window.open(f,"subWind",styleStr);
	newWindow.focus( );
}
