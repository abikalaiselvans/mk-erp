 <%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
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


<title> :: ATTENDANCE ::</title>


<script language="javascript" src="../JavaScript/comfunction.js"></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   action="" method="post" name="frm" onSubmit="return validate()">
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="390"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					<table width="300" border="0" align="center" cellpadding="2" cellspacing="2"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2"  class="BackGround1">ATTENDANCE IN &amp; OUT</td>
						</tr>
						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td valign="top" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="boldEleven">Office <font
								color='red'>*</font></td>
							<td valign="top" class="bolddeepblue">
							<%
	   String branchid=""+session.getAttribute("BRANCHID");
	   String oficeid=""+session.getAttribute("OFFICEID");
	   String usertype=""+session.getAttribute("USRTYPE");
	   String userid=""+session.getAttribute("USRID");
	   String category=""+session.getAttribute("CATEGORY");
	   String departmenid=""+session.getAttribute("DEPARTID");
				 
			  %> <select name="Office" class="formText135" id="Office" style="width:150">
								<option value="Select" selected="selected">Select Office</option>
									
									<option value="0">All</option>
									<%
		 
			
	String OfficeData[][] = CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+userid+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		out.println("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1]+"</option>");
 %>
	  </select><script language="javascript">setOptionValue('Office','<%=oficeid%>')</script></td>
						</tr>
						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="boldEleven">Department <font
								color='red'>*</font></td>
							<td valign="top" class="bolddeepblue">
							<select name="dept" id="dept" class="formText135"  style="width:150" >
								<option value="Select" selected="selected">Select Department</option>
								<option value="0">All</option>
								<%
		
		String deptid[][] = CommonFunctions.QueryExecute("SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME");
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
							</select>
<script language="javascript">setOptionValue('dept','<%=departmenid%>')</script>							</td>
						</tr>
						<tr>
								  <td align="left" valign="top" class="boldEleven">Category <font
								color='red'>*</font></td>
								  <td align="left" valign="top"> 
<select name="Category" size="5" multiple="MULTIPLE"  class="formText135" id="Category" style="width:150">
<option value="0" selected="selected">All</option>
 
	<%
   
String empcategoryData[][] =  CommonFunctions.QueryExecute(" SELECT b.INT_EMPLOYEECATEGORYID,b.CHR_CATEGORYNAME FROM  com_m_employeecategory  b WHERE   b.INT_EMPLOYEECATEGORYID IN("+ CommonFunctions.QueryExecute("SELECT a.CHR_GATEGORYLIST  FROM m_user a WHERE a.CHR_USRNAME='"+userid+"' ")[0][0]+" )");
 if(empcategoryData.length>0)
 	for(int u=0;u<empcategoryData.length;u++)
		out.println("<option value='"+empcategoryData[u][0]+"'>"+empcategoryData[u][1]+"</option>");
 %>
</select>
<script language="javascript">setOptionValue('Category','<%=category%>')</script></td>
					  </tr>
						<tr class="bolddeepblue">
							<td width="132" height="24" valign="middle" class="boldEleven">Month <font
								color='red'>*</font></td>
							<td width="268" valign="top" class="bolddeepblue"><select
								name="month" id="month" class="formText135"  style="width:150">
								<option value="Select">Select Month</option>
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
							<td class="boldEleven">Year<font
								color='red'> *</font></td>
							<td><select name="year"  id="year" class="formText135"  style="width:150">
								<option value="Select">Select Year</option>
								<%
			      for(int i=2000;i<=2050;i++)
			      {
			       out.println("<option value="+i+">"+i+"</option>");
			      }
			     %>
							</select></td>
						</tr>
						 
						<tr>
						  <td class="boldEleven">Starting Date </td>
						  <td>
						  <select name="startingdate" id="startingdate">
						  <%
						  	for(int i=1;i<=27;i++)
								out.println("<option value='"+i+"'>"+i+"</option>");
						  %>
						  </select>						  					  </td>
					  </tr>
						<tr>
						  <td class="boldEleven">Ending Date </td>
						  <td><select name="endingdate" id="endingdate">
                            <%
						  	for(int i=1;i<=31;i++)
								out.println("<option value='"+i+"'>"+i+"</option>");
						  %>
                          </select>
						  
						  <script language='JavaScript' type="text/javascript">
				<!--			
					 
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						
						setOptionValue('month',month1);
						setOptionValue('year',year1);
						setOptionValue('startingdate',day);	
						setOptionValue('endingdate','31');	
												
				//-->
          </script>						  </td>
					  </tr>

						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table   border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									 
									<td width="70">
									<input name="Button" type="button" class="buttonbold" onClick=" View()"  value="View"></td>
									<td width="70"><input class="buttonbold" type="button" name="Submit"  value="Close"   accesskey="c"  onClick="redirect('AttendanceMain.jsp')"></td>
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
		<td>
		<div align="center" class="bolddeepred">

		<div align="center">
		<%
		String er=""+request.getParameter("er");
		if( "null".equals(er)  || "".equals(er))
			out.println();
		else
		{
			out.println("<h3>"+er+"</h3>");
			String rofficeid=request.getParameter("Office");
			String rdept = ""+request.getParameter("dept");
			String rmont=request.getParameter("month");
			String ryear=request.getParameter("year");
			String rCategory=request.getParameter("Category");
			String flag=request.getParameter("flag");
			String rr = "AttendanceProcessResponse.jsp?month="+rmont+"&year="+ryear+"&Office="+rofficeid+"&dept="+rdept+"&Category="+rCategory ;
			if("Y".equals(flag))
			{
				
			%>
			<script language="javascript">
				var name=confirm("<%=er%> Then Confirm to View the data....")
				if (name==true)
				{
					location = "<%=rr%>";
				}
			</script>
			<%
			}
			else
			{
			%>
			<script language="javascript">
				 alert("Check the Attendance , because <%=er%>");
			</script>
			<%
			}
		}
		
	%>
		</div>
		</div>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<script language="javascript">
	function View()
 	{		
		//AttendanceProcessResponse.jsp?month=10&year=2007&Office=0&dept=0
		
		if( 
			checkNullSelect('Office','Select Office','Select')
			&& checkNullSelect('dept','Select Department','Select')
			&& checkNullSelect('Category','Select Category','Select')
			&& checkNullSelect('month','Select month','Select')
			&& checkNullSelect('year','Select year','Select')
			
		  )
		  {
		
			var month= document.getElementById('month').value;
			var year= document.getElementById('year').value;
			var Office= document.getElementById('Office').value;
			var dept= document.getElementById('dept').value;
			var cat= document.getElementById('Category').value;
			var startingdate= parseInt(document.getElementById('startingdate').value);
			var endingdate= parseInt(document.getElementById('endingdate').value);
			if(startingdate<=endingdate)
			{
				var sql="AttendanceInandOutResponse.jsp?month="+month+"&year="+year+"&Office="+Office+"&dept="+dept+"&Category="+cat+"&startingdate="+startingdate+"&endingdate="+endingdate;
				window.location=sql;
			}
			else
			{
				alert("Kindly check the starting and ending date...");
			}	
		  	
		  }
		 
			
		 
		
 	}
	
	function  validate()
	{
		 
		if(document.getElementById('registercheck').checked)
		{
			
		}
		else
		{
			alert("The blanks are not considered");
		}
		
		if( 
			checkNullSelect('Office','Select Office','Select')
			&& checkNullSelect('dept','Select Department','Select')
			&& checkNullSelect('Category','Select Category','Select')
			&& checkNullSelect('month','Select month','Select')
			&& checkNullSelect('year','Select year','Select')
			
		  )
			return true;
		else
			return false;
	}
</script>



</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
