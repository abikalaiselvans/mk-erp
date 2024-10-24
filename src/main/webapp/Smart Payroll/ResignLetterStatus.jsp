<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%
try
{
%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>


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

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
 
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">

function checkResginDate(ctr1,ctr2)
{
   try
   {
		var date1=document.getElementById(ctr1).value;
		var d1=date1.substr(0,2);
		var m1=date1.substr(3,2);
		var y1=date1.substr(6,4);
		var date2=document.getElementById(ctr2).value;
	  
		var d2=date2.substr(0,2);
		var m2=date2.substr(3,2);
		var y2=date2.substr(6,4);
		 
		if(!isNaN(d1) && !isNaN(m1) && !isNaN(y1))
		{
			  if(!isNaN(d2) && !isNaN(m2) && !isNaN(y2))
			  { 
				 if((d1<=d2 && m1==m2 && y1==y2) ||(d1<=d2 && m1<=m2 && y1<=y2) ||
				 (m1<m2 && y1==y2) || (y1<y2) )
				  {
					return true;
				  }
				  else
				  {
					alert(" Resign Date Should Be Greater Than or Equal to "+date1);
					document.getElementById(ctr2).value="";
					document.getElementById(ctr2).focus();
					return false;
				  }
			  }
			  else
			  {
				  alert("Enter Correct Date");
				  document.getElementById(ctr2).value="";
				  document.getElementById(ctr2).focus();
				  return false;
			  }	  
		}
		else
		{
		  alert("Enter Correct Date");
		  document.getElementById(ctr1).value="";
		  document.getElementById(ctr1).focus();
		  return false;
		}
	   }
	   catch(err)
	   {
		  alert(err);
	   }
  }




  function Validate()
  {
  
	 
	if(
		checkNull("fromdt","Enter Resing Date") 
  		&& checkNull("reason","Enter The Reason ") 
  		
		 
		&& checkResginDate("todate","fromdt")
		)
			return true;
		else
			return false;
  }
  
  
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="index.jsp"%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="100">
	  
	  <form  AUTOCOMPLETE = "off"   name="frmState" method="get" action="../SmartLoginAuth" onsubmit="return Validate()">

	  <table width="414" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
        <!--DWLayoutTable-->
        <tbody>
          <tr>
            <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
            <td width="401" height="1" class="BorderLine"><spacer
						height="1" width="1" type="block" /></td>
            <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
          </tr>
          <tr>
            <td height="6"><spacer height="1" width="1" type="block" /></td>
          </tr>
          <tr>
            <td width="1" rowspan="2" class="BorderLine"><spacer
						height="1" width="1" type="block" /></td>
            <td width="6" rowspan="2"><spacer height="1" width="1"
						type="block"></td>
            <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><div align="center">
                  <% 

 String staff1=""+session.getAttribute("EMPID");
            String status=""+com.my.org.erp.common.CommonInfo.stringGetAnySelectField("select CHR_ACCEPTSTATUS from pay_t_resignationletter where CHR_EMPID='"+staff1+"'","CHR_ACCEPTSTATUS");
            String desc=""+com.my.org.erp.common.CommonInfo.stringGetAnySelectField("select CHR_REJECTDESCRIPTION from pay_t_resignationletter where CHR_EMPID='"+staff1+"'","CHR_REJECTDESCRIPTION");

if(status.equals("N"))
	out.println("<font color='blue'>Your Resignation is still under consideration please contact your reporting head. </font>");
else if(status.equals("Y"))
	out.println("<font color='Green'>Your Resignation is accepted </font>");
else if(status.equals("R"))
	out.println("<font color='Red'>Your Resignation is rejected. </font>");

out.println("<br>");

if(status.equals("N"))
	out.println( "");
else if(status.equals("Y"))
	out.println("Description :: "+desc);
else if(status.equals("R"))
	out.println("Description :: "+desc);
	
 
%>
                </div></td>
              </tr>
              <tr>
                <td><table width="140" border="0" align="center" cellpadding="2"
								cellspacing="2">
                  <tr>
                     
                    <td width="63"><input class="buttonbold" type="Button" name="Submit2"
										 value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
            <td width="5" rowspan="2" nowrap="nowrap"> </td>
            <td width="1" rowspan="2" class="BorderLine"> </td>
          </tr>
          <tr>
            <td height="2"></td>
          </tr>
          <tr>
            <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
            <td height="6"><spacer height="1" width="1" type="block" /><div align="center"></div></td>
            <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div></td>
          </tr>
          <tr>
            <td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
          </tr>
        </tbody>
      </table>
	  </form>  	</td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>

 
</body>
</html>
<%
}
catch(Exception e)
{
}
%>
