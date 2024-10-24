<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
   
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%><head>
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
<title> :: ATTENDANCE ::</title>


  


  
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
<%
 
	 
	String cmpy=request.getParameter("company");
	String Office = request.getParameter("Office");
	String dept = request.getParameter("dept");
	String month = request.getParameter("month");
	String year = request.getParameter("year");
	String umonth=DateUtil.getMonth(Integer.parseInt(month));
	String reportheader=" <b> Late Comers Report For </b> "+umonth+"-"+year;
	String sorting = request.getParameter("sorting");
	String ss = request.getParameter("ss");
	String sql="SELECT  a.CHR_EMPID ,b.CHR_STAFFNAME,a.INT_LATE  ";
	sql = sql+" From att_t_register a, com_m_staff b ";
	sql = sql+" WHERE a.CHR_EMPID = b.CHR_EMPID   AND a.INT_YEAR="+year+"";
	sql=sql+"   AND a.INT_LATE>0  ";
	if(!"0".equals(cmpy))
		sql=sql+" AND b.INT_COMPANYID= "+cmpy;
	
	if(!"0".equals(Office))	
		sql=sql+"  AND b.INT_OFFICEID= "+Office;
	
	if(!"0".equals(dept))
		sql=sql+"   AND b.INT_DEPARTID= "+dept;
	
	sql = sql+" AND a.CHR_MONTH ='"+umonth+"' ORDER BY "+ sorting +" "+ss;
	
	
	 
	
		
	 
	 if(!"0".equals(cmpy))
		reportheader=" <b>Company ::</b> "+CommonFunctions.QueryExecute("SELECT CHR_COMPANYNAME FROM  com_m_company  WHERE INT_COMPANYID="+cmpy)[0][0];
	else
		reportheader=" <b>Company ::</b> ALL ";
	
	if(!"0".equals(Office))
		reportheader=reportheader+" <b>Office ::</b> "+CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME FROM   com_m_office   WHERE INT_OFFICEID="+Office)[0][0];
	else
		reportheader=reportheader+" <b>Office ::</b> ALL ";
	
	
	if(!"0".equals(dept))
		reportheader=reportheader+" <b>Department ::</b> "+CommonFunctions.QueryExecute("SELECT CHR_DEPARTNAME FROM  com_m_depart  WHERE INT_DEPARTID="+dept)[0][0];
	else
		reportheader=reportheader+" <b>Department ::</b> ALL ";
	
	 
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
			mn.add(child);
     } 
   
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3>"+reportheader+"</h3></center><br>");	
	 
	
%>
 
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="ID" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="NAME" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="LATE" sortable="true"><%=temp.elementAt(3)%></display:column>
					 
					
		 
					 
				 
					<display:setProperty name="export.csv.filename" value="AbsentList.csv"/>
					<display:setProperty name="export.excel.filename" value="AbsentList.xls"/>
					<display:setProperty name="export.xml.filename" value="AbsentList.xml"/>
					<display:setProperty name="export.pdf.filename" value="AbsentList.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table> 
		

<%		
		
		/*
		 
		String sql="SELECT  a.CHR_EMPID ,b.CHR_STAFFNAME,a.INT_LATE, ";
		String header="";
		
		header = header+"Empid,Name,No Of Late,";
		
		
		sql=sql.trim();
		sql = sql.substring(0,sql.length()-1);	
						
		 sql = sql+" From att_t_register a, com_m_staff b ";
		 sql = sql+" WHERE a.INT_YEAR="+year+" AND a.CHR_EMPID = b.CHR_EMPID";
		 sql=sql+" "+dep+"  "+off+" "+cmp+" AND a.INT_LATE>0  ";
		 sql = sql+" AND a.CHR_MONTH ='"+umonth+"' ORDER BY "+ sorting +" "+ss;
		 
		 String data[][] =com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
		 String head[] = header.split(",");
		 out.println("<table align='center'><tr><td align='center'>"+reportheader+"</td></tr></table>");
		 out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC'  align='center'>");
		 out.println("<tr class='MRow1'><td class='boldEleven'><b>S.No");
		 for(int y=0;y<head.length;y++)
		  	out.println("<td class='boldEleven'><b>"+head[y]+"</b></td>");
		 for(int u=0; u<data.length;u++)
		 {
		 	if(u%2==0)
				out.println("<tr  class='MRow1'>");
			else
				out.println("<tr  class='MRow2'>");
			out.println(" <td class='boldEleven'>"+(u+1));
			for(int x=0;x<head.length;x++)
				out.println("<td class='boldEleven'>"+data[u][x]);
			out.println("</tr>");	
		 }	
		 out.println("</table>");
		 */
		 
		 
%>

	 
  
     

<br />
 
									<center>	<a href='LateComersMonth.jsp'> CLOSE</a></center>

