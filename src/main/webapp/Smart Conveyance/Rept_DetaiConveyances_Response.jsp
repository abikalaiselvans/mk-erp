<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<%
try
{
%>

 <script language="javascript" src="../JavaScript/comfunction.js"></script>
  

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
<title> :: CONVEYANCE ::</title>

  
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<body  onpaste='return false;'>
 
	<%
		String company=request.getParameter("company");
		String branch=request.getParameter("branch");
		String office=request.getParameter("office");
		String fromdate=request.getParameter("fromdate");
		String todate=request.getParameter("todate");
		String type=request.getParameter("type");
		fromdate = DateUtil.FormateDateSQL(fromdate);
		todate = DateUtil.FormateDateSQL(todate);
		String sql="";
 		    
		sql=sql+" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REPTO),b.CHR_COMPANYNAME,c.CHR_BRANCHNAME, "; 
		sql=sql+" d.CHR_OFFICENAME, e.CHR_DEPARTNAME,f.CHR_DESIGNAME,h.CHR_CATEGORYNAME, "; 
		sql=sql+" DATE_FORMAT(j.DAT_CONDATE,'%d-%b-%Y') Entrydate, "; 
		sql=sql+" j.CHR_FROM fromplace,j.CHR_TO toplace,j.DOU_KM km, "; 
		sql=sql+" j.DOU_TRAVEL travel,j.DOU_TRAIN train,j.DOU_AUTO auto,j.DOU_LUNCH lunch,  "; 
		sql=sql+" j.DOU_TELEPHONE telephone,j.DOU_OTHERAMT otheramount,j.DOU_TOTAL total, "; 
		sql=sql+" IF(j.CHR_ACCEPT ='Y','ACCEPT',IF(j.CHR_ACCEPT ='R' ,'REJECT','PENDING')) Approval,  "; 
		sql=sql+" IF(j.CHR_ACCSTATUS='Y','ACCOUNT ACCEPT',''), "; 
		sql=sql+" DATE_FORMAT(j.DAT_ACCDATE,'%d-%b-%Y') accountdate, "; 
		sql=sql+" DATE_FORMAT(j.DAT_CREATION_TIME,'%d-%b-%Y %h:%m:%s') creationtime, "; 
		sql=sql+" DATE_FORMAT(j.DAT_APPROVAL_TIME,'%d-%b-%Y %h:%m:%s') Approvaltime, "; 
		sql=sql+" DATE_FORMAT(j.DAT_CLEARINGDATE,'%d-%b-%Y %h:%m:%s') Accountclearing, "; 
		sql=sql+" DATEdiff(j.DAT_APPROVAL_TIME,j.DAT_CREATION_TIME) Approvalage, "; 
		sql=sql+" DATEdiff(j.DAT_CLEARINGDATE,j.DAT_APPROVAL_TIME) Accountage  "; 
		sql=sql+" FROM com_m_staff  a,com_m_company b,com_m_branch c,com_m_office d,com_m_depart e,com_m_desig f,com_m_employeecategory h,  "; 
		sql=sql+" conveyance_t_conveyance j "; 
		sql=sql+" WHERE   a.INT_COMPANYID = b.INT_COMPANYID "; 
		sql=sql+" AND a.INT_BRANCHID = c.INT_BRANCHID  "; 
		sql=sql+" AND a.INT_OFFICEID = d.INT_OFFICEID "; 
		sql=sql+" AND a.INT_DEPARTID = e.INT_DEPARTID  "; 
		sql=sql+" AND a.INT_DESIGID = f.INT_DESIGID "; 
		sql=sql+" AND a.CHR_CATEGORY= h.INT_EMPLOYEECATEGORYID "; 
		sql=sql+" AND a.CHR_EMPID = j.CHR_EMPID "; 
		if(!"0".equals(company))
			sql=sql+" AND  a.INT_COMPANYID=  "+company+"  ";
		if(!"0".equals(branch))
			sql=sql+" AND  a.INT_BRANCHID=  "+branch+"  ";
		if(!"0".equals(office))
			sql=sql+" AND  a.INT_OFFICEID=  "+office+"  ";
		sql=sql+" AND  j.DAT_CONDATE >='"+fromdate+"'";
		sql=sql+" AND  j.DAT_CONDATE <='"+todate+"'";
		sql=sql+" ORDER BY  a.CHR_STAFFNAME";
		String cdata[][]=CommonFunctions.QueryExecute(sql);
	 	
		Vector mn = new Vector();
		Vector child= null;
		if(cdata.length>0)
		{
			for(int u=0;u<cdata.length;u++)
			{
	
					child = new Vector();
					child.addElement((u+1));
					child.addElement(cdata[u][0]); 
					child.addElement(cdata[u][1]);
					child.addElement(cdata[u][2]);
					child.addElement(cdata[u][3]);
					child.addElement(cdata[u][4]);
					child.addElement(cdata[u][5]);
					child.addElement(cdata[u][6]);
					child.addElement(cdata[u][7]);
					child.addElement(cdata[u][8]);
					child.addElement(cdata[u][9]);
					child.addElement(cdata[u][10]);
					child.addElement(cdata[u][11]);
					child.addElement(cdata[u][12]);
					child.addElement(cdata[u][13]);
					child.addElement(cdata[u][14]);
					child.addElement(cdata[u][15]);
					child.addElement(cdata[u][16]);
					child.addElement(cdata[u][17]);
					child.addElement(cdata[u][18]);
					child.addElement(cdata[u][19]);
					child.addElement(cdata[u][20]);
					child.addElement(cdata[u][21]);
					child.addElement(cdata[u][22]);
					child.addElement(cdata[u][23]);
					child.addElement(cdata[u][24]);
					child.addElement(cdata[u][25]);
					child.addElement(cdata[u][26]);
					child.addElement(cdata[u][27]);
					mn.add(child);  
	
			}
 		}		
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> <b>   CONVEYANCE  REPORT </h3></center><br>");
 
  

 
	 
		 
		 
		
	 
%>


<display:table   id="_table" name="table"   export="true" pagesize="25">

	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title=" Sl.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
                    <display:column title="Reporting Head " sortable="true"><%=temp.elementAt(3)%></display:column>
                    <display:column title="Company " sortable="true"><%=temp.elementAt(4)%></display:column>
                    <display:column title="Branch " sortable="true"><%=temp.elementAt(5)%></display:column>
                    <display:column title="Office " sortable="true"><%=temp.elementAt(6)%></display:column>
                    <display:column title="Department " sortable="true"><%=temp.elementAt(7)%></display:column>
                    <display:column title="Designation " sortable="true"><%=temp.elementAt(8)%></display:column>
                    <display:column title="Category " sortable="true"><%=temp.elementAt(9)%></display:column>
                    <display:column title=" Date" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title=" From" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title=" To" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title=" Kilometer" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title=" Vehicle Amount" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title=" Train/Bus are" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title=" Auto Fare" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title=" Lunch / Dinner" sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title=" Telephone Charges" sortable="true"><%=temp.elementAt(18)%></display:column>
					<display:column title=" other Amount " sortable="true"><%=temp.elementAt(19)%></display:column>
					<display:column title=" Totals " sortable="true"><%=temp.elementAt(20)%></display:column>
					<display:column title=" Approval " sortable="true"><%=temp.elementAt(21)%></display:column>
                    <display:column title="Account Approval " sortable="true"><%=temp.elementAt(22)%></display:column>
					<display:column title="Account date " sortable="true"><%=temp.elementAt(23)%></display:column>
                    <display:column title="Creation " sortable="true"><%=temp.elementAt(24)%></display:column>
                    <display:column title="Approval " sortable="true"><%=temp.elementAt(25)%></display:column>
                    <display:column title="Clearing " sortable="true"><%=temp.elementAt(26)%></display:column>
                    <display:column title="Approval Age " sortable="true"><%=temp.elementAt(27)%></display:column>
                    <display:column title="Account Age " sortable="true"><%=temp.elementAt(28)%></display:column>
                    
 
					<display:setProperty name="export.csv.filename" value="PaidConveyance.csv"/>
					<display:setProperty name="export.excel.filename" value="PaidConveyance.xls"/>
					<display:setProperty name="export.xml.filename" value="PaidConveyance.xml"/>
					<display:setProperty name="export.pdf.filename" value="PaidConveyance.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>   

<br />	<center>	<a href='PaidConveyance.jsp'> CLOSE</a></center>


</body>
</html>

<%

}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
 