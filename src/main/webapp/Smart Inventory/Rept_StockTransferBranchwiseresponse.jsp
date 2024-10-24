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
 <script language="javascript" src="../JavaScript/comfunction.js"></script><title>:: INVENTORY ::</title> 


 
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" ></script>
 	
<body >
 		<%
	try
	{	
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		String frombranch = request.getParameter("frombranch");
		String tobranch = request.getParameter("tobranch");
		fromdate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate);
	 	todate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
		String daterange= request.getParameter("daterange");
		String division = request.getParameter("division");
		String sqldaterange="";
		String dateheader="";
		if("Y".equals(daterange))
		{
			sqldaterange=" AND a.DAT_TRANSFERDATE >='"+fromdate+"' AND a.DAT_TRANSFERDATE<='"+todate+"' ";
			dateheader = "( "+ fromdate +" - " + todate +" )";
		}	
		String sqldivision="";
		if(!"0".equals(division))
			sqldivision=" AND a.INT_DIVIID="+division;
		
	 	String sql="";
		sql="SELECT a.CHR_STOCKTRANSFERID, ";
		sql=sql+" a.INT_BRANCHID_FROM, ";
		sql=sql+" (Select c.CHR_BRANCHNAME from  com_m_branch  c  ,com_m_company d where  c.INT_COMPANYID = d.INT_COMPANYID AND  ";
		sql=sql+" c.INT_BRANCHID = a.INT_BRANCHID_FROM) ,  ";
		sql=sql+" (Select d.CHR_COMPANYNAME from  com_m_branch  c  ,com_m_company d where  c.INT_COMPANYID = d.INT_COMPANYID AND ";
		sql=sql+" c.INT_BRANCHID = a.INT_BRANCHID_FROM) , ";
		sql=sql+" a.INT_BRANCHID_TO, ";
		sql=sql+" (Select c.CHR_BRANCHNAME from  com_m_branch  c  ,com_m_company d where  c.INT_COMPANYID = d.INT_COMPANYID AND ";
		sql=sql+" c.INT_BRANCHID = a.INT_BRANCHID_TO) , ";
		sql=sql+" (Select d.CHR_COMPANYNAME from  com_m_branch  c  ,com_m_company d where  c.INT_COMPANYID = d.INT_COMPANYID AND ";
		sql=sql+" c.INT_BRANCHID = a.INT_BRANCHID_TO) , ";
		sql=sql+" (SELECT b.CHR_DIVICODE FROM inv_m_division b WHERE b.INT_DIVIID=a.INT_DIVIID), ";
		sql=sql+" date_format(a.DAT_TRANSFERDATE,'%d-%m-%Y'),a.CHR_TRANSFERBY,date_format(a.DAT_RECEIVEDDATE,'%d-%m-%Y'), ";
		sql=sql+" a.CHR_RECEIVEDBY,a.CHR_DES,a.INT_STATUS,a.INT_TRANSFERSTATUS  ";
		sql=sql+" FROM   inv_t_stocktransfer a  ";
		sql=sql+" WHERE a.INT_BRANCHID_FROM="+frombranch;
		sql=sql+" AND a.INT_BRANCHID_TO="+tobranch;
		sql=sql+sqldaterange;
		sql=sql+sqldivision;
		sql=sql+" ORDER BY a.CHR_STOCKTRANSFERID  ";
		//out.println(sql);
		 String reportheader="Stock Transfer Report Branch wise "+dateheader ;
		 Vector mn = new Vector();
		 Vector child= null;
		 String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		
		 
		if(data.length>0)
		{
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][0]);
				child.addElement(data[u][3]+" @ " +data[u][2]);	
				child.addElement(data[u][6]+" @ " +data[u][5]);	
				child.addElement(data[u][7]);
				child.addElement(data[u][8]);
				child.addElement(data[u][9]);
				child.addElement(data[u][10]);
				child.addElement(data[u][11]);
				child.addElement(data[u][12]);
				if("1".equals(data[u][13]))
					child.addElement("Transfered");
				else
					child.addElement("Not Transfered");	
				if("1".equals(data[u][14]))
					child.addElement("Received");
				else
					child.addElement("Not Received");	 
				mn.add(child);
				 
			}
		}
		 
		
		
		/*
		out.println("<center><table  width='900'  cellpadding=2 cellspacing=1 bgcolor='#9900CC'   id='myTable'><tr bgcolor='#ffffff'>");
		out.println("<td colspan=12 class='boldEleven'><center><h3>Stock Transfer Report Branch wise "+dateheader+"</h3></center>");
		
		//out.println("<td colspan=12 class='boldEleven'><center><h3>Stock Transfer Report Branch wise "+dateheader+"</h3></center>");
		
		if(data.length>0)
		{
			out.println("<tr bgcolor='#ffffff'><td class='boldEleven'><b>S.No");
			out.println("<td class='boldEleven'><b>Transfer Id");
			out.println("<td class='boldEleven'><b>From");
			out.println("<td class='boldEleven'><b>To");
			out.println("<td class='boldEleven'><b>Division");
			out.println("<td class='boldEleven'><b>Transfer Date");
			out.println("<td class='boldEleven'><b>Transfered By");
			out.println("<td class='boldEleven'><b>Received Date");
			out.println("<td class='boldEleven'><b>Received By");
			out.println("<td class='boldEleven'><b>Description");
			out.println("<td class='boldEleven'><b>Transfer Status");
			out.println("<td class='boldEleven'><b>Received Status");
			for(int u=0;u<data.length;u++)
			{
				if(u%2==0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");	
				out.println("<td class='boldEleven'>"+(u+1));	
				out.println("<td class='boldEleven'>"+data[u][0]);	
				out.println("<td class='boldEleven'>"+data[u][3]+" @ " +data[u][2]);	
				out.println("<td class='boldEleven'>"+data[u][6]+" @ " +data[u][5]);	
				out.println("<td class='boldEleven'>"+data[u][7]);
				out.println("<td class='boldEleven'>"+data[u][8]);
				out.println("<td class='boldEleven'>"+data[u][9]);
				out.println("<td class='boldEleven'>"+data[u][10]);
				out.println("<td class='boldEleven'>"+data[u][11]);
				out.println("<td class='boldEleven'>"+data[u][12]);
				if("1".equals(data[u][13]))
					out.println("<td class='boldEleven'>Transfered");
				else
					out.println("<td class='boldEleven'>Not Transfered");	
				if("1".equals(data[u][14]))
					out.println("<td class='boldEleven'>Received");
				else
					out.println("<td class='boldEleven'>Not Received");	
			}
		}
		else
		{
			out.println("<tr bgcolor='#ffffff'><td colspan=12 class='boldred'><center>Data not found...</center>");
		}
		out.println("</table></center>");*/
		
		
		
		 

		request.setAttribute("table",mn);
		out.println("<br><center><h3> "+reportheader+" </h3></center><br>");
 %>
 
  <display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S. No " sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Transfer Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="From" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="To" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Division" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Transfer Date" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Transfered By" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Received Date" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Received By" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Description" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Transfer Status" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Received Status" sortable="true"><%=temp.elementAt(11)%></display:column>
					 
					 
					 
					
					<display:setProperty name="export.csv.filename" value="StockTransferBranchwise.csv"/>
					<display:setProperty name="export.excel.filename" value="StockTransferBranchwise.xls"/>
					<display:setProperty name="export.xml.filename" value="StockTransferBranchwise.xml"/>
					<display:setProperty name="export.pdf.filename" value="StockTransferBranchwise.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>   
<br />	<br /><br /><center>	<a href='javascript:window.close()'> CLOSE</a></center><br /><br /><br />
 <%		 		 
		
		
	}
	catch(Exception e)
	{
	
	}
%>		 
  
 </body>
</html>
