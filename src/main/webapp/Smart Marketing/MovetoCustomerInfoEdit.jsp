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
                      <td colspan="5" class="bold1"><div align="center">CUSTOMER INFORMATION MOVE TO INVENTORY
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
			
			sql = " SELECT INT_CUSTOMERID,INT_GROUPID,CHR_CONTACTPERSON,INT_CUSTOMERNAMEID, CHR_ADDRESS1,CHR_ADDRESS2,CHR_ADDRESS3, FUN_COM_GET_CITY(INT_CITYID) city,FUN_COM_GET_DISTRICT(INT_DISTRICTID) dist,FUN_COM_GET_STATE(INT_STATEID) state,FUN_COM_GET_COUNTRY(INT_COUNTRYID) country,INT_PINCODE,INT_PHONE1,INT_EXTN1,INT_PHONE2,INT_EXTN2,INT_MOBILE1,INT_MOBILE2,CHR_FAX,CHR_EMAIL,CHR_WEBSITE, CHR_ACTIVE,CHR_VERIFY,CHR_ALIAS,CHR_SALUTE,CHR_AREACODE,CHR_SALUTE1,CHR_ALIAS1,CHR_CONTACTPERSON1,CHR_DESIGINATION1,CHR_DESIGINATION2 ,FUN_MKT_GET_INVENTORY_NAMEID(INT_CUSTOMERNAMEID) inv_name_id FROM mkt_m_customerinfo WHERE INT_CUSTOMERID="+id;
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
			actionS="MKTMovetoCustomerInfoEdit";
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
                         
                        <input name="rowid" type="hidden" id="rowid" value="<%=id%>">
                      </div></td>
                    </tr>
                    <tr>
                      <td colspan="5" align="right" class="boldEleven"><span class="boldred"><span class="style3">*</span>Mandatory</span></td>
                    </tr>
                   <tr>
                      <td class="boldElevenPrint">Account Group <span class="errormessage">*</span></td>
                      <td class="boldEleven"><select name="group" class="formText135" id="group" style="width:200" >
                        <option value="0">Select Account Group</option>
                        <%
			  String sdata[][] =  CommonFunctions.QueryExecute(" SELECT INT_CUSTOMERTYPEID ,CHR_TYPENAME  FROM  inv_m_customertype  ORDER BY CHR_TYPENAME ");
			  for(int u=0;u<sdata.length;u++)
			  	out.println("<option value='"+sdata[u][0]+"'>"+sdata[u][1]+"</option>");
			  %>
                      </select> 
					    
                           </td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldElevenPrint">Account Name <span class="errormessage">*</span></td>
                      <td class="boldEleven">
                      <select name="cname" class="formText135" id="cname" style="width:200" title="Select Customer Name">
                        <option value="0">Select Customer Name</option>
                        <%
String namedata[][] =  CommonFunctions.QueryExecute("SELECT INT_CUSTOMERGROUPID,CHR_NAME FROM inv_m_customergroup ORDER BY CHR_NAME");
for(int u=0; u<namedata.length; u++)
	out.print("<option value ='"+namedata[u][0]+"'>" +namedata[u][1]+"</option>");

