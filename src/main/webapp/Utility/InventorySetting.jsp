<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>

<html>
<head>

<title> :: UTILITY :: </title>

<%@include file="Redirect.jsp" %>
 
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

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<script src="../JavaScript/comfunction.js" language="javascript"></script>
<script>
function validate()
{
	if(
		checkNull("emailid","Enter emailid...")
		&& chkemail('emailid')
		&& checkNull("deleteuser","Enter Delete User...")
		&& checkNull("edituser","Enter Edit User...")
		&& checkNull("collectionemailids","Enter Mail ids...")
		&& checkNullSelect("mailtime","Select MailTime",'0')
		&& checkNullSelect("menamechange","Select ME name change",'0')
		&& checkNullSelect("deliverydays","Select delivery days",'0')
		&& checkNullSelect("deliverykilometer","Select delivery kilometer",'0')
		&& checkNull("emdmail","Enter Mail ids...")
		&& checkNull("deliverypendingmail","Enter delivery pending mail...")
		&& checkNull("installationpendingmail","Enter installation pending mail  ...")
		&& checkNull("paymentupdate","Enter payment updated mail ids...")
		&& checkNull("inward","Enter goods received mail ids...")
		 
		&& checkNullSelect("prlock","Select Purchase Request valid for ",'0')
		&& checkNullSelect("mailstockbranch","Select Stock Mail alert branch... ",'')
		&& contributionChange()
		
	)
	{
		 
		return true;
	}
	else
		return false;
}


