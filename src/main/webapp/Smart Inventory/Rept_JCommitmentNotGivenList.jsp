<%@ page import="java.io.*,java.util.*"%>
 
<html>
<head>
<title>:: INVENTORY ::</title>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
 


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
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">


function Vali()
  {
	//alert("aaaaaaaa");
   	if(  
		checkNullSelect( "reportType","Select Export Type" ,'0') && checkNullSelect( "salestype","Select Sale Type" ,'0') 
		
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
	  <td></td>
  </tr>
  <tr>
	  <td>
		<form name="frm" method="post" action="../SmartLoginAuth" onSubmit=" return Validate()">
      
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="456"
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
					<td width="359">
					<table cellspacing="2" cellpadding="2" width="459" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">  COMMITMENT 
							  NOT GIVEN LIST
						      <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
				%></td>
							</tr>

							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							 
							
							<tr>
							  <td height="17" class="boldEleven"><strong>Sales Type </strong></td>
							  <td colspan="2" align="left">  
							  <select name="salestype" class="formText135" id="salestype" style="width:150" >
                      
						<option value="C" >Customer Sales</option>
                        <option value="S">Service Billing</option>
                      </select></td>
						  </tr>
							<tr>
							  <td height="19" align="right" valign="top" class="boldEleven"><div align="left"><strong>Branch</strong></div></td>
							  <td align="right" valign="top" class="boldEleven"><div align="left">
                                  <select name="Branch" class="formText135"
							id="Branch" tabindex="6"  style="width:150" >
                                   <option value="0">All </option>
								    <%
								
				String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
				if(usertype.equals("F") || usertype.equals("B"))
				{
				  for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
				}
				else
				{
					for(int u=0; u<shipids.length; u++)
						if(shipids[u][0].equals(branchid))
							out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
												
				}
						
							%>
                                  </select>
                                  <script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						      </script>
                              </div></td>
						  </tr>
							<tr>
							  <td height="19" align="right" valign="top" class="boldEleven"><div align="left"><strong>Division</strong></div></td>
							  <td align="right" valign="top" class="boldEleven"><div align="left">
                                  <select
										name="division" class="formText135" id="division" tabindex="1" style="width:150" >
                                    <option value='0'>All</option>
                                    <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                                  </select>
                              </div></td>
						  </tr>
							<tr>
							  <td width="136" height="19" valign="middle" class="boldEleven"><strong>Sale Month</strong></td>
							  <td width="288" valign="middle" align="left"><strong> <font size="1"><font size="1">
                                <select name="month"  id="month"
								class="formText135" style="width:150">
                                 
								   <option value="0" selected="selected">All</option>
                                  <option value="01">January</option>
                                  <option value="02">February</option>
                                  <option value="03">March</option>
                                  <option value="04">April</option>
                                  <option value="05">May</option>
                                  <option value="06">June</option>
                                  <option value="07">July</option>
                                  <option value="08">August</option>
                                  <option value="09">September</option>
                                  <option value="10">October</option>
                                  <option value="11">November</option>
                                  <option value="12">December</option>
                                </select>
                              </font></font> </strong></td>
					      </tr>
							<tr>
							  <td height="19" valign="middle" class="boldEleven"><strong>Sale Year</strong></td>
							  <td valign="middle" align="left"><strong>
                                <select
								name="year" id="year" class="formText135" style="width:150">
                                 <option value="0" selected="selected">All</option>
                                  <%
								java.util.Date d = new java.util.Date();
								int y = 1900+d.getYear();
								int styear = y-20;
								int edyear = y+20;
			         for(int i=styear;i<=edyear;i++)
			      {
			       out.println("<option value="+i+">"+i+"</option>");
			      }
			     %>
                                </select>
                                <script language='JavaScript' type="text/javascript"></script>
							  </strong></td>
						  </tr>
								<tr>
                                  <td height="17" class="boldEleven"><strong>Export Type </strong><span class="bolddeepred">*</span></td>
								  <td colspan="2" align="left"><span class="boldEleven">
                                    <select name="reportType" id="reportType" style="width:150">
                                      <option value="0" title="../DropDown - Image/icons/export.jpg" selected="selected">Export Type</option>
                                      <option value="csv" title="../DropDown - Image/icons/csv.jpg">CSV </option>
                                      <option value="xls" title="../DropDown - Image/icons/excel.jpg">Excel </option>
                                      <option value="html" title="../DropDown - Image/icons/html.jpg">Html </option>
                                      <option value="pdf" title="../DropDown - Image/icons/pdf.jpg" selected="selected">Pdf </option>
                                      <option value="rtf" title="../DropDown - Image/icons/rtf.jpg">Rtf </option>
                                      <option value="txt" title="../DropDown - Image/icons/txt.jpg">Txt </option>
                                      <option value="xml" title="../DropDown - Image/icons/xml.jpg">Xml </option>
                                    </select>
                                  </span></td>
						  </tr>
								<tr>
								  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								  <td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
											class="buttonbold13" id="Submit" value="Submit"   accesskey="s"   
											 ></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('Rept_PaymentCommitment.jsp')"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><input name="filename"
									type="hidden" value="Rept_JCommitmentNotGiven" />
                                  <input name="actionS"
									type="hidden" value="INVRept_JCommitmentNotGiven" />
                                  <span class="boldEleven">
                                  <input name="rptfilename" type="hidden" id="rptfilename" value="commitmentNotGivenList">
                                  <input name="rptfilename1" type="hidden" id="rptfilename1" value="commitmentNotGiven_serviceBilling">
                                  </span></td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
				  </table>					</td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="84"><spacer height="1" width="1"
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
<script language="JavaScript">

function Validate()
  {
	if(checkNullSelect( "salestype","Select salestype",'0' )  )
		return true;
	else
		return false;				
		
 } 	
</script> 
<%@ include file="../footer.jsp"%>
</body>
</html>
