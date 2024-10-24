 <%@ page import="com.my.org.erp.common.*"%>
 <%
   try
   {
   
	 %>
<html>
<head>

<title> :: COMMON :: </title>


 
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
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">

function  validate()
{
	if( 
	 	 checkNullSelect('reportingfrom','Select Reporting from...','0')
		&& checkNullSelect('reportingto','Select Reporting t0...','0')
	  )
		return true;
	else
		return false;
}


 
</script>
 <style type="text/css">
 @import url("../JavaScript/SmartStyles.css");
 </style>
</head>
 

		 
		 
	
         
<body  onpaste='return false;'>
<form name="frm" action="ReportingtoUpdate.jsp" onSubmit="return validate()">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
	  <td height="34" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
	<tr>
	  <td height="19" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
	<tr>
		<td height="170" align="center"><table width="600" border="0" align="center" cellpadding="1"
			cellspacing="1">
          <tr>
            <td width="594"><table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="0" bgcolor="#dce4f9" class="BackGround">
                <tbody>
                  <tr>
                    <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TLCorner.gif" width="7" /></td>
                    <td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
                    <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TRCorner.gif" width="7" /></td>
                  </tr>
                  <tr>
                    <td height="6"><spacer height="1" width="1" type="block" /></td>
                  </tr>
                  <tr>
                    <td class="BorderLine" width="1"><spacer height="1"
								width="1" type="block" /></td>
                    <td width="6"><spacer height="1" width="1" type="block" /></td>
                    <td width="577" valign="top"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td width="100%"><div align="center" class="copyright">REPORTING TO  
                               
						  
						      <span class="boldEleven">
						      <%
									 
	String empdata[][]=  CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff  WHERE   CHR_HOLD!='Y'  AND CHR_TYPE!='T' AND CHR_REP='Y' ORDER BY CHR_STAFFNAME");
	%>
						      </span></div></td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td><div align="center">
                              <table width="100%" border="0" cellpadding="3" cellspacing="4">
                                <tr>
                                  <td colspan="4" class="boldEleven"><table width="500" border="0" align="center" cellpadding="2" cellspacing="2">
                                   
                                    <tr>
                                      <td width="21">&nbsp;</td>
                                      <td width="201" class="boldEleven">Office</td>
                                      <td width="255" class="boldEleven"><select name="office" class="formText135"  id="office" style="width:165">
									  <option value="0">All</option>
									  <%
        String offdata[][]= CommonFunctions.QueryExecute("SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office   ORDER BY CHR_OFFICENAME");
for(int h=0;h<offdata.length;h++)
	out.print("<option value='"+offdata[h][0]+"'>"+offdata[h][1]+"</option>");

		
%>
                                      </select>
                                      </td>
                                      <td width="23">&nbsp;</td>
                                    </tr>
                                     <tr>
                                      <td>&nbsp;</td>
                                      <td class="boldEleven">Including Resigned People</td>
                                      <td class="boldEleven">
                                      <select name="resigned" class="formText135" id="resigned" style="width:165">
                                      <option value="Y">Yes</option>
                                      <option value="N">No</option>
                                      </select></td>
                                      <td>&nbsp;</td>
                                    </tr>
                                     <tr>
                                       <td>&nbsp;</td>
                                       <td class="boldEleven">Department</td>
                                       <td class="boldEleven"><select name="depart" class="formText135" id="depart"  style="width:165"tabindex="22">
                                         <option value="0">All</option>
                                         <%
      	String depdata[][]= CommonFunctions.QueryExecute("SELECT INT_DEPARTID,CHR_DEPARTNAME FROM  com_m_depart WHERE CHR_STATUS='Y'  ORDER BY CHR_DEPARTNAME");
	for(int h=0;h<depdata.length;h++)
		out.print("<option value='"+depdata[h][0]+"'>"+depdata[h][1]+"</option>");

		
%>
                                       </select></td>
                                       <td>&nbsp;</td>
                                     </tr>
                                     <tr>
                                       <td>&nbsp;</td>
                                       <td class="boldEleven">Category</td>
                                       <td class="boldEleven"><select name="category" class="formText135" id="category"  style="width:165" onChange="loadAttendanceCycle(this)" >
                                         <option value="0">All</option>
                                         <%
	String empcategorysql=" SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME  FROM   com_m_employeecategory WHERE CHR_STATUS='Y'   ORDER BY CHR_CATEGORYNAME ";
	String empcategoryData[][] = CommonFunctions.QueryExecute(empcategorysql);
	if (empcategoryData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+empcategoryData[i][0]+">"+empcategoryData[i][1] +"</option>");			
	
						%>
                                       </select></td>
                                       <td>&nbsp;</td>
                                     </tr>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td width="117" height="47" class="boldEleven">Reporting From <span class="errormessage">*</span> </td>
                                  <td width="150"><span class="boldEleven">
                                    <select name="reportingfrom" id="reportingfrom" class="formText135" style="width:150">
                                      <option value="0">Select Reporting From </option>
                                      <%
									 
	 
	for(int y=0; y<empdata.length;y++)
		out.println("<option  value='"+empdata[y][0]+"' title='"+empdata[y][0]+"'>"+empdata[y][1]+" / " +empdata[y][0]+ "</option>");	
%>
                                      
                                  
										%>
                                    </select>
                                  </span> </td>
                                  <td width="115" class="boldEleven">Reporting To <span class="errormessage">*</span> </td>
                                  <td width="150"><span class="boldEleven">
                                    <select name="reportingto" id="reportingto" class="formText135" style="width:150"  >
                                      <option value="0">Select Reporting To</option>
                                      <%
									 
	 
	for(int y=0; y<empdata.length;y++)
		out.println("<option  value='"+empdata[y][0]+"' title='"+empdata[y][0]+"'>"+empdata[y][1]+" / " +empdata[y][0]+ "</option>");	
%>
                                      
                                  
										%>
                                    </select>
                                  </span></td>
                                </tr>
                              </table>
                          </div></td>
                        </tr>
                        <tr>
                          <td></td>
                        </tr>
                        <tr>
                          <td height="28">
						  <center>
						  <table border="0" align="center" cellpadding="1"
										cellspacing="1">
                              <tr>
                                <td width="56"><input name="Submit2" type="submit"
												class="buttonbold" value="Submit"   accesskey="s"   ></td>
                                <td width="56"><input class="buttonbold" type="button"
												name="Submit2"  value="Close"   accesskey="c" onClick="javascript:window.close();" ></td>
                              </tr>
                          </table>
						  </center>						  </td>
                        </tr>
                    </table></td>
                    <td nowrap="nowrap" width="6"><spacer height="1" width="1"
								type="block" /></td>
                    <td width="1" class="BorderLine"><spacer height="1"
								width="1" type="block" /></td>
                  </tr>
                  <tr>
                    <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/BLCorner.gif" width="7" /></td>
                    <td height="6"><spacer height="1" width="1" type="block" /></td>
                    <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
								src="../Image/General/BRCorner.gif" width="7" /></div></td>
                  </tr>
                  <tr>
                    <td class="BorderLine" height="1"></td>
                  </tr>
                </tbody>
            </table></td>
          </tr>
      </table></td>
	</tr>
</table>

</form>
</body>
</html>
<%
	}  
	catch(Exception e)
	{
	} 
	        
        %>
