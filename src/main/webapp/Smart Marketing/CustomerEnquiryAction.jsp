<%@ page contentType="text/html; charset=iso-8859-1" import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<html><head>
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

<title> :: MARKETING ::</title>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/common/SelectChangesCountry.js"></script>

  <%
String content ="";
content = content +" <table width='100%'>";
content = content +"<tr > ";
content = content +"<td width='35%' class='boldEleven'> Customer Name<span class='spc'>*</span></td> ";
content = content +" <td width='65%' class='boldEleven'><input name='Cusname' type='text' class='formText135' id='Cusname'  value='' size='30' maxlength='99' onBlur='upperMe(this)' ></td>";
content = content +"  </tr>";
content = content +"<tr > ";
content = content +"<td width='35%' class='boldEleven'> Contact Person <span class='spc'>*</span></td> ";
content = content +"<td width='65%' class='boldEleven'><input name='contactname' type='text' class='formText135' id='contactname'  value='' size='30' maxlength='50' onBlur='upperMe(this)'   ></td> ";
content = content +" <tr>";
content = content +" <tr >";
content = content +"<td width='35%' class='boldEleven'>Address <span class='spc'>*</span></td> ";
content = content +" <td width='65%' class='boldEleven'><input name='address1' type='text' class='formText135' id='address1' value='' size='30' maxlength='99' ></td> ";
content = content +"</tr> ";
content = content +"<tr > ";
content = content +"<td width='35%' height='17' class='boldEleven'> City <span class='bolddeepred'> * </span></td> ";
content = content +"<td  width='65%' align='left' class='bolddeepblue'><select name='city' id='city' style='width:170' onChange=AssignPincode('pincode')> ";
content = content +"<option value='0' selected='selected'>Select</option> ";
content = content +"</select></td> ";
content = content +"</tr> ";
content = content +"<tr > ";
content = content +"<td width='35%' height='17' class='boldEleven'>District<span class='bolddeepred'> * </span></td> ";
content = content +" <td  width='65%' align='left' class='bolddeepblue'><select name='district' id='district' style='width:170' onChange=' LoadSelectCity()'>";
content = content +"<option value='0' selected='selected'>Select</option> ";
content = content +"</select> ";
content = content +"</td> ";
content = content +"</tr> ";
content = content +"<tr > ";
content = content +"<td width='35%' height='17' valign='top' class='boldEleven'>State<span class='bolddeepred'> * </span></td> ";
content = content +" <td  width='65%' align='left' valign='top'><select name='state' id='state' style='width:170' onChange='LoadSelectDistrict()'>";
content = content +"<option value='0' selected='selected'>Select</option> ";
content = content +"</select> ";
content = content +"</td> ";
content = content +"  </tr>";
content = content +"<tr > ";
content = content +" <td  width='35%' height='17' valign='top' class='boldEleven'>Country<span class='bolddeepred'> * </span></td>";
content = content +"<td   width='65%' align='left'> ";
content = content +"<select name='country' id='country' style='width:170' onChange='LoadSelectState()'> ";
content = content +"<option value='0'>Select</option> ";
String readData[][]=  CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
for(int i=0;i<readData.length;i++)
content = content +"<option value='"+readData[i][0]+"'>"+readData[i][1]+"</option>";
content = content +" </select> ";

