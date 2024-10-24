 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%
try
{
%>
<html>
<head>

<title> :: PAYROLL ::</title>


 

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
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<%
	String addsql="";
	String repName="";
	String repHeader="";
	String bankcondition="";
	String cpy="";
	String bid="";
	String cat="";
	String office= ""+request.getParameter("Office");
	String dept= ""+request.getParameter("dept");
	String type= ""+request.getParameter("type");
	
	
	String month= ""+request.getParameter("month");
	String year= ""+request.getParameter("year");
	String repmon = DateUtil.getMonth(Integer.parseInt( month));
	String company= ""+request.getParameter("company");
	String branch= ""+request.getParameter("branch");
	String Category= ""+request.getParameter("Category");
	String salarynotissue= ""+request.getParameter("salarynotissue");
	
	if(!"0".equals(company))
		cpy= " AND b.INT_COMPANYID="+company;
	if(!"0".equals(branch))
		bid= " AND b.INT_BRANCHID="+branch;
	if(!"0".equals(Category))
 		cat = " AND b.CHR_CATEGORY='"+Category +"' ";	
	
	 
	String empid= ""+request.getParameter("empid");
	String empname= ""+request.getParameter("empname");
	String basic= ""+request.getParameter("basic");
	String wdays= ""+request.getParameter("wdays");
	String pf= ""+request.getParameter("pf");
	String esi= ""+request.getParameter("esi");
	String mess= ""+request.getParameter("mess");
	String advance= ""+request.getParameter("advance");
	String netpay= ""+request.getParameter("netpay");
	String monhpay= ""+request.getParameter("monhpay");
	String cpyesi= ""+request.getParameter("cpyesi");
	String cpypf= ""+request.getParameter("cpypf");
	String bank= ""+request.getParameter("bank");
	String acno= ""+request.getParameter("acno");
	String ifsc= ""+request.getParameter("ifsc");
	
	String ctc= ""+request.getParameter("ctc");
	 
	String hold= ""+request.getParameter("hold");
	String PFNumber= ""+request.getParameter("PFNumber");
	String ESINumber= ""+request.getParameter("ESINumber");
	String pfdoj= ""+request.getParameter("pfdoj");
	
	
	String allsql="";
	String regflag="";
	String holdflag="";
	
	  
regflag=regflag+" AND b.CHR_TYPE ='T' ";
holdflag=holdflag+" AND b.CHR_HOLD ='Y'   ";	
 
	 
	String banksql="";
	repHeader=repHeader+"S.No,";
	repHeader=repHeader+"Empid,Name,Company,Branch,Office, Depart,Category,Staff Type,";
	addsql=addsql+" a.CHR_EMPID , a.CHR_EMPNAME,e.CHR_COMPANYNAME , z1.CHR_BRANCHNAME,d.CHR_OFFICENAME,c.CHR_DEPARTNAME,z.CHR_CATEGORYNAME,b.CHR_TYPE,";
	
	if("Y".equals(empname))
	{
		addsql=addsql+" a.CHR_EMPNAME , ";
		repHeader=repHeader+"Empname,";
	}
	
	if("Y".equals(wdays))
	{
		addsql=addsql+" a.DOU_WORKDAYS , ";
		repHeader=repHeader+"Working days,";
	}
		
	if("Y".equals(basic))
	{
		addsql=addsql+" FORMAT(a.DOU_BASIC,2) , ";
		repHeader=repHeader+"Basic,";
	}
	
	//Allowance Calculations
	if(!"null".equals(""+request.getParameter("Acheckbox")))
	{
		String Allowance[]= request.getParameterValues("Acheckbox");
		for(int u=0;u<Allowance.length;u++)
		{
			addsql=addsql+" a."+Allowance[u]+", ";
			allsql ="select CHR_ANAME FROM pay_m_allowance where CHR_ACODE='"+Allowance[u]+"'";
			String alldata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(allsql);
			repHeader=repHeader+alldata[0][0]+",";
		}
	}
	 
	repHeader=repHeader+"Added ,";
	addsql=addsql+" FORMAT(a.DOU_ATOTAL1,2) , ";
	repHeader=repHeader+"Extra ,";	 
	addsql=addsql+" FORMAT(a.DOU_ATOTAL2,2) , ";
	repHeader=repHeader+"Gross Pay,";
	addsql=addsql+" FORMAT(a.DOU_GROSSPAY,2) , ";
	
	//Recovery Calculations
	if(!"null".equals(""+request.getParameter("Rcheckbox")))
	{
		String Recovery[]= request.getParameterValues("Rcheckbox");
		for(int u=0;u<Recovery.length;u++)
		{
			addsql=addsql+" a."+Recovery[u]+", ";
			allsql ="select CHR_RNAME FROM pay_m_recovery where CHR_RCODE='"+Recovery[u]+"'";
			String alldata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(allsql);
			repHeader=repHeader+alldata[0][0]+",";
		}
	}
	
	//Pay Taxvalue;
	repHeader=repHeader+"Pay Taxvalue,";	
	addsql=addsql+" a.DOU_PAYTAX, ";
	repHeader=repHeader+"Total Recovery,";
	addsql=addsql+" a.RTOTAL , ";
	
	
	
	if("Y".equals(pfdoj))
	{
		addsql=addsql+" DATE_FORMAT(b.DAT_PFESIDATE,'%d-%b-%Y') , ";
		repHeader=repHeader+"PF Date of Joinning,";
	}
	if("Y".equals(PFNumber))
	{
		addsql=addsql+" b.CHR_PFNO , ";
		repHeader=repHeader+"PF Number,";
	}
	if("Y".equals(pf))
	{
		addsql=addsql+" FORMAT(a.DOU_PF,2) , ";
		repHeader=repHeader+"PF,";
	}
	
	
	if("Y".equals(ESINumber))
	{
		addsql=addsql+" b.CHR_ESINO , ";
		repHeader=repHeader+"ESI Number,";
	}
	if("Y".equals(esi))
	{
		addsql=addsql+" FORMAT(a.DOU_ESI,2) , ";
		repHeader=repHeader+"ESI,";
	}
	
	
	if("Y".equals(mess))
	{
		addsql=addsql+" FORMAT(a.DOU_MESS,2) , ";
		repHeader=repHeader+"Mess,";
	}
	
	
	if("Y".equals(advance))
	{
		addsql=addsql+" FORMAT(a.DOU_ADVANCE,2) , ";
		repHeader=repHeader+"Advance,";
	}
	repHeader=repHeader+"Total Recovery,";
	addsql=addsql+" FORMAT(a.DOU_TOTALRECOVERY,2) , ";
	
	if("Y".equals(netpay))
	{
		addsql=addsql+" FORMAT(a.DOU_NETSAL,2) , ";
		repHeader=repHeader+"Net Pay,";
	}
	
	
	if("Y".equals(monhpay))
	{
		addsql=addsql+" FORMAT(a.DOU_MONTHSAL,2) , ";
		repHeader=repHeader+"Month Pay,";
	}
	
	
	if("Y".equals(cpyesi))
	{
		addsql=addsql+" FORMAT(a.DOU_CPYESI,2) , ";
		repHeader=repHeader+"CPY ESI,";
	}
	
	
	if("Y".equals(cpypf))
	{
		addsql=addsql+" FORMAT(a.DOU_CPYPF1,2) , FORMAT(a.DOU_CPYPF2,2),";
		repHeader=repHeader+"CPY PF-1, CPY PF-2,";
	}
	
	if("Y".equals(bank))
	{
		addsql=addsql+"  FIND_A_BANKGROUP_NAME(b.CHR_BANK) , ";
		 
		repHeader=repHeader+"Bank,";
		 
	}
	
	if("Y".equals(acno))
	{
		addsql=addsql+" CONCAT('A/c:',b.CHR_ACCNO)  , ";
		repHeader=repHeader+"A/C NO,";
		//banksql=" ,com_m_bank f ";
	}
	
	if("Y".equals(ifsc))
	{
		addsql=addsql+" CONCAT('',b.CHR_IFSC)  , ";
		repHeader=repHeader+"IFSC CODE,";
		
	}
	
	
	if("Y".equals(ctc))
	{
		addsql=addsql+" FORMAT(a.DOU_CTC,2) , ";
		repHeader=repHeader+"CTC,";
	}
	
	
	
	
	
	String sql="";
	String off="";
	String offname="";
	String offnamedesc="";
	String dep="";
	if(!"0".equals(office))
	{
		off=" AND b.INT_OFFICEID="+office;
		sql=" SELECT CHR_OFFICENAME FROM  com_m_office  WHERE  INT_OFFICEID ="+office;
		offname=com.my.org.erp.common.CommonFunction.stringGetAnySelectField(sql, "CHR_OFFICENAME");
		offnamedesc=" - OFFICE NAME "+offname;
	}	
	if(!"0".equals(dept))
		dep=" AND b.INT_DEPARTID= "+dept;
	
	repName = "SALARY CALCULATION "+offnamedesc;
 	repName = repName + " ( " +repmon + " - ";
 	repName = repName +  year + " ) ";
	
 	addsql=addsql.trim();			
	addsql = addsql.substring(0,addsql.length()-1);	
	sql="";
	sql = " SELECT "+addsql;
	sql = sql+ " FROM pay_t_salary a , com_m_staff b  ,com_m_depart c , com_m_office  d,  com_m_employeecategory  z, com_m_branch z1, com_m_company e "+banksql;
	sql = sql+ "  WHERE a.CHR_MONTH ='"+repmon+"'  "+regflag+holdflag;
	sql = sql+" AND b.CHR_CATEGORY=z.INT_EMPLOYEECATEGORYID AND b.DT_DOJCOLLEGE<='"+year+"-"+month+"-31"+"'";
	sql = sql+ "  AND a.INT_YEAR="+ year+" ";
	sql = sql+ "  AND a.CHR_EMPID=b.CHR_EMPID "; 
	sql = sql+bankcondition;
	sql = sql+off; 
	sql = sql+dep;
	sql = sql+cpy;
	sql = sql+bid;
	sql = sql+cat;
	if(!"0".equals(type))
		if("CONSOLIDATE".equals(type))
			sql = sql +" AND b.CHR_TYPE='CONSOLIDATE' ";
		else
			sql = sql +" AND b.CHR_TYPE !='CONSOLIDATE' ";
	
	
	
	if("Y".equals(salarynotissue))
		sql = sql +" AND a.CHR_ISSUEMODE ='0'";
	
	sql = sql+" AND b.INT_OFFICEID = d.INT_OFFICEID ANd b.INT_DEPARTID = c.INT_DEPARTID AND b.INT_COMPANYID=e.INT_COMPANYID AND  b.INT_BRANCHID = z1.INT_BRANCHID ";
	sql = sql+ "  ORDER BY a.CHR_EMPNAME ";
	
	  //out.println(sql);
	
	
	
	
	String reportdata[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
	String repdata[]=repHeader.split(",");
	String staffid="";
	out.println("<br><br><br>");
	out.println("<center> <table  id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' width='80%' >");
	if(reportdata.length>0)
	{
		out.println("<tr  bgcolor='#ffffff'><td colspan=\""+repdata.length+"\"><h3>"+repName+"</h3></td></tr>");
		out.println("<tr  bgcolor='#ffffff'>");
		for(int x=0;x<repdata.length;x++)
		out.println("<td class=\"boldEleven\"><b>"+repdata[x]);
		
		
		for(int x=0;x<reportdata.length;x++)
		{
			staffid=reportdata[x][0];
			sql=" SELECT count(*) FROM com_m_staff WHERE CHR_TYPE='T' AND CHR_EMPID='"+staffid+"'";
			if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
			{
				out.println("<tr bgcolor='#ff0000'>");
				out.println("<td  class=\"boldEleven\">"+(x+1)+"****");
			}
			else
			{
				out.println("<tr  bgcolor='#ffffff' class='MRow1'>");
				out.println("<td  class=\"boldEleven\">"+(x+1));
			}
			
			for(int y=0;y<repdata.length-1;y++)
			{
				out.println("<td  class=\"boldEleven\" align=\"right\">"+reportdata[x][y]);
			}
		}	
	}
	else
	{
		out.println("<tr  bgcolor='#ffffff' class='MRow1'>");
		out.println("<td  class=\"bolddeepred\" ><center>Data not found...</center></td>");
		out.println("</tr>");
	}
	out.println("</table></center>");
%>

<!--<table width="184" align="center" cellpadding="15" cellspacing="0">
	<tr>
		<td width="100" height="44" class="boldEleven"><strong>Export
		</strong></td>
		<td class="boldEleven">
		<div align="center"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a>
		</div>
		</td>

		<td class="boldEleven">
		<div align="center"><a title="Text" href=javascript:;
			onClick="windowSave('Salary.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('Salary.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('Salary.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
		</td>

	</tr>
</table>-->
<p>
  <%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
</p>
<table width="60" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><input class="buttonbold14" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('Salary Report.jsp')"></td>
  </tr>
</table>
<p>&nbsp; </p>
