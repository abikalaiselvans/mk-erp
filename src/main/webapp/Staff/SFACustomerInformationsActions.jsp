 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.setting.*"%>
<%
try
{
%>
<html>
<head>
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

<title>:: STAFF ::</title>


<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="javascript" src="../JavaScript/common/SelectChangesCountry.js"></script>
<script language="JavaScript">

function Validate()
  {
	
 
	
	if( 
		checkNullSelect( "cname","Select Customer Name" ,'0' )
		&& checkNull( "name","Enter Person Name" )
		&& checkNull( "address1","Enter Address" )
		&& checkNullSelect( "country","Select Country" ,'0')
		&& checkNullSelect( "state","Select State" ,'0')
		&& checkNullSelect( "district","Select District" ,'0')
		&& checkNullSelect( "city","Select Location" ,'0')
		&& checkNull( "pincode","Enter pincode" )
		&& checkNull( "email","Enter email" )
		&& chkemail("email")
		&& checkNullSelect( "group","Select Customer Group" ,'0')
		
	)
		return true;
	else
		return false;				
		
	
 } 	
</script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>

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
	 
	document.getElementById('pincode').value=listArray[8];
	$('#pincode').val(listArray[8]);
	setTimeout("$('#suggestions').hide();", 200);
}



 
 </script>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");

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


.suggestionsBox1 
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
.suggestionList1 
{
	margin: 0px;
	padding: 0px;
}
.suggestionList1 li 
{
	margin: 0px 0px 3px 0px;
	padding: 3px;
	cursor: pointer;
}

.suggestionList1 li:hover {
background-color: #ffffff;
}
</style>

</head>
<body  onpaste='return false;'>
 
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
		<table class="BackGround" cellspacing="0" cellpadding="0" width="200"
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
					<td height="6" align="right"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
				  <td width="412">
				   
		 
				  <table width="450" border="0" align="center" cellpadding="2" cellspacing="2">
                    <tr>
                      <td colspan="2" class="bold1"><div align="center">CUSTOMER INFORMATION
  <%
							String action=request.getParameter("action1");
							String id="",Name="",actionS="",value="",dt="";
							String active="";
							String sql="";
							String name="",cname="",address1="",address2="",address3="",city="",state="",pincode="",district="",country="",postal="";
							String fax="",email="",website="", group="";
							String department="",designation="",phone1="",extn1="",phone2="",extn2="",mobile1="",mobile2="";
							String link ="";
							active="checked = 'checked' ";
							if("Add".equals(action))
							{
								id="";Name="";active="";dt="";
								name="";cname="";address1="";address2="";address3="";city="";state="";pincode=""; district="";country="";postal="";
								fax="";email="";website=""; group="";
								department="";designation="";phone1="";extn1="";phone2="";extn2="";mobile1="";mobile2="";
								actionS="STACustomerInfoAdd";
								value="Add";
								active="checked = 'checked' ";
								 
							}
							else
							{
								id="";Name="";dt="";
								id=request.getParameter("id");
								name="";cname="";address1="";address2="";address3="";city="";state="";pincode="";country="";postal="";
								fax="";email="";website=""; group="";   
								department="";designation="";phone1="";extn1="";phone2="";extn2="";mobile1="";mobile2="";   
								sql = " SELECT INT_CUSTOMERID,INT_GROUPID,CHR_CONTACTPERSON,INT_CUSTOMERNAMEID, CHR_ADDRESS1,CHR_ADDRESS2,CHR_ADDRESS3, INT_CITYID,INT_DISTRICTID,INT_STATEID,INT_COUNTRYID,INT_PINCODE,INT_PHONE1,INT_EXTN1,INT_PHONE2,INT_EXTN2,INT_MOBILE1,INT_MOBILE2,CHR_FAX,CHR_EMAIL,CHR_WEBSITE, CHR_ACTIVE FROM mkt_m_customerinfo WHERE INT_CUSTOMERID="+id;
				//out.println(sql);
								link ="";
								String data[][]= CommonFunctions.QueryExecute(sql);
								id=data[0][0];group=data[0][1];Name=data[0][2]; 
								cname=data[0][3];
								address1=data[0][4];
								address2=data[0][5];
								address3=data[0][6];
								city=data[0][7];
								district=data[0][8];
								state=data[0][9];
								country=data[0][10];
								pincode=data[0][11];
								phone1=data[0][12];
								extn1=data[0][13];
								phone2=data[0][14];
								extn2=data[0][15];
								mobile1=data[0][16];
								mobile2=data[0][17];  
								fax=data[0][18];
								email=data[0][19];
								website=data[0][20]; 
								active=data[0][21];
								actionS="STACustomerInfoEdit";
								value="Update";
								 if("Y".equals(active))
								 	active = " checked = 'checked'   ";
								 else 
								 active = "";
							}
							 
						%>
                        
                        <span class="boldEleven">
                        <input type="hidden" name="filename" value="SFACustomerInfo" />
                          <input type="hidden" name="actionS"  value="<%=actionS%>" />
                          <input name="rowid" type="HIDDEN" id="rowid" value="<%=id%>">
                        </span></div></td>
                    </tr>
                    <tr>
                      <td colspan="2" class="boldEleven"><span class="boldred"><span class="style3">*</span>Mandatory</span></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Customer Name<span class="spc"> *</span> </td>
                      <td class="boldEleven"> 
                        <select title="Select Customer Name" name="cname" id="cname" style="width:170">
                          <option value="0">Select Customer Name</option>
                          <%
