<%@ page contentType="text/html; " language="java" import="java.sql.*" 	errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

 <%
   try
   {
   
	 %>
<html>
<head>

<title> :: UTILITY :: </title>

<%@include file="Redirect.jsp" %>
 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function  Valid()
{
	var name=confirm("Want to update the settings")
	if (name==true)
	{ 
		validate()			
	}
	else
		return false;
}		 

function  validate()
{
	 
		return true;
	 
}
</script>
 </head>
 

		 
		 
	
         
<body  onpaste='return false;'>
<form name="a" action="HRMSettingResponse.jsp" onSubmit="return Valid()">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
	  <td height="34" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
	<tr>
	  <td height="19" align="center"><table width="800" border="0" align="center" cellpadding="0"
					cellspacing="0" bgcolor="#dce4f9" class="BackGround">
        <tbody>
          <tr>
            <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TLCorner.gif" width="7" /></td>
            <td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
            <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TRCorner.gif" width="7" /></td>
          </tr>
          <tr>
            <td height="6"><spacer height="1" width="1" type="block" /></td>
          </tr>
          <tr>
            <td class="BorderLine" width="1"><spacer height="1"
								width="1" type="block" /></td>
            <td width="6"><spacer height="1" width="1" type="block" /></td>
            <td width="577" valign="top"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="100%"><div align="center" class="copyright">HRM SETTING
                      <%
						  
						  String Data[][] =  CommonFunctions.QueryExecute("SELECT  CHR_MAILALERT , CHR_MAILIDS_CAREER , CHR_MAILIDS_EMPLOYEE_VERIFICATION from m_hrm_setting WHERE INT_ROWID  =1");
						  %>
                  </div></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td><div align="center">
                      <table width="100%" border="0" cellspacing="4" cellpadding="3">
                         
                         
                        <tr>
                          <td width="21%" class="boldEleven">Mail Enable feature<span class="boldred"> *</span></td>
                          <td width="28%" class="boldEleven"> 
						    <input name="mailenable" type="checkbox" id="mailenable" <%=( ("Y".equals(Data[0][0]))?" checked='checked'":" " )%>  value="Y"></td>
                          <td width="28%" class="boldEleven">&nbsp;</td>
                          <td width="23%" class="boldEleven">&nbsp;</td>
                        </tr>
                        <tr>
                          <td align="left" valign="top" class="boldEleven">mail ids for Career  <span class="boldred">*</span></td>
                          <td align="left" valign="top" class="boldEleven"><textarea name="career" cols="30" rows="5" class="formText135" id="career"><%=Data[0][1]%></textarea></td>
                          <td align="left" valign="top" class="boldEleven"> <span class="boldred"></span>mail ids for employee verification </td>
                          <td align="left" valign="top" class="boldEleven"> 
                            <textarea name="verification" cols="30" rows="5" class="formText135" id="verification"><%=Data[0][2]%></textarea>
                            </td>
                        </tr>
                        <tr>
                          <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                          <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                          <td align="left" valign="top" class="boldEleven">&nbsp; </td>
                          <td align="left" valign="top" class="boldEleven">&nbsp; </td>
                        </tr>
                         
                         
                      </table>
                  </div></td>
                </tr>
                <tr>
                  <td></td>
                </tr>
                <tr>
                  <td height="28"><center>
                      <table border="0" align="center" cellpadding="1"
										cellspacing="1">
                        <tr>
                          <td width="56"><input name="Submit2" type="submit"
												class="buttonbold" value="Submit"   accesskey="s"   ></td>
                          <td width="56"><input class="buttonbold" type="button"
												name="Submit2"  value="Close"   accesskey="c"  onClick="redirect('Userframe.jsp')"></td>
                        </tr>
                      </table>
                  </center></td>
                </tr>
            </table></td>
            <td nowrap="nowrap" width="6"><spacer height="1" width="1"
								type="block" /></td>
            <td width="1" class="BorderLine"><spacer height="1"
								width="1" type="block" /></td>
          </tr>
          <tr>
            <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/BLCorner.gif" width="7" /></td>
            <td height="6"><spacer height="1" width="1" type="block" /></td>
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
	  <td height="19" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
</table>

</form>
</body>
</html>
<%
	}  
	catch(Exception e)
	{
	} 
	        
        %>
