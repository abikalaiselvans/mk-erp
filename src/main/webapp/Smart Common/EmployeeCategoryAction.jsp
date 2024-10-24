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
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function Validate()
  {
	
 
	if(  checkNull( "Name","Enter Category name" )  
	&& checkNullSelect('attendancecycle','Select Attendance Cycle ','0'))
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
		 
		    <table width="98%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center"> EMPLOYEE CATEGORY NAME
				    <%
							String action=request.getParameter("action1");
							String id="",Name="",actionS="",value="",status="",attendancecycle="1";
							String sql="";
							String cdata[][]=CommonFunctions.QueryExecute("SELECT INT_FROM,INT_TO FROM att_m_basicsettings  WHERE INT_ID=1"); 
							if("Add".equals(action))
							{
								id="";Name=""; status="";attendancecycle="1";
								actionS="GENEmployeeCategoryAdd";
								value="Add";
							}
							else
							{
								id="";Name=""; status="";
								id=request.getParameter("id");
								sql = " SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME,CHR_STATUS,INT_ATTENDANCE_CYCLE FROM  com_m_employeecategory   WHERE INT_EMPLOYEECATEGORYID= "+id;
								String data[][]= CommonFunctions.QueryExecute(sql);
								id=data[0][0];
								Name=data[0][1];  
								status=data[0][2];  
								attendancecycle=data[0][3];  
								actionS="GENEmployeeCategoryEdit";
								value="Update";
							}
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td width="44%" class="boldEleven">Employee Category  Name  <span class="boldred">*</span> </td>
                <td width="56%" class="boldEleven"><input name="Name" type="text" class="formText135" id="Name" onBlur="upperMe(this)"
				 onKeyUp=" CheckUnique(this,'divunitname',' com_m_employeecategory ','CHR_CATEGORYNAME')" value="<%=Name%>" size="35" maxlength="50">
				<div id='divunitname'></div>				</td>
              </tr>
              
              <tr>
                <td class="boldEleven">Attendance Cycle  <span class="boldred">*</span> </td>
                <td class="boldEleven"><select name="attendancecycle" id="attendancecycle" class="formText135"  style="width:170" tabindex="30">
											<option value="0">Select Attendance Cycle</option>
											<option value="1" selected="selected">1-31</option>
											<option value="2"><%=cdata[0][0]%>th to <%=cdata[0][1]%>th</option>
                                            </select>
											<script language="javascript">setOptionValue('attendancecycle','<%=attendancecycle%>')</script>
				    </td>
              </tr>
              <tr>
                <td class="boldEleven">PF Calculation Type</td>
                <td class="boldEleven"><select name="pfcalculationtype" id="pfcalculationtype" class="formText135"  style="width:170" tabindex="30">
                  <option value="0">PF Calculation Cycle</option>
                  <%
 String pfcalculationData[][] =  CommonFunctions.QueryExecute("SELECT INT_ROWID,INT_PFMINIMUM_LIMIT,INT_PFMAXIMUM_LIMIT FROM m_pf_setting WHERE CHR_STATUS ='Y'" );
if(pfcalculationData.length>0)
for(int u=0;u<pfcalculationData.length;u++)
	out.print("<option value='"+pfcalculationData[u][0]+"'> Type-"+pfcalculationData[u][0]+"</option>");

%>
                </select></td>
              </tr>
              <tr>
                <td class="boldEleven">Active</td>
                <td class="boldEleven">
				<%
				sql ="";
				if("Y".equals(status))
					sql = " checked = 'checked' ";
				%>
				<input name="status" type="checkbox" <%=sql%> id="status" value="Y"></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="EmployeeCategory" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input id="Submit"  name="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('EmployeeCategory.jsp')"></td>
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
