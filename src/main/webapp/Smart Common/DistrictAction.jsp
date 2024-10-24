<%@ page import="java.sql.*,java.util.*,java.io.*"%>
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
	
   
	if(  
		 checkNullSelect( "state","Select State name",'0' ) 
		 && checkNull( "Name","Enter District name" ) 
		 && checkNull( "sdescription","Enter District Description" )  )
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
                <td colspan="2" class="bold1"><div align="center"> DISTRICT 
				
				    <%
							String action=request.getParameter("action1");
							String rowid="",stateid="",Name="",desc="",actionS="",value="";
							String sql="";
							String link="";
							 
							if("Add".equals(action))
							{
								rowid="";Name=""; desc="";stateid="0";
								actionS="GENDistrictAdd";
								value="Add";
								link=" onKeyUp=\"CheckUnique(this,'divunitname','com_m_district','CHR_DISTRICT')\"  onKeyUp=\"CheckUnique(this,'divunitname','com_m_district','CHR_DISTRICT')\" ";
								
							}
							else
							{
								rowid="";Name=""; 
								rowid=request.getParameter("id");
								sql = " SELECT INT_STATEID,INT_DISTRICTID,CHR_DISTRICT,CHR_DISTRICTDES  FROM com_m_district  WHERE INT_DISTRICTID= "+rowid;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								stateid=data[0][0]; rowid=data[0][1];Name=data[0][2];  desc=data[0][3]; 
								actionS="GENDistrictEdit";
								value="Update";
								link="onBlur=\"upperMe(this)\"";
							}
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td class="boldEleven">State <span class="boldred">*</span> </td>
                <td class="boldEleven">
				<select name="state" class="formText135" id="state" >
				  <option value="0">Select State</option> 
				  <%
				  String sdata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state  WHERE INT_COUNTRYID=1 ORDER BY CHR_STATENAME");
				  for(int i=0;i<sdata.length;i++)
				  	out.println("<option value='"+sdata[i][0]+"'>"+sdata[i][1]+"</option>");
                  
				  %></select>
				  <script language="javascript">setOptionValue('state','<%=stateid%>')</script>
				</td>
              </tr>
              <tr>
                <td width="31%" class="boldEleven">District Name <span class="boldred">*</span> </td>
                <td width="69%" class="boldEleven"><input name="Name" type="text" class="formText135" id="Name" <%=link%> value="<%=Name%>" size="40" maxlength="100"    onBlur="upperMe(this)"   >
				<div id='divunitname'></div>											</td>
              </tr>
              
              <tr>
                <td valign="top" class="boldEleven">District Description  <span class="boldred">*</span> </td>
                <td valign="top" class="boldEleven"><textarea name="sdescription"  id="sdescription" cols="35"
								rows="5" class="formText135"
								onKeyPress="textArea('sdescription','500')"><%= desc%></textarea></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="District" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="rowid" type="HIDDEN" id="rowid" value="<%=rowid%>">				</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('DistrictView.jsp')"></td>
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
