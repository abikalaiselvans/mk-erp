 <%@ page import="com.my.org.erp.common.CommonFunctions"%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage=""%>
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

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
 

<script language="javascript" src="../JavaScript/comfunction.js"></script>
  </head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="200"><table class="BackGround" cellspacing="0" cellpadding="0" width="200"
			align="center" border="0">
        <tbody>
          <tr>
            <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
            <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
            <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
          </tr>
          <tr>
            <td height="6"><spacer height="1" width="1" type="block" /></td>
          </tr>
          <tr>
            <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
            <td width="6"><spacer height="1" width="1" type="block" /></td>
            <td width="412"><table width="100%" height="124" border="0" align="center"
						  class="bolddeepblue">
                <!--DWLayoutTable-->
                <tr align="center" valign="middle">
                  <td width="390" height="28" colspan="3" align="center"
								valign="middle" class="boldgre"><div align="center"> SALARY  REPORT
                    <%
							String rowid = request.getParameter("rowid"); 
							String sql ="";
sql ="SELECT FIND_A_EMPLOYEE_ID_NAME(CHR_EMPID),CHR_MONTH,INT_YEAR, ";
sql = sql +" CHR_DESC,DATE_FORMAT(DAT_LOW,'%d-%m-%Y'),FIND_A_EMPLOYEE_ID_NAME(CHR_AUTHORAISEDBY) ";
sql = sql +"  FROM  pay_t_salaryhold  WHERE INT_ROWID= "+rowid;
String empdata[][]= CommonFunctions.QueryExecute(sql);
 
							

							%>
                  </div></td>
                </tr>
                <tr>
                  <td height="28" valign="middle" class="bolddeepblue"><table width="100%" border="0" cellpadding="3" cellspacing="3" class="boldEleven">
                      <tr>
                        <td width="17%">1.</td>
                        <td width="83%"><a href="Salary Report.jsp">Alive</a></td>
                      </tr>
                      <tr>
                        <td>2.</td>
                        <td><a href="Salary_Report_Resigned.jsp">Resigned</a></td>
                      </tr>
                     <!-- <tr>
                        <td>3.</td>
                        <td><a href="SalaryStoppedEmployeeReport.jsp">Stopped</a></td>
                      </tr>-->
                  </table></td>
                </tr>
                <tr>
                  <td height="29" valign="middle" class="bolddeepblue"><table border="0" align="center" cellpadding="3" cellspacing="3">
                      <tr>
                        <td width="56"><input name="Button" type="button"
										class="ButtonHead"  value="Close"   accesskey="c" 
										onclick="redirect('Payrollmain.jsp')" /></td>
                      </tr>
                  </table></td>
                </tr>
            </table></td>
            <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
            <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          </tr>
          <tr>
            <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
            <td height="6"><spacer height="1" width="1" type="block" /></td>
            <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
          </tr>
          <tr>
            <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
          </tr>
        </tbody>
      </table></td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
