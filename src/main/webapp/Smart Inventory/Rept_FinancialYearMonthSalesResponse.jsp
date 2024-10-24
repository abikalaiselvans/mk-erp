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
 		
		 
		String  division= request.getParameter("division");
		String type = request.getParameter("type");
		String year = request.getParameter("year");
		int fyear = Integer.parseInt( year); 
		String reportheader="TURNOVER (Rs. In Lacs) / "+fyear+" - " +(fyear+1) ; 
		 
		String sql ="  ";
		
		Vector mn = new Vector();
	 	Vector child= null;
		 
		
		if("1".equals(type))
		{
			sql = " SELECT CONCAT('DIRECT SALES'),a.CHR_DIVICODE, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'April' ,'"+fyear+"') APR, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'May' ,'"+fyear+"') MAY, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'June' ,'"+fyear+"') JUN, ";
			sql = sql + " (FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'April' ,'"+fyear+"') +FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'May' ,'"+fyear+"') +FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'June' ,'"+fyear+"'))  Q1 , ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'July' ,'"+fyear+"') JUL, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'August' ,'"+fyear+"') AUG, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'September' ,'"+fyear+"') SEP, ";
			sql = sql + " (FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'July' ,'"+fyear+"')+FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'August' ,'"+fyear+"')+FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'September' ,'"+fyear+"')) Q2, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'October' ,'"+fyear+"') OCTb, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'November' ,'"+fyear+"') NOV, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'December' ,'"+fyear+"') DECb, ";
			sql = sql + " ( FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'October' ,'"+fyear+"')+FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'November' ,'"+fyear+"')+FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'December' ,'"+fyear+"')) Q3, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'January' ,'"+(fyear+1)+"') JAN, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'February' ,'"+(fyear+1)+"') FEB, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'March' ,'"+(fyear+1)+"') MAR, ";
			sql = sql + " (FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'January' ,'"+(fyear+1)+"')+FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'February' ,'"+(fyear+1)+"')+FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'March' ,'"+(fyear+1)+"')) Q4, ";
			sql = sql + " ( ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'April' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'May' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'June' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'July' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'August' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'September' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'October' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'November' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'December' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'January' ,'"+(fyear+1)+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'February' ,'"+(fyear+1)+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'March' ,'"+(fyear+1)+"')   ";
			sql = sql + " ) total  ";
			sql = sql + " FROM inv_m_division a  WHERE a.INT_DIVIID IS NOT NULL ";
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			sql = sql + " ORDER BY a.CHR_DIVICODE ";
  	 	}
		else if("2".equals(type) )
		{
		 	 
			sql = " SELECT CONCAT('SERVICE'),a.CHR_DIVICODE, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'April' ,'"+fyear+"') APR, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'May' ,'"+fyear+"') MAY, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'June' ,'"+fyear+"') JUN, ";
			sql = sql + " (FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'April' ,'"+fyear+"') +FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'May' ,'"+fyear+"') +FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'June' ,'"+fyear+"'))  Q1 , ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'July' ,'"+fyear+"') JUL, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'August' ,'"+fyear+"') AUG, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'September' ,'"+fyear+"') SEP, ";
			sql = sql + " (FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'July' ,'"+fyear+"')+FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'August' ,'"+fyear+"')+FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'September' ,'"+fyear+"')) Q2, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'October' ,'"+fyear+"') OCTb, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'November' ,'"+fyear+"') NOV, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'December' ,'"+fyear+"') DECb, ";
			sql = sql + " (FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'October' ,'"+fyear+"')+FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'November' ,'"+fyear+"')+FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'December' ,'"+fyear+"')) Q3, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'January' ,'"+(fyear+1)+"') JAN, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'February' ,'"+(fyear+1)+"') FEB, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'March' ,'"+(fyear+1)+"') MAR, ";
			sql = sql + " (FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'January' ,'"+(fyear+1)+"')+FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'February' ,'"+(fyear+1)+"')+FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'March' ,'"+(fyear+1)+"')) Q4, ";
			sql = sql + " ( ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'April' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'May' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'June' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'July' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'August' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'September' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'October' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'November' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'December' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'January' ,'"+(fyear+1)+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'February' ,'"+(fyear+1)+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'March' ,'"+(fyear+1)+"')   ";
			sql = sql + " ) total  ";
			sql = sql + " FROM inv_m_division a  WHERE a.INT_DIVIID IS NOT NULL ";
			if(!"0".equals(division))
				sql = sql + " AND   a.INT_DIVIID = "+division;
			sql = sql + " ORDER BY a.CHR_DIVICODE ";
		}
		else if ("0".equals(type))
		{
			
			sql = " (   ";
			sql = sql + "SELECT CONCAT('DIRECT SALES'),a.CHR_DIVICODE, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'April' ,'"+fyear+"') APR, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'May' ,'"+fyear+"') MAY, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'June' ,'"+fyear+"') JUN, ";
			sql = sql + " (FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'April' ,'"+fyear+"') +FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'May' ,'"+fyear+"') +FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'June' ,'"+fyear+"'))  Q1 , ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'July' ,'"+fyear+"') JUL, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'August' ,'"+fyear+"') AUG, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'September' ,'"+fyear+"') SEP, ";
			sql = sql + " (FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'July' ,'"+fyear+"')+FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'August' ,'"+fyear+"')+FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'September' ,'"+fyear+"')) Q2, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'October' ,'"+fyear+"') OCTb, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'November' ,'"+fyear+"') NOV, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'December' ,'"+fyear+"') DECb, ";
			sql = sql + " (FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'October' ,'"+fyear+"')+FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'November' ,'"+fyear+"')+FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'December' ,'"+fyear+"')) Q3, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'January' ,'"+(fyear+1)+"') JAN, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'February' ,'"+(fyear+1)+"') FEB, ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'March' ,'"+(fyear+1)+"') MAR, ";
			sql = sql + " (FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'January' ,'"+(fyear+1)+"')+FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'February' ,'"+(fyear+1)+"')+FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'March' ,'"+(fyear+1)+"')) Q4, ";
			sql = sql + " ( ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'April' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'May' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'June' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'July' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'August' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'September' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'October' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'November' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'December' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'January' ,'"+(fyear+1)+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'February' ,'"+(fyear+1)+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SALES(a.INT_DIVIID,'March' ,'"+(fyear+1)+"')   ";
			sql = sql + " ) total  ";
			sql = sql + " FROM inv_m_division a  WHERE a.INT_DIVIID IS NOT NULL  ";
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			sql = sql + " ORDER BY a.CHR_DIVICODE ";
			sql = sql + " ) ";
			sql = sql + " UNION ";
			sql = sql + "(  ";
			
			sql = sql + "SELECT CONCAT('SERVICE'),a.CHR_DIVICODE, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'April' ,'"+fyear+"') APR, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'May' ,'"+fyear+"') MAY, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'June' ,'"+fyear+"') JUN, ";
			sql = sql + " (FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'April' ,'"+fyear+"') +FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'May' ,'"+fyear+"') +FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'June' ,'"+fyear+"'))  Q1 , ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'July' ,'"+fyear+"') JUL, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'August' ,'"+fyear+"') AUG, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'September' ,'"+fyear+"') SEP, ";
			sql = sql + " (FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'July' ,'"+fyear+"')+FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'August' ,'"+fyear+"')+FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'September' ,'"+fyear+"')) Q2, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'October' ,'"+fyear+"') OCTb, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'November' ,'"+fyear+"') NOV, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'December' ,'"+fyear+"') DECb, ";
			sql = sql + " (FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'October' ,'"+fyear+"')+FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'November' ,'"+fyear+"')+FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'December' ,'"+fyear+"')) Q3, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'January' ,'"+(fyear+1)+"') JAN, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'February' ,'"+(fyear+1)+"') FEB, ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'March' ,'"+(fyear+1)+"') MAR, ";
			sql = sql + " (FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'January' ,'"+(fyear+1)+"')+FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'February' ,'"+(fyear+1)+"')+FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'March' ,'"+(fyear+1)+"')) Q4, ";
			sql = sql + " ( ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'April' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'May' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'June' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'July' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'August' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'September' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'October' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'November' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'December' ,'"+fyear+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'January' ,'"+(fyear+1)+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'February' ,'"+(fyear+1)+"')   + ";
			sql = sql + " FUN_INV_TURNOVER_SERVICE(a.INT_DIVIID,'March' ,'"+(fyear+1)+"')   ";
			sql = sql + " ) total  ";
			sql = sql + " FROM inv_m_division a  WHERE a.INT_DIVIID IS NOT NULL ";
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			sql = sql + " ORDER BY a.CHR_DIVICODE  ";
			sql = sql + " ) ";
			
		}
		//out.println(sql);
		 
		String data[][] =  CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			double april=0.0;	
			double may=0.0;	
			double june=0.0;
			double july=0.0;
			double august=0.0;
			double september=0.0;
			double november=0.0;
			double october=0.0;
			double december=0.0;
			double january=0.0;
			double february=0.0;
			double march=0.0;
			double q1=0.0;
			double q2=0.0;
			double q3=0.0;
			double q4=0.0;
			double total=0.0;
			

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
				
				april = april+Double.parseDouble(data[u][2]);
				may = may+Double.parseDouble(data[u][3]);
				june = june+Double.parseDouble(data[u][4]);
				q1 = q1+Double.parseDouble(data[u][5]);
				july = july+Double.parseDouble(data[u][6]);
				august = august+Double.parseDouble(data[u][7]);
				september = september+Double.parseDouble(data[u][8]);
				q2 = q2+Double.parseDouble(data[u][9]);
				october = october+Double.parseDouble(data[u][10]);
				november = november+Double.parseDouble(data[u][11]);
				december = december+Double.parseDouble(data[u][12]);
				q3 = q3+Double.parseDouble(data[u][13]);
				january = january+Double.parseDouble(data[u][14]);
				february = february+Double.parseDouble(data[u][15]);
				march = march+Double.parseDouble(data[u][16]);
				q4 = q4+Double.parseDouble(data[u][17]);
				total = total+Double.parseDouble(data[u][18]);
				 
				mn.add(child); 
			}
				child = new Vector();
				child.addElement("");
				child.addElement("");
				child.addElement("Total : ");
				child.addElement(april);
				child.addElement(may);
				child.addElement(june);
				child.addElement(q1);
				child.addElement(july);
				child.addElement(august);
				child.addElement(september);
				child.addElement(q2);
				child.addElement(october);
				child.addElement(november);
				child.addElement(december);
				child.addElement(q3);
				child.addElement(january);
				child.addElement(february);
				child.addElement(march);
				child.addElement(q4);
				child.addElement(total);
				 
				mn.add(child); 
		} 
			
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25"  style="text-align:center" >
 
	<display:caption><%=reportheader.toUpperCase()%></display:caption>
	<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
	<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
	<display:column title="Type" sortable="true"><%=temp.elementAt(1)%></display:column>
	<display:column title="DIVISIONe" sortable="true"><%=temp.elementAt(2)%></display:column>
	<display:column title="APR" style="text-align:right"   sortable="true"><%=temp.elementAt(3)%></display:column>
	<display:column title="MAY" style="text-align:right"   sortable="true"><%=temp.elementAt(4)%></display:column>
	<display:column title="JUN" style="text-align:right"   sortable="true"><%=temp.elementAt(5)%></display:column>
	<display:column title="APR - JUN" style="text-align:right"   sortable="true"><%=temp.elementAt(6)%></display:column>
	<display:column title="JUL" style="text-align:right"   sortable="true"><%=temp.elementAt(7)%></display:column>
	<display:column title="AUG" style="text-align:right"   sortable="true"><%=temp.elementAt(8)%></display:column>
	<display:column title="SEP" style="text-align:right"   sortable="true"><%=temp.elementAt(9)%></display:column>
	<display:column title="JUL - SEP" style="text-align:right"   sortable="true"><%=temp.elementAt(10)%></display:column>
	<display:column title="OCT" style="text-align:right"   sortable="true"><%=temp.elementAt(11)%></display:column>
	<display:column title="NOV" style="text-align:right"   sortable="true"><%=temp.elementAt(12)%></display:column>
	<display:column title="DEC" style="text-align:right"   sortable="true"><%=temp.elementAt(13)%></display:column>
	<display:column title="OCT - DEC" style="text-align:right"   sortable="true"><%=temp.elementAt(14)%></display:column>
	<display:column title="JAN" style="text-align:right"   sortable="true"><%=temp.elementAt(15)%></display:column>
	<display:column title="FEB" style="text-align:right"   sortable="true"><%=temp.elementAt(16)%></display:column>
	<display:column title="MAR" style="text-align:right"   sortable="true"><%=temp.elementAt(17)%></display:column>
	<display:column title="JAN - MAR" style="text-align:right"   sortable="true"><%=temp.elementAt(18)%></display:column>
	<display:column title="NET [ APR - MAR ]" style="text-align:right"   sortable="true"><%=temp.elementAt(19)%></display:column>
	
	<display:setProperty name="export.excel.filename" value="Rept_FinancialYearMonthSales.xls"/>
	<display:setProperty name="export.pdf.filename" value="Rept_FinancialYearMonthSales.pdf"/>
	<display:setProperty name="export.csv.filename" value="Rept_FinancialYearMonthSales.csv"/>
	<display:setProperty name="export.pdf"  value="true" />
	 
	 
</display:table> 
    
<br />	<center>	<a style="text-align:right" href='Rept_FinancialYearMonthSales.jsp'> CLOSE</a></center>
 
 <%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>		 
</body>
</html>

