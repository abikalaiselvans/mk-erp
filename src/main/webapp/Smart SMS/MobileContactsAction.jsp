<%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage=""%>
<%
try
{
%>
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


<title>-</title>

<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function Validate()
  {
	
 
	
	if( 
	   checkNull( "name","Enter   Name" )
	   &&  checkNull( "mobile","Enter mobile" )
	   &&  checkNull( "email","Enter email" )
	   && chkemail("email")
	   && checkNullSelect( "group","Select Group Name",'0' )
	   && checkNullSelect( "age","Select Age",'0' )
	   && checkNull( "city","Enter city Name" )
	   
	 
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
  
  
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>

<body  onpaste="return false;" onLoad="document.getElementById('name').focus()">
<%@ include file="index.jsp"%>
<!--onclick="this.disabled='disabled'"-->
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
		<table width="390" border="0"
			align="center" cellpadding="0"   cellspacing="0" class="BackGround">
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
                      <td colspan="2" class="bold1"><div align="center">MOBILE CONTACTS 
                          <%
							String action=request.getParameter("action1");
							String id="",Name="",actionS="",value="";
							String group="";
							String age="";
							String city="";
							String mobile="";
							String active="";
							String email="";
							String sql="";
							if("Add".equals(action))
							{
								id="";Name="";active=""; 
								group="0"; mobile="";age="0"; city="";email="";
								actionS="SMSMobileContactsAdd";
								value="Add";
							}
							else
							{
								id="";Name=""; 
								group=""; mobile="";age=""; city="";email="";
								id=request.getParameter("id");
								      
								sql="  SELECT INT_MOBILEID,INT_GROUPID,CHR_CUSTOMERNAME,INT_MOBILENO,INT_AGE,CHR_CITY,CHR_EMAIL FROM  sms_m_mobilecontacts  WHERE INT_MOBILEID="+id; 
								 
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								id=data[0][0];
								group=data[0][1];
								Name=data[0][2]; 
								mobile=data[0][3]; 
								age=data[0][4]; 
								city=data[0][5]; 
								email=data[0][6]; 
								actionS="SMSMobileContactsEdit";
								value="Update";
							}
							
						%>
                          <span class="boldEleven">
                          <input type="hidden" name="filename" value="MobileContacts" />
                          <input type="hidden" name="actionS"  value="<%=actionS%>" />
                          <input name="id" type="HIDDEN" id="id" value="<%=id%>">
                          </span></div></td>
                    </tr>
                    <tr>
                      <td width="25%" class="boldEleven"> Name<span class="spc"> *</span></td>
                      <td width="75%" class="boldEleven"><input name="name"  onKeyUp="upperMe(this) " type="text" class="formText135" id="name"  value="<%=Name%>" size="30" maxlength="100">                          </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Mobile<span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="mobile" type="text" class="formText135" id="mobile" value="<%=mobile%>" size="30" maxlength="10" onKeyUp="CheckUnique(this,'divunitname','sms_m_mobilecontacts','INT_MOBILENO')"   onKeyPress="return numeric_only(event,'mobile','13') "  onBlur="upperMe(this), CheckUnique(this,'divunitname','sms_m_mobilecontacts','INT_MOBILENO')" >
					  <div id='divunitname'></div></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Email<span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="email" type="text" class="formText135" id="email" value="<%=email%>" size="30" maxlength="100"  onBlur=" CheckUnique(this,'divunitname','sms_m_mobilecontacts','CHR_EMAIL')"
				 onKeyUp="CheckUnique(this,'divunitname','sms_m_mobilecontacts','CHR_EMAIL')">
                          <span class="errormessage">(test@test.net)</span>
                          <div id='divunitname'></div></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Group<span class="spc"> *</span></td>
                      <td class="boldEleven"><select name="group" class="formText135" id="group"   >
                        <option value="0">Select Group</option>
                        <%
			  String sdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_GROUPID,CHR_GROUPNAME FROM  sms_m_mobile_group ORDER BY CHR_GROUPNAME ");
			  for(int u=0;u<sdata.length;u++)
			  	 out.println("<option   value='"+sdata[u][0]+"'>"+sdata[u][1]+"</option>");
			  %>
                      </select><script language="javascript">setOptionValue('group','<%=group%>')</script>
					  
					  
					  
					  
					  
					  
					  
					  
					  <table width="100" align="right">
															<TR>
															  <TD width="56">
                                                                <script language="javascript">
					 
function cityWindow(query)
	{  
		var width="800", height="400";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
	 	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );
	}

	
					                                                                                     </script>
                                                                <input name="cityname" onClick="javascript:cityWindow('addMobileGroup.jsp')" type="button" class="buttonbold13" id="cityname" value="Add Group"></td>
													  </tr>
				    </table>                    </tr>
                    <tr>
                      <td class="boldEleven">Age<span class="spc"> *</span></td>
                      <td class="boldEleven"><select name="age" class="formText135" id="age"   >
                        <option value="0">Select Age</option>
                        <%
			  for(int u=15;u<100;u++)
			   	 if(age.equals(""+u))
			  		out.println("<option selected='selected' value='"+u+"'>"+u+"</option>");
				else
			  		out.println("<option value='"+u+"'>"+u+"</option>");
			  %>
                      </select>
					  
	  				  </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">City<span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="city" type="text" class="formText135" id="city" onKeyUp="upperMe(this) "
				   value="<%=city%>" size="30" maxlength="100"></td>
                    </tr>
                     
                     
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td><input name="Submit"  id="Submit" type="submit" class="buttonbold13" value="Submit"   accesskey="s"    ></td>
                            <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('MobileContacts.jsp')"></td>
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
<%
}
catch(Exception e)
{
 System.out.println(e.getMessage()); 
}
%>