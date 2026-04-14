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
		&& checkNullSelect( "accouttype","Select The accouttype", "" )
		&& checkNullSelect( "vertical","Select The Product" ,"") 
		&& checkNullSelect( "lob","Select The LOB" ,"") 
		&& checkNullSelect( "oem","Select The OEM","" ) 
		&& checkNull( "approxclosure","Enter The Approx Closure" ) 
		&& checkNullSelect( "probabilitywinning","Enter The Probability Winning" ,"") 
		&& checkNull( "qty","Enter The QTY" ) 
		&& checkNull( "unitvalue","Enter The Unit Value" ) 
		&& checkNull( "totalvalue","Enter The Total value" ) 
		&& checkNull( "bottomlinevalue","Enter The BottomLine value" ) 
		&& checkNullSelect( "stage","Select stage" ,'')
		//&& checkNullSelect( "stage","Enter The OEM" ) 
		//&& checkNull( "proposal","Enter The Proposal" ) 
		&& checkNull( "status","Enter The Status" ) 
		&& checkNull( "remarks","Enter The Remarks" )  
		 

		)
		return true;
	else
		return false;				
 } 	

//clientname, approxclosure,unitvalue,qty,totalvalue,bottomlinevalue,remarks
//location,accouttype,vertical,lob,oem,probabilitywinning,stage,status

 
 function calculateValue()
	{
  		 
  		var quantity = document.getElementById('qty').value;
  		var uprice = document.getElementById('unitvalue').value;
  		var total = (quantity * uprice) ;
  		document.getElementById('totalvalue').value = total;
  		 
	}
	
 function checkNameLength()
 {
	 try
	 {
		 var customername = document.getElementById('customername').value;
		 if(customername.length >=8)
		 {
			 return true;
		 }
		 else
		 {
			 alert("Check the customer name");
			 return false;
		 }
	

	 }
	 catch(err)
	 {
		 alert(err);
		 return false;
	 }
 }
</script>




<script type="text/javascript">
function lookup(SerialNumber) 
{
	if(SerialNumber.length == 0) 
	{
		$('#suggestions').hide();
	} 
	else 
	{
		$.post("Search_Customername.jsp", {queryString: ""+SerialNumber+""}, function(data)
		{
			if(data.length >0) 
			{
				$('#suggestions').show();
				$('#autoSuggestionsList').html(data);
			}
		});
	}
}

function fill(thisValue) 
{
	setTimeout("$('#suggestions').hide();", 200);
}

 
</script>


