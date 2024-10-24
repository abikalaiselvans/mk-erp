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

 function LoadScheduleEntrystaff(startLetter)
 {
 	var calltype = document.getElementById('calltype').value;
 	var day = document.getElementById('day').value;
 	var status =document.getElementById('status').value;
	
 	var month =document.getElementById('month').value;
 	var year =document.getElementById('year').value;
	var customer =document.getElementById('customer').value;
	var url = "../StaffCommon?actionS=LoadScheduleEntrystaff&startLetter="+escape(startLetter)+"&day="+day+"&month="+month+"&year="+year+"&customer="+customer+"&calltype="+calltype+"&status="+status;
   	initRequest(url);
	req.onreadystatechange=LoadScheduleEntryRequeststaff;
    req.open("GET", url, true);
    req.send(null);
}
 
 function LoadScheduleEntryRequeststaff() 
 {
	if(req.readyState == 4) 
    {    	
		ClearTabler('totalrec');
	    ClearTable('GroupTable');
		if (req.status == 200) 
        {		  	
          	var tb=document.getElementById('GroupTable');
		  	tb.innerHTML="<font class='bolddeepred'> Loading Data</font>";
			LoadScheduleEntryMessagesstaff();
        }
    }
}

function LoadScheduleEntryMessagesstaff() 
{	 
    var batchs = req.responseXML.getElementsByTagName("RowsSStaff")[0];   
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
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
		var F = batch.getElementsByTagName("F")[0].childNodes[0].nodeValue;	
		 
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";

	    if(Status == "Y")
			str=str+"<td  class='boldEleven' width='5%'>"+(loop+1)+"</td>";
		else
			str=str+"<td  class='boldEleven' width='5%'><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1)+"</td>";
			
		str=str+"<td  class='boldEleven' width='12%'>&nbsp; "+Name +"</td>";
		str=str+"<td  class='boldEleven' width='13%'>&nbsp;"+Calltype+"</td>";
		str=str+"<td  class='boldEleven' width='13%'>&nbsp;"+SDate+"</td>";
		str=str+"<td  class='boldEleven' width='13%'>&nbsp;"+EDate+"</td>";
		
		if(Status == "Y")
			str=str+"<td  class='boldEleven' width='5%'><font class='boldgreen'>Closed</font></td>";
		else
			str=str+"<td  class='boldEleven' width='5%'><font class='bolddeepred'>Pending</font></td>";
		
		if(Next =="Y")
			str=str+"<td  class='boldEleven' width='10%'> Follows on"+followon+"</td>";
		else
			str=str+"<td  class='boldEleven' width='10%'>&nbsp;</td>";
		
		str=str+"<td   class='boldEleven' align='center'><a href=\"javascript:SFAUpload('"+Id+"')\"><font class=boldgreen>Upload </font></a>" ;
		
		if(F =="Y")
			str=str+"<td width='200' class='boldEleven' align='center'><a target='_blank' href='../SFA/"+Id+".pdf' download='"+Id+".pdf' ><font class='boldgreen'>Download</font></a> ";
		else
			str=str+"<td  class='boldEleven' width='10%'>&nbsp;</td>";
		

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