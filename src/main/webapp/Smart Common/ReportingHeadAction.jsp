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
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function Validate()
  {
	
   
	if(  checkNullSelect( "repto","Select reptingto  " ,'0')  )
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
                <td colspan="2" class="bold1"><div align="center"> REPORTING HEAD
				
				    <%
							String action=request.getParameter("action1");
							String id="",Name="",reptingto="",actionS="",value="";
							String sql="";
							String link="";
							String dbvalue=""; 
							 
							id="";Name=""; reptingto="0";
							id=request.getParameter("id");
							sql = " SELECT  CHR_EMPID,CHR_STAFFNAME,CHR_REPTO,  ";
							sql = sql + " IF(CHR_LEAVECARRY='Y',' checked=\\'checked\\' ','') ,  ";
							sql = sql + " IF(CHR_MANAGEMENT='Y',' checked=\\'checked\\' ','') ,  ";
							sql = sql + " IF(CHR_REP='Y',' checked=\\'checked\\' ','') ,  ";
							sql = sql + " IF(CHR_HOLD='Y',' checked=\\'checked\\' ','') ,  ";
							sql = sql + " IF(CHR_INTERVIEW='Y',' checked=\\'checked\\' ','') ,  ";
							sql = sql + " IF(CHR_PAYSLIPHIDE='Y',' checked=\\'checked\\' ','') ,  ";
							sql = sql + " IF(CHR_CONVEYANCECLEAR='Y',' checked=\\'checked\\' ','') ,  ";
							sql = sql + " IF(CHR_SALARYCALCULATE='Y',' checked=\\'checked\\' ','')  ,  ";
							sql = sql + " IF(CHR_PROFESSIONALTAX='Y',' checked=\\'checked\\' ','')    ";
							sql = sql + "  FROM com_m_staff   WHERE CHR_EMPID= '"+id+"'";
							//out.println(sql);
							String data[][]= CommonFunctions.QueryExecute(sql);
							id=data[0][0];Name=data[0][1];  reptingto=data[0][2]; 
							actionS="GENReportingHeadEdit";
							value="Update";
							link="";
							 
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td class="boldEleven">Employee Id /Name </td>
                <td class="boldEleven"><%=id +" / " +Name %>&nbsp;</td>
              </tr>
              <tr>
                <td class="boldEleven">Reporting to </td>
                <td class="boldEleven">
				<select name="repto" id="repto" style="width:200">
				<option value="0">Select Reporting Head</option>
                <%
				String rdata[][]=CommonFunctions.QueryExecute(" SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE CHR_REP='Y' AND CHR_TYPE !='T'  ORDER BY  CHR_STAFFNAME");
				if(rdata.length>0)
					for(int u=0;u<rdata.length;u++)
						out.println("<option value='"+rdata[u][0]+"'>"+rdata[u][1]+"  /  " +rdata[u][0]+"</option>");
				%>
				</select>
				<script language="javascript">setOptionValue('repto','<%=reptingto%>')</script>                </td>
              </tr>
               
              
               
              <tr>
                <td colspan="2" class="boldEleven"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="126"class="boldEleven">Leave Carry                      </td>
                    <td class="boldEleven"><input name="carry"
																type="checkbox" id="carry" value="Y" <%=data[0][3]%>></td>
                    <td class="boldEleven">Interview                      </td>
                    <td class="boldEleven"><input name="interview" type="checkbox" id="interview" value="Y"  <%=data[0][7]%>  ></td>
                    </tr>
                  <tr>
                    <td class="boldEleven">Management                      </td>
                    <td class="boldEleven"><input name="management" type="checkbox" id="management" value="Y" <%=data[0][4]%>></td>
                    <td class="boldEleven">Payslip hide                      </td>
                    <td class="boldEleven"><input name="payslip" type="checkbox" id="payslip" value="Y"  <%=data[0][8]%> ></td>
                    </tr>
                  <tr>
                    <td class="boldEleven">Reporting Head                      </td>
                    <td width="79"class="boldEleven"><input name="reporinghead" type="checkbox" id="reporinghead" value="Y" <%=data[0][5]%>></td>
                    <td width="127"class="boldEleven">Conveyance clear                      </td>
                    <td width="66"class="boldEleven"><input name="conveyance" type="checkbox" id="conveyance" value="Y"  <%=data[0][9]%>  ></td>
                    </tr>
                 
                  <tr>
                    <td class="boldEleven"><span class="errormessage">Staff Holding
                      
                    </span></td>
                    <td class="boldEleven"><input <%=data[0][6]%> name="hold" type="checkbox" id="hold" value="Y"></td>
                    <td class="errormessage">Salary Calculation                      </td>
                    <td class="boldEleven"><input name="salarycalculation" type="checkbox" id="salarycalculation" value="Y" <%=data[0][10]%>  ></td>
                    </tr>
                   <tr>
                    <td class="boldEleven">Professional Tax</td>
                    <td class="boldEleven"><input name="professionaltax" type="checkbox" id="professionaltax" value="Y" <%=data[0][11]%>  ></td>
                    <td class="errormessage">&nbsp;</td>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                </table></td>
                </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="ReportingHead" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('ReportingHeadChange.jsp')"></td>
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
