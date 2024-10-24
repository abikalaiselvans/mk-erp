<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="java.util.*"%>
<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import="org.jfree.chart.plot.*"%>
<%@ page  import ="org.jfree.data.category.*"%>
<%@ page  import ="org.jfree.data.general.*"%>
<%@ page  import ="org.jfree.util.*"%>

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

 
 </head>
<body  onpaste='return false;'>
 
	<%
try
{
	
 	 
		String company=request.getParameter("company");
		String branch=request.getParameter("branch");
		String office=request.getParameter("office");
		String fromdate=request.getParameter("fromdate");
		String todate=request.getParameter("todate");
		String fromdatesql = DateUtil.FormateDateSQL(fromdate);
		String todatesql = DateUtil.FormateDateSQL(todate);
		 
		String sql="";
		 
		 
	 	sql = " SELECT a.CHR_EMPID, SUM(a.DOU_TOTAL) ";
		sql = sql + " FROM conveyance_t_conveyance a, com_m_staff b,com_m_office c, com_m_depart d, com_m_employeecategory e ";
		sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID ";
		sql = sql + " AND b.INT_OFFICEID = c.INT_OFFICEID ";
		sql = sql + " AND b.INT_DEPARTID= d.INT_DEPARTID ";
		sql = sql + " AND b.CHR_CATEGORY=e.INT_EMPLOYEECATEGORYID ";
		sql = sql + " AND a.CHR_STATUS='Y' ";
		sql = sql + " AND a.CHR_ACCEPT ='Y' ";
		sql = sql + " AND a.CHR_ACCSTATUS='Y' ";
		sql = sql + " AND a.DAT_CONDATE >='"+fromdatesql+"' ";
		sql = sql + " AND a.DAT_CONDATE <='"+todatesql+"' ";
		if(!"0".equals(company))
			sql = sql + " AND   b.INT_COMPANYID ="+company;
		if(!"-1".equals(branch))
			sql = sql + " AND   b.INT_BRANCHID ="+branch;
		if(!"0".equals(office))
			sql = sql + " AND   b.INT_OFFICEID ="+office;
			
		sql = sql + " GROUP BY a.CHR_EMPID  ";
		sql = sql + " ORDER BY b.CHR_STAFFNAME,a.DAT_CONDATE ";
		 
		String cdata[][]= CommonFunctions.QueryExecute(sql);
		
		 /* 
			final String[][] data = cdata;

            final CategoryDataset dataset = DatasetUtilities.createCategoryDataset(
                    "Emp Id ", "Amount", data);


            final JFreeChart chart = ChartFactory.createMultiplePieChart(
                    "Multiple Pie Chart", dataset, TableOrder.BY_ROW, true, true, false);
            chart.setBackgroundPaint(new Color(249, 231, 236));
            try {
                final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
                final File file1 = new File(request.getRealPath("/")+"JFreeChart/multipiechart.png");
                ChartUtilities.saveChartAsPNG(file1, chart, 800, 600, info);
            } catch (Exception e) {
                out.println(e);
            }	  */
 
	 
		
	 
%>
<center>

<br />	<center>	 <IMG SRC="multipiechart.png" WIDTH="600" HEIGHT="400" BORDER="0" USEMAP="#chart"><br /><br />
<a href='Rept_ConveyanceAnalysis.jsp' style="text-align:right"> CLOSE</a></center>


<%

}
catch(Exception e)
{
	
}
%>
 
</body>
</html>
