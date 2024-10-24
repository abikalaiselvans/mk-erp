<%@ page contentType="text/html; " language="java" import="java.sql.*" 	errorPage="../error/index.jsp"%>
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

function  validate()
{
	if( 
	
		checkNull('host','Enter the Host Name...')
		&& checkNull('userid','Enter the userid...')
		&& chkemail("Groupmailid")
		&& chkemail("mailid")
		&& checkNull('password','Enter the password...')

	
	  )
		return true;
	else
		return false;
}


 
</script>
 </head>
 

		 
		 
	
         
<body  onpaste='return false;'>
<form name="frm" action="MailSettingsUpdate.jsp" onSubmit="return validate()">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
	  <td height="34" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
	<tr>
	  <td height="19" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
	<tr>
		<td height="170" align="center"><table width="600" border="0" align="center" cellpadding="1"
			cellspacing="1">
          <tr>
            <td width="594"><table width="100%" border="0" align="center" cellpadding="0"
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
                    <td valign="top"><table width="500" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td width="100%"><div align="center" class="copyright">MAIL SETTING 
<%

String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID,CHR_GROUPMAILD,CHR_INVOICE_DELETE,CHR_PR_APPROVAL,CHR_PR_CLOSED FROM  m_mailsetting WHERE INT_MAILID = 1");
%>
						  
						  </div></td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td><div align="center">
                              <table width="600" border="0" cellspacing="4" cellpadding="3">
                                <tr>
                                  <td width="186" class="boldEleven"> Host </td>
                                  <td width="188"><span class="boldEleven">
                                    <input name="host" type="text" class="formText135" id="host" value="<%=Data[0][0]%>" size="30" maxlength="100">
                                  </span></td>
                                  <td width="123" class="boldEleven">Groupmailid</td>
                                  <td width="199"><span class="boldEleven">
                                    <input name="Groupmailid" type="text" class="formText135" id="Groupmailid" value="<%=Data[0][4]%>" size="30" maxlength="100">
                                  </span> </td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">User id </td>
                                  <td><span class="boldEleven">
                                    <input name="userid" type="text" class="formText135" id="userid" value="<%=Data[0][1]%>" size="30" maxlength="100">
                                  </span></td>
                                  <td class="boldEleven">Mail id </td>
                                  <td><span class="boldEleven">
                                    <input name="mailid" type="text" class="formText135" id="mailid" value="<%=Data[0][3]%>" size="30" maxlength="100">
                                  </span></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Password</td>
                                  <td><span class="boldEleven">
                                    <input name="password" type="text" class="formText135" id="password" value="<%=Data[0][2]%>" size="30" maxlength="100">
                                  </span></td>
                                  <td class="boldEleven">P.R Approval </td>
                                  <td><span class="boldEleven">
                                    <input name="prapproval" type="text" class="formText135" id="prapproval" value="<%=Data[0][6]%>" size="30" maxlength="100">
                                  </span></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Inventroy Deleted </td>
                                  <td><span class="boldEleven">
                                    <input name="inventroydelete" type="text" class="formText135" id="inventroydelete" value="<%=Data[0][5]%>" size="30" maxlength="100">
                                  </span></td>
                                  <td class="boldEleven">P.R Closed </td>
                                  <td><span class="boldEleven">
                                    <input name="perclosed" type="text" class="formText135" id="perclosed" value="<%=Data[0][7]%>" size="30" maxlength="100">
                                  </span></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp; </td>
                                  <td>&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td>&nbsp;</td>
                                </tr>
                              </table>
                          </div></td>
                        </tr>
                        <tr>
                          <td></td>
                        </tr>
                        <tr>
                          <td height="28">
						  <center>
						  <table border="0" align="center" cellpadding="1"
										cellspacing="1">
                              <tr>
                                <td width="56"><input name="Submit2" type="submit"
												class="buttonbold" value="Submit"   accesskey="s"   ></td>
                                <td width="56"><input class="buttonbold" type="button"
												name="Submit2"  value="Close"   accesskey="c"  onClick="redirect('Userframe.jsp')"></td>
                              </tr>
                          </table>
						  </center>						  </td>
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
      </table></td>
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
