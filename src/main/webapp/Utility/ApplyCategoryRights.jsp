 <%@ page import="java.sql.*,java.util.*,java.io.*"%>
  <%@ page import="com.my.org.erp.common.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%
	
	String tablename=null;
	String fieldname=null;
%>
<html>
<head>

<title> :: UTILITY :: </title>
<%@include file="Redirect.jsp" %>	

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

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
  <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
 <body  onpaste='return false;'>
<form name="frm" method="post" action="SetRights.jsp">
  <br>
		
  <table width="100%" border="0" align="center" cellpadding="5" cellspacing="2">
          <tr>
            <td class="bold1"><div align="center">User Name : <%=request.getParameter("ename") %>
              <input type='hidden' name='UserName'value='<%= request.getParameter("ename") %>'>
            </div></td>
          </tr>
          <tr>
            <td class="bold1"><div align="center">
              <% 	
			  
			tablename=request.getParameter("Rights");
			 
		%>
            </div></td>
          </tr>
          
          <tr>
            <td class="bold1"><table width="95%" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
              <tbody>
                <tr>
                  <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
                  <td class="BorderLine" height="1"> </td>
                  <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="9" /></td>
                </tr>
                <tr>
                  <td height="6"> </td>
                </tr>
                <tr>
                  <td class="BorderLine" width="1"> </td>
                  <td width="10"> </td>
                  <td  valign="top"><table width="100%"  height="25" border="0" align="center"
						 >
                       

                      <tr>
                        <td valign="middle" bgcolor="#DEE7FF" class="tabledata">
						<%
							String  data[] = request.getParameterValues("Rights");
							String category="";
							for(int u=0;u<data.length;u++)
								category= category+data[u]+",";
							category = category.substring(0,category.length()-1);		
							
							 CommonFunctions.Execute(" UPDATE m_user SET CHR_GATEGORYLIST='"+category+"' WHERE CHR_EMPID='"+request.getParameter("ename")+"'");
							 
							
						%>
 <p align="center" class="boldThirteen">Do you set Rights for another user : <a href="UserCategory.jsp">YES</a>/<a href="Userframe.jsp">NO</a>
</p>
 
                           </td>
                      </tr>

                  </table></td>
                  <td nowrap="nowrap" width="8"> </td>
                  <td width="1" class="BorderLine"> </td>
                </tr>
                <tr>
                  <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
                  <td height="6"> </td>
                  <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div></td>
                </tr>
                <tr>
                  <td class="BorderLine" height="1"></td>
                </tr>
              </tbody>
            </table></td>
          </tr>
          <tr>
            <td class="bold1"><div align="center"></div></td>
          </tr>
          <tr>
            <td></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF"> </td>
          </tr>
  </table>
	 
</form>
</body>
</html>
