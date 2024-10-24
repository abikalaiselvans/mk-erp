 <%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%-- <%@ page import="sun.net.smtp.SmtpClient"%> --%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.axis.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import="org.jfree.chart.labels.*" %>
<%@ page  import="org.jfree.chart.plot.*" %>
<%@ page  import="org.jfree.chart.renderer.category.*" %>
<%@ page  import="org.jfree.chart.urls.*" %>
<%@ page  import="org.jfree.data.category.*" %>
<%@ page  import="org.jfree.data.general.*" %>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title> <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<body >
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<%
		String ename = request.getParameter("ename"); 
		String month = request.getParameter("month");
		String year = request.getParameter("year");
		
		String monthname = com.my.org.erp.Date.Day.getMonth(Integer.parseInt( month));
		int fyear = Integer.parseInt( year); 
	 	String sql ="  ";
		sql = sql + "  SELECT ";
		sql = sql + "  SUM(c.DOU_PRESENT),SUM(c.DOU_ONDUTY),SUM(c.DOU_SUNDAY),SUM(c.DOU_HOLIDAY),SUM(c.DOU_LEAVE),SUM(c.DOU_ABSENT), ";
		sql = sql + "  SUM(INT_LATE),SUM(INT_PERMISSION),SUM(DOU_EXTRADAYS),SUM(DOU_EXTRAHOURS) ";
		sql = sql + "  FROM com_m_staff a , com_m_office b , att_t_register c ";
		sql = sql + "  WHERE a.INT_OFFICEID= b.INT_OFFICEID  ";
		sql = sql + "  AND a.CHR_EMPID = c.CHR_EMPID ";
		sql = sql + "  AND a.CHR_EMPID = '"+ename+"'";;
		sql = sql + "  AND c.INT_YEAR = "+year;
		if(!"0".equals(month))
			sql = sql + "  AND c.CHR_MONTH = '"+monthname+"'";
		sql = sql + "  GROUP BY a.CHR_EMPID  ";
		 
  		//out.println(sql);
		String empname="";
		String gdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		double data1[][] =   new double[10][1];
		for(int x=0;x<10;x++)
			data1[x][0] = Double.parseDouble(gdata[0][x]);
			
		 
		final double[][] data = data1;  

		 
            final CategoryDataset dataset = DatasetUtilities.createCategoryDataset(" ", "", data);

            JFreeChart chart = null;
            BarRenderer renderer = null;
            CategoryPlot plot = null;


            final CategoryAxis categoryAxis = new CategoryAxis("MONTH");
            final ValueAxis valueAxis = new NumberAxis(" [ % ]");
            renderer = new BarRenderer();

            plot = new CategoryPlot(dataset, categoryAxis, valueAxis, renderer);
            plot.setOrientation(PlotOrientation.VERTICAL);
            chart = new JFreeChart(year, JFreeChart.DEFAULT_TITLE_FONT, plot, true);

            chart.setBackgroundPaint(new Color(249, 231, 236));

            Paint p1 = new GradientPaint(
                    0.0f, 0.0f, new Color(16, 89, 172), 0.0f, 0.0f, new Color(201, 201, 244));
            renderer.setSeriesPaint(1, p1);

            Paint p2 = new GradientPaint(
                    0.0f, 0.0f, new Color(255, 35, 35), 0.0f, 0.0f, new Color(255, 180, 180));
            renderer.setSeriesPaint(2, p2);

            plot.setRenderer(renderer);

            try 
			{ 
                final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
                final File file1 = new File(request.getRealPath("/")+"Smart Attendance/JFreeChart/barchart.png");
                ChartUtilities.saveChartAsPNG(file1, chart, 600, 400, info);
            } 
			catch (Exception e) 
			{
                out.println(e);
            }
			 
			
		%>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td align="center"><IMG SRC="JFreeChart/barchart.png" WIDTH="600" HEIGHT="400" BORDER="0" USEMAP="#chart"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><table width="56" border="0" align="center" cellpadding="1"
									cellspacing="1">
          <tr>
             <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect( 'Rept_GraphEmployeeWise.jsp')"></td>
          </tr>
        </table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>