<%@ page language="java" 	import="java.sql.*" errorPage=""%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<html>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>


<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<link href="../DropDown - Image/msdropdown/dd.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../DropDown - Image/msdropdown/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../DropDown - Image/msdropdown/js/uncompressed.jquery.dd.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />


<title> :: ATTENDANCE ::</title>


  <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <script language="JavaScript">

//checkNull( "reportType","Select Export Type" ) 

function Validate()
  {
	
   	if(  
		checkNull("month","Select Month")
		&& checkNull("year","Select Year")
		&& checkNullSelect( "reportType","Select Export Type" ,'0') 
		
	  )
		return true;
	else
		return false;				
 } 	
</script>
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="390"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7" src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7" src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1" type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					<table width="324" border="0" align="center" cellpadding="2" cellspacing="2"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2"  class="BackGround">ATTENDANCE
							  <%
							String sunday[] = CommonFunctions.QueryExecute("SELECT FIND_A_SUNDAY(month(now()) , year(now()))")[0][0].split(",");
							String sql = " UPDATE att_t_register SET "; 
							for(int i=0;i<sunday.length;i++)
								sql = sql +" CHR_MORNING"+sunday[i]+" ='SUN' , CHR_EVENING"+sunday[i]+"='SUN' ,";
							sql = sql +" DT_UPDATEDATE=DATE(NOW()) WHERE CHR_MONTH =MONTHNAME(NOW())  AND  INT_YEAR = YEAR(NOW()) ";
							%>							</td>
						</tr>
						<tr class="boldEleven">
							<td height="35" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr class="boldEleven">
							<td height="35" valign="middle" class="boldEleven">Office</td>
							<td valign="top" class="boldEleven" >
							<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				String userid=""+session.getAttribute("USRID");
				String category=""+session.getAttribute("CATEGORY");
			  %> <select name="Office" class="formText135" id="Office" style="width:200px">
								<option value="0">All</option>
								
			<%
			String OfficeData[][] =  CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+ CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+userid+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		out.println("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1]+"</option>");
 %>
	  </select><script language="javascript">setOptionValue('Office','<%=oficeid%>')</script>							 </td>
						</tr>
						<tr class="boldEleven">
							<td height="35" valign="middle" class="boldEleven">Department</td>
							<td valign="top" class="boldEleven"><select name="dept"
								id="dept" class="formText135" style="width:200px"  >
								<option value="0">All</option>
								<%
		String sq="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME";
		String deptid[][] =  CommonFunctions.QueryExecute(sq);
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
							</select></td>
						</tr>
						<tr>
								  <td class="boldEleven">Category</td>
								  <td> 
<select name="Category" class="formText135" id="Category" style="width:200px">
<option value="0">All</option>
	<%
	String empcategoryData[][] = CommonFunctions.QueryExecute(" SELECT b.INT_EMPLOYEECATEGORYID,b.CHR_CATEGORYNAME FROM  com_m_employeecategory  b WHERE b.INT_EMPLOYEECATEGORYID IN("+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_GATEGORYLIST  FROM m_user a WHERE a.CHR_USRNAME='"+userid+"' ")[0][0]+" )");
 if(empcategoryData.length>0)
 	for(int u=0;u<empcategoryData.length;u++)
		out.println("<option value='"+empcategoryData[u][0]+"'>"+empcategoryData[u][1]+"</option>");
 %>
</select>
<script language="javascript">setOptionValue('Category','<%=category%>')</script> </td>
					  </tr>
						<tr class="boldEleven">
							<td width="132" height="35" valign="middle" class="boldEleven">Month<font
								color='red'>&nbsp;</font></td>
							<td width="268" valign="top" class="boldEleven"><select
								name="month"  id="month" class="formText135" style="width:200px">
								<option value="">Select Month</option>
								<option value="01">January</option>
								<option value="02">February</option>
								<option value="03">March</option>
								<option value="04">April</option>
								<option value="05">May</option>
								<option value="06">June</option>
								<option value="07">July</option>
								<option value="08">August</option>
								<option value="09">September</option>
								<option value="10">October</option>
								<option value="11">November</option>
								<option value="12">December</option>
							</select></td>
						</tr>
						<tr>
							<td class="boldEleven">Year</td>
						  <td><select name="year"  id="year" class="formText135">
								<option value="">Select Year</option>
								<%
			      for(int i=2000;i<=2050;i++)
			      {
			       out.println("<option value="+i+">"+i+"</option>");
			      }
			     %>
						</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script>						</tr>
<tr>
                <td width="39%" height="30" class="boldEleven">Export Type <font
																class="bolddeepred" align="absmiddle">*</font></td>
                <td width="61%" class="boldEleven"><script language="javascript" type="text/javascript">
	$(document).ready(function() 
	{
		try 
		{
			$("#reportType").msDropDown();
			
		} 
		catch(e) 
		{
				
		}
	}
	)
</script>
  <select name="reportType" id="reportType"  style="width:200px;">
    <option value="0" title="../DropDown - Image/icons/export.jpg" selected="selected">Export Type</option>
    <option value="csv" title="../DropDown - Image/icons/csv.jpg">CSV </option>
    <option value="xls" title="../DropDown - Image/icons/excel.jpg">Excel </option>
    <option value="html" title="../DropDown - Image/icons/html.jpg">Html </option>
    <option value="pdf" title="../DropDown - Image/icons/pdf.jpg">Pdf </option>
    <option value="rtf" title="../DropDown - Image/icons/rtf.jpg">Rtf </option>
    <option value="txt" title="../DropDown - Image/icons/txt.jpg">Txt </option>
    <option value="xml" title="../DropDown - Image/icons/xml.jpg">Xml </option>
  </select></td>
</tr>
               
              
              
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven"><input name="filename" type="hidden" id="filename"
										value="Rept_JStaffMonthwiseAttendance">
                  <input name="actionS"
										type="hidden" id="actionS"
										value="ATTRept_StaffMonthwiseAttendance">
                  <input name="rptfilename" type="hidden" id="rptfilename" value="StaffMonthwiseAttendance"></td>
              </tr> 
				
						<tr>
						  <td height="28" colspan="2" valign="middle" class="boldEleven">
							<table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="61"><input name="Submit2" type="submit"
										class="buttonbold" id="submit" value="Submit"   accesskey="s"   ></td>
									<td width="60"><input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="javascript:window.close()"></td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="2"></td>
							<td></td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
