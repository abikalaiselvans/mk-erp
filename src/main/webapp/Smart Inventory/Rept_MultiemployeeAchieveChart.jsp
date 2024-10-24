<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import="org.jfree.chart.plot.*"%>
<%@ page  import ="org.jfree.data.category.*"%>
<%@ page  import ="org.jfree.data.general.*"%>
<%@ page  import ="org.jfree.util.*"%>
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
		 
		String year = request.getParameter("year");
		int fyear = Integer.parseInt( year); 
	 	String sql ="  ";
		sql = sql + "  SELECT  ";
		sql = sql + "  FUN_GET_EMPLOYEE_SALES_PERCENTAGE('April','"+fyear+"',a.INT_APR,a.CHR_EMPID ) APR ,    ";
		sql = sql + "  FUN_GET_EMPLOYEE_SALES_PERCENTAGE('May','"+fyear+"',a.INT_APR,a.CHR_EMPID ) MAY ,    ";
		sql = sql + "  FUN_GET_EMPLOYEE_SALES_PERCENTAGE('June','"+fyear+"',a.INT_APR,a.CHR_EMPID ) JUN ,    ";
		sql = sql + "  FUN_GET_EMPLOYEE_SALES_PERCENTAGE('July','"+fyear+"',a.INT_APR,a.CHR_EMPID ) JUL ,    ";
		sql = sql + "  FUN_GET_EMPLOYEE_SALES_PERCENTAGE('August','"+fyear+"',a.INT_APR,a.CHR_EMPID ) AUG ,    ";
		sql = sql + "  FUN_GET_EMPLOYEE_SALES_PERCENTAGE('September','"+fyear+"',a.INT_APR,a.CHR_EMPID ) SEP ,    ";
		sql = sql + "  FUN_GET_EMPLOYEE_SALES_PERCENTAGE('October','"+fyear+"',a.INT_APR,a.CHR_EMPID ) sOCT ,    ";
		sql = sql + "  FUN_GET_EMPLOYEE_SALES_PERCENTAGE('November','"+fyear+"',a.INT_APR,a.CHR_EMPID ) NOV ,    ";
		sql = sql + "  FUN_GET_EMPLOYEE_SALES_PERCENTAGE('December','"+fyear+"',a.INT_APR,a.CHR_EMPID ) sDEC ,    ";
		sql = sql + "  FUN_GET_EMPLOYEE_SALES_PERCENTAGE('January','"+(fyear+1)+"',a.INT_APR,a.CHR_EMPID ) JAN ,    ";
		sql = sql + "  FUN_GET_EMPLOYEE_SALES_PERCENTAGE('February','"+(fyear+1)+"',a.INT_APR,a.CHR_EMPID ) FEB ,    ";
		sql = sql + "  FUN_GET_EMPLOYEE_SALES_PERCENTAGE('March','"+(fyear+1)+"',a.INT_APR,a.CHR_EMPID ) MAR      ";
		sql = sql + "   ";
		sql = sql + " FROM  inv_t_targetassign a    ";
		sql = sql + "  WHERE a.INT_YEAR ="+fyear;
		//out.println(sql); 
		 double data1[][] =  CommonFunctions.DoubleRecordSetArray(sql);
		
		
		final double[][] data = data1;  

		 
		 final CategoryDataset dataset = DatasetUtilities.createCategoryDataset(
                    "EMPLOYEE ", "MONTH", data);


            final JFreeChart chart = ChartFactory.createMultiplePieChart(
                    "EMPLOYEE ACHEIVE [ "+fyear+ "-" +(fyear+1)+" ] ", dataset, TableOrder.BY_ROW, true, true, false);
            chart.setBackgroundPaint(new Color(249, 231, 236));
            try 
			{
                final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
                final File file1 = new File(request.getRealPath("/")+"Smart Inventory/JFreeChart/multipiechart.png");
                ChartUtilities.saveChartAsPNG(file1, chart, 800, 600, info);
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
		<td><IMG SRC="JFreeChart/multipiechart.png" WIDTH="100%" HEIGHT="100%" BORDER="0" USEMAP="#chart"></td>
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
