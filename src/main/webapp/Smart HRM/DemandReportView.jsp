
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
  
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
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
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<title>:: HRM ::</title>

 


 
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
<%
try
{
%>
<%!
	String stateName,stateId;
	String districtName,districtDes,districtId;
	String actionStu;
%>
 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/HRM/HrmAjax.js"></script>
<body  onpaste="return false;"  >
 
 <%
	String grade=request.getParameter("grade");
	String year=request.getParameter("Year");
	String office=request.getParameter("office");
	String sql=" ";
	sql = " SELECT a.INT_JOBDEMANDID,a.CHR_JOBGRADE,b.CHR_JOBCODE,b.CHR_JOBTITLE,c.CHR_OFFICENAME, ";
	sql = sql + " DATE_FORMAT(a.DAT_REGISTERDATE,'%d-%m-%Y'), "; 
 	sql = sql + " MONTHNAME(a.DAT_REGISTERDATE),YEAR(a.DAT_REGISTERDATE), ";
 	sql = sql + " a.INT_DEMAND  FROM hrm_m_jobdemand a,hrm_m_jobdesign b,com_m_office c  "; 
	sql = sql + "  WHERE a.INT_JOBID=b.INT_JOBID AND a.INT_OFFICEID= c.INT_OFFICEID "; //AND a.CHR_STATUS='Y' 
	sql = sql + " AND YEAR(a.DAT_REGISTERDATE) = "+year;
	if(!"0".equals(grade))
	 	sql = sql + " AND a.CHR_JOBGRADE='"+grade+"'";
	if(!"0".equals(office))
	 	sql = sql + " AND a.INT_OFFICEID = "+office ;
	
	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
		 
Vector mn = new Vector();
Vector child= null;

for(int u=0;u<data.length;u++)
{
		
		child = new Vector();
		child.addElement((u+1));
		child.addElement(data[u][1].trim() );
		child.addElement(data[u][2].trim() );
		child.addElement(data[u][3].trim() );
		child.addElement(data[u][4].trim() );
		child.addElement(data[u][5].trim() );
		child.addElement(data[u][6].trim() );
		child.addElement(data[u][7].trim() );
		child.addElement(data[u][8].trim() );

		mn.add(child);  

}  
	 
	 
	 
	 
	 
   
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> <b> DEMAND REPORTS FOR THE YEAR - "+year+"  </h3></center><br>");
 
  

 




/*
	if(data.length>0)
	{
		out.println("<center>");
		out.println("<table width='60%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1'> <td class='boldEleven' colspan='12' align='center'><b> DEMAND REPORTS FOR THE YEAR - "+year+"</b></td>");
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven'><b>S.No</b></td>");
		out.println("<td class='boldEleven'><b>GRADE</b></td>");
		out.println("<td class='boldEleven'><b>CODE</b></td>");
		out.println("<td class='boldEleven'><b>TITLE</b></td>");
		out.println("<td class='boldEleven'><b>OFFICE</b></td>");
		out.println("<td class='boldEleven'><b>DATE</b></td>");
		out.println("<td class='boldEleven'><b>MONTH</b></td>");
		out.println("<td class='boldEleven'><b>YEAR</b></td>");
		out.println("<td class='boldEleven'><b>DEMAND (Nos) </b></td>");
		out.println("</tr>");
		for(int u=0;u<data.length;u++)
		{
			if(u%2==0)
				out.println("<tr class='MRow1'>");	
			else
				out.println("<tr class='MRow2'>");	
			out.println("<td class='boldEleven'>"+(u+1)+"</b>");
			out.println("<td class='boldEleven'>"+data[u][1]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][2]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][3]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][4]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][5]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][6]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][7]+"</td>");
			out.println("<td class='boldEleven' align='right'>"+data[u][8]+"</td>");
			out.println("</tr>");
		}
		
		out.println("</table>");
		out.println("</center>");
		
	}	*/
	
	%>
	 
	
 
<display:table   id="_table" name="table"   export="true" pagesize="25">

	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title=" Sl.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="GRADE" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="CODE" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="TITLE" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="OFFICE " sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title=" DATE" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="MONTH" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="YEAR" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="DEMAND (Nos)" sortable="true"><%=temp.elementAt(8)%></display:column>
					 
			   
					 
					<display:setProperty name="export.csv.filename" value="DemandReport.csv"/>
					<display:setProperty name="export.excel.filename" value="DemandReport.xls"/>
					<display:setProperty name="export.xml.filename" value="DemandReport.xml"/>
					<display:setProperty name="export.pdf.filename" value="DemandReport.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>          
		
		<br />	<center>	<a href='DemandReport.jsp'> CLOSE</a></center>



</body>
</html>
<%
}
catch(Exception e)
{
}
%>
