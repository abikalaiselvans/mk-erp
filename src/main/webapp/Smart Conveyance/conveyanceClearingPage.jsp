 <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%><%
try
{
%>
<html>
<head>
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


<title> :: CONVEYANCE ::</title>

 
   
  <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
  
 
  
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script> 

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<br>
<br>
<%
try
{

%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth"	onSubmit="return validate()">
 
			<center>
			<p>&nbsp;</p>
			<table width="600" border="0"
			align="center" cellpadding="0"   cellspacing="0" class="BackGround">
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
                  <td width="7"><spacer height="1" width="1" type="block" /></td>
                  <td width="575">
				  <%
				  try
				  {
				  	String cdata[][] = CommonFunctions.QueryExecute("SELECT  (DAT_CLEARINGDATE is null),DATE_FORMAT(DAT_ACCDATE,'%d-%m-%Y') FROM conveyance_t_conveyance WHERE CHR_ACCSTATUS='Y'  and DAT_CLEARINGDATE is null GROUP BY DAT_ACCDATE  ORDER BY DAT_ACCDATE  DESC LIMIT 0,1");
					if(cdata.length>0)
					{
				  %>
				  
				  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
                    <tr>
                      <td colspan="2" class="boldEleven"><div align="center"><span
								class="boldThirteen">CONVEYANCE CLEAR </span></div></td>
                    </tr>
                    <tr>
                      <td width="33%" class="boldEleven">Conveyance Paid Date </td>
                      <td width="67%" class="boldEleven">
					  <%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  (DAT_CLEARINGDATE is null),DATE_FORMAT(DAT_ACCDATE,'%d-%m-%Y') FROM conveyance_t_conveyance WHERE CHR_ACCSTATUS='Y'  and DAT_CLEARINGDATE is null GROUP BY DAT_ACCDATE  ORDER BY DAT_ACCDATE  DESC LIMIT 0,1")[0][1]%>
					  
					  <input name="paiddate" type="hidden" value="<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  (DAT_CLEARINGDATE is null),DATE_FORMAT(DAT_ACCDATE,'%d-%m-%Y') FROM conveyance_t_conveyance WHERE CHR_ACCSTATUS='Y' GROUP BY DAT_ACCDATE  ORDER BY DAT_ACCDATE  DESC LIMIT 0,1")[0][1]%>">					  </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Clearing Date </td>
                      <td class="boldEleven">
					  <input name="clearingdate"
								type="text" class="formText135" id="clearingdate"
								onKeyPress="numericHypenOnly('clearingdate',10)" size="12"
								maxlength="10" readonly="readonly"> <a
								href="javascript:cal1.popup();"> <img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click here to Pick Up the Date" onClick="submitenable()"  
								
		 ></a> 
		 
		 <script
								language="JavaScript">
<!--
  var cal1=new calendar1(document.forms['frm'].elements['clearingdate']);
  cal1.year_scroll=true;
  cal1.time_comp=false;
  setCurrentDate('clearingdate');
//--></script>					  </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Credit via <span
									class="bolddeepred">* </span></td>
                      <td class="tabledata"><select name="creditto" class="formText135" id="creditto" style="width:200">
                          <option value="">Select</option>
                          <%
					  
					   String deposit[][] = CommonFunctions.QueryExecute("SELECT INT_DEPOSITID, CHR_DEPOSITNAME FROM com_m_deposit_to WHERE CHR_STATUS !='N' ORDER BY CHR_DEPOSITNAME");
					  for(int u=0; u<deposit.length;u++)
					  		out.println("<option value='"+deposit[u][0]+"'>"+deposit[u][1]+"</option>");
					  %>
                      </select>
                        <span class="boldEleven">
                        <input name="filename" type="hidden" id="filename"
						value="Conveyance">
                        <input name="actionS" type="hidden"
						id="actionS" value="CONConveyanceClearing">
                      </span></td>
                    </tr>
                   <!--
				    <tr>
                      <td class="boldEleven">Bank Name </td>
                      <td class="boldEleven">
					  <select name="bank" id="bank" style="width:200">
					  <option value="0">Select Bank</option>
					  <%
					 String bankdata[][] =  CommonFunctions.QueryExecute("SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME FROM com_m_bankgroup ORDER BY CHR_BANKGROUPNAME");
					 for(int u=0; u<bankdata.length; u++)
						out.print("<option selected='selected' value='"+bankdata[u][0]+"'>"+bankdata[u][1]  +"</option>");
					  %>
					  </select></td>
                    </tr>
                    <tr>
					-->
					
                      <td class="boldEleven">Description</td>
                      <td class="boldEleven"><textarea name="descriptions" id="descriptions" cols="0" rows="0" style="width:250px;height:80px;"  onBlur="textArea('descriptions','120')" ></textarea></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="2" class="boldEleven"><table width="50" border="0" align="center" cellpadding="2" cellspacing="2">
                          <tr>
                            <td width="56"><input type="submit" name="Submit" value="Submit"   accesskey="s"    class="tMLAscreenHead"></td>
                            <td width="56"><input type="button" name="Submit2"  value="Close"   accesskey="c"  class="tMLAscreenHead" onClick="redirect('Conveyancemain.jsp')"></td>
                          </tr>
                      </table></td>
                    </tr>
                  </table>
				  <%
				  	}
					else 
					{
						out.println("<div align='center' >Datat not found</div>");
					}
				  }
				  catch(Exception e)
				  {
				  	out.println("Error : "+e.getMessage());
				  }
				  %>
				  
				  
				  
				  </td>
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
			<p>&nbsp;</p>
			</center>
			 
</form>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>

<%@ include file="../footer.jsp"%>
<script language="javascript">
 
function validate()
{
	try
	{
		 
		 if(  
			checkNull("clearingdate","Enter Clearing date") 
			&& checkNullSelect("creditto","Select credited to",'')  
			//&&checkNullSelect("bank","Select Bank",'0') 
			&&checkNull("descriptions","Enter Descriptions...")  )
			
			return true;
		else
			return false;
		 
		 
	}
	catch(err)
	{
		alert(err);
	}
}	
</script>
</body>
</html>

<%
}
catch(Exception e)
{
	 
	System.out.println(e.getMessage());
}
%>
