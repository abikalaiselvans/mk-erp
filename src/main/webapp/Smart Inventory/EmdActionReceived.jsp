<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%><html>
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

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>


 </head>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>

$(function() {
		$( "#DateofDD" ).datepicker({
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true,
			minDate: -10, maxDate: "+15D"
		});
	}); 
 
</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function validate()
{
	try
	{
		if(
			 checkNull('DateofDD','Enter DateofDD') 
			&& checkNull('OtherDescrip','Enter Description') 
		)
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
    <td><form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit=" return validate()">
      <table class="BackGround1" cellspacing="0" cellpadding="0" width="450"
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
            <td width="412" valign="top"><table width="99%" height="380" border="0" align="center">
              <tr>
                <td height="24" colspan="4"><div align="center"><strong>DEPOSIT<span class="boldThirteen">
                    <%
String Rowid = request.getParameter("Rowid");
String sql="SELECT INT_EMD_TYPE,DAT_CREATION,CHR_TENDERNO,DATE_FORMAT(DAT_TENDER_LASTDATE,'%d-%b-%Y') ,CHR_TENDER_DESC,INT_CUSTOMERID,DOU_EMD_AMOUNT,CHR_EMD_INFAVOUROF,CHR_PAYABLE_AT,DOU_ORDERVALUE,INT_BANKGROUPID,CHR_REF,IF(CHR_APPROVAL='Y','Accept','Reject'),CHR_STATUS,DATE_FORMAT(DAT_TENDER_TIMELINE,'%d-%b-%Y') ,CHR_OTHERDEC ,CHR_EMD_REFNUMBER  ";
sql = sql+" FROM inv_t_emd_informations  WHERE  INT_EMDID="+Rowid+"";
//out.println(sql);
String data[][]= CommonFunctions.QueryExecute(sql);
String ss=" checked= 'checked' ";
%>
                </span></strong></div></td>
              </tr>
              <tr>
                <td height="24">&nbsp;</td>
                <td class="boldEleven">Deposit Reference Number </td>
                <td class="boldEleven"><%=data[0][16]%></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td width="23" height="24">&nbsp;</td>
                <td width="212" class="boldEleven"><div align="left">Type<span class="bolddeepred"> </span></div></td>
                <td width="202" class="boldEleven"><div align="left">
                    <%if(data[0][0].equals("E")){%>
                  Earnest money deposit(E)
                  <%}else if(data[0][0].equals("B")){%>
                  Bank guarantee(B)
                  <%}else if(data[0][0].equals("S")){%>
                  Security deposit(S)
                  <%}%>
                </div></td>
                <td width="10">&nbsp;</td>
              </tr>
              <tr>
                <td width="23">&nbsp;</td>
                <td width="212" class="boldEleven"><div align="left">Tender No<span class="bolddeepred"> </span></div></td>
                <td width="202" class="boldEleven" ><div align="left"><%=data[0][2]%></div></td>
                <td width="10">&nbsp;</td>
              </tr>
              <tr>
                <td width="23">&nbsp;</td>
                <td width="212" class="boldEleven"><div align="left">Tender Last Date<span class="bolddeepred"> </span></div></td>
                <td width="202" class="boldEleven"><div align="left"><%=data[0][3]%></div></td>
                <td width="10">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td class="boldEleven">Tender Timeline</td>
                <td class="boldEleven" ><%=data[0][14]%></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td width="23">&nbsp;</td>
                <td width="212" class="boldEleven"><div align="left">Customer Name<span class="bolddeepred"> </span>&nbsp;</div></td>
                <td width="202" class="boldEleven" ><div align="left">
                    <%
						String Customer[][] =  CommonFunctions.QueryExecute("SELECT FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID ) FROM inv_m_customerinfo a WHERE  a.INT_CUSTOMERID ="+data[0][5]+"");
 						
 				   %>
                    <%=Customer[0][0]%></div></td>
                <td width="10">&nbsp;</td>
              </tr>
              <tr>
                <td width="23">&nbsp;</td>
                <td width="212" class="boldEleven"><div align="left">Deposit Amount </div></td>
                <td width="202" class="boldEleven" ><div align="left"><%=data[0][6]%></div></td>
                <td width="10">&nbsp;</td>
              </tr>
              <tr>
                <td width="23">&nbsp;</td>
                <td width="212" class="boldEleven"><div align="left">Deposit Favour Of<span class="bolddeepred"> </span></div></td>
                <td width="202" class="boldEleven" ><div align="left"><%=data[0][7]%></div></td>
                <td width="10">&nbsp;</td>
              </tr>
              <tr>
                <td width="23">&nbsp;</td>
                <td width="212" class="boldEleven"><div align="left">Payable at<span class="bolddeepred"> </span></div></td>
                <td width="202" class="boldEleven" ><div align="left"><%=data[0][8]%></div></td>
                <td width="10">&nbsp;</td>
              </tr>
              <tr>
                <td width="23">&nbsp;</td>
                <td width="212" class="boldEleven"><div align="left">Order Value<span class="bolddeepred"> </span></div></td>
                <td width="202" class="boldEleven" ><div align="left"><%=data[0][9]%></div></td>
                <td width="10">&nbsp;</td>
              </tr>
              <tr>
                <td width="23">&nbsp;</td>
                <td width="212" class="boldEleven"><div align="left">Bank<span class="bolddeepred"> </span></div></td>
                <td width="202" class="boldEleven" ><div align="left">
                    <%
						String Bank[][] =  CommonFunctions.QueryExecute(" SELECT CHR_BANKGROUPNAME FROM com_m_bankgroup WHERE INT_BANKGROUPID ="+data[0][10]+"");
 				%>
                    <%=Bank[0][0]%></div></td>
                <td width="10">&nbsp;</td>
              </tr>
              <tr>
                <td width="23">&nbsp;</td>
                <td width="212" class="boldEleven"><div align="left">Description<span class="bolddeepred"> </span></div></td>
                <td width="202" class="boldEleven" ><div align="left"><%=data[0][4]%></div></td>
                <td width="10">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td class="boldEleven">Approval <span class="bolddeepred">*</span>&nbsp;</td>
                <td class="boldEleven" ><%=data[0][12]%> </td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td class="boldEleven">Returned
                  <%
				ss="";
				if("Y".equals(data[0][13]))
					ss = " checked='checked' ";
				%>
                    <span class="bolddeepred">*</span>&nbsp;</td>
                <td class="boldEleven" ><input name="returned" type="checkbox" id="returned" value="Y" <%=ss%>></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td width="23">&nbsp;</td>
                <td width="212" class="boldEleven"><div align="left">Dateof DD<span class="bolddeepred">*</span>&nbsp;</div></td>
                <td width="202" class="boldEleven" ><input name="DateofDD"
									type="text" class="formText135" id="DateofDD" size="21"
									onKeyPress="dateOnly(this)" readonly="readonly"/>
                    <script language='JavaScript'
									type="text/javascript">
						 
							setCurrentDate('DateofDD'); 
						 
                                </script>
                  &nbsp;</td>
                <td width="10">&nbsp;</td>
              </tr>
              <tr>
                <td width="23">&nbsp;</td>
                <td width="212" align="left" valign="top" class="boldEleven"><div align="left">Other Description<span class="bolddeepred">*</span>&nbsp;</div></td>
                <td width="202" class="boldEleven" ><textarea type="text" name="OtherDescrip"   cols="24" id="OtherDescrip" rows="5" class="formText135"   onkeyup="textArea('OtherDescrip','250')" ><%=data[0][15]%></textarea></td>
                <td width="10">&nbsp;</td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td>&nbsp;</td>
                <td><input type="hidden" name="actionS" value="INVEmdAssignReceived"/>
                    <input type="hidden" name="filename" value="Emd" />
                    <input name="Rowid" type="hidden" id="Rowid" value="<%=Rowid%>">
                </td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td colspan="4"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                    <tr>
                      <td width="56"><input type="submit" name="Submit"	id="submit_btn" class="buttonbold" value="Received" /></td>
                      <td width="56"><input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c" 	onClick="redirect('EMDApproval.jsp')" /></td>
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
	out.println(e.getMessage());
}
%>