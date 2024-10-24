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
 <title>:: INVENTORY ::</title>

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
 		
		//String Branch = request.getParameter("Branch");
		//String  division= request.getParameter("division");
		String quarter = request.getParameter("quarter");
		String year = request.getParameter("year");
		int fyear = Integer.parseInt( year); 
		String reportheader=" TURN OVER FOR "+fyear+" - "+(fyear+1) ; 
		String sql ="";
		
		
		
		Vector mn = new Vector();
	 	Vector child= null;
		
		
		if("1".equals(quarter) || "0".equals(quarter))
		{
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_directsales a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='April' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String adata[][] =  CommonFunctions.QueryExecute(sql);
			
			sql ="";
			sql = " SELECT 	SUM(b.DOU_CONTRIBUTION)/100000 ";
			sql = sql +" FROM inv_t_directsales a , inv_t_contribution b  WHERE a.CHR_SALESNO = b.CHR_SALESNO ";
			sql = sql +" AND a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='April' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String cdata[][] =  CommonFunctions.QueryExecute(sql);
			
			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_servicebilling a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='April' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String sadata[][] =  CommonFunctions.QueryExecute(sql);
			
			
			child = new Vector();
			child.addElement("APRIL");
			if(adata.length>0)
				child.addElement(adata[0][0]);
			else
				child.addElement("0");
			
			if(adata.length>0)
				child.addElement(cdata[0][0]);
			else
				child.addElement("0");
					
			if(sadata.length>0)
				child.addElement(sadata[0][0]);
			else
				child.addElement("0");
			
			child.addElement("");
			mn.add(child);
		}
			
		
		
		 
		if("1".equals(quarter) || "0".equals(quarter))
		{
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_directsales a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='May' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String mdata[][] =  CommonFunctions.QueryExecute(sql);
			
			sql ="";
			sql = " SELECT 	SUM(b.DOU_CONTRIBUTION)/100000 ";
			sql = sql +" FROM inv_t_directsales a , inv_t_contribution b  WHERE a.CHR_SALESNO = b.CHR_SALESNO ";
			sql = sql +" AND a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='May' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String cdata[][] =  CommonFunctions.QueryExecute(sql);
			
			
			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT) /100000";
			sql = sql +" FROM inv_t_servicebilling a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='May' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String smdata[][] =  CommonFunctions.QueryExecute(sql);
			child = new Vector();
			
			child.addElement("MAY");
			if(mdata.length>0)
				child.addElement(mdata[0][0]);
			else
				child.addElement("0");
			if(cdata.length>0)
				child.addElement(cdata[0][0]);
			else
				child.addElement("0");
			if(smdata.length>0)
				child.addElement(smdata[0][0]);
			else
				child.addElement("0");
			
			child.addElement("");
			mn.add(child);
		}
			 
					
		if("1".equals(quarter) || "0".equals(quarter))
		{
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_directsales a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='June' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String junedata[][] =  CommonFunctions.QueryExecute(sql);
			
			sql ="";
			sql = " SELECT 	SUM(b.DOU_CONTRIBUTION)/100000 ";
			sql = sql +" FROM inv_t_directsales a , inv_t_contribution b  WHERE a.CHR_SALESNO = b.CHR_SALESNO ";
			sql = sql +" AND a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='June' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String cdata[][] =  CommonFunctions.QueryExecute(sql);
			
			
			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_servicebilling a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='June' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String sjunedata[][] =  CommonFunctions.QueryExecute(sql);
			child = new Vector();
			
			child.addElement("JUNE");
			if(junedata.length>0)
				child.addElement(junedata[0][0]);
			else
				child.addElement("0");
			if(cdata.length>0)
				child.addElement(cdata[0][0]);
			else
				child.addElement("0");
			if(sjunedata.length>0)
				child.addElement(sjunedata[0][0]);
			else
				child.addElement("0");
			
			child.addElement("");
			mn.add(child);
		}
		
		
		
		if("2".equals(quarter) || "0".equals(quarter))
		{
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_directsales a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='July' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String Julydata[][] =  CommonFunctions.QueryExecute(sql);
			
			sql ="";
			sql = " SELECT 	SUM(b.DOU_CONTRIBUTION)/100000 ";
			sql = sql +" FROM inv_t_directsales a , inv_t_contribution b  WHERE a.CHR_SALESNO = b.CHR_SALESNO ";
			sql = sql +" AND a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='July' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String cdata[][] =  CommonFunctions.QueryExecute(sql);
			
			
			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_servicebilling a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='July' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String sJulydata[][] =  CommonFunctions.QueryExecute(sql);
			child = new Vector();
			
			child.addElement("JULY");
			if(Julydata.length>0)
				child.addElement(Julydata[0][0]);
			else
				child.addElement("0");
			if(cdata.length>0)
				child.addElement(cdata[0][0]);
			else
				child.addElement("0");
			if(sJulydata.length>0)
				child.addElement(sJulydata[0][0]);
			else
				child.addElement("0");
			
			child.addElement("");
			mn.add(child);
		}
		
		if("2".equals(quarter) || "0".equals(quarter))
		{			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_directsales a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='August' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String Augustdata[][] =  CommonFunctions.QueryExecute(sql);
			
			sql ="";
			sql = " SELECT 	SUM(b.DOU_CONTRIBUTION)/100000 ";
			sql = sql +" FROM inv_t_directsales a , inv_t_contribution b  WHERE a.CHR_SALESNO = b.CHR_SALESNO ";
			sql = sql +" AND a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='August' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String cdata[][] =  CommonFunctions.QueryExecute(sql);
			
			
			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT) /100000";
			sql = sql +" FROM inv_t_servicebilling a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='August' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String sAugustdata[][] =  CommonFunctions.QueryExecute(sql);
			child = new Vector();
			
			child.addElement("AUGUST");
			if(Augustdata.length>0)
				child.addElement(Augustdata[0][0]);
			else
				child.addElement("0");
			if(cdata.length>0)
				child.addElement(cdata[0][0]);
			else
				child.addElement("0");
			if(sAugustdata.length>0)
				child.addElement(sAugustdata[0][0]);
			else
				child.addElement("0");
			
			child.addElement("");
			mn.add(child);
		}				
		
		if("2".equals(quarter) || "0".equals(quarter))
		{
			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_directsales a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='September' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String Septemberdata[][] =  CommonFunctions.QueryExecute(sql);
			
			sql ="";
			sql = " SELECT 	SUM(b.DOU_CONTRIBUTION)/100000 ";
			sql = sql +" FROM inv_t_directsales a , inv_t_contribution b  WHERE a.CHR_SALESNO = b.CHR_SALESNO ";
			sql = sql +" AND a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='September' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String cdata[][] =  CommonFunctions.QueryExecute(sql);
			
			
			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_servicebilling a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='September' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String sSeptemberdata[][] =  CommonFunctions.QueryExecute(sql);
			child = new Vector();
			
			child.addElement("September");
			if(Septemberdata.length>0)
				child.addElement(Septemberdata[0][0]);
			else
				child.addElement("0");
			if(cdata.length>0)
				child.addElement(cdata[0][0]);
			else
				child.addElement("0");
			if(sSeptemberdata.length>0)
				child.addElement(sSeptemberdata[0][0]);
			else
				child.addElement("0");
			
			child.addElement("");
			mn.add(child);
		}
		
		
					
		if("3".equals(quarter) || "0".equals(quarter))
		{	
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_directsales a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='October' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String Octoberdata[][] =  CommonFunctions.QueryExecute(sql);
			
			sql ="";
			sql = " SELECT 	SUM(b.DOU_CONTRIBUTION)/100000 ";
			sql = sql +" FROM inv_t_directsales a , inv_t_contribution b  WHERE a.CHR_SALESNO = b.CHR_SALESNO ";
			sql = sql +" AND a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='October' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String cdata[][] =  CommonFunctions.QueryExecute(sql);
			
			
			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_servicebilling a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='October' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String sOctoberdata[][] =  CommonFunctions.QueryExecute(sql);
			child = new Vector();
			
			child.addElement("October");
			if(Octoberdata.length>0)
				child.addElement(Octoberdata[0][0]);
			else
				child.addElement("0");
			if(cdata.length>0)
				child.addElement(cdata[0][0]);
			else
				child.addElement("0");
			if(sOctoberdata.length>0)
				child.addElement(sOctoberdata[0][0]);
			else
				child.addElement("0");
			
			child.addElement("");
			mn.add(child);
		}
		
		if("3".equals(quarter) || "0".equals(quarter))
		{			 
			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT) /100000";
			sql = sql +" FROM inv_t_directsales a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='November' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String Novemberdata[][] =  CommonFunctions.QueryExecute(sql);
			
			sql ="";
			sql = " SELECT 	SUM(b.DOU_CONTRIBUTION)/100000 ";
			sql = sql +" FROM inv_t_directsales a , inv_t_contribution b  WHERE a.CHR_SALESNO = b.CHR_SALESNO ";
			sql = sql +" AND a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='November' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String cdata[][] =  CommonFunctions.QueryExecute(sql);
			
			
			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_servicebilling a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='November' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String sNovemberdata[][] =  CommonFunctions.QueryExecute(sql);
			child = new Vector();
			
			child.addElement("November");
			if(Novemberdata.length>0)
				child.addElement(Novemberdata[0][0]);
			else
				child.addElement("0");
			if(cdata.length>0)
				child.addElement(cdata[0][0]);
			else
				child.addElement("0");
			if(sNovemberdata.length>0)
				child.addElement(sNovemberdata[0][0]);
			else
				child.addElement("0");
			
			child.addElement("");
			mn.add(child);
		}
		
		if("3".equals(quarter) || "0".equals(quarter))
		{			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_directsales a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='December' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String Decemberdata[][] =  CommonFunctions.QueryExecute(sql);
			
			sql ="";
			sql = " SELECT 	SUM(b.DOU_CONTRIBUTION)/100000 ";
			sql = sql +" FROM inv_t_directsales a , inv_t_contribution b  WHERE a.CHR_SALESNO = b.CHR_SALESNO ";
			sql = sql +" AND a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='December' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String cdata[][] =  CommonFunctions.QueryExecute(sql);
			
			
			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_servicebilling a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='December' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String sDecemberdata[][] =  CommonFunctions.QueryExecute(sql);
			child = new Vector();
			
			child.addElement("December");
			if(Decemberdata.length>0)
				child.addElement(Decemberdata[0][0]);
			else
				child.addElement("0");
			if(cdata.length>0)
				child.addElement(cdata[0][0]);
			else
				child.addElement("0");
			if(sDecemberdata.length>0)
				child.addElement(sDecemberdata[0][0]);
			else
				child.addElement("0");
			
			child.addElement("");
			mn.add(child);
		}
		
		if("4".equals(quarter) || "0".equals(quarter))
		{			
			 
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_directsales a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='January' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+(fyear+1);
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String Januarydata[][] =  CommonFunctions.QueryExecute(sql);
			
			sql ="";
			sql = " SELECT 	SUM(b.DOU_CONTRIBUTION)/100000 ";
			sql = sql +" FROM inv_t_directsales a , inv_t_contribution b  WHERE a.CHR_SALESNO = b.CHR_SALESNO ";
			sql = sql +" AND a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='January' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+(fyear+1);
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String cdata[][] =  CommonFunctions.QueryExecute(sql);
			
			
			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_servicebilling a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='January' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+(fyear+1);
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String sJanuarydata[][] =  CommonFunctions.QueryExecute(sql);
			child = new Vector();
			
			child.addElement("January");
			if(Januarydata.length>0)
				child.addElement(Januarydata[0][0]);
			else
				child.addElement("0");
			if(cdata.length>0)
				child.addElement(cdata[0][0]);
			else
				child.addElement("0");
			if(sJanuarydata.length>0)
				child.addElement(sJanuarydata[0][0]);
			else
				child.addElement("0");
			
			child.addElement("");
			mn.add(child);
			
		}
					
		if("4".equals(quarter) || "0".equals(quarter))
		{			
		
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_directsales a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='February' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+(fyear+1);
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String Februarydata[][] =  CommonFunctions.QueryExecute(sql);
			
			sql ="";
			sql = " SELECT 	SUM(b.DOU_CONTRIBUTION)/100000 ";
			sql = sql +" FROM inv_t_directsales a , inv_t_contribution b  WHERE a.CHR_SALESNO = b.CHR_SALESNO ";
			sql = sql +" AND a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='February' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+(fyear+1);
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String cdata[][] =  CommonFunctions.QueryExecute(sql);
			
			
			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_servicebilling a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='February' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+(fyear+1);
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String sFebruarydata[][] =  CommonFunctions.QueryExecute(sql);
			child = new Vector();
			
			child.addElement("February");
			if(Februarydata.length>0)
				child.addElement(Februarydata[0][0]);
			else
				child.addElement("0");
			if(cdata.length>0)
				child.addElement(cdata[0][0]);
			else
				child.addElement("0");	
			if(sFebruarydata.length>0)
				child.addElement(sFebruarydata[0][0]);
			else
				child.addElement("0");
			
			child.addElement("");
			mn.add(child);
		}
		
		if("4".equals(quarter) || "0".equals(quarter))
		{			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_directsales a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='March' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+(fyear+1);
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String Marchdata[][] =  CommonFunctions.QueryExecute(sql);
			
			sql ="";
			sql = " SELECT 	SUM(b.DOU_CONTRIBUTION)/100000 ";
			sql = sql +" FROM inv_t_directsales a , inv_t_contribution b  WHERE a.CHR_SALESNO = b.CHR_SALESNO ";
			sql = sql +" AND a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='March' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+(fyear+1);
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String cdata[][] =  CommonFunctions.QueryExecute(sql);
			
			
			
			sql ="";
			sql = " SELECT 	SUM(DOU_AMOUNT)/100000 ";
			sql = sql +" FROM inv_t_servicebilling a WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND  MONTHNAME(a.DAT_SALESDATE) ='March' ";
			sql = sql +" AND  YEAR(a.DAT_SALESDATE) = "+(fyear+1);
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql +" order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
			String sMarchdata[][] =  CommonFunctions.QueryExecute(sql);
			child = new Vector();
			
			child.addElement("March");
			if(Marchdata.length>0)
				child.addElement(Marchdata[0][0]);
			else
				child.addElement("0");
			if(cdata.length>0)
				child.addElement(cdata[0][0]);
			else
				child.addElement("0");	
			if(sMarchdata.length>0)
				child.addElement(sMarchdata[0][0]);
			else
				child.addElement("0");
			
			child.addElement("");
			mn.add(child); 
		}
			 
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25"  style="text-align:center" >
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="MONTH" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="SALES (Rs. In Lacs)"  style="text-align:right"    sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="CONTRIBUTION (Rs. In Lacs)"  style="text-align:right"    sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="SERVICE(Rs. In Lacs)" style="text-align:right"   sortable="true"><%=temp.elementAt(3)%></display:column>
					 
					<display:setProperty name="export.excel.filename" value="Rept_FinancialYearSales.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_FinancialYearSales.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_FinancialYearSales.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a style="text-align:right" href='Rept_DailySales.jsp'> CLOSE</a></center>
  <%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>		 
</body>
</html>

