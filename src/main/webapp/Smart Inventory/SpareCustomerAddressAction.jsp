   <%@ page import="java.sql.*,java.util.*,java.io.*"%>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title> 
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
<script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>

<script language="javascript" src="../JavaScript/common/SelectChangesCountry.js"></script>
<script type="text/javascript">
function lookup(inputString) 
{
	 
	if(inputString.length == 0) 
	{
		$('#suggestions').hide();
	} 
	else 
	{
		$.post("../JavaScript/pincodes.jsp", {queryString: ""+inputString+""}, function(data)
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
	var listArray = thisValue.split("/");
	setOptionValue('country',listArray[0]);
	
	var _targ=document.getElementsByName('state')[0];       
	 _targ.options.length=0;
	 _targ.options[0]=new Option(listArray[3],listArray[2]);  
	
	var _targ1=document.getElementsByName('district')[0];       
	 _targ1.options.length=0;
	 _targ1.options[0]=new Option(listArray[5],listArray[4]);  

	var _targ2=document.getElementsByName('city')[0];       
	 _targ2.options.length=0;
	 _targ2.options[0]=new Option(listArray[7],listArray[6]);  
	 
	document.getElementById('pin').value=listArray[8];
	$('#pin').val(listArray[8]);
	$('#suggestions').hide();
	//setTimeout("$('#suggestions').hide();", 200);
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
	width: 200px;
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



<script language="JavaScript">

function Validate()
  {

	if(  
			checkNullSelect( "customer","Select customer " ,'0' )
			&& checkNull( "cperson","Enter contact person" )
			&& checkNull( "address1","Enter Address - 1" )
			&& checkNull( "address2","Enter Address - 2" )
			&& checkNullSelect( "country","Select Country" ,'0')
			&& checkNullSelect( "state","Select State" ,'0')
			&& checkNullSelect( "district","Select District" ,'0')
			&& checkNullSelect( "city","Select City" ,'0')
			&& checkNull( "pin","Enter pincode" )
			&& chkemail("email")
		  )
		return true;
	else
		return false;				
		
	
 } 	
 
  

</script>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('cperson').focus()" >
<%@ include file="indexinv.jsp"%>
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
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
          <td width="412" valign="top">
		 
		    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center"><span class="boldThirteen">SPARE CUSTOMER</span>
                    <%
							String action=request.getParameter("action1");
							String id="",customer="0",name="",desc="",actionS="",value="";
							String sql="";
							String link="";
							String cperson="",address1="",address2="";
							String country="0",state="0",district="0",city="0",pin="";
							String mobile="",email="";
							String taxValue="";
							
							if("Add".equals(action))
							{
								id="";name=""; desc=" ";
								actionS="INVSpareCustomerAddressAdd";
								value="Add";taxValue="";
								link=" onBlur=\"upperMe(this), CheckUnique(this,'divunitname','inv_m_sparecustomer','CHR_CUSTOMERNAME')\"  onKeyUp=\"upperMe(this),CheckUnique(this,'divunitname','inv_m_sparecustomer','CHR_CUSTOMERNAME')\" ";
								
							}
							else
							{
								id="";name=""; 
								id=request.getParameter("rowid");
								sql = "SELECT INT_ADDRESSID,INT_CUSTOMERID,CHR_LOCATION,CHR_CONTACTPERSON,CHR_ADDRESS1, ";
								sql = sql + "CHR_ADDRESS2,INT_COUNTRYID,INT_STATEID,INT_DISTRICTID,INT_CITYID, ";
								sql = sql + "INT_PINCODE,CHR_PHONE1,CHR_PHONE2,CHR_EMAIL ";
								sql = sql + "FROM inv_m_sparecustomeraddress  WHERE INT_ADDRESSID= "+id;
								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];
								customer=data[0][1];
								cperson=data[0][3];
								address1=data[0][4];
								address2=data[0][5];
								country=data[0][6];
								state=data[0][7];
								district=data[0][8];
								city=data[0][9];
								pin=data[0][10];
								mobile=data[0][11];
								email=data[0][12];
							
								actionS="INVSpareCustomerAddressEdit";
								value="Update";
								link=" onBlur=\"upperMe(this)\"";
							}
							
						%>			
                  
                </div></td>
                </tr>
              <tr>
                <td width="31%" class="boldEleven">Customer Name
                
                 
                </td>
                <td width="69%" class="boldEleven">
                <select name="customer" class="formText135" id="customer" style="width:200">
                <option value="" selected>Select Customer</option>
                <%
String	customerData[][]= CommonFunctions.QueryExecute("SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME  FROM inv_m_sparecustomer   ORDER BY CHR_CUSTOMERNAME");
for(int u=0;u<customerData.length;u++)
	out.println("<option value='"+customerData[u][0]+"'>"+customerData[u][1]+"</option>");
				%>
				</select></td>
              </tr>
              <tr>
                <td class="boldEleven">Contact Person</td>
                <td align="left" valign="top" class="boldEleven"><input name="cperson"
									type="text" class="formText135" id="cperson"     onBlur="upperMe(this)"      value="<%=cperson%>"
									size="25" maxlength="50"></td>
              </tr>
              <tr>
                <td class="boldEleven">Address 1 <span
									class="bolddeepred">* </span></td>
                <td align="left" valign="top" class="boldEleven"><input name="address1"
									type="text" class="formText135" id="address1"     onBlur="upperMe(this)"      value="<%=address1%>"
									size="25" maxlength="50"></td>
              </tr>
              <tr>
                <td class="boldEleven">Address 2 <span
									class="bolddeepred">* </span></td>
                <td align="left" valign="top" class="boldEleven"><input name="address2"
									type="text" class="formText135" id="address2"     onBlur="upperMe(this)"      value="<%=address2%>"
									size="25" maxlength="50"></td>
              </tr>
              <tr>
                <td class="boldEleven">Country<span class="bolddeepred"> * </span></td>
                <td align="left" valign="top" class="boldEleven"><select name="country" class="formText135" id="country" style="width:215" onChange="LoadSelectState(),resetPincode('pin')">
                  <option value="0">Select Country</option>
                  <%
	 		String readData[][]=  CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<readData.length;i++)
				out.println("<option value='"+readData[i][0]+"'>"+readData[i][1]+"</option>");
	 %>
                </select></td>
              </tr>
              <tr>
                <td class="boldEleven">State<span class="bolddeepred"> * </span></td>
                <td align="left" valign="top" class="boldEleven"><select name="state" class="formText135" id="state" style="width:215" onChange="LoadSelectDistrict(),resetPincode('pin')">
                  <option value="0" selected="selected">Select State</option>
                  <%
						
						if(!"Add".equals(action))
	  					{
							String stateData[][] =  CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID=" +country);
							if(stateData.length>0)
								for(int u=0;u<stateData.length;u++)
									out.print("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+"</option>");
						}
					%>
                </select></td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">District<span class="bolddeepred"> * </span></td>
                <td align="left" valign="top" class="boldEleven"><span class="bolddeepblue">
                  <select name="district" class="formText135" id="district" style="width:215" onChange=" LoadSelectCity(),resetPincode('pin')">
                    <option value="0" selected="selected">Select District</option>
                    <%
						
						if(!"Add".equals(action))
	  					{
							String districtData[][] =  CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT FROM com_m_district WHERE INT_STATEID=" +state);
							if(districtData.length>0)
								for(int u=0;u<districtData.length;u++)
									out.print("<option value='"+districtData[u][0]+"'>"+districtData[u][1]+"</option>");
						}
					%>
                  </select>
                </span></td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">City<span class="bolddeepred"> *</span></td>
                <td align="left" valign="top" class="boldEleven"><span class="bolddeepblue">
                  <select name="city" class="formText135" id="city" style="width:215" onChange="AssignPincode('pin')">
                    <option value="0" selected="selected">Select City</option>
                    <%
						
						if(!"Add".equals(action))
	  					{
							String cityData[][] =  CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +district);
							if(cityData.length>0)
								for(int u=0;u<cityData.length;u++)
									out.print("<option value='"+cityData[u][0]+"'>"+cityData[u][1]+"</option>");
						}
					%>
                  </select>
                  
                   <%
	 if(!"Add".equals(action))
	  {
	  %>
                                <script language="JavaScript" type="text/javascript">
	   		setOptionValue('country',"<%=country%>");
			setOptionValue('state',"<%=state%>");
			setOptionValue('district',"<%=district%>");
			setOptionValue('city',"<%=city%>");
			setOptionValue('customer',"<%=customer%>");
			
	
   		                        </script>
                                <%	
	  }
	  %>
      
                </span></td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Postal<span class="bolddeepred"> * </span></td>
                <td align="left" valign="top" class="boldEleven">
                <input name="pin" type="text" class="formText135" id="pin" onKeyPress="return numeric_only(event,'pin','7') "    onKeyUp="lookup(this.value);" value="<%=pin%>" size="10" 									maxlength="6" />
                          <br />
                          <div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
                            <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                          </div>
                           					
                </td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">mobile</td>
                <td align="left" valign="top" class="boldEleven"><input name="mobile"
									type="text" class="formText135" id="mobile" onKeyPress="return numeric_only(event,'mobile','12')" value="<%=mobile%>"
									size="25" maxlength="10"></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Email</td>
                <td align="left" valign="top" class="boldEleven"><input name="email"
									type="email" class="formText135" id="email" value="<%=email%>" size="25"
									maxlength="50" ></td>
              </tr>
               
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="SpareCustomerAddress" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="rowid" type="HIDDEN" id="rowid" value="<%=id%>">				 
				<input name="userid" type="hidden" id="userid" value="<%=""+session.getAttribute("USRID")%>"></td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('Make.jsp')"></td>
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
 
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
</body>
</html>
