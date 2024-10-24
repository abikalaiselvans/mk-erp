<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.NumberFormat"%>
 
<html>
<head>

<title>:: ACCOUNTS ::</title>

 
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
</head>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">

function Validate()
  {
	
 
	
	if(checkNullSelect("group","Select Group","0")
	&& checkNull( "desc","Enter Description" )
	&& checkNull( "incomedate","Enter Date" )
	&& checkNull( "Amount","Enter Total amount" )
	)
		return true;
	else
		return false;				
		
	
 } 	
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" > 
<%
try
{
%>
<%@ include file="indexacct.jsp"%>
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
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table class="BackGround1" cellspacing="0" cellpadding="0"
			align="center" border="0">
      <tbody>
        <tr>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
        </tr>
        <tr>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          <td width="6"><spacer height="1" width="1" type="block" /></td>
          <td width="412" align="center" valign="top">            <table width="713" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td colspan="7"><div align="center"><strong>Trading Account for the year ended
				  <%
				  	String fyear = com.my.org.erp.common.CommonFunctions.CurrentFinancialYear();
					String y[] = fyear.split("-");
					String fyear1= y[0];
					String fyear2= y[1];
					String Branch= ""+session.getAttribute("ACCBRANCH");
					out.println( "    ( 01-04-"+fyear1+"  to 31-03-"+ fyear2 + " ) ");
					NumberFormat formatter = new DecimalFormat("#0.00"); 

					double sum1=0;
					double sum2=0;
					double sum3=0;
					double sum4=0;
					double sum5=0;
					double sum6=0;
					double sum7=0;
					double sum8=0;
					double sum9=0;
					double sum10=0;
				  %>
				  
				  
				   </strong></div></td>
                </tr>
                <tr>
                  <td width="12%">&nbsp;</td>
                  <td width="28%">&nbsp;</td>
                  <td width="10%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="21%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="19%">&nbsp;</td>
                </tr>
                <tr>
                  <td><div align="center"></div></td>
                  <td>&nbsp;</td>
                  <td><div align="center"><strong>Rs.</strong></div></td>
                  <td><div align="center"></div></td>
                  <td><div align="center"></div></td>
                  <td><div align="center"></div></td>
                  <td><div align="center"><strong>Rs.</strong></div></td>
                </tr>
                <tr>
                  <td><strong>To Opening Stock </strong></td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>By Sales </td>
                  <td>&nbsp;</td>
                  <td><div align="right">
                    <%
				  	sum3= 0;//com.my.org.erp.Account.CommonFunctions.transactionAmount(Branch,"acc_t_salesentry");
					out.println(formatter.format(sum3)); 

				  %>
                  </div></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>Less Sales Return </td>
                  <td>&nbsp;</td>
                  <td><div align="right">
                    <%
				  	sum4=0;// com.my.org.erp.Account.CommonFunctions.transactionAmount(Branch,"acc_t_salesreturnentry");
					out.println(formatter.format(sum4)); 

				  %>
                  </div></td>
                </tr>
                <tr>
                  <td><strong>To Purchase </strong></td>
                  <td>&nbsp;</td>
                  <td>
				    <div align="right">
				      <%
				  	sum1= 0;//com.my.org.erp.Account.CommonFunctions.transactionAmount(Branch,"acc_t_purchaseentry");
					out.println(formatter.format(sum1)); 

				  %>
		            </div></td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td><div align="right">
                    <%
				  out.println(formatter.format(sum3-sum4));
				  %>
                  </div></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>Less purchase Return </td>
                  <td><div align="right">
                    <%
				  	sum2= 0;//com.my.org.erp.Account.CommonFunctions.transactionAmount(Branch,"acc_t_purchasereturnentry");
					out.println(formatter.format(sum2)); 

				  %>
                  </div></td>
                  <td>&nbsp;</td>
                  <td>By Closing Stock </td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td><div align="right"></div></td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>Total</td>
                  <td>
				  <%
				  out.println(formatter.format(sum1-sum2));
				  %>				  </td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td><strong>To Direct Expenses </strong></td>
                  <td>&nbsp;</td>
                  <td>
				  
				  </td>
                  <td>&nbsp;</td>
                  <td>By Gross loss c/d </td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>Carriage Inward </td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>Wages</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>Frieght</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>Import Duty </td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>Gas and Fuel </td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              <tr>
                <td>&nbsp;</td>
                  <td>Royalty in Production</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              <tr>
                <td>&nbsp;</td>
                  <td>Factory Expenses </td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              <tr>
                <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              <tr>
                <td><strong>To Gross Profit c/d </strong></td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              <tr>
                <td>&nbsp;</td>
                  <td>Transfered to Profit and loss A/c</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              <tr>
                <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              <tr>
                <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              <tr>
                <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              <tr>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
            </table></td><td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
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
</table>
<%@ include file="../footer.jsp"%>
<%
}
catch(Exception e)
{
}
%>
</body>
</html>
