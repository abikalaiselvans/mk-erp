<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>

<title> :: COMMON ::</title>


 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id,payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function Validate()
  {
	
   
	if(  checkNull( "Name","Enter Office name" ) 
		 && checkNullSelect( "state","Select State" ,"0" ) 
		 && checkNull( "sdescription","Enter Office Description" ) 
		 && checkNull( "shortname","Enter Office shortname" ) 
		 && checkNull('emailid','Enter the E-mail id...')
		 && chkemail1("emailid",'Entert the E-mail Address...')
		  )
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
		 
		    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center"> OFFICE 
				
				    <%
							String action=request.getParameter("action1");
							String id="",state="0",email="",Name="",desc="",shortname="",actionS="",value="",status="";
							String sql="";
							String link="";
							 
							if("Add".equals(action))
							{
								id="";Name=""; desc=""; status="";email="";
								actionS="GENOfficeAdd";
								value="Add";state="0";
								link=" onKeyUp=\" CheckUnique(this,'divunitnames','com_m_office','CHR_OFFICENAME')\"  ";
								shortname="";
								
							}
							else
							{
								id="";Name=""; status="";
								id=request.getParameter("id");
								sql = " SELECT INT_OFFICEID,CHR_OFFICENAME,CHR_OFFICESHORTNAME ,CHR_OFFICEDES,CHR_STATUS,INT_STATEID,CHR_EMAIL FROM com_m_office  WHERE INT_OFFICEID= "+id;
								String data[][]= CommonFunctions.QueryExecute(sql);
								id=data[0][0];Name=data[0][1];  shortname=data[0][2];desc=data[0][3]; status=data[0][4]; 
								state =data[0][5];email=data[0][6];
								actionS="GENOfficeEdit";
								value="Update";
								link=" onKeyUp=\" CheckUnique(this,'divunitnames','com_m_office','CHR_OFFICENAME')\"  ";
							}
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td width="31%" class="boldEleven"> Name <span class="boldred">*</span> </td>
                <td width="69%" class="boldEleven"><input name="Name" type="text" class="formText135"  id="Name" <%=link%> value="<%=Name%>" size="40" maxlength="25"    onBlur="upperMe(this)"   ><div id='divunitnames'></div>				 											</td>
              </tr>
              
              <tr>
                <td valign="top" class="boldEleven">State  <span class="boldred">*</span> </td>
                <td valign="top" class="boldEleven">
				<select name="state" class="formText135" id="state" style="width:200">
				<option value="0"> Select State</option>
				<%
				
				String data[][] =CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state  ORDER BY CHR_STATENAME");
				if(data.length>0)
				{
					for(int u=0;u<data.length;u++)
						out.println("<option value='"+data[u][0]+"'>"+data[u][1]+"</option>");
				}
				%>
                </select>
				<script language="javascript">setOptionValue('state','<%=state%>')</script>                </td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Description  <span class="boldred">*</span> </td>
                <td valign="top" class="boldEleven"><textarea name="sdescription"  id="sdescription" cols="35"
								rows="5" class="formText135"     onBlur="upperMe(this)"   
								onKeyPress="textArea('sdescription','500')"><%= desc%></textarea></td>
              </tr>
              <tr>
                <td class="boldEleven">Office Shortname <font color="#ff0000">*</font></td>
                <td class="boldEleven"><input name="shortname"
								type="text" class="formText135" id="shortname" 
								
								onBlur="upperMe(this)"
				 onKeyUp="CheckUnique(this,'divunitname',' com_m_office ','CHR_OFFICESHORTNAME')"
				 
				  
								 value="<%=shortname %>"
								size="35" maxlength="3"><div id='divunitname'></div></td>
              </tr>
              <tr>
                <td class="boldEleven">E-mail <font
																class="bolddeepred" align="absmiddle">*</font></td>
                <td class="boldEleven"><input name="emailid" type="email" class="formText135" id="emailid" size="30"  maxlength="90" tabindex="9" value="<%=email%>"></td>
              </tr>
              <tr>
                <td class="boldEleven">Active</td>
                <td class="boldEleven"><%
				sql ="";
				if("Y".equals(status))
					sql = " checked = 'checked' ";
				%> 
                    <input name="status" type="checkbox" <%=sql%> id="status" value="Y"></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="Office" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('OfficeView.jsp')"></td>
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