%>
                      </select>
                      <script language="javascript">setOptionValue('cname','<%=data[0][31]%>')</script>
                      
                       <br><%=CommonFunctions.QueryExecute("SELECT INT_CUSTOMERNAMEID,CHR_NAME FROM mkt_m_customername WHERE INT_CUSTOMERNAMEID= "+cname+" ORDER BY CHR_NAME")[0][1]%>
                      
                       
                      
                      
                      </td>
                    </tr>
                    <tr>
                      <td colspan="5" class="boldEleven">
                      
                      <fieldset>
                      <legend ><strong><img src="../images/icon-misuse.gif">  Contact information</strong></legend>
                      <table width="99%" align="center">
                      <tr>
                      <td class="boldElevenPrint">Contact Person -1 <span class="errormessage"></span></td>
                      <td class="boldEleven"><%=Name%></td>
                      <td class="boldElevenPrint">Contact Person - 2<span class="spc"> </span></td>
                      <td class="boldEleven"><%=Name1%></td>
                    </tr>
                    <tr>
                      <td class="boldElevenPrint">Department-1  <span class="errormessage"> </span></td>
                      <td class="boldEleven"><%=alias%></td>
                      <td class="boldElevenPrint">Department - 2 </td>
                      <td class="boldEleven"><%=alias1%></td>
                    </tr>
                    <tr>
                      <td width="16%" class="boldElevenPrint">Desgination-1 <span class="errormessage"> </span></td>
                      <td width="33%" class="boldEleven"><%=desigination1%></td>
                      <td width="14%" class="boldElevenPrint">Desgination - 2</td>
                      <td width="36%" class="boldEleven"><%=desigination2%></td>
                    </tr>
                      </table>
                      
                      </fieldset>
                      
                      </td>
                    </tr>
                    
                     
                    <tr>
                      <td class="boldElevenPrint">Address1 <span class="errormessage"></span></td>
                      <td class="boldEleven"><%=address1%></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldElevenPrint"><span class="bolddeepblue">STD Code<span class="bolddeepred"> </span></span></td>
                      <td class="boldEleven"><%=areacode%></td> 
                    </tr>
                    
                    <tr>
                      <td class="boldElevenPrint">Address2</td>
                      <td class="boldEleven"><%=address2%></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldElevenPrint"><span class="bolddeepblue">Phone 1<span class="bolddeepred"> </span></span></td>
                      <td class="boldEleven"><span class="bolddeepblue"><%=phone1%></span></td>
                    </tr>
                    <tr>
                      <td class="boldElevenPrint"> Location <span class="bolddeepred"></span></td>
                      <td class="boldEleven"><%=city%></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldElevenPrint"><span class="bolddeepblue">Extn 1 </span></td>
                      <td class="boldEleven"><span class="bolddeepblue"><%=extn1%></span></td> 
                    </tr>
                    <tr>
                      <td height="17" class="boldElevenPrint">District<span class="bolddeepred"> </span></td>
                      <td   align="left" class="bolddeepblue"><%=district%></td>
                      <td   align="left" class="bolddeepblue">&nbsp;</td>
                      <td   align="left" class="boldElevenPrint">Phone 2</td>
                      <td   align="left" class="bolddeepblue"><%=phone2%></td>
                    </tr>
                    <tr>
                      <td height="17" class="boldElevenPrint">State<span class="bolddeepred"> </span></td>
                      <td   align="left" class="bolddeepblue"><%=state%></td>
                      <td   align="left" class="bolddeepblue">&nbsp;</td>
                      <td   align="left" class="boldElevenPrint">Extn 2 </td>
                      <td   align="left" class="bolddeepblue"><%=extn2%></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldElevenPrint">Country<span class="bolddeepred"> </span></td>
                      <td   align="left" valign="top"><%=country%>
					  
                      </td>
                      <td   align="left" valign="top">&nbsp;</td>
                      <td   align="left" valign="top" class="boldElevenPrint">Mobile 1</td>
                      <td   align="left" valign="top"><span class="bolddeepblue"><span class="boldEleven"><%=mobile1%></span></span></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldElevenPrint">Postal<span class="bolddeepred"> </span></td>
                      <td   align="left"><%=pincode%></td>
                      <td   align="left">&nbsp;</td>
                      <td   align="left" class="boldElevenPrint">Mobile 2 </td>
                      <td   align="left"><span class="boldEleven"><span class="bolddeepblue"><%=mobile2%></span></span></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldElevenPrint">Email<span class="spc"></span></td>
                      <td   align="left" valign="top" class="bolddeepblue"><%=email%></td>
                      <td   align="left" valign="top" class="bolddeepblue">&nbsp;</td>
                      <td   align="left" valign="top" class="boldElevenPrint">Fax</td>
                      <td   align="left" valign="top" class="bolddeepblue"><span class="boldEleven"><%=fax%></span></td>
                    </tr>
                    
                      
                    <tr>
                      <td class="boldElevenPrint">PAN Number </td>
                      <td class="boldEleven"><input name="pannumber"
									type="text" class="formText135" id="pannumber" size="40"
									maxlength="30" title="Enter the CST Number"></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldElevenPrint"><span class="bolddeepblue">Website</span></td>
                      <td class="boldEleven"><span class="bolddeepblue"><%=website%></span></td>
                    </tr>
                    <tr>
                      <td class="boldElevenPrint">TIN Number</td>
                      <td class="boldEleven"><input name="tinnumber"
									type="text" class="formText135" id="tinnumber" size="40"
									maxlength="30" title="Enter the TIN Number"></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldElevenPrint">Tax Exemption</td>
                      <td class="boldEleven"><table border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                        <tr>
                          <td width="6%"><input name="taxexamption" type="radio" id="radio2" value="Y"></td>
                          <td width="6%">Yes</td>
                          <td width="6%"><input name="taxexamption" type="radio" id="radio3" value="N" checked></td>
                          <td width="28%">No</td>
                           
                        </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td class="boldElevenPrint">CST Number </td>
                      <td class="boldEleven"><input name="cstnumber"
									type="text" class="formText135" id="cstnumber" size="40"
									maxlength="30" title="Enter the CST Number"></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldElevenPrint"> Tax Exemption Ref. no</td>
                      <td class="boldEleven"><input name="taxexamptionno" type="text" class="formText135" id="taxexamptionno" maxlength="100"></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven"></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven"></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                    </tr>
                     <tr valign='top' align='left'>
                      <td colspan="5" class="boldEleven"><!--<p>name,cname,address1,address2,address3,</p>
                        <p>city,state,pincode,phone1,</p>
                      <p>mobile1,fax,email,website,active,group</p>--></td>
                    </tr>
                    
                    <tr>
                      <td colspan="5" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td>
                            
                            <%
							int inv_name_id = Integer.parseInt(data[0][31]);
							if(inv_name_id >0)
								out.println("<input name='Submit' type='submit' id='Submit' class='buttonbold13' value='"+value+"'>");
																	
							%>
                            </td>
                            <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('MovetoCustomerInfo.jsp')"></td>
                          </tr>
                      </table></td>
                    </tr>
                    <tr>
                       <td colspan="5" class="boldEleven" align="center">
                        <%
							if(inv_name_id <1)
								out.println("<font class='bolddeepred'>Kindly transfer the Account name </font>");
																	
							%>
                       </td>
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
