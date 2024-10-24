<%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage=""%>
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


<title> :: ATTENDANCE ::</title>


<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function Validate()
  {
	
 
	
	if( 
	   checkNull( "name","Enter Group Name" )
	   
	 
	)
		return true;
	else
		return false;				
		
	
 } 	
</script>
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
<%@ include file="index.jsp"%>

<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
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
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="390"
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
				  <td width="412">
				   
		 
				  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
                    <tr>
                      <td colspan="2" class="bold1"><div align="center">Email Customer  Group
                          <%
							String action=request.getParameter("action1");
							String id="",Name="",actionS="",value="",dt="";
							String active="";
							String sql="";
							if("Add".equals(action))
							{
								id="";Name="";active="";dt="";
								actionS="ATTEmailCustomerGroupAdd";
								value="Add";
							}
							else
							{
								id="";Name="";dt="";
								id=request.getParameter("id");
								      
								sql = " SELECT INT_GROUPID,CHR_GROUPNAME,DATE_FORMAT(DAT_REGISTER,'%d-%m-%Y'),CHR_ACTIVE     FROM email_m_customergroup WHERE INT_GROUPID= "+id;
								
								 
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								id=data[0][0];Name=data[0][1]; 
								 dt=data[0][2]; active=data[0][3]; 
								actionS="ATTEmailCustomerGroupEdit";
								value="Update";
							}
							
						%>
                          <span class="boldEleven">
                          <input type="hidden" name="filename" value="EmailCustomerGroup" />
                          <input type="hidden" name="actionS"  value="<%=actionS%>" />
                          <input name="id" type="HIDDEN" id="id" value="<%=id%>">
                          </span></div></td>
                    </tr>
                    <tr>
                      <td width="42%" class="boldEleven"> Name</td>
                      <td width="58%" class="boldEleven"><input name="name" type="text" class="formText135" id="name" onBlur="upperMe(this), CheckUnique(this,'divunitname','email_m_customergroup','CHR_GROUPNAME')"
				 onKeyUp="CheckUnique(this,'divunitname','email_m_customergroup','CHR_GROUPNAME')" value="<%=Name%>" size="30" maxlength="50">
                          <div id='divunitname'></div></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Date of Registration </td>
                      <td class="boldEleven"><input title="dd/mm/yyyy" 
																onKeyPress="numericHypenOnly('dor','9')" name="dor" id="dor"
																type="text" class="formText135" size="15" maxlength="10" />
                          <a href="javascript:cal3.popup();"> <img
																src="../JavaScript/img/cal.gif" width="16" border="0"
																alt="Click here to Pick Up the Date" /></a>
                          <script language="javascript">
																<!--

  var cal3=new calendar1(document.forms['frm'].elements['dor']);
  cal3.year_scroll=true;
  cal3.time_comp=false;
  setCurrentDate('dor')
//-->
																</script>
                          <%					
	if(!"Add".equals(action))
	{
	%>
                          <script language="javascript">setOptionValue('dor','<%=dt%>')</script>
                          <%
	}
	%>                      </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Active</td>
                      <td class="boldEleven"><label>
                        <input name="active" type="checkbox" id="active" value="" checked>
                        <%					
	if(!"Add".equals(action) && "Y".equals(active))
	{
	%>
                        <script language="javascript">document.getElementById('active').checked=true</script>
                        <%
	}
	%>
                      </label></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td><input name="Submit" id="Submit"   type="submit" class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                            <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('EmailCustomerGroup.jsp')"></td>
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
		</table>
		</td>
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
  </form>
<%@ include file="../footer.jsp"%>
</body>
</html>
