<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
 <%
try
{
%>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='ATT' ")[0][0]%></title>

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

 
 
<style type="text/css">
<!--
.style3 {color: #000000}
-->
</style>
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/Attendance/CommonHolidayAjax.js"></script>

<script language="javascript">
 </script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
 <%@ include file="indexhrm.jsp"%>

<table width="100%" height="285" align="center">
	<tr>
		<td height="151" align="center">
		
		<%
		String fromdt=request.getParameter("fromdt");
		String todt=request.getParameter("todt");
		String s="&fromdt="+fromdt+"&todt="+todt;
		fromdt=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdt);
		todt=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todt);
		String sql="";
		
		
		sql= " SELECT a.INT_CAREERID,a.CHR_NAME,a.CHR_FATHERNAME,DATE_FORMAT(a.CHR_DOB,'%d-%M-%Y'), ";
		sql = sql + "  a.CHR_GENDER,a.CHR_CURRENTLOCATION,a.CHR_INTERESTEDLOCATION, ";
		sql = sql + "  b.CHR_QUALIFICATIONNAME,a.CHR_AREAOFINTEREST,a.CHR_PREVIOUSDETAILS,a.CHR_DESCRIPTION, ";
		sql = sql + "  a.CHR_EMAIL,a.INT_MOBILE,a.INT_EXPERIENCE,a.CHR_APPLIEDPOST,a.CHR_REF, ";
		sql = sql + "  a.CHR_REFNUMBER,DATE_FORMAT(a.DAT_REGISTER,'%d-%M-%Y'),a.CHR_RESUMESTATUS,CHR_RESUMEVIEWSTATUS ";
		sql = sql + "  FROM com_m_careers a ,com_m_qualification b ";
		sql = sql + "  WHERE a.INT_QUALIFICATIONID=b.INT_QUALIFICATIONID ";
		sql = sql + "   AND   (a.DAT_REGISTER)  >='"+fromdt+"' AND  (a.DAT_REGISTER)  <='"+todt+"' ";
		sql = sql + "  ORDER BY a.DAT_REGISTER ";
		//out.println(sql); 
		String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			out.println("<br><br><br>");
			out.println("<table width='100%'  class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
			out.println("<tr class='MRow1'><td class='boldEleven' colspan=24 align='center'><b>RESUME DETAILS");
			out.println("<tr class='MRow2'><td class='boldEleven'><b>S.No");
			out.println("<td class='boldEleven'><b>Care ID");
			out.println("<td class='boldEleven'><b>Name");
			out.println("<td class='boldEleven'><b>Father ");
			out.println("<td class='boldEleven'><b>DOB");
			out.println("<td class='boldEleven'><b>Gender");
			out.println("<td class='boldEleven'><b>Current Location");
			out.println("<td class='boldEleven'><b>Preferred Location");
			out.println("<td class='boldEleven'><b>Qualification");
			out.println("<td class='boldEleven'><b>Area Of Interest");
			out.println("<td class='boldEleven'><b>Previous Details");
			out.println("<td class='boldEleven'><b>Description");
			out.println("<td class='boldEleven'><b>Email");
			out.println("<td class='boldEleven'><b>Mobile");
			out.println("<td class='boldEleven'><b>Experience");
			out.println("<td class='boldEleven'><b>Applied Post");
			out.println("<td class='boldEleven'><b>Reference");
			out.println("<td class='boldEleven'><b>Ref. Number");
			out.println("<td class='boldEleven'><b>Date of Reg.");
			out.println("<td class='boldEleven'><b>Status");
			out.println("<td class='boldEleven'>&nbsp;");
			out.println("<td class='boldEleven'>&nbsp;");
			//out.println("<td class='boldEleven'>&nbsp;");
			
			for(int u=0;u<data.length;u++)
			{
				if(u%2==0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");
					
			out.println("<td class='boldEleven'>"+(u+1));
			out.println("<td class='boldEleven'>"+data[u][0]);
			out.println("<td class='boldEleven'>"+data[u][1]);
			out.println("<td class='boldEleven'>"+data[u][2]);
			out.println("<td class='boldEleven'>"+data[u][3]);
			out.println("<td class='boldEleven'>"+data[u][4]);
			out.println("<td class='boldEleven'>"+data[u][5]);
			out.println("<td class='boldEleven'>"+data[u][6]);
			out.println("<td class='boldEleven'>"+data[u][7]);
			out.println("<td class='boldEleven'>"+data[u][8]);
			out.println("<td class='boldEleven'>"+data[u][9]);
			out.println("<td class='boldEleven'>"+data[u][10]);
			out.println("<td class='boldEleven'>"+data[u][11]);
			out.println("<td class='boldEleven'>"+data[u][12]);
			out.println("<td class='boldEleven'>"+data[u][13]);
			out.println("<td class='boldEleven'>"+data[u][14]);
			out.println("<td class='boldEleven'>"+data[u][15]);
			out.println("<td class='boldEleven'>"+data[u][16]);
			out.println("<td class='boldEleven'>"+data[u][17]);
			
			if("Y".equals(data[u][19]))
				out.println("<td class='boldEleven'>Resume Viewed");
			else
				out.println("<td class='boldEleven'>Resume Not Viewed <a href='../SmartLoginAuth?filename=AttendanceProcess&actionS=ATTCareersClosed&id="+data[u][0]+s+"'>Close</a>");
			
			if("Y".equals(data[u][18]))
				out.println("<td class='boldEleven'><a href='../CareersResume/"+data[u][0]+".doc' target='blank'><img src='../Image/report/MS.GIF' border='0' /></a>");
			else
				out.println("<td class='boldEleven'>Resume not upload");
				
			out.println("<td class='boldEleven'><a href='../CareerProfiles?myid="+data[u][0]+"' target='_blank' >Download Resume</a>");
			//out.println("<td class='boldEleven'>&nbsp;");
							
			}
			out.println("</table>");
			
			%>
			<table width="184" align="center" cellpadding="15" cellspacing="0">
	<tr>
		<td width="100" height="44" class="boldEleven"><strong>Export
		</strong></td>
		<td class="boldEleven">
		<div align="center"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a>
		</div>
		</td>

		<td class="boldEleven">
		<div align="center"><a title="Text" href=javascript:;
			onClick="windowSave('resumedetails.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('resumedetails.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('resumedetails.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
		</td>

	</tr>
</table>
			<%
		}
		else
		{
			out.println("<br><br><br><center><font class=bolddeepred>Resume not found...</font></center>");
		}
 
  
		%> 
		 
		</td>
	</tr>
	<tr>
		<td height="17">  </td>
	</tr>
	<tr>
		<td height="17" align="center">
		 
		<tr>
		<td height="20"></td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
<%
}
catch(Exception e)
{
}
%>
