 <%@ page import="java.sql.*,java.util.*,java.io.*"%>
 <%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>

<%
try
{
%>
<html>
<head>

<title> :: TRAINNING ::</title>

 
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
	
 
	if(  
		checkNull( "Name","Enter Test Name" ) 
		&& checkNullSelect( "noofquetion","Enter no of question","0" ) 
		&& checkNullSelect( "duration","Select Duration","0" ) 
		&& checkNullSelect( "percentage","Select Percentage","0" ) 
		&& checkNull( "desc","Enter Description" ) 
		
		)
		return true;
	else
		return false;				
		
 
 } 	
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('Name').focus()" >
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
                <td colspan="2" class="bold1"><div align="center"> TEST TYPE
				
				    <%
							String action=request.getParameter("action1");
							String id="",Name="",actionS="",value="";
							String sql="";
							String desc=""; 
							String noofquetion="";
							String link="";
							String duration="",percentage="";
							if("Add".equals(action))
							{
								id="";Name=""; 
								actionS="TRATestTypeAdd";
								value="Add";desc="";
								noofquetion="0";
								duration="0";
								percentage="0";
								link = " onBlur=\"upperMe(this), CheckUnique(this,'divunitname','internal_training_m_testtype','CHR_TESTNAME')\"  onKeyUp=\"upperMe(this),CheckUnique(this,'divunitname','internal_training_m_testtype','CHR_TESTNAME')\" ";
 
							}
							else
							{
								id="";Name=""; link="";
								id=request.getParameter("id");
								sql = " SELECT INT_TESTTYPEID,CHR_TESTNAME,CHR_DESC,INT_NO_OF_QUESTION,INT_DURATION,INT_PECENTAGE FROM internal_training_m_testtype  WHERE INT_TESTTYPEID= "+id;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								id=data[0][0];Name=data[0][1]; desc=data[0][2]; 
								noofquetion=data[0][3];
								duration=data[0][4];
								percentage=data[0][5];
								actionS="TRATestTypeEdit";
								value="Update";
							}
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td width="31%" class="boldEleven">Test Name<span class="boldred"> * </span></td>
                <td width="69%" class="boldEleven">
					<input name="Name" type="text" class="formText135" id="Name"  value="<%=Name%>" size="40" maxlength="100" <%=link%> onBlur="upperMe(this),CheckUnique(this,'divunitname','internal_training_m_testtype','CHR_TESTNAME')"  onKeyUp="upperMe(this),CheckUnique(this,'divunitname','internal_training_m_testtype','CHR_TESTNAME')">
				<div id='divunitname'></div>				
				</td>
              </tr>
              
              <tr>
                <td valign="top" class="boldEleven">No of Question <span class="boldred"> * </span></td>
                <td class="boldEleven">
				<select name="noofquetion" id="noofquetion">
				<option value='0'>Select No of Question</option>
				<%
				for(int u=0;u<=100;u=u+5)
					out.println("<option value='"+u+"'>"+u+"</option>");
				%>
                </select>
				<script language="javascript">setOptionValue('noofquetion','<%=noofquetion%>')</script>                </td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Duration<span class="boldred"> * </span></td>
                <td class="boldEleven"><select name="duration" id="duration">
                  <option value='0'>Select Duration</option>
                  <%
				for(int u=0;u<=100;u=u+5)
					out.println("<option value='"+u+"'>"+u+" - minutes</option>");
				%>
                </select>
				<script language="javascript">setOptionValue('duration','<%=duration%>')</script> 
				</td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Percentage<span class="boldred"> * </span></td>
                <td class="boldEleven"><select name="percentage" id="percentage">
                  <option value='0'>Select Percentage</option>
                  <%
				for(int u=0;u<=100;u=u+5)
					out.println("<option value='"+u+"'>"+u+" - [ % ]</option>");
				%>
                </select>
				<script language="javascript">setOptionValue('percentage','<%=percentage%>')</script> 
				</td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Description<span class="boldred"> * </span></td>
                <td class="boldEleven"><textarea name="desc" cols="30" rows="5" class="formText135" id="desc" onKeyUp="textArea('desc','1900')"><%=desc%></textarea></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="TestType" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit"  id="Submit" type="submit" 	class="tMLAscreenHead" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="tMLAscreenHead" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('TestType.jsp')"></td>
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

}
catch(Exception e)
{
}
%>
</body>
</html>
