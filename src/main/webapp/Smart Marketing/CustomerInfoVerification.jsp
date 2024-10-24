<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
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

<title> :: MARKETING ::</title>

<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="javascript" src="../JavaScript/common/SelectChangesCountry.js"></script>
<script language="JavaScript">

function Validate()
  {
	
 
	
	if( 
		checkNullSelect( "group","Select Account Group" ,'0')
		&& checkNullSelect( "cname","Select Account Name" ,'0' )
		&& checkNullSelect( "salute","Select Salute","0" )
		&& checkNull( "name","Enter Person Name" )
		&& checkNull( "desigination1","Enter desigination-1" )
		
		&& checkNull( "address1","Enter Address" )
		&& checkNullSelect( "country","Select Country" ,'0')
		&& checkNullSelect( "state","Select State" ,'0')
		&& checkNullSelect( "district","Select District" ,'0')
		&& checkNullSelect( "city","Select Location" ,'0')
		&& checkNull( "pincode","Enter pincode" )
		&& checkNull( "areacode","Enter area code" )
		&& checkNull( "phone1","Enter phone1" )
		&& chkemail("email")
		//salute="0",areacode="";
		
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
<body onselectstart="return false" onpaste="return false;" onCopy="return false"  >
<%@ include file="index.jsp"%>

<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
        <%
String msg = ""+request.getParameter("msg");
String action=request.getParameter("action1");
String customerrowid="0";
 
							
 %>
         </td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="200"
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
				   
		 
				  <table width="800" border="0" align="center" cellpadding="2" cellspacing="2">
                    <tr>
                      <td colspan="5" class="bold1"><div align="center">CUSTOMER INFORMATION
  <%
							
							 
							String id="",Name="",alias="",actionS="",value="",dt="";
							String active="";
							String sql="";
							String name="",cname="0",address1="",address2="",address3="",city="",state="",pincode="",district="",country="",postal="";
							String fax="",email="",website="http://www.", group="";
							String department="",designation="",phone1="",extn1="",phone2="",extn2="",mobile1="",mobile2="";
							String link ="";
							String verification ="N";
							String salute="0",areacode="";
							String salute1,alias1,Name1,desigination1,desigination2;
							String googlelink="Mythra IT SOLUTION PVT LTD +Nandanam+Chennai";
							active="checked = 'checked' ";
							if("Add".equals(action))
							{
								id="";Name="";active="";dt="";alias="";
								name="";cname="";address1="";address2="";address3="";city="";state="";pincode=""; district="";country="";postal="";
								fax="";email="";website="http://www."; group="";
								department="";designation="";phone1="";extn1="";phone2="";extn2="";mobile1="";mobile2="";
								cname=customerrowid;salute="0";areacode="";
								verification="N";
								actionS="MKTCustomerInfoAdd";
								value="Add";
								active="checked = 'checked' ";
								salute1="";alias1="";Name1="";desigination1="";desigination2=""; 
								googlelink="Mythra IT SOLUTION PVT LTD +Nandanam+Chennai";
							}
							else
							{
								id="";Name="";dt="";alias="";
								id=request.getParameter("id");
								name="";cname="";address1="";address2="";address3="";city="";state="";pincode="";country="";postal="";
								fax="";email="";website=""; group="";   
								department="";designation="";phone1="";extn1="";phone2="";extn2="";mobile1="";mobile2="";   
								salute="0";areacode="";
								sql = " SELECT INT_CUSTOMERID,INT_GROUPID,CHR_CONTACTPERSON,INT_CUSTOMERNAMEID, CHR_ADDRESS1,CHR_ADDRESS2,CHR_ADDRESS3, INT_CITYID,INT_DISTRICTID,INT_STATEID,INT_COUNTRYID,INT_PINCODE,INT_PHONE1,INT_EXTN1,INT_PHONE2,INT_EXTN2,INT_MOBILE1,INT_MOBILE2,CHR_FAX,CHR_EMAIL,CHR_WEBSITE, CHR_ACTIVE,CHR_VERIFY,CHR_ALIAS,CHR_SALUTE,CHR_AREACODE,CHR_SALUTE1,CHR_ALIAS1,CHR_CONTACTPERSON1,CHR_DESIGINATION1,CHR_DESIGINATION2  FROM mkt_m_customerinfo WHERE INT_CUSTOMERID="+id;
								 
				 //out.println(sql);
				
				
								link ="";
								verification="";
								String data[][]= CommonFunctions.QueryExecute(sql);
								if(data.length>0)
									for(int i=0;i<27;i++)
										if("-".equals(data[0][i]))
											data[0][i] ="";
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
								verification=data[0][22];
								alias=data[0][23];
								salute=data[0][24];
								areacode=data[0][25];
								salute1=data[0][26];alias1=data[0][27];Name1=data[0][28];desigination1=data[0][29];desigination2=data[0][30]; 
								actionS="MKTCustomerInfoEdit";
								value="Update";
								if("Y".equals(active))
								 	active = " checked = 'checked'   ";
								else 
									active = "";
									
								 
									
									
						sql = "SELECT  CONCAT(FIND_A_MKT_CUSTOMER_NAME(c.INT_CUSTOMERID),'+',UPPER(b.CHR_CITYNAME),'+',UPPER(a.CHR_DISTRICT))  FROM com_m_district a, com_m_city b, mkt_m_customerinfo c  ";
						sql = sql + " WHERE a.INT_DISTRICTID = b.INT_DISTRICTID AND a.INT_DISTRICTID = c.INT_DISTRICTID AND b.INT_CITYID = c.INT_CITYID ";
						sql = sql + " AND c.INT_CUSTOMERID = " +id;
						String gd[][]=CommonFunctions.QueryExecute(sql) ;
						if(gd.length>0)
							googlelink=gd[0][0];

							}
							 
						%>
                        
                        <span class="boldEleven">
                        <input type="hidden" name="filename" value="CustomerInfo" />
                          <input type="hidden" name="actionS"  value="<%=actionS%>" />
                          <input name="rowid" type="HIDDEN" id="rowid" value="<%=id%>">
                        </span><span class="boldEleven">
                        <input name="active" type="hidden" id="active" value=""   <%=active%>>
                        </span>
                        <a href='https://www.google.co.in/maps/place/<%=googlelink%>' target="_blank">Map view</a>
                        
                        </div></td>
                    </tr>
                    <tr>
                      <td colspan="5" align="right" class="boldEleven"><span class="boldred"><span class="style3">*</span>Mandatory</span></td>
                    </tr>
                   <tr>
                      <td class="boldEleven">Account Group <span class="spc">*</span></td>
                      <td class="boldEleven"><select name="group" class="formText135" id="group" style="width:200" >
                        <option value="0">Select Account Group</option>
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
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">Account Name<span class="spc"> *</span></td>
                      <td class="boldEleven"><select name="cname" class="formText135" id="cname" style="width:200" title="Select Customer Name">
                        <option value="0">Select Customer Name</option>
                        <%
String namedata[][] =  CommonFunctions.QueryExecute("SELECT INT_CUSTOMERNAMEID,CHR_NAME FROM mkt_m_customername ORDER BY CHR_NAME");
for(int u=0; u<namedata.length; u++)
	out.print("<option value ='"+namedata[u][0]+"'>" +namedata[u][1]+"</option>");

%>
                      </select><script language="javascript">setOptionValue('cname','<%=cname%>')</script> </td>
                    </tr>
                    <tr>
                      <td colspan="5" class="boldEleven">
                      
                      <fieldset>
                      <legend ><strong><img src="../images/icon-misuse.gif">  Contact information</strong></legend>
                      <table width="99%" align="center">
                      <tr>
                      <td class="boldEleven">Contact Person -1<span class="spc"> *</span></td>
                      <td class="boldEleven"><table width="100" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td><select name="salute" class="formText135" id="salute">
                            <option value="Mr">Mr</option>
                            <option value="Mrs">Mrs</option>
                            <option value="Miss">Miss</option>
                            </select>
                            <script language="javascript">setOptionValue('salute','<%=salute%>')</script></td>
                          <td><input name="name" type="text" class="formText135" id="name"  value="<%=Name%>" size="23" maxlength="50" onBlur="upperMe(this)"   ></td>
                          </tr>
                      </table></td>
                      <td class="boldEleven">Contact Person - 2<span class="spc"> </span></td>
                      <td class="boldEleven"><table width="100" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td><select name="salute1" class="formText135" id="salute1">
                            <option value="Mr">Mr</option>
                            <option value="Mrs">Mrs</option>
                            <option value="Miss">Miss</option>
                          </select>
                           <script language="javascript">setOptionValue('salute1','<%=salute1%>')</script>
                            </td>
                          <td><input name="name1" type="text" class="formText135" id="name1"  value="<%=Name1%>" size="23" maxlength="50" onBlur="upperMe(this)"   ></td>
                        </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Department-1  <span class="spc">*</span></td>
                      <td class="boldEleven"><input name="alias" type="text" class="formText135" id="alias"  value="<%=alias%>" size="30" maxlength="50" onBlur="upperMe(this)"   ></td>
                      <td class="boldEleven">Department - 2 </td>
                      <td class="boldEleven"><input name="alias1" type="text" class="formText135" id="alias1" onBlur="upperMe(this)" value="<%=alias1%>" size="30" maxlength="50"   ></td>
                    </tr>
                    <tr>
                      <td width="16%" class="boldEleven">Desgination-1 <span class="spc">*</span></td>
                      <td width="33%" class="boldEleven"><input name="desigination1" type="text" class="formText135" id="desigination1" onBlur="upperMe(this)" value="<%=desigination1%>" size="30" maxlength="50"   ></td>
                      <td width="14%" class="boldEleven">Desgination - 2</td>
                      <td width="36%" class="boldEleven"><input name="desigination2" type="text" class="formText135" id="desigination2" onBlur="upperMe(this)" value="<%=desigination2%>" size="30" maxlength="50"   ></td>
                    </tr>
                      </table>
                      
                      </fieldset>
                      
                      </td>
                    </tr>
                    
                     
                    <tr>
                      <td class="boldEleven">Address1 <span class="spc">*</span></td>
                      <td class="boldEleven"><input name="address1" type="text" class="formText135" id="address1" value="<%=address1%>" size="30" maxlength="99"  onBlur="upperMe(this)" ></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">Address2</td>
                      <td class="boldEleven"><input name="address2" type="text" class="formText135" id="address2" value="<%=address2%>" size="30" maxlength="99"  onBlur="upperMe(this)"></td> 
                    </tr>
                    
                    <tr>
                      <td class="boldEleven">Address3</td>
                      <td class="boldEleven"><input name="address3" type="text" class="formText135" id="address3" value="<%=address3%>" size="30" maxlength="99"    onBlur="upperMe(this)" ></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven"><span class="bolddeepblue">STD Code<span class="bolddeepred"> * </span></span></td>
                      <td class="boldEleven"><span class="bolddeepblue">
                        <input name="areacode" title="044" type="text" class="formText135" id="areacode" value="<%=areacode%>" size="30" maxlength="15">
                      </span></td> 
                    </tr>
                    <tr>
                      <td height="17" class="boldEleven"> Location <span class="bolddeepred"> * </span></td>
                      <td   align="left" class="bolddeepblue"><select name="city" class="formText135" id="city" style="width:200" onChange="AssignPincode('pincode')"  >
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
                      <td   align="left" class="bolddeepblue">&nbsp;</td>
                      <td   align="left" class="bolddeepblue"><span class="boldEleven">Phone 1<span class="bolddeepred"> * </span></span></td>
                      <td   align="left" class="bolddeepblue"><input name="phone1" type="text" class="formText135" id="phone1" value="<%=phone1%>" size="30" maxlength="10"  onKeyPress="return numeric_only(event,'phone1','25')" title="24340906"></td>
                    </tr>
                    <tr>
                      <td height="17" class="boldEleven">District<span class="bolddeepred"> * </span></td>
                      <td   align="left" class="bolddeepblue"><select name="district" class="formText135" id="district" style="width:200" onChange=" LoadSelectCity()">
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
                      <td   align="left" class="bolddeepblue">&nbsp;</td>
                      <td   align="left" class="bolddeepblue"><span class="boldEleven">Extn 1 </span></td>
                      <td   align="left" class="bolddeepblue"><input name="extn1" type="text" class="formText135" id="extn1" value="<%=extn1%>" size="30" maxlength="4" onKeyPress="return numeric_only(event,'extn1','6')" title="5005"></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven">State<span class="bolddeepred"> * </span></td>
                      <td   align="left" valign="top"><select name="state" class="formText135" id="state" style="width:200" onChange="LoadSelectDistrict()">
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
                      <td   align="left" valign="top">&nbsp;</td>
                      <td   align="left" valign="top"><span class="boldEleven">Phone 2</span></td>
                      <td   align="left" valign="top"><input name="phone2" type="text" class="formText135" id="phone2" value="<%=phone2%>" size="30" maxlength="10" onKeyPress="return numeric_only(event,'phone2','25')" title="24340906"></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven">Country<span class="bolddeepred"> * </span></td>
                      <td   align="left"><select name="country" class="formText135" id="country" style="width:200" onChange="LoadSelectState()">
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
                      <td   align="left">&nbsp;</td>
                      <td   align="left"><span class="bolddeepblue"><span class="boldEleven">Extn 2 </span></span></td>
                      <td   align="left"><span class="bolddeepblue">
                        <input name="extn2" type="text" class="formText135" id="extn2" value="<%=extn2%>" size="30" maxlength="4" onKeyPress="return numeric_only(event,'extn2','6')" title="5005">
                      </span></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven">Postal<span class="bolddeepred"> * </span></td>
                      <td   align="left" valign="top" class="bolddeepblue"> 
					  <input name="pincode" type="text" class="formText135" id="pincode" onKeyPress="return numeric_only(event,'pincode','7') "    onKeyUp="lookup(this.value);" value="<%=pincode%>" size="10" 									maxlength="6" />
                          <br />
                          <div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
                            <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                          </div>					                        </td>
                      <td   align="left" valign="top" class="bolddeepblue">&nbsp;</td>
                      <td   align="left" valign="top" class="bolddeepblue"><span class="boldEleven">Mobile 1</span></td>
                      <td   align="left" valign="top" class="bolddeepblue"><span class="boldEleven">
                        <input name="mobile1" type="text" class="formText135" id="mobile1" value="<%=mobile1%>" size="30" maxlength="10"  onKeyPress="return numeric_only(event,'mobile1','25')" title="9865043008">
                      </span></td>
                    </tr>
                    
                      
                    <tr>
                      <td class="boldEleven">Fax</td>
                      <td class="boldEleven"><input name="fax" type="text" class="formText135" id="fax" value="<%=fax%>" size="30" maxlength="15" onKeyPress="return   numeric_only(event,'fax','30')" title="24340906"></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven"><span class="bolddeepblue">Mobile 2 </span></td>
                      <td class="boldEleven"><span class="bolddeepblue">
                        <input name="mobile2" type="text" class="formText135" id="mobile2" value="<%=mobile2%>" size="30" maxlength="10"  onKeyPress="return numeric_only(event,'mobile2','25')" title="9865043008">
                      </span></td>
                    </tr>
                     
                     
                    <tr>
                      <td class="boldEleven">Email<span class="spc"> </span></td>
                      <td class="boldEleven"><input  title="test@test.net" name="email" type="email" class="formText135" id="email" value="<%=email%>" size="30" maxlength="99" >
					  
					   <!-- onKeyUp="CheckUnique(this,'divunitname1','mkt_m_customerinfo','CHR_EMAIL')"-->
				  
                        <div id='divunitname1'></div>					  </td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">Website</td>
                      <td class="boldEleven"><input name="website" title="http://www.test.net" type="url" class="formText135" id="website" value="<%=website%>" size="30" maxlength="30">
                      </td>
                    </tr>
                     
                     
                    
                    <%
					if(!"Add".equals(action))
					{
						if(  "F".equals(""+session.getAttribute("USERTYPE")) || "B".equals(""+session.getAttribute("USERTYPE"))  )
						{
							out.println("<tr>");
							out.println("<td class='boldEleven'>Verification</td>");
							out.println("<td class='boldEleven'>");
							out.println("<select name='verification' class='formText135' id='verification'  style='width:200'>");
							out.println("<option value='N'>Pending</option>");
							out.println(" <option value='Y'>Verified</option>");
							out.println("<option value='R'>Reject</option>");
							out.println("</select>");
							%>
                            <script language="javascript">setOptionValue('verification','<%=verification%>')</script>
                            <%
							
							out.println("</td>");
							out.println(" </tr>");
							
							out.println("<tr>");
							out.println("<td class='boldEleven' valign='top' align='left'>Description</td>");
							out.println("<td class='boldEleven' valign='top' align='left'>");
							out.println("<textarea name='memo' cols='25' rows='5' class='formText135' id='memo'  onKeyUp=\"textArea('memo','200')\" >&nbsp;</textarea>");
							out.println("</td>");
							out.println(" </tr>");
						}
						else
						{
							out.println(" <input name='verification'  id='verification' type='hidden' value='N'>");
							out.println(" <input name='memo'  id='memo' type='hidden' value=''>");
						}
					}
					
					%>
                     
                    
                    <tr valign='top' align='left'>
                      <td colspan="5" class="boldEleven"><!--<p>name,cname,address1,address2,address3,</p>
                        <p>city,state,pincode,phone1,</p>
                      <p>mobile1,fax,email,website,active,group</p>--></td>
                    </tr>
                    <tr>
                      <td colspan="5" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td><input name="Submit" type="submit" id="Submit" 
											class="buttonbold13" value="<%=value%>"></td>
                            <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('CustomerInfo.jsp')"></td>
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
		<td></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
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
