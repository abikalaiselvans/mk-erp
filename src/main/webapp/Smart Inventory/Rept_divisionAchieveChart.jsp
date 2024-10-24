<%@ page import="java.io.*,java.util.*"%>
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
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<%
		String division = request.getParameter("division"); 
		String year = request.getParameter("year");
		int fyear = Integer.parseInt( year); 
	 	String reportheader=" DIVISION ACHEIVE    "+fyear+" - " +(fyear+1)  +" " ; 
		String sql ="  ";
		sql = sql + "  SELECT  ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('April','"+fyear+"',b.INT_APR,a.INT_DIVIID ) APR ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('May','"+fyear+"',b.INT_APR,a.INT_DIVIID ) MAY ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('June','"+fyear+"',b.INT_APR,a.INT_DIVIID ) JUN ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('July','"+fyear+"',b.INT_APR,a.INT_DIVIID ) JUL ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('August','"+fyear+"',b.INT_APR,a.INT_DIVIID ) AUG ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('September','"+fyear+"',b.INT_APR,a.INT_DIVIID ) SEP ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('October','"+fyear+"',b.INT_APR,a.INT_DIVIID ) sOCT ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('November','"+fyear+"',b.INT_APR,a.INT_DIVIID ) NOV ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('December','"+fyear+"',b.INT_APR,a.INT_DIVIID ) sDEC ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('January','"+(fyear+1)+"',b.INT_APR,a.INT_DIVIID ) JAN ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('February','"+(fyear+1)+"',b.INT_APR,a.INT_DIVIID ) FEB ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('March','"+(fyear+1)+"',b.INT_APR,a.INT_DIVIID ) MAR      ";
		sql = sql + "   ";
		sql = sql + " FROM inv_m_division a , inv_t_targetassign_division b    ";
		sql = sql + "  WHERE a.INT_DIVIID = b.INT_DIVIID  ";
		sql = sql + "  AND  b.INT_YEAR ="+fyear;
		if(!"0".equals(division))
			sql = sql + "  AND a.INT_DIVIID = "+division;
		sql = sql + "  ORDER BY a.CHR_DIVICODE   ";
		//out.println(sql); 
		
		String divisionname="";
		if(!"0".equals(division))
			divisionname = CommonFunctions.QueryExecute("SELECT FUN_INV_DIVISION("+division+") ")[0][0];
		
		 
	 
		
		 double data1[][] =  CommonFunctions.DoubleRecordSetArray(sql);
		
		
		final double[][] data = data1;  

		 
            final CategoryDataset dataset = DatasetUtilities.createCategoryDataset(
                    "Division ", "", data);

            JFreeChart chart = null;
            BarRenderer renderer = null;
            CategoryPlot plot = null;


            final CategoryAxis categoryAxis = new CategoryAxis("MONTH");
            final ValueAxis valueAxis = new NumberAxis("%");
            renderer = new BarRenderer();

            plot = new CategoryPlot(dataset, categoryAxis, valueAxis, renderer);
            plot.setOrientation(PlotOrientation.VERTICAL);
            chart = new JFreeChart(divisionname+"  DIVISION [ "+fyear+ " - " +(fyear+1)+" ] ", JFreeChart.DEFAULT_TITLE_FONT, plot, true);

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
                final File file1 = new File(request.getRealPath("/")+"Smart Inventory/JFreeChart/barchart.png");
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
											onClick="javascript:window.close()"></td>
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
