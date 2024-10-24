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

<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 
</head>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
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
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">
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


	
	
var isIE;
var req;
var names;

 
function initRequest(url) 
{
    if (window.XMLHttpRequest) 
    {
        req = new XMLHttpRequest();
    } 
    else if (window.ActiveXObject) 
    {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}
 
 
 
function LoadSpareModel()
{
	try
	{
		var unittype = document.getElementById('unittype').value;
	 	var url = "../inventory?actionS=LoadSpareModel&startLetter=0&unittype="+unittype;
	 	initRequest(url);
		req.onreadystatechange=LoadSpareModelRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}
 
 function LoadSpareModelRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	 var _targ=document.getElementsByName('model')[0];       
	    	 _targ.options.length=0;
	    	 _targ.options[0]=new Option('Select model','0');  
	    	if (req.status == 200) 
	        {		  	
	    		LoadSpareModelMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
 
 
function LoadSpareModelMessages() 
{	 
 try
 {
	  
	 var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	 var _targ=document.getElementsByName('model')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select model','0');  
     var str=""; 
	 for(loop = 0; loop < batchs.childNodes.length; loop++) 
	 {	     
        var batch = batchs.childNodes[loop];
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
	    var Model = batch.getElementsByTagName("Model")[0].childNodes[0].nodeValue;
	   _targ.options[loop+1]=new Option(Model,Rowid);
	 }
      
	
  	}
 	catch(err)
 	{
 		alert(err.description);
 	}    	
}
		
</script>

<body onLoad="">
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
					<td width="5"><spacer height="1" width="1" type="block" /></td>
				  <td width="464"><table width="463" height="323" border="0" align="center" class="boldEleven">
         <tr>
                <td colspan="4"><span class="boldThirteen">
                 
                </span></td>
              </tr>
               
			  	 <tr>
			  	   <td height="22" colspan="4" align="center" class="bold1">SPARE [ MAIF ]</td>
			  	   </tr>
			  	 <tr>
                <td width="25" height="22">&nbsp;</td>
                <td width="144" valign="top">Customer Name <span class="bolddeepred">*</span>&nbsp;</td>
                <td width="227" class="boldEleven" >
                <select name="customernam" class="formText135" id="customernam"  style="width: 200">
          <option value="">Select Customer </option>
          <%
String	custData[][]= CommonFunctions.QueryExecute("SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME FROM inv_m_sparecustomer  ORDER BY CHR_CUSTOMERNAME");
for(int u=0;u<custData.length;u++)
	out.println("<option value='"+custData[u][0]+"'>"+custData[u][1]+" [ "+custData[u][0]+" ] </option>");
          %>
          </select>
                 </td>
                <td width="49">&nbsp;</td>
              </tr>
			   <tr>
                <td width="25" >&nbsp;</td>
                <td width="144" valign="top">State <span class="bolddeepred">*</span></td>
                <td width="227" class="boldEleven" ><select name="location" id="location" class="formText135"  style="width: 200" >
                  <option value="" selected="selected">Select State</option>
                  <%
String	stateData[][]= CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME,CHR_SHORTNAME FROM com_m_state   ORDER BY CHR_STATENAME");
for(int u=0;u<stateData.length;u++)
	out.println("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+" [ "+stateData[u][0]+" ] </option>");
																	%>
                </select></td>
				<td width="49">&nbsp;</td>
              </tr>	 
			   <tr>
			     <td height="22">&nbsp;</td>
			     <td valign="top">Unit type <span class="bolddeepred">*</span></td>
			     <td class="boldEleven" > <select name="unittype" id="unittype" class="formText135" style="width: 200"  onChange="LoadSpareModel()">
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
			     <td valign="top">Model Number <span class="bolddeepred">*</span></td>
			     <td class="boldEleven" ><select name="model" class="formText135" id="model"  style="width: 200" >
			       <option value="">Select Model</option>
			       </select></td>
			     <td>&nbsp;</td>
			     </tr>
			   <tr>
			     <td height="22">&nbsp;</td>
			     <td valign="top">Category <span class="errormessage">*</span></td>
			     <td class="boldEleven" ><select name="category" class="formText135" id="category"  style="width: 200">
			       <option value="A" selected>AMC</option>
			       <option value="W">Warranty</option>
			       <option value="O">Oncall</option>
			       </select></td>
			     <td>&nbsp;</td>
			     </tr>
			   <tr>
                <td width="25" height="22">&nbsp;</td>
                <td width="144" valign="top">Product SerialNo <span class="bolddeepred">*</span>&nbsp;</td>
                <td width="227" class="boldEleven" ><input type="text" size ="30" class="formText135" name="serialno" id="serialno" maxlength="20" onKeyUp="upperMe(this),CheckUnique(this,'divunitname','inv_ss_sparemaster','CHR_SERIALNO')" /><div id='divunitname'></div>
				
				
				
				</td>
                <td width="49">&nbsp;</td>
              </tr>
               
               <tr>
                 <td height="22">&nbsp;</td>
                 <td valign="top">Description  <span class="bolddeepred"> </span></td>
                 <td class="boldEleven" ><textarea name="description" cols="35"
										rows="5" class="formText135" id="description" onKeyUp="textArea('description','200')" tabindex="9"></textarea></td>
                 <td>&nbsp;</td>
               </tr>
               <tr>
                 <td width="25" height="22">&nbsp;</td>
                 <td width="144" valign="top">Starting Date <span class="bolddeepred">*</span>&nbsp;</td>
                 <td width="227" class="boldEleven" >
                   <input name="fromdate" type="text" class="formText135" id="fromdate" value="" size="20"  readonly="readonly"/> 
                   
                   
                   </td>
                 <td width="49">&nbsp;</td>
               </tr>	
			   <tr>
                <td width="25" height="22">&nbsp;</td>
                <td width="144" valign="top">Ending Date<span class="bolddeepred"> *</span>&nbsp;</td>
                <td width="227" class="boldEleven" ><input name="todate" type="text" class="formText135" id="todate" value="" size="20" readonly />
				<script language="javascript">setCurrentDate('fromdate');setCurrentDate('todate');</script> 
				  
				  </td>
                <td width="49">&nbsp;</td>
              </tr>	
			  
			  
			  
			    
               <tr>
                 <td class="boldEleven">&nbsp;</td>
                 <td valign="top">&nbsp;</td>
                 <td>&nbsp;</td>
                 <td>&nbsp;</td>
               </tr>
               <tr>
                <td class="boldEleven">&nbsp;</td>
                <td valign="top">&nbsp;</td>
                <td><input type="hidden" name="filename" value="ServiceSpare" />
                  <input type="hidden" name="actionS" value="INVServiceSpareAdd"/></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="36" colspan="4"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                    <tr>
                      <td width="56"><input type="submit" name="Submit"	id="Submit" class="buttonbold"  value="Add"   accesskey="s"   /></td>
                      <td width="56"><input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c" 	onClick="redirect('SpareMaster.jsp')" /></td>
                    </tr>
                </table></td>
              </tr>
            </table>
				  
				  
				  </td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
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
		out.println(e.getMessage());
}
%>
