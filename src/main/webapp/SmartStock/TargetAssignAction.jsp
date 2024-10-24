<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='STK' ")[0][0]%></title></title>
 
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

</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="javascript" >
function validate()
{
	if( 
		checkNull('ename','Select Staff name') 
		&& checkNull('April','Enter April month target') 
		&& checkNull('May','Enter May month target') 
		&& checkNull('June','Enter June month target') 
		&& checkNull('July','Enter July month target') 
		&& checkNull('August','Enter August month target') 
		&& checkNull('September','Enter September month target') 
		&& checkNull('October','Enter October month target') 
		&& checkNull('November','Enter November month target') 
		&& checkNull('December','Enter December month target') 
		&& checkNull('January','Enter January month target') 
		&& checkNull('February','Enter February month target') 
		&& checkNull('March','Enter March month target') 
	   )
		return true;
	else
		return false
}
</script>
<%
	String action=request.getParameter("action1");
	String s="";
	if(!"Add".equals(action))
		s="";
	else
		s="onLoad=\"init()\"" 	;
%>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" <%=s%> >
<%
try
{
%>
<%@ include file="indexstock.jsp"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td height="19">&nbsp;</td>
	</tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>

	<tr>
	  <td height="19"><form AUTOCOMPLETE="off" method="post" name="frm" id="frm" action="../SmartLoginAuth" onSubmit="return validate()">
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table class="BackGround" cellspacing="0" cellpadding="0" width="424"
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
                  <td width="412"><table cellspacing="2" cellpadding="2" width="184" align="center"
						border="0">
                    <!--DWLayoutTable-->
                    <tbody>
                      <tr>
                        <td height="16" align="center" valign="top"
									class="boldThirteen">Target Assign 
                          <%
							
							String Empid="",TargetAssignid="",Financialyear="",actionS="",value="";
							String April="",May="", June="", July="", August="", September="", October="";
							String November="", December="", January="", February="", March ="";
							String sql="";
							if("Add".equals(action))
							{
								Empid="";TargetAssignid="";Financialyear="";
								April="";May=""; June=""; July=""; August=""; September=""; October="";
								November=""; December=""; January=""; February=""; March ="";
								actionS="STKTargetAssignAdd";
								value="Add";
							}
							else
							{
								Empid="";TargetAssignid="";Financialyear="";
								April="";May=""; June=""; July=""; August=""; September=""; October="";
								November=""; December=""; January=""; February=""; March ="";
								TargetAssignid=request.getParameter("TargetAssignid");
								sql = " SELECT CHR_EMPID,INT_TARGETID,INT_FINANCIALYEARID ,INT_APR,INT_MAY,INT_JUN,INT_JUL,INT_AUG,INT_SEP,INT_OCT,INT_NOV,INT_DEC,INT_JAN,INT_FEB,INT_MAR FROM con_ inv_t_targetassign  WHERE INT_TARGETID="+TargetAssignid;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								Empid=data[0][0];TargetAssignid=data[0][1];Financialyear=data[0][2];
								April=data[0][3];May=data[0][4]; June=data[0][5]; July=data[0][6]; August=data[0][7]; 
								September=data[0][8]; October=data[0][9];November=data[0][10]; December=data[0][11]; 
								January=data[0][12]; February=data[0][13]; March =data[0][14];
								actionS="STKTargetAssignEdit";
								value="Update";
							}
							
						%>
                          <input name="TargetAssignid" type="HIDDEN" id="TargetAssignid" value="<%=TargetAssignid%>">
                          <input type="hidden" name="filename" value="TargetAssign" />
                          <input type="hidden" name="actionS" value="<%=actionS%>" /></td>
                      </tr>
                      <tr>
                        <td height="16" align="center" valign="top"	class="boldThirteen">
						
						    <%
							if(!"Add".equals(action))
							{
								out.println("Emp Id :: "+Empid);
							%>
							<input name="ename" type="HIDDEN" id="ename" value="<%=Empid%>">
							<% 
							}
							else
							{
							%>
							<%@ include file="../JavaScript/ajax.jsp"%>
							<%
							}
						   %>
							 	
							</td>
                      </tr>
                      <tr>
                        <td height="17" class="boldEleven"><table width="153" border="0" align="center" cellpadding="5" cellspacing="0">
                            <tr>
                              <td class="boldEleven">Year</td>
                              <td class="boldEleven"><strong>
                                <select name="Financialyear" id="Financialyear">
                                  <%
		String CurrentFinancialYear = com.my.org.erp.common.CommonFunctions.CurrentFinancialYear();
		String ydata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_FINANCIALYEARID,CHR_FINANCIALYEAR FROM  com_m_financialyear ORDER BY INT_FINANCIALYEARID");
		for(int u=0;u<ydata.length;u++)
			if(CurrentFinancialYear.equals(ydata[u][1]))
				out.println("<option selected='selected' value='"+ydata[u][0]+"'>"+ydata[u][1]+"</option>");
			else
				out.println("<option   value='"+ydata[u][0]+"'>"+ydata[u][1]+"</option>");	
			
	%>
                                </select>
								
							<%
							if(!"Add".equals(action))
							{
							%>
							<script language="javascript">setOptionValue("Financialyear","<%=Financialyear%>")</script>
							<% 
							}
							 
							%>
                              </strong> </td>
                            </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td height="17" class="boldEleven"><table width="100" border="0" cellspacing="0" cellpadding="5">
                            <tr>
                              <td class="boldEleven">April</td>
                              <td class="boldEleven">May</td>
                              <td class="boldEleven">June</td>
                              <td class="boldEleven">July</td>
                              <td class="boldEleven">August</td>
                              <td class="boldEleven">September</td>
                              <td class="boldEleven">October</td>
                              <td class="boldEleven">November</td>
                              <td class="boldEleven">December</td>
                              <td class="boldEleven">January</td>
                              <td class="boldEleven">February</td>
                              <td class="boldEleven">March</td>
                            </tr>
                            <tr>
                              <td class="boldEleven"><input name="April" type="text" class="formText135" id="April" style='text-align:right' onKeyPress="numericValue('April','6')" value="<%=April%>" size="6"></td>
                              <td class="boldEleven"><input name="May" type="text" class="formText135" id="May" style='text-align:right' onKeyPress="numericValue('May','6')" value="<%=May%>" size="6"></td>
                              <td class="boldEleven"><input name="June" type="text" class="formText135" id="June" style='text-align:right' onKeyPress="numericValue('June','6')" value="<%=June%>" size="6"></td>
                              <td class="boldEleven"><input name="July" type="text" class="formText135" id="July" style='text-align:right' onKeyPress="numericValue('July','6')" value="<%=July%>" size="6"></td>
                              <td class="boldEleven"><input name="August" type="text" class="formText135" id="August" style='text-align:right' onKeyPress="numericValue('August','6')" value="<%=August%>" size="6"></td>
                              <td class="boldEleven"><input name="September" type="text" class="formText135" id="September" style='text-align:right' onKeyPress="numericValue('September','6')" value="<%=September%>" size="6"></td>
                              <td class="boldEleven"><input name="October" type="text" class="formText135" id="October" style='text-align:right' onKeyPress="numericValue('October','6')" value="<%=October%>" size="6"></td>
                              <td class="boldEleven"><input name="November" type="text" class="formText135" id="November" style='text-align:right' onKeyPress="numericValue('November','6')" value="<%=November%>" size="6"></td>
                              <td class="boldEleven"><input name="December" type="text" class="formText135" id="December" style='text-align:right' onKeyPress="numericValue('December','6')" value="<%=December%>" size="6"></td>
                              <td class="boldEleven"><input name="January" type="text" class="formText135" id="January" style='text-align:right' onKeyPress="numericValue('January','6')" value="<%=January%>" size="6"></td>
                              <td class="boldEleven"><input name="February" type="text" class="formText135" id="February" style='text-align:right' onKeyPress="numericValue('February','6')" value="<%=February%>" size="6"></td>
                              <td class="boldEleven"><input name="March" type="text" class="formText135" id="March" style='text-align:right' onKeyPress="numericValue('March','6')" value="<%=March%>" size="6"></td>
                            </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td height="17" class="boldEleven"><span class="boldred">* </span>All inputs are in terms of lakhs.<font size="1"><strong><font
										color="#000000"><font size="1"><strong><font
										color="#000000"><font size="1">
                          <input
										type="hidden" name="filename2" value="Target" />
                          <strong><font
										color="#000000"><font size="1">
                          <input
										type="hidden" name="actionS2" value="INVTargetAssign" />
                        </font></font></strong></font></font></strong></font></font></strong></font></td>
                      </tr>
                      <tr>
                        <td height="17" class="boldEleven"><table width="131" border="0" align="center">
                          <tr>
                            <td width="54"><input name="Submit" type="submit"	id="submit" class="buttonbold13" value="<%=value%>" ></td>
                            <td width="67"><div align="center">
                                <input name="button" type="button" class="buttonbold13"  value="Close"   accesskey="c"  onClick="redirect('TargetAssignview.jsp')">
                            </div></td>
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
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp; </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table>
	  </form>	  </td>
	   
	  
	  	  </td>
  </tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>
	
	
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
<%
}
catch(Exception e)
{
}
%>
</body>
</html>
