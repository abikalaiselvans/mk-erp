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



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">
function Validate()
  {
	if(  
		checkNull( "clientname","Enter The Client Name" ) 
		&& checkNull( "location","Enter The Location" ) 
		&& checkNull( "product","Enter The Product" ) 
		&& checkNull( "lob","Enter The LOB" ) 
		&& checkNull( "oem","Enter The OEM" ) 
		&& checkNull( "category","Enter The Category" ) 
		&& checkNull( "approxclosure","Enter The Approx Closure" ) 
		&& checkNull( "probabilitywinning","Enter The Probability Winning" ) 
		&& checkNull( "qty","Enter The QTY" ) 
		&& checkNull( "unitvalue","Enter The Unit Value" ) 
		&& checkNull( "totalvalue","Enter The Total value" ) 
		&& checkNull( "bottomlinevalue","Enter The BottomLine value" ) 
		&& checkNullSelect( "stage","Select stage" ,'0')
		//&& checkNullSelect( "stage","Enter The OEM" ) 
		&& checkNull( "proposal","Enter The Proposal" ) 
		&& checkNull( "status","Enter The Status" ) 
		&& checkNull( "remarks","Enter The Remarks" )  
		 

		)
		return true;
	else
		return false;				
 } 	
 
 
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



<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>

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
							
							String clientname="",location="",product="",lob="",oem="",category="",approxclosure="",probabilitywinning="";
							String qty="", unitvalue="",totalvalue="",bottomlinevalue="",stage="",proposal="",status="",remarks="";

							String id="", value="", actionS="" ;
							String sql="";
							String link="";
							String link1="";
							String taxValue="";
							if("Add".equals(action))
							{
								id=""; 
								clientname="";location="";product="";lob="";oem="";category="";approxclosure="";probabilitywinning="";
							    qty=""; unitvalue="";totalvalue="";bottomlinevalue="";stage="";proposal="";status="";remarks="";

								actionS="MKTMyFunnelAdd";
								value="Add"; taxValue=""; 
								
	 					}
							else
							{
								id="";  
								id=request.getParameter("rowid");
								sql = " SELECT INT_FUNNELID, CHR_CLIENT_NAME,CHR_LOCATION,CHR_PRODUCT,CHR_LOB_TYPE,CHR_OEM, ";
								sql = sql + " INT_QTY,  INT_UNITVALUE,  DOU_TOTAL_VALUE, DOU_BOTTOM_VALUE, CHR_CATEGORY,CHR_STAGE,  ";
								sql = sql + " CHR_APPR_CLOSURE,CHR_SATUS,CHR_WINNING, CHR_PROPOSAL,CHR_REMARK, DT_UPDATEDATE  from mkt_t_funnel   ";
  								sql = sql + " WHERE INT_FUNNELID="+id;
								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];
								clientname=data[0][1];location=data[0][2];product=data[0][3];lob=data[0][4];oem=data[0][5];
								qty=data[0][6]; unitvalue=data[0][7];totalvalue=data[0][8];bottomlinevalue=data[0][9];category=data[0][10]; stage=data[0][11];
								approxclosure=data[0][12];status=data[0][13];probabilitywinning=data[0][14];
							    proposal=data[0][15];remarks=data[0][16]; 
								
								actionS="MKTMyFunnelEdit";
								value="Update";
								link=" onBlur=\"upperMe(this),fill()\"  ";
								link1="";
							}
							
						%>
              </div></td>
            </tr>
            <tr>
              <td width="23%" class="boldEleven">Client Name</td>
              <td width="22%" class="boldEleven"><input name="clientname" type="text" id="clientname" value="<%=clientname%>"  onBlur="upperMe(this)" /></td>
              <td width="7%" class="boldEleven">&nbsp;</td>
              <td width="26%" class="boldEleven">Qty</td>
              <td width="22%" class="boldEleven"><input name="qty" type="text" id="qty" value="<%=qty%>" onKeyPress="return numeric_only(event,'qty','25')" onBlur="calculateValue()"/></td>
            </tr>
            <tr>
              <td   class="boldEleven">Location</td>
              <td  class="boldEleven"><input name="location" type="text" id="location" value="<%=location%>"  onBlur="upperMe(this)" /></td>
              <td   class="boldEleven">&nbsp;</td>
              <td   class="boldEleven">Unit Value</td>
              <td   class="boldEleven"><div class="suggestionsBox" id="suggestions" style="display: none; width:440">
                  <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:100px" ></div>
              </div>
                  <span class="boldred">
                  <input name="unitvalue" type="text" id="unitvalue" value="<%=unitvalue%>"  onKeyPress="return numeric_only(event,'unitvalue','25')" onBlur="calculateValue()"/>
                </span></td>
            </tr>
            <tr>
              <td class="boldEleven">Product</td>
              <td class="boldEleven"><input name="product" type="text" id="product" value="<%=product%>"  onBlur="upperMe(this)" /></td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">Total Value</td>
              <td class="boldEleven"><input name="totalvalue" type="text" id="totalvalue" value="<%=totalvalue%>"  onBlur="upperMe(this)"  readonly=""/></td>
            </tr>
            <tr>
              <td class="boldEleven">LOB Type</td>
              <td class="boldEleven"><input name="lob" type="text" id="lob" value="<%=lob%>"  onBlur="upperMe(this)" /></td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">Bottomline Value</td>
              <td class="boldEleven"><input name="bottomlinevalue" type="text" id="bottomlinevalue" value="<%=bottomlinevalue%>"    onKeyPress="return numeric_only(event,'bottomlinevalue','25')" onBlur="upperMe(this)" /></td>
            </tr>
            <tr>
              <td class="boldEleven">OEM</td>
              <td class="boldEleven"><input name="oem" type="text" id="oem" value="<%=oem%>"  onBlur="upperMe(this)" /></td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">Stage</td>
              <td class="boldEleven"><select name="stage" id="stage">
			  				<option value="0">Select</option>
			  				<%
							 for(int i=0; i<=100; i=i+5)
							 {
							 	out.println("<option value='"+i+"'>Stage "+i+"%</option>");
							 }
							%>
                            </select>
							<script language="javascript">setOptionValue('stage','<%=stage%>')</script>
							</td>
            </tr>
            <tr>
              <td class="boldEleven">Category</td>
              <td class="boldEleven"><input name="category" type="text" id="category" value="<%=category%>"  onBlur="upperMe(this)" /></td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">Proposal</td>
              <td class="boldEleven"><input name="proposal" type="text" id="proposal" value="<%=proposal%>"  onBlur="upperMe(this)" /></td>
            </tr>
            <tr>
              <td class="boldEleven">Approx Closure</td>
              <td class="boldEleven"><input name="approxclosure" type="text" id="approxclosure" value="<%=approxclosure%>"  onBlur="upperMe(this)" /></td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">Status</td>
              <td class="boldEleven"><input name="status" type="text" id="status" value="<%=status%>"  onBlur="upperMe(this)" /></td>
            </tr>
            <tr>
              <td class="boldEleven">Probability    Winning&nbsp;</td>
              <td class="boldEleven"><input name="probabilitywinning" type="text" id="probabilitywinning" value="<%=probabilitywinning%>"  onBlur="upperMe(this)" /></td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven">Remarks</td>
              <td class="boldEleven"><input name="remarks" type="text" id="remarks" value="<%=remarks%>" /></td>
            </tr>
            <tr>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven"><span class="boldThirteen">
                <input type="hidden" name="filename" value="MyFunnel" />
                <input type="hidden" name="actionS"  value="<%=actionS%>" />
                <input name="rowid" type="hidden" id="rowid" value="<%=id%>" />
              </span></td>
              <td class="boldEleven">&nbsp;</td>
              <td class="boldEleven"><p>&nbsp;</p>
                </td>
              <td class="boldEleven"><p>&nbsp;</p>
                </td>
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
