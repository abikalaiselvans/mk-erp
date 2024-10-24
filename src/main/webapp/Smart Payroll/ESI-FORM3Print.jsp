<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*" %>
<html>
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


<title> :: PAYROLL ::</title>


 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body  onpaste="return false;" topmargin="0" leftmargin="0">
<p>
  <%
try
{

	String company =request.getParameter("company");
	String branch =request.getParameter("branch");
	String office =request.getParameter("Office");
	String frmdate =request.getParameter("frmdate");
	String todate =request.getParameter("todate");
	frmdate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(frmdate);
	todate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
	String sql="";
	
	sql =" SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,'','','','' ";
	sql = sql +" FROM    com_m_branch a , com_m_company b ";
	sql = sql +" WHERE a.INT_COMPANYID=b.INT_COMPANYID ";
	sql = sql +" AND INT_BRANCHID="+branch;
	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	String officeName=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  CHR_OFFICESHORTNAME  FROM  com_m_office  WHERE INT_OFFICEID="+office)[0][0];
	String place=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME FROM  com_m_office  WHERE INT_OFFICEID="+office)[0][0];
	String date=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(now(),'%d-%m-%Y') FROM  com_m_office  WHERE INT_OFFICEID="+office)[0][0];
	String esinumber=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_ESINUMBER FROM m_institution WHERE INT_ID=1")[0][0];
	
	 
 
%>
</p>
<p>&nbsp;</p>
<table width="750" align="center"  cellpadding=2 cellspacing=1 bgcolor='#9900CC' id='myTable'>
  <tr>
    <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="5" cellpadding="2">
      <tr>
        <td colspan="2"><h4 align="center"><strong>FORM No.3</strong></h4></td>
      </tr>
      <tr>
        <td colspan="2"><div align="center"><strong>(See Regulation 14 of the Employees' State Insurance (General) Regulations, 1950)</strong></div></td>
      </tr>
      <tr>
        <td colspan="2"><div align="center"><strong>EMPLOYEES' STATE INSURANCE CORPORATION RETURN OF DECLARATION FORM</strong></div></td>
      </tr>
      <tr>
        <td width="56%" valign="top" class="boldEleven">1. Name and Address of the Factory or Establishment :</td>
        <td width="44%" valign="top" class="boldEleven">
		<%
			if(!data[0][0].equals("-"))
				out.println(data[0][0]+",<br>");
			if(!data[0][2].equals("-"))
				out.println(data[0][2]+",<br>");
			if(!data[0][3].equals("-"))
				out.println(data[0][3]+",<br>");
			if(!data[0][4].equals("-"))
				out.println(data[0][4]+",<br>");	
			if(!data[0][5].equals("-"))
				out.println("Pincode : "+data[0][5]+".<br>");
		%>
		</td>
      </tr>
      <tr>
        <td valign="top" class="boldEleven">2. Employer's Code No . </td>
        <td valign="top" class="boldEleven">
		<%
		out.println(esinumber+" - "+officeName);
		%>
		</td>
      </tr>
      <tr>
        <td colspan="2" class="boldEleven"><div align="justify" class="boldEleven">I sent herewith the Declaration Forms in respect of the employees' mentioned below I hereby declare that every employed as an employee within the meaning of Section 2 (9) of the Employees' State Insurance Act, 1948 on in this factory or establishment and in receipt of a remunaration not exceeding Rs.10000/- ( exceeding remuneration for overtime work) per month has been included in this list(excepting only those in respect of whom declaration have been sent to the Corporation in the past).</div></td>
        </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><table width="70%" border="0" align="left" cellpadding="2" cellspacing="2">
          <tr>
            <td width="14%" class="boldEleven">Place</td>
            <td width="86%" class="boldEleven"><%=place%></td>
          </tr>
          <tr>
            <td class="boldEleven">Date</td>
            <td class="boldEleven"><%=date%></td>
          </tr>
        </table></td>
        <td><table width="63%" border="0" align="right" cellpadding="2" cellspacing="2">
          <tr>
            <td width="39%" class="boldEleven">Signature</td>
            <td width="61%" class="boldEleven">&nbsp;</td>
          </tr>
          <tr>
            <td class="boldEleven">&nbsp;</td>
            <td class="boldEleven">&nbsp;</td>
          </tr>
          <tr>
            <td class="boldEleven">Designation</td>
            <td class="boldEleven">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2"><table width="100%"    cellpadding=2 cellspacing=1 bgcolor='#9900CC'>
           
          <tr bgcolor="#FFFFFF">
            <td width="6%" class="boldEleven"><b>Sl.No. </td>
            <td width="15%" class="boldEleven"><b>Employee Id </td>
            <td width="20%" class="boldEleven"><b>Name of the Employee</td>
            <td width="19%" class="boldEleven"><b>Distinguishing No.with the employer, if any</td>
            <td width="16%" class="boldEleven"><b>Father's or Husband's Name</td>
            <td width="24%" class="boldEleven"><b>Insurance No.allotted by the Corporation ( to be entered at the appropriate office)</td>
          </tr>
		  
		  <%
		  	sql = " SELECT CHR_EMPID,CHR_STAFFNAME,CHR_STAFFFNAME,CHR_ESINO,DT_DOJCOLLEGE FROM  com_m_staff  ";
		  	sql = sql +" WHERE DT_DOJCOLLEGE >='"+frmdate+"'  ";
			sql = sql +" AND DT_DOJCOLLEGE <='"+todate+"'  ";
			sql = sql +" AND INT_COMPANYID="+company;
			sql = sql +" AND INT_BRANCHID="+branch; 
			sql = sql +" AND INT_OFFICEID="+office;
			sql = sql +" ORDER BY CHR_STAFFNAME  ";
			//out.println(sql);
			String datas[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(datas.length>0)
			{
				for(int u=0;u<datas.length;u++)
				{
					out.println("<tr bgcolor='#FFFFFF'>");
					out.println("<td class='boldEleven'>"+(u+1));
					out.println("<td class='boldEleven'>"+datas[u][0]);
					out.println("<td class='boldEleven'>"+datas[u][1]);
					out.println("<td class='boldEleven'>&nbsp;");
					out.println("<td class='boldEleven'>"+datas[u][2]);
					out.println("<td class='boldEleven'>"+datas[u][3]);
					 
				}
			}
			
	
		  %>
          
        </table></td>
      </tr>
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
<p>&nbsp;</p>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
</body>
</html>