function contributionChange()
{
	try
	{
		var c1 =parseInt(document.getElementById('contributionlevel1').value);
		var c2 =parseInt(document.getElementById('contributionlevel2').value);
		if(c1 >c2)
		{
			alert("Kindly check the minimum and maximum value");
			document.getElementById('contributionlevel1').focus();
			return false;
		}
		else
			return true;
		
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}
</script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
 
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td><table class="BackGround1" cellspacing="0" cellpadding="0" width="90%"
			align="center" border="0">
        <tbody>
          <tr>
            <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
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
            <td>
			
			 <form name="form1" method="post" action="inventorysettingresponse.jsp" onSubmit=" return validate()">
			<table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
              <tr>
                <td colspan="4" class="boldThirteen"><div align="center">INVERTORY SETTINGS 
				<%
				String data[][] = CommonFunctions.QueryExecute("SELECT INT_ROWID ,CHR_PURCHASEREQUEST,CHR_PURCHASEACCEPT,CHR_INVOICEDELETE,CHR_DELETEUSER,CHR_DAILY_COLLECTION_MAIL,CHR_DAILY_COLLECTION_MAIL_IDS, INT_DAILY_COLLECTION_MAIL_TIME,INT_DELIVERYDAYS,INT_DELIVERY_KM,INT_ME_NAME_CHANGE,CHR_EMD_MAILIDS,CHR_DELIVERY_PENDING_MAIL_IDS,CHR_INSTALLATION_PENDING_MAIL_IDS,INT_PURCHASEREQUEST_LOCK ,CHR_STOCKMAIL_ALERT_BRANCH,INT_UNBLOCK, INT_CONTRIBUTION_LEVEL1, INT_CONTRIBUTION_LEVEL2,CHR_CUSTOMERCREDITLIMIT,INT_INVOCECHANGES,CHR_MAILENABLE,CHR_PR_APPROVAL ,CHR_PR_CLOSED,CHR_INWARDMAIL,CHR_PAYMENTMAIL,CHR_STOCKTRANSFERMAIL,CHR_PR_BYPASS,CHR_BANK_NAME,CHR_ACCOUNT_NO,CHR_IFSCCODE, CHR_FOOTER_CONTENT ,CHR_SALES_INVOICE_CREATED   FROM m_inventorysetting  WHERE INT_ROWID=1");
				//String s[]="000150,001277,004464".split(",");
				//String ss="001277";
				//boolean contains = org.apache.commons.lang.ArrayUtils.contains(s, ss);
				//out.println("Contains Blue? " + contains);
				%>
				</div></td>
                </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td width="21%">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td width="17%" class="boldEleven">Mail feature enabled </td>
                <td width="21%"><input <%="Y".equals(data[0][21])?" checked='checked' ":" "%> name="mailfeatue" type="checkbox" class="formText135" id="mailfeatue" value="Y"></td>
                <td class="boldEleven">&nbsp;</td>
                <td width="41%">&nbsp;</td>
              </tr>
              <tr>
                <td class="boldEleven">Invoice Delete information <span class="boldred">*</span> </td>
                <td class="boldEleven"><input name="emailid" type="text" class="formText135" value="<%=data[0][3]%>" id="emailid" size="30" maxlength="100"></td>
                <td class="boldEleven">Invoice Delete User  <span class="boldred">*</span> </td>
                <td class="boldEleven"><input name="deleteuser" type="text" class="formText135" value="<%=data[0][4]%>" id="deleteuser" size="30" maxlength="100">
                  <span class="boldElevenlink">( e.g 001277,004321, ) </span></td>
              </tr>
              <tr>
                <td class="boldEleven">Invoice change with in </td>
                <td class="boldEleven"><select name="invoicechanges" class="formText135" id="invoicechanges" >
                  <%
				for(int u=1;u<=400;u++)
				 	out.println("<option value='"+u+"'>"+u+" - Days </option>");	
				%>
                </select>
				<script language="javascript">setOptionValue('invoicechanges','<%=data[0][20]%>')</script>				</td>
                <td class="boldEleven">Invoice Edit User <span class="boldred">*</span></td>
                <td class="boldEleven"><input name="edituser" type="text" class="formText135" value="<%=data[0][4]%>" id="edituser" size="30" maxlength="100">
                  <span class="boldElevenlink">( e.g 001277,004321, ) </span></td>
              </tr>
              <tr>
                <td class="boldEleven">Enable Daily Collection Report <span class="boldred">*</span>
				  <%
				String f1="";
				if("Y".equals(data[0][5]))
					f1 = " checked = 'checked' ";
				%>				</td>
                <td class="boldEleven"><input name="collectionmail" <%=f1%> type="checkbox" id="collectionmail" value="Y"></td>
                <td class="boldEleven">mail ids for Daily Report <span class="boldred">*</span> </td>
                <td class="boldEleven"><input name="collectionemailids" type="text" class="formText135" value="<%=data[0][6]%>" id="collectionemailids" size="30" maxlength="100"></td>
              </tr>
              <tr>
                <td class="boldEleven"> Dail Collection Report Mail Time  <span class="boldred">*</span> </td>
                <td class="boldEleven">
				<select name="mailtime" id="mailtime">
				<option value="0"> Select Time</option>
				<%
					for(int i=15;i<24;i++)
						out.println("<option value='"+i+"'>"+(i-12)+" PM </option>");
				%>
                </select> 
				<script language="javascript">setOptionValue('mailtime','<%=data[0][7]%>')</script>                </td>
                <td class="boldEleven">M.E Name Change  <span class="boldred">*</span> </td>
                <td class="boldEleven"><select name="menamechange" class="formText135" id="menamechange">
                  <option value="0">Select ME Name Change </option>
                  <%
				 for(int u=1;u<161;u++)
				 	out.println("<option value='"+u+"'>"+u+" - Days </option>");
				%>
                </select> 
				<script language="javascript">setOptionValue('menamechange','<%=data[0][10]%>')</script>				</td>
              </tr>
              <tr>
                <td class="boldEleven">Delivery Days Lock  <span class="boldred">*</span> </td>
                <td class="boldEleven">
				<select name="deliverydays" class="formText135" id="deliverydays">
				<option value="0">Select Delivery Days</option>
				<%
				 for(int u=1;u<60;u++)
				 	out.println("<option value='"+u+"'>"+u+" - Days </option>");
				%>
                </select><script language="javascript">setOptionValue('deliverydays','<%=data[0][8]%>')</script>                </td>
                <td class="boldEleven">Delivery Kilometer  <span class="boldred">*</span> </td>
                <td class="boldEleven">
				<select name="deliverykilometer" class="formText135" id="deliverykilometer">
				<option value="0">Select Delivery Kilometer</option>
				<%
				 for(int u=1;u<60;u++)
				 	out.println("<option value='"+u+"'>"+u+" - Days </option>");
				%>
                </select><script language="javascript">setOptionValue('deliverykilometer','<%=data[0][9]%>')</script>				</td>
              </tr>
              <tr>
                <td class="boldEleven">EMD Mail <span class="boldred">*</span></td>
                <td class="boldEleven"><textarea onBlur="textArea('emdmail','400')" name="emdmail" cols="30" rows="5" class="formText135" id="emdmail"><%=data[0][11]%></textarea></td>
                <td class="boldEleven">Delivery pending mail <span class="boldred">*</span></td>
                <td class="boldEleven"><textarea name="deliverypendingmail"  onBlur="textArea('deliverypendingmail','400')" cols="30" rows="5" class="formText135" id="deliverypendingmail"><%=data[0][12]%></textarea></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Purchase Request Lock  <span class="boldred">*</span></td>
                <td align="left" valign="top" class="boldEleven">
				<select name="prlock"  id="prlock">
                  <%
						  for(int u=1;u<=100;u++)
						  	out.println("<option value='"+u+"'>"+u+" - Days</option>");
						  %>
                </select>
				<script language="javascript">setOptionValue('prlock','<%=data[0][14]%>')</script>				</td>
                <td align="left" valign="top" class="boldEleven">Installation pending mail <span class="boldred">*</span></td>
                <td align="left" valign="top" class="boldEleven"><textarea name="installationpendingmail"  onBlur="textArea('installationpendingmail','400')" cols="30" rows="5" class="formText135" id="installationpendingmail"><%=data[0][13]%></textarea></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">P.R Approval <span class="boldred">*</span> </td>
                <td align="left" valign="top" class="boldEleven"><textarea name="prapproval" cols="30" rows="5" class="formText135" id="prapproval"><%=data[0][22]%></textarea></td>
                <td align="left" valign="top" class="boldEleven">P.R Closed <span class="boldred">*</span></td>
                <td class="boldEleven"><textarea name="perclosed" cols="30" rows="5" class="formText135" id="perclosed"><%=data[0][23]%></textarea></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Payment updated <span class="boldred">*</span></td>
                <td align="left" valign="top" class="boldEleven"><textarea name="paymentupdate" cols="30" rows="5" class="formText135" id="paymentupdate"><%=data[0][25]%></textarea></td>
                <td align="left" valign="top" class="boldEleven">Goods Received Mails <span class="boldred">*</span></td>
                <td class="boldEleven"><textarea name="inward" cols="30" rows="5" class="formText135" id="inward"><%=data[0][24]%></textarea></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Stock Transfer Mails <span class="boldred">*</span></td>
                <td align="left" valign="top" class="boldEleven"><textarea name="stocktransfermail" cols="30" rows="5" class="formText135" id="stocktransfermail"><%=data[0][26]%></textarea></td>
                <td align="left" valign="top" class="boldEleven">P.R  Required</td>
                <td align="left" valign="top" class="boldEleven"><select name="bypasspr" class="formText135" id="bypasspr" >
                  <option value="">Select </option>
				  <option value="Y">Yes</option>
				  <option value="N">No</option>
                </select>
				<script language="javascript">setOptionValue('bypasspr','<%=data[0][27]%>')</script>				</td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Release Unblock invoice in days </td>
                <td align="left" valign="top" class="boldEleven">
				<select name="blockinvoice" class="formText135" id="blockinvoice">
                <%
				for(int u=1;u<=30;u++)
				 	out.println("<option value='"+u+"'>"+u+" - Days</option>");	
				%>
				</select>
				<script language="javascript">setOptionValue('blockinvoice','<%=data[0][16]%>')</script>                </td>
                <td align="left" valign="top" class="boldEleven">P.R Contribution minimum </td>
                <td class="boldEleven"><select name="contributionlevel1" class="formText135" id="contributionlevel1" >
                  <%
				for(int u=1;u<=100;u++)
				 	out.println("<option value='"+u+"'>"+u+"  %</option>");	
				%>
                </select>
				<script language="javascript">setOptionValue('contributionlevel1','<%=data[0][17]%>')</script>				</td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Creditlimit for customer </td>
                <td align="left" valign="top" class="boldEleven"><input name="creditlimit" <%="Y".equals(data[0][19])?" checked='checked'":" "%> type="checkbox" id="creditlimit" value="Y"></td>
                <td align="left" valign="top" class="boldEleven">P.R Contribution maximum </td>
                <td class="boldEleven"><select name="contributionlevel2" class="formText135" id="contributionlevel2"  >
                  <%
				for(int u=1;u<=100;u++)
				 	out.println("<option value='"+u+"'>"+u+"  %</option>");	
				%>
                </select>
				<script language="javascript">setOptionValue('contributionlevel2','<%=data[0][18]%>')</script>				</td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                <td align="left" valign="top" class="boldEleven">Sales Invoice Created By </td>
                <td class="boldEleven"><select name="salesinvoice" class="formText135" id="salesinvoice"  >
                  <option value="A">Automatic</option>
				  <option value="M">Manual</option>
                </select><%=data[0][32]%>
				<script language="javascript">setOptionValue('salesinvoice','<%=data[0][32]%>')</script>
				</td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Enable daily stock report   <span class="boldred">*</span></td>
                <td colspan="2" align="left" valign="top" class="boldEleven">
                <select name="mailstockbranch" size="10" multiple
									class="formText135" id="mailstockbranch" style="width:300" tabindex="6"
									 >
                  
                  <%
				  

	String stdata[] = data[0][15].split(",");
	String shipids[][] = CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID  AND a.INT_ACTIVE= 1 AND b.INT_ACTIVE =1");
	boolean f = false;						
	if(shipids.length>0)							
		for(int c=0;c<shipids.length;c++)
		{	
			f = false;
			for(int u=0; u<stdata.length;u++)
				if(stdata[u].equals(shipids[c][0]) )
					f= true;
					
			if(f)
				out.print("<option value='"+shipids[c][0]+"'  selected='selected'  title='"+shipids[c][2]+" @ "+shipids[c][1]+"'>"+shipids[c][2]+" @ "+shipids[c][1]+"</option>");
				 
			else
				out.print("<option value='"+shipids[c][0]+"'  title='"+shipids[c][2]+" @ "+shipids[c][1]+"'>"+shipids[c][2]+" @ "+shipids[c][1]+"</option>");
		}
									
 %>
                </select></td>
                <td class="boldEleven">&nbsp;</td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Invoice Bank &amp; Branch Name </td>
                <td align="left" valign="top" class="boldEleven"><input name="bankname" type="text" class="formText135" id="bankname" value="<%=data[0][28]%>"></td>
                <td align="left" valign="top" class="boldEleven">Account Number </td>
                <td align="left" valign="top" class="boldEleven"><input name="accountnumber" type="text" class="formText135" id="accountnumber" value="<%=data[0][29]%>"></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">IFSC Code </td>
                <td align="left" valign="top" class="boldEleven"><input name="ifsccode" type="text" class="formText135" id="ifsccode" value="<%=data[0][30]%>"></td>
                <td align="left" valign="top" class="boldEleven">Footer Content </td>
                <td align="left" valign="top" class="boldEleven"><textarea name="footercontent" cols="50" rows="5" id="footercontent"><%=data[0][31]%></textarea></td>
              </tr>
              <tr>
                <td colspan="4"><table border="0" align="center" cellpadding="3" cellspacing="0">
                  <tr>
                    <td width="56"><input name="Submit" type="submit" class="buttonbold" value="Submit"   accesskey="s"   ></td>
                    <td width="56"><input name="button" type="button"
					class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect('Userframe.jsp')"></td>
                  </tr>
                </table></td>
                </tr>
            </table>
			
			</form>
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
      </table></td>
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
		<td></td>
	</tr>
</table>
 
</body>
</html>