content = content +" </td> ";
content = content +" </tr> ";
content = content +" <tr > ";
content = content +" <td width='35%' height='17' valign='top' class='boldEleven'>Pincode<span class='bolddeepred'> * </span></td> ";
content = content +"  <td  width='65%' align='left' valign='top' class='bolddeepblue'>";
content = content +"  <input type='text' name='pincode' id='pincode' class='formText135' value='' maxlength='6' size='30'   readonly='readonly' /> ";
content = content +" </td> ";
content = content +"  </tr> ";
content = content +" <tr > ";
content = content +" <td width='35%' class='boldEleven'>Mobile</td> ";
content = content +"  <td width='65%' class='boldEleven'><input name='mobile1' type='text' class='formText135' id='mobile1' value='' size='30' maxlength='10' onKeyPress=' return numeric_only1(event,this,25)'  > ";
content = content +" <span class='errormessage'>(919865043008)</span></td> ";
content = content +"  </tr> ";
content = content +" <tr > ";
content = content +" <td width='35%' class='boldEleven'>Email<span class='spc'> *</span></td> ";
content = content +" <td width='65%' class='boldEleven'><input name='email' type='text' class='formText135' id='email' value='' size='30' maxlength='99'    /><span class='errormessage'>(test@test.net)</span> <div id='divunitname'></div></td> ";
content = content +"  </tr> ";
content = content +" <tr > ";
content = content +"  <td width='35%' class='boldEleven'>Group Name  <span class='spc'>*</span></td> ";
content = content +" <td width='65%' class='boldEleven'><select name='group' class='formText135' id='group'   style='width:175'> ";
content = content +"  <option value='0'>Select</option>";
String sdata[][] =  CommonFunctions.QueryExecute("SELECT INT_GROUPID,CHR_GROUPNAME FROM  mkt_m_customergroup ORDER BY CHR_GROUPNAME ");
for(int u=0;u<sdata.length;u++)
content = content +" <option value='"+sdata[u][0]+"'>"+sdata[u][1]+"</option>";
content = content +" </select>  ";
content = content +"</td> ";
content = content +"</tr></table> ";	


String   content1 = " ";
content1 = content1 +" ";
content1 = content1 +"<table width='100%'> ";
content1 = content1 +"<tr id='hidethis1'> ";
content1 = content1 +"<td width='35%' class='boldEleven'>Customer<span class='spc'> *</span></td> ";
content1 = content1 +"<td width='65%' class='boldEleven'> ";
content1 = content1 +"<select name='customer' class='formText135' id='customer'  style='width:175'> ";
content1 = content1 +"<option value='0'>Select Customer</option> ";
String cdata[][]= CommonFunctions.QueryExecute("SELECT a.INT_CUSTOMERID,b.CHR_NAME ,a.CHR_CONTACTPERSON  FROM mkt_m_customerinfo a, mkt_m_customername b  WHERE a.INT_CUSTOMERNAMEID =b.INT_CUSTOMERNAMEID  AND  a.CHR_VERIFY='Y'  ORDER BY b.CHR_NAME ");  
if(cdata.length>0)  
	for(int u=0;u<cdata.length;u++)  
		content1 = content1 +"<option value='"+cdata[u][0]+"'>"+cdata[u][1]+" / "+cdata[u][2]+"</option>";
content1 = content1 +"</select>                </td> ";
content1 = content1 +"</tr> ";
content1 = content1 +"</table> ";

 			  %>
<script language="javascript">
var status="";

function changeStateN()
{
	if(document.getElementById('Ncustomer').checked)
	{
		var tb=document.getElementById('t1');
  	 	tb.innerHTML="<%=content%>"  ; 
		
		var tb=document.getElementById('t2');
  	 	tb.innerHTML=""  ; 
	
	}
	else
	{
		var tb=document.getElementById('t1');
  	 	tb.innerHTML=""  ; 
		var tb=document.getElementById('t2');
  	 	tb.innerHTML="<%=content1%>"  ; 
		
	}
}

//function numeric_only1(e,ctr,len )//firfox
function numeric_only1(e,ctr,len)//firfox
{
	//alert("value..."+len+" event ..."+e.charCode+"keycode...."+e.keyCode);
	//var txtval=document.getElementById(ctr).value;
	var txtval=ctr.value;
	//alert("value..."+txtval);

	var unicode = e.charCode ? e.charCode : e.keyCode;
	if( unicode == 8 || unicode == 9 || ( unicode >= 48 && unicode <= 57 ) )
	{
		if(txtval !="")
		if(txtval.length>=len)
		{	
			unicode=0;		
			alert("Max char reached");
			return false;
		}
		return true;
	}	
	else
		return false;
}
  
function Validate()
{
	if( 
			checknewCustomer()
			&& checkNull( "subject","Enter subject" )
			&& checkNull( "desc","Enter description" )
			&& checkNullSelect( "assignto","Select assignto",'0')
		)
				return true;
			else
				return false;	
}







