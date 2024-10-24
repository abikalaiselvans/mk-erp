<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%><%
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

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
 
 
$(function() {
		$( "#ReceivedDate" ).datepicker({
			changeMonth: true,
			changeYear: true,
			showOn: "button",minDate: -0, maxDate: "+2D",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); 
	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">



<script language="javascript">
function Validate()
{
	if(
		checkNullSelect('Status','Select Asset Status','0') 
		&& checkNullSelect('ReceivedBy','Select ReceivedBy','0') 
		&& checkNull('ReceivedDate','Enter ReceivedDate...')
		&& checkNull('Description','Enter Description') 

	)
		return true;
	else
		return false;
		

}
</script>


<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">

<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css" />
 


<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
	<tr><td>
			<br/>
			<br/>
			<%
String Rowid = request.getParameter("Rowid");
String sql="SELECT CHR_ITEMID,CHR_SERIALNO,CHR_DESCRIPTION,CHR_AUTHORISEDBY,CHR_EMPID ,CHR_STATUS ";
sql = sql+" FROM inv_t_asset  WHERE  INT_ASSETID="+Rowid+"";
String data[][]= CommonFunctions.QueryExecute(sql);
String Empid =data[0][4];
String serial =data[0][1];

			%>
			 
<p> 
<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
      <td width="412"><table cellspacing="2" cellpadding="2" width="450" align="center"
						border="0">
        <!--DWLayoutTable-->
        <tbody>
          <tr>
            <td height="20" colspan="3" align="center" valign="top"
									class="boldThirteen">Asset Received </td>
          </tr>
          <tr>
            <td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead"> Mandatory </span></td>
          </tr>
          <tr>
            <td height="17" class="boldEleven">EmpId</td>
            <td colspan="2" align="left"><span class="bold1"><%=CommonFunctions.QueryExecute("SELECT FIND_A_EMPLOYEE_ID_NAME('"+Empid+"') " )[0][0]%></span></td>
          </tr>
          <tr>
            <td height="17" class="boldEleven">Asset SerialNo</td>
            <td colspan="2" align="left"><%=serial%> <input name="serialId" type="hidden" id="serialId" value="<%=serial%>">
              <input name="Asset" type="hidden" id="Asset" value="<%=data[0][0]%>"></td>
          </tr>
          <tr>
            <td height="17" class="boldEleven">Return Status <span
									class="bolddeepred">* </span></td>
            <td colspan="2" align="left">
			<select name="Status" id="Status"  style="width: 175" >
				<option value="0" selected="selected">Select Status</option>
				<option value="Y">Returned</option>
				<option value="F">Damaged</option>
			</select>
			 
			</td>
          </tr>
          <tr id="chk1">
            <td height="17" class="boldEleven">ReceivedBy <span
									class="bolddeepred">* </span></td>
            <td colspan="2" align="left">
			
			<select name="ReceivedBy" id="ReceivedBy" style="width: 175">
                <option value='0'>Select Authorised by</option>
                 <%
	String Approved[][] =  CommonFunctions.QueryExecute(" SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE   CHR_TYPE != 'T' AND CHR_REP='Y'");
 if(Approved.length>0)
 	for(int u=0;u<Approved.length;u++)
		out.println("<option value='"+Approved[u][0]+"'>"+Approved[u][0] +  " / " +Approved[u][1]+"</option>");
 %>
                  </select> 
                    <script language="javascript">setOptionValue('ReceivedBy','<%=data[0][3]%>')</script></td>
          </tr>
          <tr id="chk3">
            <td height="17" class="boldEleven">Received Date <span class="bolddeepred">*</span></td>
            <td colspan="2" align="left"><input name="ReceivedDate"
									type="text" class="formText135" id="ReceivedDate" size="15"
									  readonly="readonly"/>
                 
                <script language='JavaScript'
									type="text/javascript">
						<!--			
							 
							setCurrentDate('ReceivedDate'); 
						//-->
                                </script></td>
          </tr>
          <tr>
            <td height="17" align="left" valign="top" class="boldEleven">Description <span class="bolddeepred">*</span>
                <input name="filename" type="hidden" value="StaffAsset"/>
                <input name="actionS" type="hidden" value="INVStaffAssetReceived"/>
                <input	 name="Empid" size="31" value="<%=Empid%>"	type="hidden"  id="Empid" readonly />
                <input name="Rowid" type="hidden" id="Rowid" value="<%=Rowid%>"></td>
            <td colspan="2" align="left" valign="top"><textarea name="Description" id="Description"
									cols="25" rows="5" class="formText135"></textarea></td>
          </tr>
          <tr>
            <td height="17" colspan="3" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                <tr>
                  <td><input name="Submit11" type="submit" id="submit"
											class="buttonbold13" value="Submit"   accesskey="s"    /></td>
                  <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onclick="redirect('StaffAsset.jsp')" /></td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td height="17" colspan="3" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
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
<p>

<p>
  <%@ include file="../footer.jsp"%>
</form>
  
  <%
  }
catch(Exception e)
{
	out.println(e.getMessage());
}

  %>
</p>
<p>&nbsp;</p>
<p>
   
</p>
<p>
  
</p>
</body>
</html>
