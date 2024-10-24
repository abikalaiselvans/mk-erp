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

function loadPermissionLeaveRegisterMark(startletter)
 {
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var office = document.getElementById('Office').value;  
    var day = document.getElementById('day').value;  
    var staffid = document.getElementById('staffid').value; 
    var leavetype = document.getElementById('leavetype').value; 
    var Status = document.getElementById('Status').value;  
    var url = "../attendance?actionS=loadPermissionLeaveRegisterMark&month="+escape(mon)+"&year="+escape(yea)+"&startLetter=0&Office="+office+"&day="+day+"&staffid="+staffid+"&leavetype="+leavetype+"&Status="+Status+"&startletter="+startletter;
	initRequest(url);
    req.onreadystatechange = loadPermissionLeaveRegisterMarkRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function loadPermissionLeaveRegisterMarkRequest()
{
    if(req.readyState == 4) 
    {
         
        ClearTable('PermissionLeaveTable');  
    	ClearTabler('totRec');  
         if (req.status == 200) 
         {
        	 loadPermissionLeaveRegisterMarkMessage();
         }
    }
}

function loadPermissionLeaveRegisterMarkMessage() 
{	
    var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  
    str = str+"<tr class='MRow1'>";
    str = str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Employee ID</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Name</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Date</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Description</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Permission /Leave</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Status</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Mark</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Marking Status</b></td>";
    str = str+"</tr>";
    
    for(loop=0; loop<batchs.childNodes.length; loop++)
     {
     
	    var batch = batchs.childNodes[loop];
        
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
        var EmpId = batch.getElementsByTagName("EmpId")[0].childNodes[0].nodeValue;
        var EmpName = batch.getElementsByTagName("EmpName")[0].childNodes[0].nodeValue;  
        var Date = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;  
        var Description = batch.getElementsByTagName("Description")[0].childNodes[0].nodeValue;  
        var Reason = batch.getElementsByTagName("Reason")[0].childNodes[0].nodeValue;  
        var Type = batch.getElementsByTagName("Type")[0].childNodes[0].nodeValue;  
        var Sqldate = batch.getElementsByTagName("Sqldate")[0].childNodes[0].nodeValue; 
        var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue; 
        var ARDesc = batch.getElementsByTagName("ARDesc")[0].childNodes[0].nodeValue;
        var Mark = batch.getElementsByTagName("Mark")[0].childNodes[0].nodeValue;
        var MarkStatus = batch.getElementsByTagName("MarkStatus")[0].childNodes[0].nodeValue;
        
        
		var val="";
		var vl =EmpId+"~"+Sqldate+"~"+R;
		var R=Type;		
		var R1=Description;		
		 
		if(loop%2==0)
			str = str+"<tr class='MRow1'>";
		else
			str = str+"<tr class='MRow2'>";	
			
		if(Mark =="N")
			str = str+"<td class='boldEleven'><input name='rowid' id='rowid' type='checkbox' value='"+Rowid+"'/>&nbsp;"+(loop+1)+"</td>";
		else
			str = str+"<td class='boldEleven'>"+(loop+1)+".</td>";
		
		str = str+"<td class='boldEleven'>"+ EmpId+ "</td>";
		str = str+"<td class='boldEleven'>"+ EmpName+ "</td>";      
		str = str+"<td class='boldEleven'>"+ Date;       
		if (R == "PERMISSION")
		{
			var sh = R1.split("~");
			var sh1= sh[0];
			if(sh1=="PFD")
				val="&nbsp;Full Day&nbsp;";
			if(sh1=="PFN")
				val="&nbsp;Fore Noon&nbsp;";
			if(sh1=="PAN")
				val="&nbsp;After Noon&nbsp;";
			val = val +"&nbsp;In Time   : "+sh[1]+"<br>&nbsp;Out Time : "+sh[2];	
		}
		
		if (R == "LEAVE")
		{
			var sh = R1.split("~");
			var sh1= sh[0];
			var lname="";
			if(sh1 == "P" )
				lname="Privelege Leave";
			if(sh1 == "C" )
				lname="Casual Leave";
			if(sh1 == "" )
				lname="Sick Leave";
			if(sh1 == "M" )
				lname="Maternity Leave";
			if(sh1 == "A" )
				lname="Accident Leave";
			if(sh1 == "O" )
				lname="Others";
			val="<table width='100%'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' ><tr class='MRow1'><td class='boldEleven'>Leave : <td class='boldEleven'>"+lname;
			val=val +"<tr class='MRow2'><td class='boldEleven'>Day<td class='boldEleven'>"+sh[1];
			val=val +"</table>";
		}
		str = str+"<td class='boldEleven'>"+ val + "</td>";       	
		    
		str = str+"<td class='boldEleven'>"+ Type+ "</td>"; 
		str = str+"<td class='boldEleven'>"+ Status+ "</td>";
		
		
		
		if(Mark =="N")      
			str = str+"<td class='boldEleven'><font class='bolddeepred'>Pending</font></td>"; 
		else     
			str = str+"<td class='boldEleven'><font class='boldgreen'>Marked </font></td>";
		
		str = str+"<td class='boldEleven'><font class='boldgreen'>"+MarkStatus+"</font></td>"; 
		 
		
     }
     str=str+"</table><br>";     
  	 var tb=document.getElementById('PermissionLeaveTable');
  	if(batchs.childNodes.length>0)
	 	tb.innerHTML=str  ; 
	 
  	tb=document.getElementById('totRec');
	tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
	
}