String namedata[][] =  CommonFunctions.QueryExecute("SELECT INT_CUSTOMERNAMEID,CHR_NAME FROM mkt_m_customername ORDER BY CHR_NAME");
for(int u=0; u<namedata.length; u++)
	out.print("<option value ='"+namedata[u][0]+"'>" +namedata[u][1]+"</option>");

%>
                      </select>  <script language="javascript">setOptionValue('cname','<%=cname%>')</script>                       	</td>
                    </tr>
                    <tr>
                      <td width="26%" class="boldEleven"> Contact Person <span class="spc">*</span></td>
                      <td width="74%" class="boldEleven"><input name="name" type="text" class="formText135" id="name"  value="<%=Name%>" size="30" maxlength="50" onBlur="upperMe(this)"   >					 </td>
                    </tr>
                     
                    <tr>
                      <td class="boldEleven">Address1 <span class="spc">*</span></td>
                      <td class="boldEleven"><input name="address1" type="text" class="formText135" id="address1" value="<%=address1%>" size="30" maxlength="99" ></td> 
                    </tr>
                    <tr>
                      <td class="boldEleven">Address2</td>
                      <td class="boldEleven"><input name="address2" type="text" class="formText135" id="address2" value="<%=address2%>" size="30" maxlength="99" ></td>  
                    </tr>
                    <tr>
                      <td class="boldEleven">Address3</td>
                      <td class="boldEleven"><input name="address3" type="text" class="formText135" id="address3" value="<%=address3%>" size="30" maxlength="99"    ></td> 
                    </tr>
                    <tr>
                      <td height="17" class="boldEleven"> Location <span class="bolddeepred"> * </span></td>
                      <td   align="left" class="bolddeepblue"><select name="city" id="city" style="width:170" onChange="AssignPincode('pincode')"  >
                          <option value="0" selected="selected">Select</option>
                          <%
						
						if(!"Add".equals(action))
	  					{
							String cityData[][] =  CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +district);
							if(cityData.length>0)
								for(int u=0;u<cityData.length;u++)
									out.print("<option value='"+cityData[u][0]+"'>"+cityData[u][1]+"</option>");
						}
					%>
                      </select></td>
                    </tr>
                    <tr>
                      <td height="17" class="boldEleven">District<span class="bolddeepred"> * </span></td>
                      <td   align="left" class="bolddeepblue"><select name="district" id="district" style="width:170" onChange=" LoadSelectCity()">
                          <option value="0" selected="selected">Select</option>
                          <%
						
						if(!"Add".equals(action))
	  					{
							String districtData[][] =  CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT FROM com_m_district WHERE INT_STATEID=" +state);
							if(districtData.length>0)
								for(int u=0;u<districtData.length;u++)
									out.print("<option value='"+districtData[u][0]+"'>"+districtData[u][1]+"</option>");
						}
					%>
                        </select>                      </td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven">State<span class="bolddeepred"> * </span></td>
                      <td   align="left" valign="top"><select name="state" id="state" style="width:170" onChange="LoadSelectDistrict()">
                          <option value="0" selected="selected">Select</option>
                          <%
						
						if(!"Add".equals(action))
	  					{
							String stateData[][] =  CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID=" +country);
							if(stateData.length>0)
								for(int u=0;u<stateData.length;u++)
									out.print("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+"</option>");
						}
					%>
                        </select>                      </td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven">Country<span class="bolddeepred"> * </span></td>
                      <td   align="left"><select name="country" id="country" style="width:170" onChange="LoadSelectState()">
                          <option value="0">Select</option>
                          <%
	 		String readData[][]=  CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<readData.length;i++)
				out.println("<option value='"+readData[i][0]+"'>"+readData[i][1]+"</option>");
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
	  %>                      </td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven">Postal<span class="bolddeepred"> * </span></td>
                      <td   align="left" valign="top" class="bolddeepblue"> 
					  <input name="pincode" type="text" class="formText135" id="pincode" onKeyPress="return numeric_only(event,'pincode','7') "    onKeyUp="lookup(this.value);" value="<%=pincode%>" size="10" 									maxlength="6" />
                          <br />
                          <div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
                            <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                          </div>						
					                        </td>
                    </tr>
                    
                     <tr>
                      <td class="boldEleven">Phone 1</td>
                      <td class="boldEleven"><input name="phone1" type="text" class="formText135" id="phone1" value="<%=phone1%>" size="30" maxlength="10"  onKeyPress="return numeric_only(event,'phone1','25')">                        
                        <span class="errormessage">(044 24340906)</span></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Extn 1 </td>
                      <td class="boldEleven"><input name="extn1" type="text" class="formText135" id="extn1" value="<%=extn1%>" size="30" maxlength="4" onKeyPress="return numeric_only(event,'extn1','6')"> 
                        <span class="errormessage">(5005)</span></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Phone 2</td>
                      <td class="boldEleven"><input name="phone2" type="text" class="formText135" id="phone2" value="<%=phone2%>" size="30" maxlength="10" onKeyPress="return numeric_only(event,'phone2','25')">
                        <span class="errormessage">(044 24340906)</span></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Extn 2 </td>
                      <td class="boldEleven"><input name="extn2" type="text" class="formText135" id="extn2" value="<%=extn2%>" size="30" maxlength="4" onKeyPress="return numeric_only(event,'extn2','6')"> 
                        <span class="errormessage">(5005)</span></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Mobile 1</td>
                      <td class="boldEleven"><input name="mobile1" type="text" class="formText135" id="mobile1" value="<%=mobile1%>" size="30" maxlength="10"  onKeyPress="return numeric_only(event,'mobile1','25')">
                        <span class="errormessage">(919865043008)</span></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Mobile 2 </td>
                      <td class="boldEleven"><input name="mobile2" type="text" class="formText135" id="mobile2" value="<%=mobile2%>" size="30" maxlength="10"  onKeyPress="return numeric_only(event,'mobile2','25')">
                        <span class="errormessage">(919865043008)</span></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Fax</td>
                      <td class="boldEleven"><input name="fax" type="text" class="formText135" id="fax" value="<%=fax%>" size="30" maxlength="15" onKeyPress="return   numeric_only(event,'fax','30')">
                        <span class="errormessage">(044 24340906)</span></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Email<span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="email" type="text" class="formText135" id="email" value="<%=email%>" size="30" maxlength="99"  onKeyUp="CheckUnique(this,'divunitname1','mkt_m_customerinfo','CHR_EMAIL')">
					  
					   
				 
                          <span class="errormessage">(test@test.net)</span>
                          <div id='divunitname1'></div>					  </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Website</td>
                      <td class="boldEleven"><input name="website" type="text" class="formText135" id="website" value="<%=website%>" size="30" maxlength="30">
                      <span class="errormessage">(http://www.test.net)</span></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Active</td>
                      <td class="boldEleven">
					  
					  <input name="active" type="checkbox" id="active" value=""   <%=active%>> 
                         			   </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Group Name  <span class="spc">*</span></td>
                      <td class="boldEleven"><select name="group" class="formText135" id="group" >
                        <option value="0">Select</option>
                        <%
			  String sdata[][] =  CommonFunctions.QueryExecute(" SELECT INT_GROUPID,CHR_GROUPNAME FROM  mkt_m_customergroup ORDER BY CHR_GROUPNAME ");
			  for(int u=0;u<sdata.length;u++)
			  	out.println("<option value='"+sdata[u][0]+"'>"+sdata[u][1]+"</option>");
			  %>
                      </select> 
					  <%					
	if(!"Add".equals(action))
	{
	%>
                        <script language="javascript">setOptionValue('group','<%=group%>')</script>
                        <%
	}
	%>					  </td>
                    </tr>
                    <tr>
                      <td colspan="2" class="boldEleven"><!--<p>name,cname,address1,address2,address3,</p>
                        <p>city,state,pincode,phone1,</p>
                      <p>mobile1,fax,email,website,active,group</p>--></td>
                    </tr>
                    <tr>
                      <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td><input name="Submit" type="submit" id="Submit" 
											class="buttonbold13" value="<%=value%>"></td>
                            <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('SFACustomerInformations.jsp')"></td>
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
 <%
String msg = ""+request.getParameter("msg");
if(!"null".equals(msg))
{
%>
<script language="javascript">
	var rs=confirm("Your informations are <%=msg%>, You want to add one more record...");
	if (rs==true)
		location = 'SFACustomerInformationsActions.jsp?action1=Add'; 
	else	
		location = 'SFACustomerInformations.jsp'; 
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
