<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title> :: MARKETING ::</title> 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id,payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>

<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>

<script language="JavaScript">
function Validate()
  {
	if(  
		checkNull( "clientname","Enter The Client Name" ) 
		&& checkNullSelect( "location","Select The Location", "" )   
		&& checkNull( "contactperson","Enter TheContact Person" )  
		&& checkNull( "designation","Enter The Designation" ) 
		&& checkNull( "contactnumber","Enter The Contact Number" ) 
		&& checkNullSelect( "typeofcall","Select The call type", "" )
		&& checkNull( "entrydate","Enter The Entry date" ) 
		&& checkNull( "description","Enter The QTY" ) 
		//&& checkNull( "nextfollowdate","Enter The QTY" )  
		)
		return true;
	else
		return false;				
 } 	
  
	 
</script>


 
<script>
	
	
$(function() {
		$( "#entrydate" ).datepicker({ 
		minDate: -10, maxDate: "+30D" ,
			defaultDate: "+1w",
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true 
			
		});
	});
 
 
 $(function() {
		$( "#nextfollowdate" ).datepicker({ 
		minDate: -10, maxDate: "+30D" ,
			defaultDate: "+1w",
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true 
			
		});
	});
	

</script>

<style type="text/css">
body {
font-family: Helvetica;
font-size: 13px;
color: #000;
}
h3 {
margin: 0px;
padding: 0px;
}


.suggestionsBox 
{
	position: relative;
	margin: 0px 0px 0px 0px;
	width: 300px;
	background-color: #ffffff;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border: 1px solid #000;
	color: #000;
}
.suggestionList 
{
	margin: 0px;
	padding: 0px;
}
.suggestionList li 
{
	margin: 0px 0px 3px 0px;
	padding: 1px;
	cursor: pointer;
}

.suggestionList li:hover {
background-color: #99cc99;
}
</style>