<script>
	
	
$(function() {
		$( "#approxclosure" ).datepicker({ 
		minDate: -10, maxDate: "+30D" ,
			defaultDate: "+1w",
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true 
			
		});
	});
 
 
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
              <td colspan="5" class="bold1"><div align="center"><span class="boldThirteen">MY FUNNEL </span>
                      <%
							String action=request.getParameter("action1");
							String msg= ""+request.getParameter("msg");
							String rowid= ""+request.getParameter("rowid");
							
							String clientname="", approxclosure="",unitvalue="",qty="",totalvalue="",bottomlinevalue="",remarks="";
							String location="",accouttype="",vertical="",lob="",oem="",probabilitywinning,stage="",status="";
							String entrydate = "";
							
							String  product="" ,category="" ;
							String  proposal="";

							String id="", value="", actionS="" ;
							String sql="";
							String link="";
							String link1="";
							String taxValue="";
							if("Add".equals(action))
							{
								id=""; 
								clientname=""; approxclosure="";unitvalue="";qty="";totalvalue="";bottomlinevalue="";remarks="";
								location="";accouttype="";vertical="";lob="";oem=""; probabilitywinning=""; stage="";status="";
								clientname="";location="";product="";lob="";oem="";category="";approxclosure="";probabilitywinning="";
							    qty=""; unitvalue="";totalvalue="";bottomlinevalue="0";stage="";proposal="";status="";remarks="";
								entrydate="";
								actionS="MKTMyFunnelAdd";
								value="Add"; taxValue=""; 
								
	 					}
							else
							{
								id="";  
								id=request.getParameter("rowid");
								 
  								sql = sql + " SELECT INT_FUNNELID, CHR_CLIENT_NAME, CHR_LOCATION, CHR_ACCOUNTTYPE, CHR_VERTICAL,  ";
  								sql = sql + "  CHR_LOB_TYPE, CHR_OEM,  DATE_FORMAT(DT_APPR_CLOSURE,'%d-%m-%Y')  ,CHR_WINNING, ";
  								sql = sql + " INT_UNITVALUE, INT_QTY, DOU_TOTAL_VALUE, DOU_BOTTOM_VALUE, CHR_STAGE, CHR_SATUS, CHR_REMARK,  ";
  								sql = sql + " DT_UPDATEDATE,  DATE_FORMAT(DT_ENTRY,'%d-%m-%Y') from mkt_t_funnel  ";  
  								sql = sql + " WHERE INT_FUNNELID="+id;  
  								//out.println(sql);
								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];
								clientname=data[0][1];location=data[0][2];accouttype=data[0][3];vertical=data[0][4];
								lob=data[0][5];oem=data[0][6];approxclosure=data[0][7];probabilitywinning=data[0][8];
								unitvalue=data[0][9];qty=data[0][10]; totalvalue=data[0][11];bottomlinevalue=data[0][12];
								stage=data[0][13];
								status=data[0][14]; remarks=data[0][15];  entrydate=data[0][17]; 
								
								actionS="MKTMyFunnelEdit";
								value="Update";
								link=" onBlur=\"upperMe(this),fill()\"  ";
								link1="";
								out.println(approxclosure);
								out.println(entrydate);
							}
							
						%>
              </div></td>
            </tr>
            <tr>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">&nbsp;</td>
            </tr>
            <tr>
              <td width="23%" class="boldEleven">Client Name</td>
              <td width="22%" class="boldEleven"><input name="clientname" type="text" id="clientname" value="<%=clientname%>"  onBlur="upperMe(this)" /></td>
              <td width="7%" class="boldEleven">&nbsp;</td>
              <td width="26%" class="boldEleven">Unit Value</td>
              <td width="22%" class="boldEleven"><span class="boldred">
                <input name="unitvalue" type="text" id="unitvalue" value="<%=unitvalue%>"  onKeyPress="return numeric_only(event,'unitvalue','25')" onBlur="calculateValue()"/>
              </span></td>
            </tr>
            <tr>
              <td   class="boldEleven">Location</td>
              <td  class="boldEleven">
			  				<select name="location" id="location">
			  				<option value="">Select location</option>
							<option value="Coimbatore">Coimbatore</option>
							<option value="Chennai">Chennai</option>
							<option value="Madurai">Madurai</option>
							<option value="Bengaluru">Bengaluru</option>
							</select>
							<script language="javascript">setOptionValue('location','<%=location%>')</script> </td>
              <td   class="boldEleven">&nbsp;</td>
              <td   class="boldEleven">Qty</td>
              <td   class="boldEleven"><input name="qty" type="text" id="qty" value="<%=qty%>" onKeyPress="return numeric_only(event,'qty','25')" onBlur="calculateValue()"/></td>
            </tr>
            <tr>
              <td   class="boldEleven">Account Type </td>
              <td  class="boldEleven"><select name="accouttype" id="accouttype">
                <option value="">Select Account Type</option>
                <option value="House Account">House Account</option>
                <option value="Prime Account">Prime Account</option>
                <option value="Farming">Farming</option>
                <option value="Acquisition">Acquisition</option>
				<option value="SOHO / OTR">SOHO / OTR</option>
              </select>
			  <script language="javascript">setOptionValue('accouttype','<%=accouttype%>')</script>			  </td>
              <td   class="boldEleven">&nbsp;</td>
              <td   class="boldEleven">Total Value</td>
              <td   class="boldEleven"><div class="suggestionsBox" id="suggestions" style="display: none; width:440">
                  <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:100px" ></div>
              </div>                
                <input name="totalvalue" type="text" id="totalvalue" value="<%=totalvalue%>"  onBlur="upperMe(this)"  readonly=""/></td>
            </tr>
            <tr>
              <td class="boldEleven">Vertical</td>
              <td class="boldEleven">
			  <select name="vertical" id="vertical">
                <option value="">Select Vertical</option>
                <option value="BFSI">BFSI</option>
				<option value="Education">Education</option>
				<option value="Government">Government</option>
				<option value="Health Care">Health Care</option>
				<option value="IT / ITES">IT / ITES</option>
				<option value="Manufacturing">Manufacturing</option>
				<option value="SMB">SMB</option>
				<option value="SOHO">SOHO</option>
				<option value="Others">Others</option> 
  			</select>
			  <script language="javascript">setOptionValue('vertical','<%=vertical%>')</script>  </td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">Bottomline Value</td>
              <td class="boldEleven"><input name="bottomlinevalue" type="text" id="bottomlinevalue" value="<%=bottomlinevalue%>"    onKeyPress="return numeric_only(event,'bottomlinevalue','25')" onBlur="upperMe(this)" /></td>
            </tr>
            <tr>
              <td class="boldEleven">LOB Type</td>
              <td class="boldEleven">
			   <select name="lob" id="lob">
                <option value="">Select LOB</option>
                <option value="Desktop">Desktop</option>
				<option value="Laptop">Laptop</option>
				<option value="Networking">Networking</option>
				<option value="End Point Security">End Point Security</option>
				<option value="Firewall Security">Firewall Security</option>
				<option value="Server">Server</option>
				<option value="Storage">Storage</option>
				<option value="Workstation">Workstation</option>
				<option value="Upgrade">Upgrade</option>
				<option value="Consumables">Consumables</option>
				<option value="AMC / Warranty Extension">AMC / Warranty Extension</option>
				<option value="Others">Others</option>
				<option value="Printer">Printer</option>
				<option value="Backup">Backup</option>
  			</select>
			  <script language="javascript">setOptionValue('lob','<%=lob%>')</script>			   </td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">Stage</td>
              <td class="boldEleven">
			  <select name="stage" id="stage">
			  				<option value="">Select Stage</option>
							<option value="0">Stage 0%</option>
							<option value="1">Stage 1%</option>
							<option value="10">Stage 10%</option>
							<option value="30">Stage 30%</option>
							<option value="60">Stage 60%</option>
							<option value="90">Stage 70%</option>
							<option value="100">Stage 100%</option>
						    </select>
							<script language="javascript">setOptionValue('stage','<%=stage%>')</script>			  </td>
            </tr>
            <tr>
              <td class="boldEleven">OEM</td>
              <td class="boldEleven">
			   <select name="oem" id="oem">
                <option value="">Select OEM</option>
                <option value="DELL">DELL</option>
				<option value="HP">HP</option>
				<option value="Lenovo">Lenovo</option>
				<option value="HPE">HPE</option>
				<option value="Acer">Acer</option>
				<option value="Epson">Epson</option>
				<option value="Canon">Canon</option>
				<option value="Microsoft">Microsoft</option>
				<option value="Adobe">Adobe</option>
				<option value="Others">Others</option>
			 </select>	
			  <script language="javascript">setOptionValue('oem','<%=oem%>')</script>	</td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">Status</td>
              <td class="boldEleven"><select name="status" id="status">
				 <option value="">Select Status</option>
				 <option value="Live">Live</option>
				 <option value="Hold">Hold</option>
				 <option value="Lost">Lost</option>
				 <option value="Won">Won</option>
			</select><script language="javascript">setOptionValue('status','<%=status%>')</script>							</td>
            </tr>
            <tr>
              <td class="boldEleven">Approx Closure <% out.println(approxclosure);%></td>
              <td class="boldEleven"> 
			  <div align="left"><input name="approxclosure" type="text" class="formText135" id="approxclosure" size="15" readonly value="<%=approxclosure%>" /> 
				 <%
				 	if("Add".equals(action))
					{
				 %>
				 <script language='JavaScript' type="text/javascript"> setCurrentDate('approxclosure');  </script>
				 <%
				 }
				 %>
				 </div>			  </td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">Remarks </td>
              <td class="boldEleven"><input name="remarks" type="text" id="remarks" value="<%=remarks%>" /></td>
            </tr>
            <tr>
              <td class="boldEleven">Probability    Winning </td>
              <td class="boldEleven"><select name="probabilitywinning" id="probabilitywinning">
				 <option value="">Select Probability Winning</option>
				 <option value="10%">10%</option>
				  <option value="25%">25%</option>
				   <option value="50%">50%</option>
				    <option value="75%">75%</option>
					 <option value="90%">90%</option>
					 <option value="100%">100%</option>
			  </select>
			  <script language="javascript">setOptionValue('probabilitywinning','<%=probabilitywinning%>')</script> </td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">Entry Date </td>
              <td class="boldEleven"><div align="left"><input name="entrydate" type="text" class="formText135" id="entrydate" size="15" readonly value="<%=entrydate%>" /> 
				 <%
				 	if("Add".equals(action))
					{
				 %>
				 <script language='JavaScript' type="text/javascript"> setCurrentDate('entrydate');  </script>
				 <%
				 }
				 %></td>
            </tr>
            <tr>
              <td colspan="5" class="boldEleven"><!--<p>clientname, approxclosure,unitvalue,qty,totalvalue,bottomlinevalue,remarks</p>
                <p>location,accouttype,vertical,lob,oem,probabilitywinning,stage,status</p>--></td>
              </tr>
            <tr>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven"><span class="boldThirteen">
                <input type="hidden" name="filename" value="MyFunnel" />
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
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onclick="redirect('MyFunnel_View.jsp')" /></td>
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
