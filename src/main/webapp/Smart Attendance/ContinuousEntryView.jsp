 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>


 
<%@ include file="index.jsp"%>
 
<html>
<head>

<title> :: ATTENDANCE ::</title>



<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/Attendance/ContinuousEntryAjax.js"></script>
<script language="javascript" src="../JavaScript/common/Staffloadsdependsoffice.js"></script>

<script language="javascript"> 
 
	 
function HEdit()
 	{					
	   obj = findObj("rowid");
		if(obj == null)
		{
			alert("No records  to edit...");
			return false;
		}
 	    var count;
		count=0; 				
		coffee1=document.forms[0].rowid;
		txt="";
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.frm.rowid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="AbsentEdit.jsp";			
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
	
 	} 



	
  function HDelete()
 	{		
		
		obj = findObj("rowid");
		if(obj == null)
		{
			alert("No records  to edit...");
			return false;
		}
		var count;
		count=0;
		coffee1=document.forms[0].rowid
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].rowid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				return true;			
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
	
	
	
	function EAdd()
 	{		
		document.frm.action="ContinuousEntry.jsp";		
 	}	
 	</script>
 
<style type="text/css">
<!--
.style3 {color: #000000}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadContinuousEntryDays('0')"   >
<form  AUTOCOMPLETE = "off"   method="get" name="frm"  >
<table width="100%" height="285" align="center">
	<tr>
		<td height="151" align="center"><br>
		<table width="90%" height="120" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle" >
				<td height="28"  
					class="tablehead"><span class="whiteMedium">CONTINUOUS ENTRY </span></td>
			</tr>
			<tr>
				<td height="31" align="center">
				<table width="46%" border="0" align="center" cellpadding="1"
					cellspacing="1" class="whiteMedium">
					<tr>
						<td    >Office</td>
						<td    >
						<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 String usertype=""+session.getAttribute("USRTYPE");  
			  %> <select name="Office" class="formText135" id="Office"
							tabindex="6" onBlur="LoadContinuousEntryDays('0')"  onChange="loadStaffName() ">
							 
							<option value="0">All</option>	
							<%
	String OfficeData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		out.println("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1]+"</option>");
 %>
	  </select><script language="javascript">setOptionValue('Office','<%=""+session.getAttribute("OFFICEID")%>')</script>
							</td>
						<td  >Staff </td>
						<td  >
						
<select name="staffid" class="formText135" id="staffid"  onBlur="LoadContinuousEntryDays('0') ">
<option value="0">All</option>
<%
 String empdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT  CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE   CHR_TYPE!='T' AND INT_OFFICEID= "+oficeid+" AND CHR_HOLD!='Y'  ORDER BY CHR_STAFFNAME ");
		for(int u=0; u<empdata.length; u++)
			out.print("<option value='"+empdata[u][0]+"'>"+empdata[u][1] +"</option>");
%>				
</select></td>
						<td  >Day</td>
						<td  ><select name="day" id="day"  onBlur="LoadContinuousEntryDays('0') ">
                            <option value="0">All</option>
                            <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                          </select>                        </td>
						<td    >Month </td>
						<td  >  <select name="month"
							id="month" onBlur="LoadContinuousEntryDays('0')"
							onChange="LoadContinuousEntryDays('0')">
							<%@ include file="../JavaScript/months.jsp"%>
						</select> </td>
						<td  > Year  </td>
						<td  > <select name="year"
							id="year" onBlur="LoadContinuousEntryDays('0')"
							onChange="LoadContinuousEntryDays('0')">
							<%@ include file="../JavaScript/years.jsp"%>
						</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1;
						var day=d.getDate()
						if(day<10) day="0"+day;
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);	
						setOptionValue('day',day);								
				//-->
          </script>  </td>
					</tr>
				</table>			  </td>
			</tr>
			<tr  >
				<td height="31" align="left" valign="middle" class="boldEleven"><table width="100%" border="0" class="whiteMedium"
					  >
                  <tr>
                    <td>S.No</td>
                    <td>Staff Id</td>
                    <td>Staff Name</td>
                    <td>Office</td>
                    <td>Date</td>
					<td>Day Type</td>
                  </tr>
                </table></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="28" valign="top">
				<div id="ContinuousTable" 	style="OVERFLOW: auto;width:100%;height:300px"></div><br>
					<div id="totRec"></div><br>				</td>
		</table>		</td>
	</tr>
	<tr>
	  <td height="17">&nbsp;</td>
  </tr>
	<tr>
		<td height="17"><input name="filename"
										type="hidden" id="filename" value="StafContinuousAttendance">
		<input name="actionS"
			type="hidden" id="actionS" value="ATTContinuousEntryDelete">
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('0')">All</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadContinuousEntryDays('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td height="17" align="center">    
  <tr>
	  <td height="17" align="center">
		<center>
		<table border="0" cellspacing="1" cellpadding="1">
			<tr>
				<td width="56"><input class="ButtonHead" name="submit2" type="submit" onClick=" EAdd()" value="Add"></td>
				
				<%
	  usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Delete" id="Delete" value="Delete"
					onClick="return HDelete()" /></td>
				<%
		}
		else
		{ 
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}


		%>

 				<td width="56"><input class="ButtonHead" type="Button" 	name="Button"  value="Close"   accesskey="c"  	onClick="redirect('AttendanceMain.jsp')"></td>
			<td width="56"><input class="buttonbold" name="Edit" id="Edit" 	type="hidden" onClick="return HEdit()" value="Edit"></td>
				</tr>
		</table>
	<tr>
		<td height="20"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>



<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>


