<%@ page import="java.io.*,java.util.*"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript">
function validate()
{
	if(
		checkNullSelect('dept','Select Staff name','0') 
		&& checkNullSelect('select','Select Accessories ','0') 
		&& checkNull('year','Select Budget year') 
		&& checkNull('amount','Enter Budget Amount') 
		 
	)
		return true;
	else
		return false;
		

}
</script>
<body >
<%@ include file="indexinv.jsp"%>

<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
    <td><form  AUTOCOMPLETE = "off"   name="form1" method="post" action="../SmartLoginAuth" onSubmit="return validate()">
      <table class="BackGround1" cellspacing="0" cellpadding="0" width="250"
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
            <td width="412"><table cellspacing="2" cellpadding="2" width="184" align="center"
						border="0">
                <!--DWLayoutTable-->
                <tbody>
                  <tr>
                    <td height="16" align="center" valign="top"
									class="boldThirteen">Budget Updation </td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven"><table width="98%" border="0" align="center" cellpadding="5" cellspacing="0">
                        <tr>
                          <td class="boldEleven"><table width="342" border="0" align="center" cellpadding="5" cellspacing="0">
                              <tr>
                                <td class="boldEleven">Department  ::  
                                  <%
String id = request.getParameter("id");
String sql="SELECT INT_TARGETID,INT_DEPARTID,INT_GROUPID,INT_YEAR,DOU_AMOUNT  FROM inv_t_budgetassign  WHERE INT_TARGETID="+id;
String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
//SELECT INT_TARGETID,INT_DEPARTID,INT_ACCESSORIEID,INT_YEAR,DOU_AMOUNT  FROM inv_t_budgetassign  WHERE INT_TARGETID=1

%>                                    </td>
                                <td class="boldEleven"><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_DEPARTNAME FROM com_m_depart WHERE INT_DEPARTID="+data[0][1])[0][0]%></td>
                                <td class="boldEleven">YEAR</td>
                                <td class="boldEleven"><%=data[0][3]%></td>
                              </tr>
                            </table></td>
                        </tr>
                        <tr>
                          <td class="boldEleven"><table width="400" border="0" align="center" cellpadding="4" cellspacing="4">
                            <tr>
                              <td width="111" class="bold1"><strong>Department</strong></td>
                              <td width="261"><select name="dept" class="formText135"	id="dept" tabindex="1"  >
                                  <option value="0">Select</option>
                                  <%
			String deptsql="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM com_m_depart ORDER BY INT_DEPARTID";
			String deptdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(deptsql);
			for(int x=0;x<deptdata.length;x++)
				out.println("<option value='"+deptdata[x][0]+"'>"+deptdata[x][1]+"</option>");
			%>
                              </select>
							  <script language="javascript">setOptionValue('dept','<%=data[0][1]%>')</script>						  </td>
                            </tr>
                            <tr>
                              <td class="bold1"><strong>Accessories</strong></td>
                              <td><select name="select" class="formText135"	id="select" tabindex="1"  >
                                  <option value="0">Select</option>
                                  <%
						String accdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_GROUPID,CHR_GROUPNAME,CHR_DESC FROM  inv_m_accessoriesgroup  ORDER BY CHR_GROUPNAME");
			for(int x=0;x<accdata.length;x++)
				out.println("<option value='"+accdata[x][0]+"'>"+accdata[x][1]+"</option>");
				
						%>
                              </select>
							  <script language="javascript">setOptionValue('select','<%=data[0][2]%>')</script>						  </td>
                            </tr>
                            <tr>
                              <td class="bold1">Year</td>
                              <td><select name="year" class="formText135" id="year">
                                  <%@ include file="../JavaScript/Inventory/year.jsp"%>
                                </select>
                                  <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('year',year1);							
				//-->
                                    </script>
									<script language="javascript">setOptionValue('year','<%=data[0][3]%>')</script>									</td>
                            </tr>
                            <tr>
                              <td class="bold1">Budget Amount </td>
                              <td><input name="amount" type="text" class="formText135" id="amount" onKeyPress="doubleValue('amount','6')" size="6" style='text-align:right' value="<%=data[0][4]%>">                                <span class="boldred">* </span>In terms of lakhs.<font size="1"><strong><font
										color="#000000"><font size="1"><strong><font
										color="#000000"><font size="1">
                                  <input
										type="hidden" name="filename" value="BudgetAssign" />
                                  <strong><font
										color="#000000"><font size="1">
                                  <input
										type="hidden" name="actionS" value="INVBudgetAssignEdit" />
                                  <input name="id" type="hidden" id="id" value="<%=id%>">
                                  </font></font></strong></font></font></strong></font></font></strong></font></td>
                            </tr>
                            
                          </table></td>
                        </tr>
						<tr>
						<td><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                          <tr>
                            <td width="56"><input type="submit" name="Submit"	id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"    /></td>
                            <td width="56"><input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c" 	onClick="redirect('BudgetAssign.jsp')" /></td>
                          </tr>
                        </table></td>
						</tr>
                    </table></td>
                  </tr>
                </tbody>
            </table></td>
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
    </form>
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
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
}
%>
