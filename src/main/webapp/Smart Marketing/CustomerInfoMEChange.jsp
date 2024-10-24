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

 <script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<script language="JavaScript">

function Validate()
  {
 	if( 
		 checkNull( "othersid","Enter the ME name" )
		 
		
	)
		return true;
	else
		return false;				
		
	
 } 	
</script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
  </style>

</head>


<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript">
 
function lookupbefore(othersid) 
{
	try
	{
		
			if(othersid.length == 0) 
			{
				$('#suggestions').hide();
			} 
			else 
			{
				$.post("../Smart Common/getEmployeeid.jsp", {queryString: ""+othersid+""}, function(data)
				{
					if(data.length >0) 
					{
						$('#suggestions').show();
						$('#autoSuggestionsList').html(data);
					}
				});
			}
		 
	}
	catch(err)
	{
		alert(err);
	}
}
function fill(thisValue) 
{
	 
	{		
		document.getElementById('othersid').value=thisValue;
		$('#othersid').val(thisValue);
		//$('#suggestions').hide();
		setTimeout("$('#suggestions').hide();", 1000);
	}
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
	width: 400px;
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

<body onselectstart="return false" onpaste="return false;" onCopy="return false"  >
<%@ include file="index.jsp"%>

<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
        
         </td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="700"
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
				   
		 
				  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
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
			String salute1="Mr",alias1,Name1,desigination1,desigination2;
			String googlelink="Mythra IT SOLUTION PVT LTD +Nandanam+Chennai";
			id="";Name="";dt="";alias="";
			id=request.getParameter("id");
			
			sql = " SELECT INT_CUSTOMERID,INT_GROUPID,CHR_CONTACTPERSON,INT_CUSTOMERNAMEID, CHR_ADDRESS1,CHR_ADDRESS2,CHR_ADDRESS3, INT_CITYID,INT_DISTRICTID,INT_STATEID,INT_COUNTRYID,INT_PINCODE,INT_PHONE1,INT_EXTN1,INT_PHONE2,INT_EXTN2,INT_MOBILE1,INT_MOBILE2,CHR_FAX,CHR_EMAIL,CHR_WEBSITE, CHR_ACTIVE,CHR_VERIFY,CHR_ALIAS,CHR_SALUTE,CHR_AREACODE,CHR_SALUTE1,CHR_ALIAS1,CHR_CONTACTPERSON1,CHR_DESIGINATION1,CHR_DESIGINATION2  FROM mkt_m_customerinfo WHERE INT_CUSTOMERID="+id;
			//out.println(sql);
			link ="";
			verification="";
			String data[][]= CommonFunctions.QueryExecute(sql);
			if(data.length>0)
				for(int i=0;i<29;i++)
					if("-".equals(data[0][i]))
						data[0][i] ="";	
							
			id=data[0][0];group=data[0][1];Name=data[0][2]; 
			cname=data[0][3];	address1=data[0][4];	address2=data[0][5];	address3=data[0][6];
			city=data[0][7];	district=data[0][8];	state=data[0][9];		country=data[0][10];
			pincode=data[0][11];phone1=data[0][12];		extn1=data[0][13];		phone2=data[0][14];
			extn2=data[0][15];	mobile1=data[0][16];	mobile2=data[0][17];  	fax=data[0][18];
			email=data[0][19];	website=data[0][20]; 	active=data[0][21];		verification=data[0][22];
			alias=data[0][23];	salute=data[0][24];		areacode=data[0][25];	salute1=data[0][26];
			alias1=data[0][27];	Name1=data[0][28];		desigination1=data[0][29];
			desigination2=data[0][30]; 
			actionS="MKTCustomerInfoMEChange";
			value="Update";
 			
			//FIND_A_MKT_CUSTOMER_NAME(c.INT_CUSTOMERID),',',								
			sql = "SELECT  CONCAT( UPPER(b.CHR_CITYNAME),',',UPPER(a.CHR_DISTRICT))  FROM com_m_district a, com_m_city b, mkt_m_customerinfo c  ";
			sql = sql + " WHERE a.INT_DISTRICTID = b.INT_DISTRICTID AND a.INT_DISTRICTID = c.INT_DISTRICTID AND b.INT_CITYID = c.INT_CITYID ";
			sql = sql + " AND c.INT_CUSTOMERID = " +id;
			
			String gd[][]=CommonFunctions.QueryExecute(sql) ;
			
			if(gd.length>0)
				googlelink=gd[0][0];

			 
							 
						%>
                        
                        
                        <input type="hidden" name="filename" value="CustomerInfo" />
                          <input type="hidden" name="actionS"  value="<%=actionS%>" />
                          <input name="rowid" type="HIDDEN" id="rowid" value="<%=id%>">
                         
                        <a href='https://www.google.co.in/maps/place/<%=googlelink%>' target="_blank">Map view</a>
                        
                        </div></td>
                    </tr>
                    <tr>
                      <td colspan="5" align="right" class="boldEleven"><span class="boldred"><span class="style3">*</span>Mandatory</span></td>
                    </tr>
                   <tr>
                      <td width="17%" class="boldEleven">Account Group <span class="spc"></span></td>
                      <td width="20%" class="boldEleven"> 
                        <%
			  String sdata[][] =  CommonFunctions.QueryExecute(" SELECT INT_GROUPID,CHR_GROUPNAME FROM  mkt_m_customergroup WHERE INT_GROUPID= "+group);
			  for(int u=0;u<sdata.length;u++)
			  	out.println( sdata[u][1] );
			  %>
                       
                           </td>
                      <td width="9%" class="boldEleven">&nbsp;</td>
                      <td width="23%" class="boldEleven">Account Name<span class="spc"> </span></td>
                      <td width="31%" class="boldEleven"> 
                        <%
String namedata[][] =  CommonFunctions.QueryExecute("SELECT INT_CUSTOMERNAMEID,CHR_NAME FROM mkt_m_customername WHERE INT_CUSTOMERNAMEID ="+cname);
for(int u=0; u<namedata.length; u++)
	out.print( namedata[u][1] );

%>
                      </td>
                    </tr>
                    <tr>
                      <td colspan="5" class="boldEleven">
                      
                      <fieldset>
                      <legend ><strong><img src="../images/icon-misuse.gif">  Contact information</strong></legend>
                      <table width="99%" align="center">
                      <tr>
                      <td class="boldEleven">Contact Person - 1</td>
                      <td class="boldEleven"><table width="100" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td><%=salute%></td>
                          <td><%=Name%></td>
                          </tr>
                      </table></td>
                      <td class="boldEleven">Contact Person - 2<span class="spc"> </span></td>
                      <td class="boldEleven"><table width="100" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td><%=salute1%></td>
                          <td><%=Name1%></td>
                        </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Department - 1</td>
                      <td class="boldEleven"><%=alias%></td>
                      <td class="boldEleven">Department - 2 </td>
                      <td class="boldEleven"><%=alias1%></td>
                    </tr>
                    <tr>
                      <td width="23%" class="boldEleven">Desgination - 1 <span class="spc"></span></td>
                      <td width="26%" class="boldEleven"><%=desigination1%></td>
                      <td width="27%" class="boldEleven">Desgination - 2</td>
                      <td width="24%" class="boldEleven"><%=desigination2%></td>
                    </tr>
                      </table>
                      
                      </fieldset>
                      
                      </td>
                    </tr>
                    
                     
                    <tr>
                      <td class="boldEleven"><span class="boldEleven">Address1 *</span></td>
                      <td class="boldEleven"><span class="boldEleven"><%=address1%></span></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven"><span class="boldEleven">STD Code</span></td>
                      <td class="boldEleven"><span class="boldEleven"><%=areacode%></span></td> 
                    </tr>
                    
                    <tr>
                      <td class="boldEleven"><span class="boldEleven">Address2</span></td>
                      <td class="boldEleven"><span class="boldEleven"><%=address2%></span></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven"><span class="boldEleven">Phone 1</span></td>
                      <td class="boldEleven"><span class="boldEleven"><%=phone1%></span></td>
                    </tr>
                    <tr>
                      <td class="boldEleven"><span class="boldEleven">Address3</span></td>
                      <td class="boldEleven"><span class="boldEleven"><%=address3%></span></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven"><span class="boldEleven">Extn 1 </span></td>
                      <td class="boldEleven"><span class="boldEleven"><%=extn1%></span></td> 
                    </tr>
                    <tr>
                      <td height="17" class="boldEleven"><span class="boldEleven"> Location</span></td>
                      <td   align="left" class="boldEleven"> 
      					<span class="boldEleven">
      					<%
						 
							String cityData[][] =  CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_CITYID=" +city);
							if(cityData.length>0)
								for(int u=0;u<cityData.length;u++)
									out.print(cityData[u][1]);
			 
					%>
                      </select>
   					  </span></td>
                      <td   align="left" class="bolddeepblue">&nbsp;</td>
                      <td   align="left" class="bolddeepblue"><span class="boldEleven">Phone 2</span></td>
                      <td   align="left" class="bolddeepblue"><span class="boldEleven"><%=phone2%></span></td>
                    </tr>
                    <tr>
                      <td height="17" class="boldEleven"><span class="boldEleven">District</span></td>
                      <td   align="left" class="boldEleven"> 
                          <span class="boldEleven">
                          <%
						
						 
							String districtData[][] =  CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT FROM com_m_district WHERE INT_DISTRICTID=" +district);
							if(districtData.length>0)
								for(int u=0;u<districtData.length;u++)
									out.print(districtData[u][1]);
						 
					%>
                      </span></td>
                      <td   align="left" class="bolddeepblue">&nbsp;</td>
                      <td   align="left" class="bolddeepblue"><span class="boldEleven">Extn 2 </span></td>
                      <td   align="left" class="bolddeepblue"><span class="boldEleven"><%=extn2%></span></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven"><span class="boldEleven">State</span></td>
                      <td   align="left" valign="top" class="boldEleven"> 
                          <span class="boldEleven">
                          <%
						
						 
							String stateData[][] =  CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_STATEID=" +state);
							if(stateData.length>0)
								for(int u=0;u<stateData.length;u++)
									out.print( stateData[u][1] );
						 
					%>
                      </span></td>
                      <td   align="left" valign="top">&nbsp;</td>
                      <td   align="left" valign="top"><span class="boldEleven">Mobile 1</span></td>
                      <td   align="left" valign="top"><span class="boldEleven"><%=mobile1%></span></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven"><span class="boldEleven">Country</span></td>
                      <td   align="left" class="boldEleven"> 
                          <span class="boldEleven">
                          <%
	 		String readData[][]=  CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country WHERE INT_COUNTRYID="+country);
			for(int i=0;i<readData.length;i++)
				out.println( readData[i][1] );
	 %>
                        
                          
                          
                      </span></td>
                      <td   align="left">&nbsp;</td>
                      <td   align="left"><span class="boldEleven">Mobile 2 </span></td>
                      <td   align="left"><span class="boldEleven"><%=mobile2%></span></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven"><span class="boldEleven">Postal</span></td>
                      <td   align="left" valign="top" class="boldEleven"> <span class="boldEleven"><%=pincode%>				                        </span></td>
                      <td   align="left" valign="top" class="bolddeepblue">&nbsp;</td>
                      <td   align="left" valign="top" class="bolddeepblue"><span class="boldEleven">Fax</span></td>
                      <td   align="left" valign="top" class="bolddeepblue"><span class="boldEleven"><%=fax%></span></td>
                    </tr>
                    
                      
                    <tr>
                      <td class="boldEleven"><span class="boldEleven">Email</span></td>
                      <td class="boldEleven"><span class="boldEleven"><%=email%></span></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven"><span class="boldEleven">Website</span></td>
                      <td class="boldEleven"><span class="boldEleven"><%=website%></span></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">M.E Change <span class="errormessage">*</span></td>
                      <td colspan="3" class="boldEleven"><input name="othersid" type="text" class="formText135" id="othersid" size="50" maxlength="50"  onBlur="fill();"   onkeyup="upperMe(this),lookupbefore(this.value);" value="" >
                <div class="suggestionsBox" id="suggestions" style="display: none;" >
					<div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
				 </div></td>
                    </tr>
                     
                   
                    
                    <tr valign='top' align='left'>
                      <td colspan="5" class="boldEleven"></td>
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
