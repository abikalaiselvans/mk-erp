<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>


  
<script language="javascript" src="../JavaScript/comfunction.js"></script>

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

  
</head>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>


  
</head>
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 

<%
 
	 String cmpy=request.getParameter("company");
	String Office = request.getParameter("Office");
	String dept = request.getParameter("dept");
	String sorting = request.getParameter("sorting");
	String ss = request.getParameter("ss");
	String sql = "";
	
	 
	sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME ,a.CHR_STAFFFNAME , c.CHR_OFFICENAME,d.CHR_DEPARTNAME,e.CHR_DESIGNAME,  ";
	sql = sql +" a.CHR_GENDER , DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'),  LOWER(a.CHR_EMAILID),a.CHR_MOBILE    "; 
	sql = sql +" FROM com_m_staff a,com_m_bloodgroup b,com_m_office c,com_m_depart d,com_m_desig e  ";
	sql = sql +" WHERE a.CHR_TYPE!='T' AND a.CHR_HOLD !='Y'   ";
	sql = sql +" AND a.CHR_BG=b.INT_BLOODGROUPID  ";
	sql = sql +" AND a.INT_OFFICEID=c.INT_OFFICEID AND a.INT_DEPARTID= d.INT_DEPARTID AND a.INT_DESIGID = e.INT_DESIGID  ";
    if(!"0".equals(cmpy))
	 	sql = sql +" AND  a.INT_COMPANYID= "+cmpy;
	if(!"0".equals(Office))
	 	sql = sql +" AND  a.INT_OFFICEID= "+Office;
		 
	 if(!"0".equals(dept))
		 sql = sql +" AND  a.INT_DEPARTID= "+dept;
	sql = sql+"  ORDER BY "+ sorting +" "+ss;	 
	
	
	 String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 Vector mn = new Vector();
	 Vector child= null;
     for(int u=0; u<data.length;u++)
	 {
	     	child = new Vector();
			child.addElement((u+1));
			child.addElement(data[u][0]);
			child.addElement(data[u][1]);
			child.addElement(data[u][2]);
			child.addElement(data[u][3]);
			child.addElement(data[u][4]);
			child.addElement(data[u][5]);
			/*if("M".equals(data[u][5]))
				child.addElement("Married");
			else if("U".equals(data[u][5]))
				child.addElement("Un Married");
		 	 */
			child.addElement(data[u][6]);
			child.addElement(data[u][7]);
			child.addElement(data[u][8]);
			child.addElement(data[u][9]);
			mn.add(child);
     } 
 
	mn.add(child);
	request.setAttribute("table",mn);
	out.println("<br><center><h1>OFFICIAL INFORMATION</h1></center><br>"); 
	%>
	
	<display:table   id="_table" name="table"  pagesize="<%=data.length%>" export="true">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Empid" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Father Name" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Office" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Department" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Desigination" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Gender" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Date of Birth" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Mail id" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Mobile" sortable="true"><%=temp.elementAt(10)%></display:column>
					<%="<center>"%>
				 
					
					<display:setProperty name="export.csv.filename" value="Report.csv"/>
					<display:setProperty name="export.excel.filename" value="Report.xls"/>
					<display:setProperty name="export.xml.filename" value="Report.xml"/>
					<display:setProperty name="export.pdf.filename" value="Report.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					<%="</center>"%>
	</display:table> 
	
	<%
	
	  /*
	 out.println("<br><br><center><table width='100%' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>");
	 out.println("<tr  class='MRow1'><td class='boldEleven' colspan='15'><h3><center>OFFICIAL INFORMATION</center></h3></td></tr>");
	 out.println("<tr  class='MRow1'>");
	 out.println("<td class='boldEleven'><b>S.No</b></td>");
	 out.println("<td class='boldEleven'><b>Empid</b></td>");
	 out.println("<td class='boldEleven'><b>Name</b></td>");
	 out.println("<td class='boldEleven'><b>Father Name</b></td>");
	 out.println("<td class='boldEleven'><b>Office </b></td>");
	 out.println("<td class='boldEleven'><b>Department</b></td>");
	 out.println("<td class='boldEleven'><b>Desigination</b></td>");
	 out.println("<td class='boldEleven'><b>Gender</b></td>");
	 out.println("<td class='boldEleven'><b>Date of Birth</b></td>");
	 
	 
	 out.println("<td class='boldEleven'><b>Mail id</b></td>");
	 out.println("<td class='boldEleven'><b>Mobile</b></td>");
	 
	 for(int u=0; u<data.length;u++)
	 {
	 	if(u%2==0)
			out.println("<tr  class='MRow1'>");
		else
			out.println("<tr  class='MRow2'>");
			
		out.println("<td class='boldEleven'>"+(u+1));
		out.println("<td class='boldEleven'>"+data[u][0] +"</td>");
		out.println("<td class='boldEleven'>"+data[u][1] +"</td>");
		out.println("<td class='boldEleven'>"+data[u][2] +"</td>");
		out.println("<td class='boldEleven'>"+data[u][3] +"</td>");
		out.println("<td class='boldEleven'>"+data[u][4] +"</td>");
		out.println("<td class='boldEleven'>"+data[u][5] +"</td>");
		out.println("<td class='boldEleven'>"+data[u][6] +"</td>");
		out.println("<td class='boldEleven'>"+data[u][7] +"</td>");
		out.println("<td class='boldEleven'>"+data[u][8] +"</td>");
		out.println("<td class='boldEleven'>"+data[u][9] +"</td>");
		 
		out.println("</tr>");	
	 }	
	 out.println("</table></center>");*/
	 
%>

<br /><br />
<!--
<table width="184" align="center" cellpadding="15" cellspacing="0">
	<tr>
		<td width="100" height="44" class="boldEleven"><strong>Export
		</strong></td>
		<td class="boldEleven">
		<div align="center"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a>		</div>		</td>

		<td class="boldEleven">
		<div align="center"><a title="Text" href=javascript:;
			onClick="windowSave('report.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('report.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>		</td>
		
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('report.html')"><img
			src="../Image/report/IE.GIF" width="8" height="16" border="0"></a></div>		</td>
	<td class="boldEleven"><a href=javascript:redirect('AttendanceMain.jsp')>Close</a> </td>
	</tr>
</table>-->


<br />
 
									<center>	<a href='StaffOfficialInfo.jsp'> CLOSE</a></center>