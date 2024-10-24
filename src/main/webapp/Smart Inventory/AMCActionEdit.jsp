<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<html>
<head>
<title>:: INVENTORY ::</title> 
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
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" >
function validate()
{
	if( 
			checkNullSelect("customerid","Select Customer Id",'')
			&&checkNullSelect("peripheralid","Select  Service Peripherals...",'0')
			&&checkNull("serialno","Enter Serial Number")
			&&checkNull("description","Enter Description")	
			&&checkNull("startdate","Enter Start Date")	
			&&checkNullSelect("amcperiod","SELECT amcperiod",'0')	
			&&checkNull("amcamount","Enter AMC Amount")	
		
	   )
		return true;
	else
		return false
}


 

</script>
<body    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('customerid').focus()" >
<%
try
{
%>
<%@ include file="indexinv.jsp"%>
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
                  <td width="412"><table cellspacing="2" cellpadding="2" width="700" align="center"
						border="0">
                      <!--DWLayoutTable-->
                      <tbody>
                        <tr>
                          <td height="16" colspan="3" align="center" valign="top" 	class="boldThirteen">SERVICE CONTRACTS   
						    <%
						String action=request.getParameter("action1");
						
						String id="",Name="",category="",actionS="",value="",cid="",pid="",serial="",desc="",stdate="",noofyear="",amcamount="";
						String sql="";
						
							if("Add".equals(action))
							{
								id="";Name="";
								cid="";pid="";serial="";desc="";stdate="";noofyear="";amcamount="";category="";
								actionS="INVServiceAMCAdd";
								value="Add";
							}
							else
							{
								id="";Name="";
								id=request.getParameter("id");
								sql = "SELECT CHR_AMCID,INT_CUSTOMERID,INT_SERVICEITEMID,CHR_SERIALNO, CHR_DESC,DT_STARTDATE,INT_NOOFYEAR,DOU_AMCAMOUNT,CHR_STATUS,CHR_CATEGORY FROM  inv_m_serviceamc WHERE CHR_AMCID='"+id+"'";
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								id=data[0][0];
								cid=data[0][1];
								pid=data[0][2];
								serial=data[0][3];
								desc=data[0][4];
								stdate=data[0][5];
								String startdate =data[0][5];
								String stdates[] = startdate.split(" ");
								String sdate = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(stdates[0])+" "+stdates[1];
						//com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(indate)
								stdate=sdate;
						
								noofyear=data[0][6];
								amcamount=data[0][7];
								category = data[0][9];
								actionS="INVServiceAMCEdit";
								value="Update";
							}
							
						%>			
									
						<input 	name="id" type="HIDDEN" id="id" value="<%=id%>">
                        <input type="hidden" name="filename" value="ServiceAMC" />
                        <input type="hidden" name="actionS" value="<%=actionS%>" /></td>
                        </tr>
                         
                        <tr>
                          <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                          <td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
                        </tr>
                        <tr>
                          <td height="17" valign="top" class="boldEleven">Customer Name </td>
                          <td colspan="2" align="left" valign="top">
						  
						  <select name="customerid" id="customerid" size="5" class="formText135" >
								 
								<%
				String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME FROM  inv_m_servicecustomerinfo WHERE INT_BRANCHID="+""+session.getAttribute("BRANCHID") +" ORDER BY CHR_CUSTOMERNAME");
				for(int u=0;u<readData.length;u++)
					out.println("<option value="+readData[u][0]+">"+readData[u][1]+"</option>");
				%>
						</select>
						<script language="javascript">setOptionValue('customerid','<%=cid%>')</script>												  </td>
                        </tr>
                        <tr>
                          <td height="17" valign="top" class="boldEleven">Service peripherals </td>
                          <td colspan="2" align="left" valign="top">
						  
						  <select name="peripheralid" id="peripheralid"    class="formText135">
							<option value="0">Select</option>	 
								<%
				String readData1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_SERVICEITEMID,CHR_SERVICEITEMNAME FROM  inv_m_serviceitems ORDER BY CHR_SERVICEITEMNAME");
				for(int u=0;u<readData1.length;u++)
					out.println("<option value="+readData1[u][0]+">"+readData1[u][1]+"</option>");
				%>
						</select>
						<script language="javascript">setOptionValue('peripheralid','<%=pid%>')</script>												  </td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Serial Number </td>
                          <td colspan="2" align="left">
						  
						  
						  <input name="serialno" type="text" class="formText135" id="serialno" 
									size="30" maxlength="50" value="<%=serial%>" onKeyUp="upperMe(this),CheckUnique(this,'divunitname','inv_m_serviceamc','CHR_SERIALNO')" onBlur="upperMe(this), CheckUnique(this,'divunitname','inv_m_serviceamc','CHR_SERIALNO')">
                          <div id='divunitname'></div>									</td>
                        </tr>
                        <tr>
                          <td height="17" valign="top" class="boldEleven">Description</td>
                          <td colspan="2" align="left" valign="top"><textarea
									name="description" cols="30" rows="5" class="formText135"
									id="description"><%=desc%></textarea></td>
                        </tr>
						 
						 
						<tr>
						  <td height="17" valign="top" class="boldEleven">Booked Status
						    <%
				  	String complainttype=category;
					String direct ="";
					String phone ="";
					String others ="";
					if(complainttype.equals("A"))
						direct = " checked = checked" ;
						
					if(complainttype.equals("W"))
						phone = " checked = checked" ;
						
					if(complainttype.equals("O"))
						others = " checked = checked" ;	
						
					 
				  %></td>
						  <td colspan="2" align="left" valign="top"><table width="78%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="10%" class="boldEleven"><input
											name="complainttype" type="radio" value="A" <%=direct%>></td>
                              <td width="16%" class="boldEleven">AMC</td>
                              <td width="11%" class="boldEleven"><input
											name="complainttype" type="radio" value="W" <%=phone%>></td>
                              <td width="25%" class="boldEleven">Warranty</td>
                              <td width="10%" class="boldEleven"><input
											name="complainttype" type="radio" value="O" <%=others%>></td>
                              <td width="28%" class="boldEleven">Oncall</td>
                            </tr>
                          </table></td>
					    </tr>
						<td height="17" valign="top" class="boldEleven">Starting
								Date</td>
								<td colspan="2" align="left" valign="top"><input
									name="startdate" type="text" class="formText135" id="startdate" onKeyPress="dateOnly(this)"
									size="20" maxlength="20" /> 
								<a
									href="javascript:cal1.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a> <script language='JavaScript'
									type="text/javascript">
						<!--			
							var cal1 = new calendar1(document.forms['frm'].elements['startdate']);
							cal1.year_scroll = true;
							cal1.time_comp = true;
							setCurrentDateandTime('startdate'); 
							document.getElementById('startdate').value='<%=stdate%>';
						//-->
                       </script></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">No of Years								</td>
								<td colspan="2" align="left" valign="top">
								<select 	name="amcperiod" class="formText135" id="amcperiod">
									<option value="0">Select</option>
									<option value="1">1 - Year</option>
									<option value="2">2 - Years</option>
									<option value="3">3 - Years</option>
									<option value="4">4 - Years</option>
									<option value="5">5 - Years</option>
								</select> 
								<script language="javascript">setOptionValue('amcperiod','<%=noofyear%>')</script>								</td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">AMC Amount								</td>
							  <td colspan="2" align="left" valign="top"><input
									name="amcamount" type="text" class="formText135" id="amcamount" value="<%=amcamount%>"
									size="12" maxlength="12" onKeyPress="priceOnly(this)">
								  <input name="param" type="hidden" id="param" value="0,">							    </td>
							</tr>
						
						
						
                         
                         
                        <tr>
                          <td height="17" colspan="3" valign="top" class="boldEleven"><table width="131" border="0" align="center">
                              <tr>
                                <td width="54">
<input name="Submit" type="submit"	id="submit" class="buttonbold13" value="<%=value%>" ></td>
                                <td width="67"><div align="center">
                                  <input name="button" type="button" class="buttonbold13"  value="Close"   accesskey="c"  onClick="redirect('amc.jsp')">
                                </div></td>
                              </tr>
                          </table></td>
                        </tr>
                       
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
out.println(""+e.getMessage());
}
%>
</body>
</html>
