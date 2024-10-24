<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
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
 
<title> :: PAYROLL ::</title>





<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
  
   
</head>
<body >

<%
try
{
 		String reportheader="REVISION & ARREARS"; 
		String  company  = request.getParameter("company");
		String  branch  = request.getParameter("branch");
		String  Office  = request.getParameter("Office");
		String Dept= request.getParameter("Dept");
		String orderby= request.getParameter("orderby");
		String Category=request.getParameter("Category");
		String resigned= request.getParameter("resigned");
		
		String month= request.getParameter("month");
		String year= request.getParameter("year");
		
		
		/*String fromdate= request.getParameter("fromdate");
		String todate= request.getParameter("todate");
		fromdate = DateUtil.FormateDateSQL(fromdate);
		todate = DateUtil.FormateDateSQL(todate);*/
		
		String sql ="";
		
		sql = " SELECT 	 a.CHR_EMPID,a.CHR_STAFFNAME, ";
		sql = sql+ " if(a.CHR_OLD_PF='C','Common',if(a.CHR_OLD_PF='Y','Yes','No')), ";
		sql = sql+ " if(a.CHR_OLD_PFTYPE='A','Amount','Percentage'), ";
		sql = sql+ " a.CHR_OLD_PFNO, ";
		
		sql = sql+ " if(a.CHR_OLD_ESI='C','Common',if(a.CHR_OLD_ESI='Y','Yes','No')), ";
		sql = sql+ " if(a.CHR_OLD_ESITYPE='A','Amount','Percentage'), ";
		sql = sql+ " a.CHR_OLD_ESINO, ";
		
		sql = sql+ " if(a.CHR_PF='C','Common',if(a.CHR_PF='Y','Yes','No')), ";
		sql = sql+ " if(a.CHR_PFTYPE='A','Amount','Percentage'), ";
		sql = sql+ " a.CHR_PFNO, ";
		sql = sql+ " if(a.CHR_ESI='C','Common',if(a.CHR_ESI='Y','Yes','No')), ";
		sql = sql+ " if(a.CHR_ESITYPE='A','Amount','Percentage'), ";
		sql = sql+ " a.CHR_ESINO, ";
		sql = sql+ " if(a.CHR_REVISION='Y','Yes','No'), ";
		sql = sql+ " if(a.CHR_REVISION_TYPE='A','Automatic','Manual'), ";
		sql = sql+ " a.CHR_DESC,a.INT_REVISION_PERCENT,a.INT_OLD_GROSS,a.INT_GROSS, ";
		
		sql = sql+ " a.INT_OLDCTC,a.INT_CTC,DATE_FORMAT(a.DAT_DOJ,'%d-%b-%Y'),DATE_FORMAT(a.DAT_DOR,'%d-%b-%Y'), ";
		sql = sql+ " DATE_FORMAT(a.DAT_DOA,'%d-%b-%Y'), DATE_FORMAT(a.DAT_DOA1,'%d-%b-%Y'),MONTHNAME(a.DAT_DOR ), YEAR(a.DAT_DOR ), a.INT_DIFFERENCE,a.DOU_INCREMENT,	a.DOU_ARREAR_AMOUNT, ";
		sql = sql+ " a.DOU_GROSS_DIFFERENCE,a.DOU_CTC_DIFFERENCE 	 ";
		sql = sql+ " FROM pay_t_appraisal a , com_m_staff b";
		sql = sql+ "  WHERE a.CHR_EMPID = b.CHR_EMPID  AND a.CHR_ACCEPT = 'Y' ";
		sql = sql+ " AND MONTH(a.DAT_DOR ) = "+month;
		sql = sql+ " AND YEAR(a.DAT_DOR ) = "+year;
		
		
		/*sql = sql+ " AND a.DAT_DOR >= '"+fromdate+"' ";
		sql = sql+ " AND a.DAT_DOR <= '"+todate+"' ";*/
		
		if(!"0".equals(company))
			sql = sql + " AND b.INT_COMPANYID="+company;
		if(!"0".equals(branch))
			sql = sql + " AND b.INT_BRANCHID="+branch;
				
		if(!"0".equals(Office))
			sql = sql + " AND b.INT_OFFICEID="+Office;
		if(!"0".equals(Dept))
			sql = sql + " AND b.INT_DEPARTID= "+Dept;
		if(!"0".equals(Category))
			sql = sql + "  AND b.CHR_CATEGORY='"+Category +"' ";
		if(!"Y".equals(resigned))
			sql = sql + "   AND b.CHR_TYPE !='T'";
			
		sql = sql + " ORDER BY  "+orderby;
		 
		 


		Vector mn = new Vector();
	 	Vector child= null;
		String data[][] =  CommonFunctions.QueryExecute(sql);
				
		if(data.length>0)
		{
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][0]);
				child.addElement(data[u][1]);
				child.addElement(data[u][2]);
				child.addElement(data[u][3]);
				child.addElement(data[u][4]);
				child.addElement(data[u][5]);
				child.addElement(data[u][6]);
				child.addElement(data[u][7]);
				child.addElement(data[u][8]);
				child.addElement(data[u][9]);
				child.addElement(data[u][10]);
				child.addElement(data[u][11]);
				child.addElement(data[u][12]);
				child.addElement(data[u][13]);
				child.addElement(data[u][14]);
				child.addElement(data[u][15]);
				child.addElement(data[u][16]);
				child.addElement(data[u][17]);
				child.addElement(data[u][18]);
				child.addElement(data[u][19]);
				child.addElement(data[u][20]);
				child.addElement(data[u][21]);
				child.addElement(data[u][22]);
				child.addElement(data[u][23]);
				child.addElement(data[u][24]);
				child.addElement(data[u][25]);
				child.addElement(data[u][26]);
				child.addElement(data[u][27]);
				child.addElement(data[u][28]);
				child.addElement(data[u][29]);
				child.addElement(data[u][30]);
				child.addElement(data[u][31]);
				child.addElement(data[u][32]);
				 mn.add(child); 
			}
		} 
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="EMP ID "   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="EMP NAME "   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="OLD PF "   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="OLD PF TYPE "   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="OLD PF NUMBER "   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="OLD ESI "   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="OLD ESI TYPE "   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="OLS ESI NUMBER "   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="NEW PF "   sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="NEW PF TYPE "   sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="NEW PF NUMBER "   sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="NEW ESI "   sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="NEW ESI TYPE "   sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="NEW ESI NUMBER "   sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="REVISION "   sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="REVISION TYPE "   sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="DESCRIPTION"   sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title="REVISION % "   sortable="true"><%=temp.elementAt(18)%></display:column>
					<display:column title="OLD GROSS "   sortable="true"><%=temp.elementAt(19)%></display:column>
					<display:column title="NEW GROSS "   sortable="true"><%=temp.elementAt(20)%></display:column>
					<display:column title="OLD CTC "   sortable="true"><%=temp.elementAt(21)%></display:column>
					<display:column title="NEW CTC "   sortable="true"><%=temp.elementAt(22)%></display:column>
					<display:column title="DOJ "   sortable="true"><%=temp.elementAt(23)%></display:column>
					<display:column title="DOR "   sortable="true"><%=temp.elementAt(24)%></display:column>
					<display:column title="DOA FROM "   sortable="true"><%=temp.elementAt(25)%></display:column>
					<display:column title="DOA TO"   sortable="true"><%=temp.elementAt(26)%></display:column>
					<display:column title="MONTH "   sortable="true"><%=temp.elementAt(27)%></display:column>
					<display:column title="YEAR "   sortable="true"><%=temp.elementAt(28)%></display:column>
					
					<display:column title="DIFFERENCE "   sortable="true"><%=temp.elementAt(29)%></display:column>
					<display:column title="INCREMENT "   sortable="true"><%=temp.elementAt(30)%></display:column>
					<display:column title="ARREAR AMOUNT "   sortable="true"><%=temp.elementAt(31)%></display:column>
					<display:column title="GROSS DIFFERENCE "   sortable="true"><%=temp.elementAt(32)%></display:column>
					<display:column title="CTC DIFFERENCE "   sortable="true"><%=temp.elementAt(33)%></display:column>
					 
					
					 
					<display:setProperty name="export.excel.filename" value="Rept_RevisionandArrear.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_RevisionandArrear.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_RevisionandArrear.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='RevisionandArrear.jsp'> CLOSE</a></center>
 <%
}
catch(Exception e)
{
}
%>		 
</body>
</html>

