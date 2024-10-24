<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>

<%
try
{
%>
<html>
<head>

<title> :: COMMON ::</title>


 
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
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function Validate()
  {
	
   
	if(  checkNull( "Name","Enter Dispensary name" ) 
		 && checkNull( "addresss","Enter Dispensary Address" )  
		 && checkNullSelect( "country","Select Country" ,'0')
			&& checkNullSelect( "state","Select State" ,'0')
			&& checkNullSelect( "district","Select District" ,'0')
			&& checkNullSelect( "city","Select City" ,'0') 
			&& checkNull('pin','Enter Postal Code..') 
			
			)
		return true;
	else
		return false;				
		
	
 } 	
</script>
<script language="javascript" src="../JavaScript/common/SelectChangesCountry.js"></script>
<script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
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

 

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
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
                <td colspan="2" class="bold1"><div align="center"><span class="boldThirteen">DISPENSARY INFORMATION </span>
                  <%
							String action=request.getParameter("action1");
							String id="",Name="",desc="",actionS="",value="";
							String city,district,state,country,pin;
							String sql="";
							String link="";
							String phone="";
							String pincode=""; 
							if("Add".equals(action))
							{
								id="";Name=""; desc="";
								city="0";district="0";state="0";country="0";pin="0";
								actionS="GENDispensaryAdd";
								value="Add";
								phone="0";
								pincode="0"; 
								link=" onBlur=\"upperMe(this), CheckUnique(this,'divunitname','com_m_dispensary','CHR_DESPNAME')\"  onKeyUp=\"upperMe(this),CheckUnique(this,'divunitname','com_m_dispensary','CHR_DESPNAME')\" ";
								
							}
							else
							{
								id="";Name=""; 
								id=request.getParameter("id");
								sql = " SELECT INT_DESPID, CHR_DESPNAME,CHR_ADDRESS, INT_CITYID,INT_DISTRICTID,INT_STATEID, INT_COUNTRYID ,INT_PINCODE,INT_PHONE FROM com_m_dispensary  WHERE INT_DESPID= "+id;
								 
								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];Name=data[0][1];  desc=data[0][2]; 
								city=data[0][3];
								district=data[0][4];
								state=data[0][5];
								country=data[0][6];
								pin=data[0][7];
								phone=data[0][8]; 
								actionS="GENDispensaryEdit";
								value="Update";
								link="";
							}
							
						%>			
                  
				  
				 
                </div></td>
                </tr>
              <tr>
                <td width="31%" class="boldEleven">Dispensary Place <span class="boldred">*</span> </td>
                <td width="69%" class="boldEleven"><input name="Name" type="text"   onBlur="upperMe(this)"    class="formText135" id="Name" <%=link%> value="<%=Name%>" size="40" maxlength="50">
				<div id='divunitname'></div>											</td>
              </tr>
              
              <tr>
                <td valign="top" class="boldEleven">Address<span class="boldred"> *</span> </td>
                <td valign="top" class="boldEleven"><textarea name="addresss"  id="addresss" cols="35"
								rows="5" class="formText135"   onBlur="upperMe(this)"    
								onKeyPress="textArea('addresss','500')"><%= desc%></textarea></td>
              </tr>
              <tr>
                <td class="boldEleven">Country <span class="bolddeepred">*</span></td>
                <td class="boldEleven"><select name="country" id="country" style="width:170" onChange="LoadSelectState()">
                    <option value="0">Select Country</option>
                    <%
	 		String readData[][]=  CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<readData.length;i++)
				out.println("<option value='"+readData[i][0]+"'>"+readData[i][1]+"</option>");
	 %>
                </select></td>
              </tr>
              <tr>
                <td class="boldEleven">State<span class="bolddeepred"> *</span></td>
                <td class="errormessage"><select name="state" id="state" style="width:170" onChange="LoadSelectDistrict()">
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
                <td class="boldEleven">District<span class="bolddeepred"> *</span></td>
                <td class="boldEleven"><span class="bolddeepblue">
                  <select name="district" id="district" style="width:170" onChange=" LoadSelectCity()">
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
                </span> </td>
              </tr>
              <tr>
                <td class="boldEleven">City<span class="bolddeepred"> *</span></td>
                <td class="boldEleven"><span class="bolddeepblue">
                  <select name="city" id="city" style="width:170" onChange="AssignPincode('pin')">
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
			
	 
   		                        </script>
                  <%	
	  }
	  %>
                </span> </td>
              </tr>
              <tr>
                <td class="boldEleven">Postal <span class="bolddeepred">*</span></td>
                <td  align="left" class="bolddeepblue"><input name="pin" type="text" class="formText135" id="pin" onKeyPress="return numeric_only(event,'pin','7')"     onKeyUp="lookup(this.value) " value="<%=pin%>" size="10" 									maxlength="6" />
                    <br />
                    <div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
                      <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                    </div></td>
              </tr>
               
              <tr>
                <td class="boldEleven">Phone</td>
                <td class="boldEleven"><span class="bolddeepblue">
                  <input name="phone" type="text" class="formText135" id="phone"  onKeyPress="return numeric_only(event,'phone','17')"  value="<%=phone%>"    size="15" maxlength="16">
                </span></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="Dispensary" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('DispensaryView.jsp')"></td>
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
	String msg=""+request.getParameter("msg");
	if(!"null".equals(msg))
	{
	%>
	<script language="javascript">
		var rs=confirm("<%=msg%>, Add one more record...");
		if (rs==true)
  		 	location = 'EmailCompanyAction.jsp?action1=Add'; 
		else	
		location = 'EmailCompany.jsp'; 
	</script>
	<%	
	}
}
catch(Exception e)
{
}
%>
</body>
</html>
