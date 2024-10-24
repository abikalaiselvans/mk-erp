<%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage=""%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
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


<title> :: MARKETING ::</title>

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
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>


 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
 
<body onselectstart="return false" onpaste="return false;" onCopy="return false"   >
<%@ include file="index.jsp"%>
<!--onclick="this.disabled='disabled'"  onLoad="document.getElementById('name').focus()"-->
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
                      <td colspan="2" class="bold1"><div align="center">STAGE  
                          <%
							String action=request.getParameter("action1");
							String id="",Name="",actionS="",value="",dt="";
							String active="checked = 'checked' ";
							String percentage="";
							String color="#ff0000";
							String sql="";
							if("Add".equals(action))
							{
								id="";Name="";active="checked = 'checked' ";dt="";
								actionS="MKTStageAdd";
								value="Add";percentage="";color="#ff0000";
							}
							else
							{
								id="";Name="";dt="";
								id=request.getParameter("id");
								sql = " SELECT  INT_STAGEID,CHR_STAGENAME,INT_PERCENTAGE,CHR_STATUS,CHR_COLORVALUE FROM mkt_m_stage WHERE INT_STAGEID= "+id;
								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];Name=data[0][1]; 
								active=data[0][3];
								percentage=data[0][2];color=data[0][4];
								
								 if("Y".equals(active))
								 	active = " checked = 'checked'   ";
								else
								active = "";
								actionS="MKTStageEdit";
								value="Update";
							}
							
						%>
                          <span class="boldEleven">
                          <input type="hidden" name="filename" value="Stage" />
                          <input type="hidden" name="actionS"  value="<%=actionS%>" />
                          <input name="id" type="HIDDEN" id="id" value="<%=id%>">
                           
                          </span></div></td>
                    </tr>
                    <tr>
                      <td width="42%" class="boldEleven"> Stage Name<span class="spc"> *</span></td>
                      <td width="58%" class="boldEleven"><input name="name" type="text" class="formText135" id="name" onBlur="upperMe(this), CheckUnique(this,'divunitname','mkt_m_stage','CHR_STAGENAME')"
				 onKeyUp="CheckUnique(this,'divunitname','mkt_m_stage','CHR_STAGENAME')" value="<%=Name%>" size="30" maxlength="100">
                          <div id='divunitname'></div></td>
                    </tr>
                     
                     
                    <tr>
                      <td class="boldEleven">Percentage *</td>
                      <td class="boldEleven">
                      <select name="percentage" class="formText135" id="percentage">
                      <option value="">Select percentage</option>
                      <%
					  for(int i=0;i<101;i++)
					  	out.println("<option value='"+i+"'>"+(i)+"</option>");
					  %>
                      </select>
                      <script language="javascript">setOptionValue('percentage','<%=percentage%>')</script>
                      </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Color</td>
                      <td class="boldEleven"><input id="html5colorpicker"  name="html5colorpicker" class="form-control" onchange="clickColor(0, -1, -1, 5)" value="<%=color%>" type="color"></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Active </td>
                      <td class="boldEleven"><input name="active" <%=active%> type="checkbox" id="active" value="Y"></td>
                    </tr>
                    <tr>
                      <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td><input name="Submit"  id="Submit" type="submit" class="buttonbold13" value="<%=value%>" ></td>
                            <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('Stage.jsp')"></td>
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