<body onselectstart="return false" onpaste="return false;" onCopy="return false"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="index.jsp"%>
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
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	 <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="700"
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
          <td width="" valign="top"><table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
            <tr>
              <td colspan="5" class="bold1"><div align="center"><span class="boldThirteen">MY Daily Call </span>
                      <%
							String action=request.getParameter("action1");
							String msg= ""+request.getParameter("msg");
							String rowid= ""+request.getParameter("rowid");
							
							String clientname = "",location = "",contactperson = "",designation = "",contactnumber = "";
							String typeofcall = "",entrydate = "",description = "",nextfollowdate = "";
							String id="", value="", actionS="" ;
							String sql="";
							String link="";
							String link1="";
							 
							if("Add".equals(action))
							{
								id=""; 
								clientname = ""; location = ""; contactperson = ""; designation = ""; contactnumber="";
								typeofcall = ""; entrydate = ""; description = ""; nextfollowdate = "";
								 
								actionS="MKTMyDailyCallAdd";
								value="Add";  
								
	 					}
							else
							{
								id="";  
								id=request.getParameter("rowid");
								 
  								sql = sql + " SELECT INT_CALLID, CHR_CLIENT_NAME, CHR_LOCATION, CHR_CONTACTPERSON, CHR_DESIGNATION, INT_CONTACTNUMBER,  ";
  								sql = sql + " CHR_TYPEOFCALL,   DATE_FORMAT(DT_ENTRY,'%d-%m-%Y'), CHR_DESCRIPTION,   DATE_FORMAT(DT_FOLLOWUP,'%d-%m-%Y') ";
  								sql = sql + "  from mkt_t_mydailycall  ";  
  								sql = sql + " WHERE INT_CALLID ="+id;  
								String data[][]=CommonFunctions.QueryExecute(sql);
								//out.println(sql);
								 
								
								clientname=data[0][1]; location=data[0][2]; contactperson=data[0][3]; designation=data[0][4]; contactnumber=data[0][5];
								typeofcall=data[0][6]; entrydate=data[0][7];description=data[0][8];
								nextfollowdate=data[0][9] ;
								
								actionS="MKTMyDailyCallEdit";
								value="Update";
								link=" onBlur=\"upperMe(this),fill()\"  ";
								link1="";
								//out.println(approxclosure);
								//out.println(entrydate);
							}
							
						%>
              </div></td>
            </tr>
            <tr>
              <td width="23%" class="boldEleven">Client Name</td>
              <td width="22%" class="boldEleven"><input name="clientname" type="text" class="formText135" id="clientname"  onBlur="upperMe(this)" value="<%=clientname%>" maxlength="80" /></td>
              <td width="7%" class="boldEleven">&nbsp;</td>
              <td width="26%" class="boldEleven">Type of Call</td>
              <td width="22%" class="boldEleven"><select name="typeofcall" class="formText135" id="typeofcall">
                <option value="">Select Call Type</option>
                <option value="Follow up">Follow up</option>
                <option value="Courtesy">Courtesy</option>
                <option value="Payment">Payment</option>
                <option value="Negotiation">Negotiation</option> 
                <option value="Others">Others</option>
			 </select><script language="javascript">setOptionValue('typeofcall','<%=typeofcall%>')</script></td>
            </tr>
            <tr>
              <td class="boldEleven">Location</td>
              <td class="boldEleven">&nbsp;<select name="location" class="formText135" id="location">
			  				<option value="">Select location</option>
							<option value="Coimbatore">Coimbatore</option>
							<option value="Chennai">Chennai</option>
							<option value="Madurai">Madurai</option>
							<option value="Bengaluru">Bengaluru</option>
							</select>
							<script language="javascript">setOptionValue('location','<%=location%>')</script> </td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">Call Date</td>
              <td class="boldEleven"><input name="entrydate" type="text" class="formText135" id="entrydate" size="15" readonly value="<%=entrydate%>" /> 
				 <%
				 	if("Add".equals(action))
					{
				 %>
				 <script language='JavaScript' type="text/javascript"> setCurrentDate('entrydate');  </script>
				 <%
				 }
				 %></td>
            </tr>
            <tr valign="top">
              <td class="boldEleven">Person of Contact</td>
              <td class="boldEleven"><input name="contactperson" type="text" class="formText135" id="contactperson" value="<%=contactperson%>" maxlength="50" /></td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">Call Description</td>
              <td class="boldEleven"><textarea name="description" cols="30" rows="5" class="formText135" id="description" ><%=description%></textarea></td>
            </tr>
            <tr>
              <td class="boldEleven">Designation </td>
              <td class="boldEleven"><input name="designation" type="text" class="formText135" id="designation" maxlength="80" value="<%=designation%>" /></td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">Next Follow up Date</td>
              <td class="boldEleven"><input name="nextfollowdate" type="text" class="formText135" id="nextfollowdate" size="15" readonly value="<%=entrydate%>" />
                  <%
				 	if("Add".equals(action))
					{
				 %>
                  <script language='JavaScript' type="text/javascript"> setCurrentDate('nextfollowdate');  </script>
                  <%
				 }
				 %></td>
            </tr>
            <tr>
              <td class="boldEleven">Contact Number</td>
              <td class="boldEleven"><input name="contactnumber" value="<%=contactnumber%>" type="text" class="formText135" id="contactnumber"  onKeyPress="return numeric_only(event,'contactnumber','12')" maxlength="11"/></td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">&nbsp;</td>
            </tr>
            <tr>
              <td colspan="5" class="boldEleven"><!--<p>clientname, approxclosure,unitvalue,qty,totalvalue,bottomlinevalue,remarks</p>
                <p>location,accouttype,vertical,lob,oem,probabilitywinning,stage,status</p>--></td>
              </tr>
            <tr>
              <td colspan="5" class="boldEleven">&nbsp;</td>
              </tr>
            <tr>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven"><span class="boldThirteen">
                <input type="hidden" name="filename" value="MyDailyCall" />
                <input type="hidden" name="actionS"  value="<%=actionS%>" />
                <input name="rowid" type="hidden" id="rowid" value="<%=id%>" />
              </span></td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven"><p>&nbsp;</p>                </td>
              <td class="boldEleven"><p>&nbsp;</p>                </td>
            </tr>
            <%
					if(!"Add".equals(action))
					{
						if(  "F".equals(""+session.getAttribute("USERTYPE")) || "B".equals(""+session.getAttribute("USERTYPE"))  )
						{
						}
					}	
			%> 
             
            <tr>
              <td colspan="5" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>" /></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onclick="redirect('MyDailyCall_View.jsp')" /></td>
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
    </table> </form></td>
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


<%	
	if("Y".equals(msg))
	{
%>
<script language="javascript" >
	var rs=confirm("Account name added successfully, Are you want to add a account informations...");
	if (rs==true)
  		location = "CustomerInfoAction.jsp?action1=Add&customerrowid=<%=rowid%>"; 
	else
		location = "CustomerNameAction.jsp?action1=Add Customer";
			
</script>
<%			
	}
 
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
</body>
</html>
