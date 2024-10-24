<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%><html xmlns="http://www.w3.org/1999/xhtml">
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
<script language="javascript">
function checkall()
{
var sel="";
 if(document.getElementById("SA").checked)
 {
 		sel=document.forms[0].staff;
 	    for(i=0;i<sel.length;i++)
 	       sel[i].checked=true;
 }
 else
 {
 		sel=document.forms[0].staff;
 	    for(i=0;i<sel.length;i++)
 	       sel[i].checked=false;
 }
}
</script>




<body  onpaste='return false;'><form name="form3a" method="post" action="Form3a.jsp">

  <%@ include file="index.jsp"%>
 

  <%
		int byear=0,cyear=0;
		 
		String comid=request.getParameter("company");
		String branchid=request.getParameter("branch");
		String officeid=request.getParameter("Office");
		String year=request.getParameter("Year");
		String Category=request.getParameter("Category");
		String dept=request.getParameter("dept");
		 
		 
		String cpy  ="",cyend="",byend="",dis="";
		String bid  ="";
		String off="";
		String yer="";
		
		byear=(Integer.parseInt(year)-1);
		cyear=Integer.parseInt(year);
		cyend=year.substring(2,4);
		byend=((""+byear).trim()).substring(2,4);
		
		String sql="";
		sql=" SELECT b.CHR_EMPID, b.CHR_PFNO,a.CHR_EMPNAME ";
		sql = sql+"	FROM  com_m_staff b,pay_t_salary a ";                               
		sql = sql+"	WHERE b.CHR_TYPE!='T' AND b.CHR_HOLD!='Y'";
		if(!"0".equals(dept))
			sql = sql+" AND b.INT_DEPARTID="+dept;
		if(!"0".equals(Category))
			sql = sql+" AND b.CHR_CATEGORY="+Category;
		if(!"0".equals(comid))
			sql = sql+" AND b.INT_COMPANYID = "+comid;
		
		if(!"0".equals(branchid))
			sql = sql+" AND b.INT_BRANCHID = "+branchid;
		
		if(!"0".equals(officeid))
			sql = sql+" AND b.INT_OFFICEID = "+officeid;
			
		sql = sql+" AND a.CHR_EMPID=b.CHR_EMPID group BY a.CHR_EMPID";
		String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		
		sql = " SELECT a.CHR_COMPANYNAME,a.CHR_STREET,f.CHR_CITYNAME,a.INT_PINCODE,a.CHR_PFNUMBER, ";
		sql = sql + " c.CHR_COUNTRYNAME,d.CHR_STATENAME,e.CHR_DISTRICT,f.CHR_CITYNAME  ";
		sql = sql + " FROM com_m_company a, com_m_country c, com_m_state d, com_m_district e, com_m_city f ";
		sql = sql + " WHERE a.INT_COUNTRYID= c.INT_COUNTRYID ";
		sql = sql + " AND a.INT_STATEID = d.INT_STATEID ";
		sql = sql + " AND a.INT_DISTRICTID = e.INT_DISTRICTID ";
		sql = sql + " AND a.INT_CITYID = f.INT_CITYID ";
		sql = sql + " AND a.INT_COMPANYID="+comid;
		String datac[][]=CommonFunctions.QueryExecute(sql);
	
%>
<br><br>

<table width="689" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#333399" class="BackGround">
          <tr>
            <td height="27" colspan="3" ><div align="center" class="tablesubhead" >Form No.3A(Revised) Employees List For- &nbsp;<%= datac[0][0] %>. Apr -<%= byear %> to Mar - <%= cyear %></div><br />
			<div align="right">
		  <input name="SA" type="checkbox" id="SA" value="A" onClick="checkall()"/>
		  <span class="bolddeepred">Select All&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
        </div>
			</td>
          </tr>
          <tr bgcolor="#FFDDDD">
            <td width="97" height="23" class="tablesubhead"><div align="center">Sl.No</div></td>
            <td width="178" class="tablesubhead"><div align="center">EmpId</div></td>
            <td width="406" class="tablesubhead"><div align="center">Staff Name </div></td>
          </tr>
          <tr>
            <td height="29" colspan="3"><div style="overflow:auto;height:400px;width:680px;">
			  <table width="100%" border="0" cellpadding="1" cellspacing="1">
                <%
				dis="disabled='disabled'";
			
			for(int i=0;i<data.length;i++)
			{
				dis="";
				
				if(i%2==0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");
					
				  out.println("<td height='25' class='boldEleven'>"+(i+1)+"<input type='checkbox' name='staff'  id='staff' value='"+data[i][0]+"'></td>");
				  out.println("<td class='boldEleven'>&nbsp;"+data[i][0]+"</td>");
				  out.println("<td class='boldEleven'>&nbsp;"+data[i][2]+"</td>");
				  out.println("</tr>");
			}
			
			%>
              </table>
		
	<input type="hidden" name="company" value="<%= comid %>"/>
	<input type="hidden" name="branch" value="<%= branchid %>"/>
	<input type="hidden" name="Office" value="<%= officeid %>"/>
	<input type="hidden" name="Year" value="<%= year %>"/>
	</div></td>
          </tr>
  </table>
		<table width="100" border="0" align="center" cellpadding="2" cellspacing="2">
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td width="50"><input name="Submit" type="submit" class="buttonbold14" <%= dis %> value="Submit"   accesskey="s"    /></td>
            <td width="50"><input name="Submit2" type="button" class="buttonbold14"  value="Close"   accesskey="c"  onClick="redirect('PF-FORM3A.jsp')"/></td>
          </tr>
        </table>
		
		
		  <%@ include file="../footer.jsp"%>
           
</p></form></body>
</html>
