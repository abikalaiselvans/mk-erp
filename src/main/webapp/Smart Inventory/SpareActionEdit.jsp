<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title><%= CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='INV' ")[0][0]%></title>
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
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
</head>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>


 <script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">

<script>
	
	 
	 $(function() {
		var dates = $( "#fromdate, #todate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			changeYear: true, 
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true,
			onSelect: function( selectedDate ) {
				var option = this.id == "fromdate" ? "minDate" : "maxDate",
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
<script language="javascript">
function validate()
{
	if(
		 checkNull('customernam','Enter Customer Name') 
		&& checkNullSelect("location","Select the location","")
		&& checkNullSelect("unittype","Select the unittype","")
		&& checkNullSelect("model","Select the model","")
		&& checkNullSelect('category','Select type','0') 
		&& checkNull('serialno','Enter Serial No') 
		&& checkNull('fromdate','Select StartDate') 
		&& checkNull('todate','Select EndDate') 
		 
	)
		return true;
	else
		return false;
		

}
</script>

<body    onLoad="">
<jsp:include page="indexinv.jsp" />


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
		<td>
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return validate()">
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
				  <td width="412">
				  
		<table width="465"  border="0" align="center" class="boldEleven">
              <tr>
                <td colspan="4" align="center"><span class="bold1">
                 
                  <%
String Rowid = request.getParameter("id");
String idS="",customername="",category="",address="",serial="",desc ="",from="",to="",cdate="";
String unittype="", modelnumber="", location="";
//idS,customername,location,unittype,modelnumber,category,serial,from,to

String sql="";
sql = sql+" SELECT INT_ROWID,INT_CUSTOMERID,INT_STATEID,INT_SPAREUNITID,INT_MODELID,CHR_CATEGORY,  ";
sql = sql+" CHR_SERIALNO,DATE_FORMAT(DT_STARTDATE,'%d-%m-%Y'),DATE_FORMAT(DT_ENDDATE,'%d-%m-%Y')   ";
sql = sql+" FROM inv_m_sparemaster  WHERE  INT_ROWID="+Rowid+"";
//out.println(sql);
String data[][]= CommonFunctions.QueryExecute(sql);
								idS=data[0][0];
								customername=data[0][1];
								location =data[0][2];
								unittype =data[0][3];
								modelnumber =data[0][4];
								category =data[0][5];
								serial =data[0][6]; 
								from =data[0][7];
								to =data[0][8];
								 
%>
                SPARE [ MIF ]</span></td>
              </tr>
               
			  	 <tr>
                <td width="47" height="22">&nbsp;</td>
                <td width="157" valign="top" class="boldEleven">Customer Name<span class="bolddeepred"> *</span>&nbsp;</td>
                <td width="193" class="boldEleven" >
                <select name="customernam" class="formText135" id="customernam"  style="width: 200">
          <option value="">Select Customer </option>
          <%
String	custData[][]= CommonFunctions.QueryExecute("SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME FROM inv_m_sparecustomer  ORDER BY CHR_CUSTOMERNAME");
for(int u=0;u<custData.length;u++)
	out.println("<option value='"+custData[u][0]+"'>"+custData[u][1]+" [ "+custData[u][0]+" ] </option>");
          %>
          </select>
                 </td>
                <td width="50">&nbsp;</td>
              </tr>
			   
			   
			  <tr>
                <td width="47" height="22">&nbsp;</td>
                <td width="157" valign="top" class="boldEleven">State <span class="bolddeepred">*</span></td>
                <td width="193" class="boldEleven" ><select name="location" id="location" class="formText135"  style="width: 200" >
                  <option value="" selected="selected">Select State</option>
                  <%
String	stateData[][]= CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME,CHR_SHORTNAME FROM com_m_state   ORDER BY CHR_STATENAME");
for(int u=0;u<stateData.length;u++)
	out.println("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+" [ "+stateData[u][0]+" ] </option>");
																	%>
                </select></td>
                <td width="50">&nbsp;</td>
              </tr>	
			 <tr>
                 <td height="22">&nbsp;</td>
                 <td valign="top" class="boldEleven">Unit type <span class="bolddeepred"> *</span></td>
                 <td class="boldEleven" >
                    
                
                   
                   <select name="unittype" id="unittype" class="formText135" style="width: 200"  onChange="LoadSpareModel()">
                     <option value="">Select unittype </option>
                     <%
String	typeData[][]= CommonFunctions.QueryExecute("SELECT INT_SPAREUNITID,CHR_SPAREUNITNAME  FROM inv_m_spareunit   ORDER BY CHR_SPAREUNITNAME");
for(int u=0;u<typeData.length;u++)
	out.println("<option value='"+typeData[u][0]+"'>"+typeData[u][1]+" [ "+typeData[u][0]+" ]</option>");
																	%>
                   </select></td>
                 <td>&nbsp;</td>
               </tr>
               <tr>
                 <td height="22">&nbsp;</td>
                 <td valign="top" class="boldEleven">Model Number <span class="bolddeepred"> *</span></td>
                 <td class="boldEleven" ><select name="model" class="formText135" id="model"  style="width: 200" >
                   <option value="">Select Model</option>
                    <%
String	modeleData[][]= CommonFunctions.QueryExecute("SELECT INT_MODELID,CHR_MODEL  FROM inv_m_spareunitmodel WHERE INT_MODELID ="+modelnumber+"  ORDER BY CHR_MODEL");
for(int u=0;u<modeleData.length;u++)
	out.println("<option value='"+modeleData[u][0]+"'>"+modeleData[u][1] +" </option>");
																	%>
                    
                 </select></td>
                 <td>&nbsp;</td>
               </tr>
               <tr>
                 <td height="22">&nbsp;</td>
                 <td valign="top" class="boldEleven">Category <span class="errormessage">*</span></td>
                 <td class="boldEleven" > 
                   <select name="category" class="formText135" id="category"  style="width: 200">
                     <option value="A" selected>AMC</option>
                     <option value="W">Warranty</option>
                     <option value="O">Oncall</option>
                   </select></td>
                 <td>&nbsp;</td>
               </tr>
			  <tr>
                <td width="47" >&nbsp;</td>
                <td valign="top" class="boldEleven">Product SerialNo <span class="bolddeepred">*</span>&nbsp;</td>
                <td width="193" class="boldEleven" ><input name="serialno" type="text" class="formText135" id="serialno" onKeyUp="upperMe(this),CheckUnique(this,'divunitname','inv_ss_sparemaster','CHR_SERIALNO')" value="<%=serial%>" size ="30" maxlength="20" /></td>
                <td width="50">&nbsp;</td>
              </tr>	 
			   
			  <tr>
                <td width="47" height="22">&nbsp;</td>
                <td width="157" valign="top" class="boldEleven">Starting Date <span class="bolddeepred">*</span>&nbsp;</td>
                <td width="193" class="boldEleven" >
                  <input name="fromdate" type="text" class="formText135" id="fromdate" value="<%=from%>" size="20"  readonly="readonly"/> 
				  		</td>
                <td width="50">&nbsp;</td>
              </tr>	
            <tr>
                <td width="47" height="22">&nbsp;</td>
                <td width="157" valign="top" class="boldEleven">Ending Date <span class="bolddeepred">*</span>&nbsp;
                
                <input type="hidden" name="filename" value="ServiceSpare" />
                          <input type="hidden" name="actionS"  value="INVServiceSpareEdit" />
                          <input name="id" type="hidden" id="id" value="<%=idS%>">
                  <script language="javascript">
                  setOptionValue('customernam',"<%=customername%>");
				 setOptionValue('location',"<%=location%>");
				setOptionValue('unittype',"<%=unittype%>");
				  setOptionValue('model',"<%=modelnumber%>");
				 setOptionValue('category',"<%=category%>");
				    
                  </script>   
                 
                </td>
                <td width="193" class="boldEleven" ><input name="todate" type="text" class="formText135" id="todate" value="<%=to%>" size="20" readonly />
				 		  </td>
                <td width="50">&nbsp;</td>
              </tr>	  
			   <tr>
                <td width="47" height="22">&nbsp;</td>
                <td width="157" class="boldEleven">&nbsp;</td>
                <td width="193" class="boldEleven" align="center">&nbsp; </td>
                <td width="50">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="4"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                    <tr> 
                      <td width="56"><input type="submit" name="Submit"	id="Submit" class="buttonbold" value="Update" /></td>
                      <td width="56"><input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c" 	onClick="redirect('SpareMaster.jsp')" /></td>
                    </tr>
                </table></td>
              </tr>
            </table>

				  
				  
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
		</form>
		</td>
	</tr>
	<tr>
		<td height="65">&nbsp;</td>
	</tr>
</table>
<jsp:include page="../footer.jsp" />
</body>
</html>
<%
}
catch(Exception e)
{
		System.out.println(e.getMessage());
}
%>
