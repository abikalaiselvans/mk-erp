 <%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
<html>
<head>
<title>:: ATTENDANCE  ::</title>
 
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
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function Validate()
  {
	
 
	if(  checkNull( "Name","Enter Certification name" ) )
		return true;
	else
		return false;				
		
	
 } 	
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
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
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	 <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
          <td width="412" valign="top">
		 
		    <table width="86%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center"> BLOOD GROUP 
                    <%
							String action=request.getParameter("action1");
							String id="",Name="",actionS="",value="";
							String sql="";
							 
							if("Add".equals(action))
							{
								id="";Name=""; 
								actionS="ATTBloodGroupAdd";
								value="Add";
							}
							else
							{
								id="";Name=""; 
								id=request.getParameter("id");
								sql = " SELECT INT_BLOODGROUPID,CHR_GROUPNAME FROM com_m_bloodgroup  WHERE INT_BLOODGROUPID= "+id;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								id=data[0][0];Name=data[0][1];  
								actionS="ATTBloodGroupEdit";
								value="Update";
							}
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td width="31%" class="boldEleven">Blood Group    Name</td>
                <td width="69%" class="boldEleven"><input name="Name" type="text" class="formText135" id="Name" onBlur="upperMe(this), CheckUnique(this,'divunitname','com_m_bloodgroup','CHR_GROUPNAME')"
				 onKeyUp="upperMe(this),CheckUnique(this,'divunitname','com_m_bloodgroup','CHR_GROUPNAME')" value="<%=Name%>" size="40" maxlength="100">
				<div id='divunitname'></div>				</td>
              </tr>
              
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="BloodGroup" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" type="submit" 	class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('BloodGroup.jsp')"></td>
                  </tr>
                </table></td>
                </tr>
            </table>
		 </td>
          <td nowrap="nowrap" width="4"><spacer height="1" width="1"
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
    </table> </form></td>
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
	String msg=""+request.getParameter("msg");
	if(!"null".equals(msg))
	{
	%>
	<script language="javascript">
		var rs=confirm("<%=msg%>, Add one more record...");
		if (rs==true)
  		 	location = 'EmailCompanyAction.jsp?action1=Add'; 
		else	
		location = 'EmailCompany.jsp'; 
	</script>
	<%	
	}
}
catch(Exception e)
{
}
%>
</body>
</html>
