<%@ page  language="java" 	import="java.sql.*" errorPage=""%>
 <html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title> :: ATTENDANCE ::</title>


 
 <link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css" />
</head>
<script language="javascript" src="../JavaScript/comfunction.js" /></script>

<script language="javascript">

	function Add()
	{ 
		document.frm.action="ForceLeaveandPermission.jsp";
 	}

</script> 


<script language="javascript"  >
var isIE;
var req;
var names;


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




function StaffloadPermissionLeave(startletter)
{
 
     
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var day = document.getElementById('day').value;  
    var leavetype = document.getElementById('leavetype').value; 
    var Status = document.getElementById('Status').value;  
    var url = "../attendance?actionS=ForceLeaveandPermission&month="+escape(mon)+"&year="+escape(yea)+"&Status="+Status+"&day="+day +"&leavetype="+leavetype+"&startletter="+startletter;
	initRequest(url);
    req.onreadystatechange = StaffPermissionLeaveRequest;
    req.open("GET", url, true);
    req.send(null);
     
} 
 
 
 function StaffPermissionLeaveRequest()
{
    if(req.readyState == 4) 
    {
         ClearTable('PermissionLeaveTable');  
    	 ClearTabler('totRec'); 
         if (req.status == 200) 
         {
          StaffPermissionLeaveMessage();
         }
    }
}

function StaffPermissionLeaveMessage() 
{	
    var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  
    str = str+"<tr class='MRow1'>";
    str = str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Emp ID</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Emp Name</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Date</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Details</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Description</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Type</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Status</b></td>";
    str = str+"<td class='boldEleven' align='center'><b>Delete</b></td>";
    for(loop=0; loop<batchs.childNodes.length; loop++)
     {
     
	    var batch = batchs.childNodes[loop];
        
        var Rowid = batch.getElementsByTagName("Rowid")[0];
        var EmpId = batch.getElementsByTagName("EmpId")[0];
        var EmpName = batch.getElementsByTagName("EmpName")[0];  
        var Date = batch.getElementsByTagName("Date")[0];  
        var Description = batch.getElementsByTagName("Description")[0];  
        var Reason = batch.getElementsByTagName("Reason")[0];  
        var Type = batch.getElementsByTagName("Type")[0];  
        var Sqldate = batch.getElementsByTagName("Sqldate")[0]; 
        var Status = batch.getElementsByTagName("Status")[0]; 
         
		var val="";
		var vl =EmpId.childNodes[0].nodeValue+"~"+Sqldate.childNodes[0].nodeValue+"~"+R;
		var R=Type.childNodes[0].nodeValue;		
		var R1=Description.childNodes[0].nodeValue;		
		 
		if(loop%2==0)
			str = str+"<tr class='MRow1'>";
		else
			str = str+"<tr class='MRow2'>";	
			
		str = str+"<td width=6 valign='top' >"+(loop+1)+".</td>";
		str = str+"<td class='boldEleven'>"+ EmpId.childNodes[0].nodeValue+"</td>";
		str = str+"<td class='boldEleven'>"+ EmpName.childNodes[0].nodeValue+"</td>";       
		str = str+"<td class='boldEleven'>"+ Date.childNodes[0].nodeValue+"</td>";       
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
		
		if(Status.childNodes[0].nodeValue =="P")      
			str = str+"<td class='boldEleven'><font class='bolddeepred'>Pending</font></td>"; 
		else if(Status.childNodes[0].nodeValue =="R")      
			str = str+"<td class='boldEleven'><font class='bolddeepred'>Rejected </font></td>"; 
		else      
			str = str+"<td class='boldEleven'><font class='bold1'>Accepted </font></td>"; 
		
		
		if(Status.childNodes[0].nodeValue =="P") 
			str = str+"<td class='boldEleven'><a href='../SmartLoginAuth?filename=ForceLeavePermission&actionS=ATTForceLeaveandPermissionDelete&rowid="+Rowid.childNodes[0].nodeValue+"'>Delete</a></td>"; 
		else
			str = str+"<td class='boldEleven'>&nbsp;</td>"; 
     }
     str=str+"</table>";     
  	 var tb=document.getElementById('PermissionLeaveTable');
  	 if(batchs.childNodes.length>0)
	 	tb.innerHTML=str  ; 
	 
	 tb=document.getElementById('totRec');
 	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
 	
          
}


</script>
 
<body  onpaste="return false;" onLoad="StaffloadPermissionLeave('0')">
<jsp:include page="index.jsp" />
<form  AUTOCOMPLETE = "off"   name="frm" method="get" action="">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="90%" height="177" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle" >
			  <td  height="28" ><span class="whiteMedium"  >FORCE PERMISSION / LEAVE  </span></td>
		  </tr>
			<tr align="center" valign="middle"   background="">
			  <td height="28" class="tablehead"><table width="90%" border="0" cellpadding="5" cellspacing="0" class="whiteMedium">
                <tr>
                   
						
						<td  >Month</td>
						<td><span class="boldThirteen"> <select name="month" class="formText135"
							id="month"  onBlur="StaffloadPermissionLeave('0' ) ">
							<%@ include file="../JavaScript/months.jsp"%>
						</select> </span></td>
						<td  >Year</td>
						<td><span class="boldThirteen"> <select name="year" class="formText135"
							id="year"  onBlur="StaffloadPermissionLeave('0') ">
							<%@ include file="../JavaScript/years.jsp"%>
						</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script> </span></td>
					    <td  >Day</td>
					    <td>
						<select name="day" id="day"  onBlur="StaffloadPermissionLeave('0') ">
					    <option value="0">All</option>
						<%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
						</select>					    </td>
					    <td  >Type </td>
					    <td><select name="leavetype" id="leavetype"  onBlur="StaffloadPermissionLeave('0') ">
						<option value="0">All</option>
						<option value="PERMISSION">PERMISSION</option>
						<option value="LEAVE">LEAVE</option>
						
						 
						 
						  </select>					    </td>
						  <td  >Status</td>
                              <td><select name="Status" id="Status"    onblur="StaffloadPermissionLeave('0')">
                                <option value="0">All</option>
                                <option value="P">PENDING</option>
                                <option value="A">ACCEPTED</option>
								<option value="R">REJECTED</option>
                              </select></td>
                </tr>
              </table></td>
		  </tr>
			 
			<tr bgcolor="#FFFFFF">
			  <td valign="top">
			  <div id="PermissionLeaveTable" style="OVERFLOW: auto;width:100%;height:250px">			  </div><br>
			  <div id="totRec"></div>			  			  </td>
		  </tr>
			<tr>
				<td valign="top">				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('0')">All</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('A')">A</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('B')">B</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('C')">C</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('D')">D</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('E')">E</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('F')">F</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('G')">G</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('H')">H</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('I')">I</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('J')">J</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('K')">K</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('L')">L</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('M')">M</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('N')">N</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('O')">O</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('P')">P</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('Q')">Q</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('R')">R</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('S')">S</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('T')">T</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('U')">U</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('V')">V</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('W')">W</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('X')">X</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('Y')">Y</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:StaffloadPermissionLeave('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="1" cellspacing="1">
			<tr>
			  <td width="56"><input type="submit"	class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
			  <td width="56"><input class="ButtonHead" type="button"
					name="Button" id="Button"  value="Close"   accesskey="c" 
					onclick="redirect('AttendanceMain.jsp')"></td>
			</tr>
		</table>		</td>
	</tr>
	
	<tr>
		<td><jsp:include page="../footer.jsp" /></td>
	</tr>
</table>
</form>

</body>
</html>
