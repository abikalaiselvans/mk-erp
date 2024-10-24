<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

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

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<style type="text/css">
<!--
.style5 {font-weight: bold}
-->
</style>
</head>
 
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>


$(function() {
		var dates = $( "#TenderDate, #timeline" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 1,
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true,
			minDate: -15, 
			onSelect: function( selectedDate ) {
				var option = this.id == "TenderDate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
			}
		});
	});
	
 
</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">



<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function validate()
{
	if(
		checkNullSelect('EmdType','Select Deposit Type','0') 
		&& checkNullSelect('division','Select division','0') 
		&& checkNull('TenderNo','Enter Tender No') 
		&& checkNull('TenderDate','Enter Tender Date') 
		&& checkNull('timeline','Enter Tender timeline') 
		&& checkNullSelect('CustomerName','Enter Customer Name','0') 
		&& checkNull('EmdAmt','Enter EMD Amount') 
		&& checkNull('EmdFavourOf','Enter In Favour Of') 
		&& checkNull('Payableat','Enter Payable at') 
		&& checkNull('OrderValue','Enter Order Value') 
		&& checkNull('Descrip','Enter Description') 
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
             <td width="412" valign="top"><table width="100%" height="380" border="0" align="center">
               <tr>
                 <td height="24" colspan="4"><div align="center"><strong>DEPOSIT<span class="boldThirteen">
                     <%
							String action=request.getParameter("action1");
							String id="",name="",desc="",actionS="",value="";
							String sql="";
							String link="";
							String taxValue="";
							if("Add".equals(action))
							{
								id="";name=""; desc="";
								actionS="INVtermAdd";
								value="Add";taxValue="";
								 
							}
						%>
                 </span></strong></div></td>
               </tr>
               <tr>
                 <td width="18" height="24">&nbsp;</td>
                 <td width="128" class="boldEleven"><div align="left">Type<span class="bolddeepred"> *</span></div></td>
                 <td width="274" class="boldEleven" align="center"><div align="left">
                     <select name="EmdType" class="formText135" id="EmdType" tabindex="1"  style="width:250">
                       <option value='0'>Select deposit type</option>
                       <option value="E">Earnest money deposit </option>
                       <option value="B">Bank guarantee </option>
                       <option value="S">Security deposit </option>
                     </select>
                 </div></td>
                 <td width="12">&nbsp;</td>
               </tr>
               <tr>
                 <td>&nbsp;</td>
                 <td class="boldEleven"  >Division<span class="bolddeepred"> *</span></td>
                 <td class="whiteMedium"  ><select name="division" style="width:250"
							class="formText135" id="division"  
							 >
                     <option value="0">Select Division</option>
                     <%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                 </select></td>
                 <td>&nbsp;</td>
               </tr>
               <tr>
                 <td width="18">&nbsp;</td>
                 <td width="128" class="boldEleven"><div align="left">Tender No<span class="bolddeepred"> *</span>&nbsp;</div></td>
                 <td width="274" class="boldEleven" align="center"><div align="left">
                     <input type="text" size ="47" class="formText135" name="TenderNo" value="" id="TenderNo" maxlength="50">
                   </div>
                     <div id='divunitname'></div></td>
                 <td width="12">&nbsp;</td>
               </tr>
               <tr>
                 <td width="18">&nbsp;</td>
                 <td width="128" class="boldEleven"><div align="left">Tender Last Date<span class="bolddeepred"> *</span>&nbsp;</div></td>
                 <td width="274" class="boldEleven" align="center"><div align="left">
                     <input name="TenderDate"
									type="text" class="formText135" id="TenderDate"
									 size="20" maxlength="20" readonly="readonly"/>
                     <script language='JavaScript' type="text/javascript"> setCurrentDate('TenderDate');   </script>
                   &nbsp; </div></td>
                 <td width="12">&nbsp;</td>
               </tr>
               <tr>
                 <td>&nbsp;</td>
                 <td class="boldEleven">Tender Timeline <span class="bolddeepred">*</span></td>
                 <td class="boldEleven" align="left"><input name="timeline"
									type="text" class="formText135" id="timeline"
									 size="20" maxlength="20" readonly="readonly"/>
                     <script language='JavaScript' type="text/javascript"> setCurrentDate('timeline');   </script>
                 </td>
                 <td>&nbsp;</td>
               </tr>
               <tr>
                 <td width="18">&nbsp;</td>
                 <td width="128" class="boldEleven"><div align="left">Customer Name<span class="bolddeepred"> *</span>&nbsp;</div></td>
                 <td width="274" class="boldEleven" align="center"><div align="left">
                     <select name="CustomerName" class="formText135" style="width:250" id="CustomerName">
                       <option value='0'>Select CustomerName</option>
                       <jsp:include page="LoadCustomer.jsp" />             
                     </select>
                 </div></td>
                 <td width="12">&nbsp;</td>
               </tr>
               <tr>
                 <td width="18">&nbsp;</td>
                 <td width="128" class="boldEleven"><div align="left">Deposit Amount <span class="bolddeepred">*</span>&nbsp;</div></td>
                 <td width="274" class="boldEleven" align="center"><div align="left">
                     <input name="EmdAmt" type="text" class="formText135" id="EmdAmt" onkeypress="return numeric_only(event,'EmdAmt','12')" size ="47" maxlength="10"/>
                 </div></td>
                 <td width="12">&nbsp;</td>
               </tr>
               <tr>
                 <td width="18">&nbsp;</td>
                 <td width="128" class="boldEleven"><div align="left">Deposit Favour Of<span class="bolddeepred"> *</span>&nbsp;</div></td>
                 <td width="274" class="boldEleven" align="center"><div align="left">
                     <input type="text" size ="47" class="formText135" name="EmdFavourOf" id="EmdFavourOf" maxlength="100" onkeyup="upperMe(this)"/>
                 </div></td>
                 <td width="12">&nbsp;</td>
               </tr>
               <tr>
                 <td width="18">&nbsp;</td>
                 <td width="128" class="boldEleven"><div align="left">Payable at<span class="bolddeepred"> *</span>&nbsp;</div></td>
                 <td width="274" class="boldEleven" align="center"><div align="left">
                     <input type="text" size ="47" class="formText135" id = "Payableat" name="Payableat" maxlength="95" onkeyup="upperMe(this)"/>
                 </div></td>
                 <td width="12">&nbsp;</td>
               </tr>
               <tr>
                 <td width="18">&nbsp;</td>
                 <td width="128" class="boldEleven"><div align="left">Order Value<span class="bolddeepred"> *</span>&nbsp;</div></td>
                 <td width="274" class="boldEleven" align="center"><div align="left">
                     <input name="OrderValue" type="text" class="formText135"  id="OrderValue" onkeypress="return numeric_only(event,'OrderValue','12')" size ="47" maxlength="10" />
                 </div></td>
                 <td width="12">&nbsp;</td>
               </tr>
               <tr>
                 <td width="18">&nbsp;</td>
                 <td width="128" align="left" valign="top" class="boldEleven"><div align="left">Description<span class="bolddeepred"> *</span>&nbsp;
                         <input type="hidden" name="filename" value="Emd" />
                         <input type="hidden" name="actionS" value="INVEmdAssign"/>
                 </div></td>
                 <td width="274" class="boldEleven" align="center"><div align="left">
                     <textarea type="text" name="Descrip" onblur="textArea('Descrip','400')"   cols="44" id="Descrip" rows="5" class="formText135"></textarea>
                 </div></td>
                 <td width="12">&nbsp;</td>
               </tr>
               <tr>
                 <td class="boldEleven">&nbsp;</td>
                 <td colspan="2" class="boldEleven"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                     <tr>
                       <td width="56"><input type="submit" name="Submit"	id="submit_btn" class="buttonbold"  value="Add"   accesskey="s"   /></td>
                       <td width="56"><input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c" 	onclick="redirect('Emd.jsp')" /></td>
                     </tr>
                 </table></td>
                 <td class="boldEleven">&nbsp;</td>
               </tr>
               <tr>
                 <td class="boldEleven">&nbsp;</td>
                 <td>&nbsp;</td>
                 <td>&nbsp;</td>
                 <td>&nbsp;</td>
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
