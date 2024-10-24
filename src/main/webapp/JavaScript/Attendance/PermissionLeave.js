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

function loadPermissionLeave(startletter)
 {
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var office = document.getElementById('Office').value;  
    var day = document.getElementById('day').value;  
    var staffid = document.getElementById('staffid').value; 
    var leavetype = document.getElementById('leavetype').value; 
    var Status = document.getElementById('Status').value;  
    var url = "../attendance?actionS=PermissionLeave&month="+escape(mon)+"&year="+escape(yea)+"&startLetter=0&Office="+office+"&day="+day+"&staffid="+staffid+"&leavetype="+leavetype+"&Status="+Status+"&startletter="+startletter;
	initRequest(url);
    req.onreadystatechange = PermissionLeaveRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function PermissionLeaveRequest()
{
    if(req.readyState == 4) 
    {
         
        ClearTable('PermissionLeaveTable');  
    	ClearTabler('totRec');  
         if (req.status == 200) 
         {
          PermissionLeaveMessage();
         }
    }
}

function PermissionLeaveMessage() 
{	
    var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  
    for(loop=0; loop<batchs.childNodes.length; loop++)
     {
     
	    var batch = batchs.childNodes[loop];
        
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
        var EmpId = batch.getElementsByTagName("EmpId")[0];
        var EmpName = batch.getElementsByTagName("EmpName")[0];  
        var Date = batch.getElementsByTagName("Date")[0];  
        var Description = batch.getElementsByTagName("Description")[0];  
        var Reason = batch.getElementsByTagName("Reason")[0];  
        var Type = batch.getElementsByTagName("Type")[0];  
        var Sqldate = batch.getElementsByTagName("Sqldate")[0]; 
        var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue; 
        var ARDesc = batch.getElementsByTagName("ARDesc")[0];  
        var Mark = batch.getElementsByTagName("Mark")[0].childNodes[0].nodeValue; 
         
		var val="";
		var vl =EmpId.childNodes[0].nodeValue+"~"+Sqldate.childNodes[0].nodeValue+"~"+R;
		var R=Type.childNodes[0].nodeValue;		
		var R1=Description.childNodes[0].nodeValue;		
		 
		if(loop%2==0)
			str = str+"<tr class='MRow1'>";
		else
			str = str+"<tr class='MRow2'>";	
			
		str = str+"<td class='boldEleven'>"+(loop+1)+".</td>";
		str = str+"<td class='boldEleven'>"+ EmpId.childNodes[0].nodeValue;
		str = str+"<td class='boldEleven'>"+ EmpName.childNodes[0].nodeValue;       
		str = str+"<td class='boldEleven'>"+ Date.childNodes[0].nodeValue;       
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
		str = str+"<td class='boldEleven'>"+ val;       	
		str = str+"<td class='boldEleven'>"+ Reason.childNodes[0].nodeValue;       
		str = str+"<td class='boldEleven'>"+ Type.childNodes[0].nodeValue; 
		
		if(Status =="P")      
			str = str+"<td class='boldEleven'><font class='bolddeepred'>Pending</font></td>"; 
		else if(Status =="R")      
			str = str+"<td class='boldEleven'><font class='bolddeepred'>Rejected </font>&nbsp;&nbsp;&nbsp;"+ARDesc.childNodes[0].nodeValue+"</td>"; 
		else      
			str = str+"<td class='boldEleven'><font class='bold1'>Accepted </font> &nbsp;&nbsp;&nbsp;"+ARDesc.childNodes[0].nodeValue+"</td>"; 
		
		
		if(Mark == "N" && Status !="P")
			str = str+"<td class='boldEleven'><a  href=\"javascript:onClick=cancelLeave('../SmartLoginAuth?filename=StaffPermission&actionS=ATTStaffPermissionleaveGrantDelete&rowid="+Rowid+"') \"><font class='boldgreen'>Delete</font></a></td>";
		
		
		else
			str = str+"<td class='boldEleven'><font class='bolddeepred'>&nbsp;</font></td>";
     }
     str=str+"</table>";     
  	 var tb=document.getElementById('PermissionLeaveTable');
  	if(batchs.childNodes.length>0)
	 	tb.innerHTML=str  ; 
	 
  	tb=document.getElementById('totRec');
	tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
	
}


function cancelLeave(query)
{  
	
	var name=confirm("Are you Sure Confirm to Cancel")
	if (name==true)
		location = query;
		
}