function checknewCustomer()
{
		if(document.getElementById('Ncustomer').checked)
		{
			if(
				checkNull("Cusname","Enter the customer name") 
				&& checkNull("contactname","Enter the contact name") 
				&& checkNull("address1","Enter the address") 
				&& checkNullSelect("country","Select the Country",'0')
				&& checkNullSelect("state","Select the state",'0')
				&& checkNullSelect("district","Select the district",'0') 
				&& checkNullSelect("city","Select the city",'0') 
				&& checkNull("email","Enter the personal E-mail id...") 
				&& chkemail("email") 
				&& checkNullSelect("group","Select the group",'0') 
				&& checkNull( "subject","Enter subject" )
				&& checkNull( "desc","Enter description" )
				&& checkNullSelect( "assignto","Select assignto",'0')
			  )
				return true;
			else
				return false;	
		}
		else
		{
			if(checkNullSelect("customer","Select the customer",'0'))	
				return true;
			else
				return false;
		}
}
	
</script>

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
</head>

<body onselectstart="return false" onpaste="return false;" onCopy="return false"    >
<%@ include file="index.jsp"%>

<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">  
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
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
		<table class="BackGround" cellspacing="0" cellpadding="0" width="600"
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
				  <td width="600">
				   
		 
				  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
                    <tr>
                      <td colspan="2" class="bold1"><div align="center">Enquiry
                                                   <span class="boldEleven">
                          <input type="hidden" name="filename" value="EnquiryCustomerInfo" />
                          <input type="hidden" name="actionS"  value="MKTEnquiryCustomerInfoAdd" />
                          </span></div></td>
                    </tr>
					
					
					<tr>
					<td>
					</td></tr>
					<tr   >
					  <td height="0"><table width='100%'>
					    <tr>
					      <td width="35%" class='boldEleven'>New Customer </td>
					      <td width="65%"><span class='boldEleven'>
					        <input name='Ncustomer' type='checkbox' id='Ncustomer' value='Y' onClick='changeStateN()' >
					        </span></td>
				        </tr>
					     
				      </table></td>
				    </tr>
					<tr >
					  <td height="0"><div id="t1"><%=content1%></div></td>
				    </tr>
					<tr >
					  <td height="0">
					<div id="t2"></div>
                    </td></tr>
					<tr><td>
					<table width="100%">
					
					 <tr>
                      <td width="35%" class="boldEleven">Subject<span class="spc"> *</span></td>
                      <td width="65%" class="boldEleven"><input name="subject" type="text" class="formText135" id="subject" value="" size="30" maxlength="100" style="width:175">                          </td>
                    </tr>
					
					<tr>
                      <td width="35%" class="boldEleven">Description<span class="spc"> *</span></td>
                      <td width="65%" class="boldEleven"><textarea name="desc" cols="30" rows="5" class="formText135" maxlength="100"
									id="desc" ></textarea></td>
                    </tr>
					
                    <tr>
                      <td width="35%" class="boldEleven">Assign To <span class="spc">*</span></td>
                      <td width="65%" class="boldEleven"><select name="assignto" class="formText135" id="assignto" style="width:175" >
<option value="0">Select Staff</option>
<%

String officeid =(String)session.getAttribute("OFFICEID");
String cdata1[][]= CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff where INT_OFFICEID = "+officeid+" ORDER BY CHR_STAFFNAME");
if(cdata1.length>0)
for(int u=0;u<cdata1.length;u++)
	out.println("<option value='"+cdata1[u][0]+"'>"+cdata1[u][0]+" / "+cdata1[u][1]+"</option>");
%>
</select> </td>
                    </tr>
					</table>
					</td></tr>
                    <tr>
                      <td colspan="2" class="boldEleven">
					  <table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td><input name="Submit"  id="Submit" type="submit" class="buttonbold13"  value="Add"   accesskey="s"   ></td>
                            <td><input name="Close" type="button" class="buttonbold13" id="Close"  value="Close"   accesskey="c"  onClick="redirect('Customerenquiry.jsp')"></td>
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
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
  </form>
<%@ include file="../footer.jsp"%>
</body>
</html>
