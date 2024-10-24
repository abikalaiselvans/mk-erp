<%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage=""%>
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
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/common/SelectChangesCountry.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
 
<script language="javascript">
var status="";
function changeStateN()
    {
		status = "Y";
		hidethis.style.visibility="visible";
	} 	


function Validate()
  {
				var ncustomer = document.getElementById('Ncustomer1').value;
				if(ncustomer == "Y"){
					if(checkNull("Cusname","Enter the customer name") 
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
				}else {
				if( checkNullSelect( "customer","Select customer",'0')
	   				&& checkNull( "subject","Enter subject" )
					&& checkNull( "desc","Enter description" )
					&& checkNullSelect( "assignto","Select assignto",'0')
				)
						return true;
					else
						return false;	
				}	
				
 }
	
</script>

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
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
		<%
							String id="",subject="",actionS="",value="",desc="",assignto="",sql="",cid="";
							String customertype="";
							String customernname="";
							String contactname="";
							String address="";
							String city="";
							String district="",state="",countryid="";
							String pincode="";
							String email ="";
							String mobile="";
							String groupid ="";
								id=request.getParameter("id");
								// getting current record
								sql = "SELECT INT_CUSTOMERID,CHR_SUBJECT,CHR_DESC,CHR_CALLASSIGNED,CHR_CUSTOMER_TYPE,CHR_CUSTOMERNAME,CHR_CONTACTNAME,CHR_ADDRESS1,INT_CITYID,INT_DISTRICTID,INT_STATEID,INT_COUNTRYID,INT_PINCODE,CHR_EMAIL,INT_MOBILE,INT_GROUPID FROM mkt_t_enquiry WHERE INT_ENQUIRYID= "+id;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								//getting previous record
								cid=data[0][0];
								subject=data[0][1];
								desc=data[0][2];
								assignto=data[0][3];
								customertype=data[0][4];
								customernname=data[0][5];
								contactname=data[0][6];
								address= data[0][7];
								city=data[0][8];
								district=data[0][9];
								state=data[0][10];
								countryid=data[0][11];
								pincode=data[0][12];
								email=data[0][13];
								mobile=data[0][14];
								groupid=data[0][15];
						%>

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
                          <input type="hidden" name="actionS"  value="MKTEnquiryCustomerInfoEdit" />
					    <input type="hidden" name="enquiryid" id="enquiryid"  value="<%=id%>"/>
						<input type="hidden" name="Ncustomer1" id="Ncustomer1" value="<%=customertype%>"/>
                          </span>
                      </div></td>
                    </tr>
					
					
					<tr>
					<td>
					</td></tr>
					<tr >
					  <td>
					<%
					if("Y".equals(customertype.trim()))
						{
					
					%>
					<table width="100%">
						
					<tr >
                      <td width="35%" class="boldEleven"> Customer Name<span class="spc">*</span></td>
                      <td width="65%" class="boldEleven"><input name="Cusname" type="text" class="formText135"  id="Cusname"  value="<%=customernname%>" size="30" maxlength="99" onBlur="upperMe(this)" ></td>
                    </tr>
					 <tr >
                      <td width="35%" class="boldEleven"> Contact Person <span class="spc">*</span></td>
                      <td width="65%" class="boldEleven"><input name="contactname" type="text" class="formText135" id="contactname"  value="<%=contactname%>" size="30" maxlength="50" onBlur="upperMe(this)"   >					</td>
                    <tr>
					<tr >
                      <td width="35%" class="boldEleven">Address <span class="spc">*</span></td>
                      <td width="65%" class="boldEleven"><input name="address1" type="text" class="formText135" id="address1" value="<%=address%>" size="30" maxlength="99" ></td> 
                    </tr>
					<tr >
                      <td width="35%" height="17" class="boldEleven"> City <span class="bolddeepred"> * </span></td>
                      <td  width="65%" align="left" class="bolddeepblue"><select name="city" id="city" style="width:170" onChange="AssignPincode('pincode')">
                          <option value="0" selected="selected">Select</option>
						  <%


String cityData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_CITYID="+data[0][8] );
if(cityData.length>0)
for(int u=0;u<cityData.length;u++)
	out.print("<option value='"+cityData[u][0]+"'>"+cityData[u][1]+"</option>");

%>
                         
                      </select><script language="javascript">setOptionValue("city","<%=data[0][8]%>") </script></td>
                    </tr>

					<tr>
                      <td height="17" width="35%" class="boldEleven">District<span class="bolddeepred"> * </span></td>
                      <td  width="65%" align="left" class="bolddeepblue"><select name="district" id="district" style="width:170" onChange="LoadSelectCity()">
                          <option value="0" selected="selected">Select</option>
                          <%
						String	districtData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT  FROM com_m_district WHERE INT_DISTRICTID="+data[0][9]);
						for(int u=0;u<districtData.length;u++)
						out.println("<option value='"+districtData[u][0]+"'>"+districtData[u][1]+"</option>");
						 %>
                        </select>   <script language="javascript">setOptionValue("district","<%=data[0][9]%>") </script>  </td>
                    </tr>
					<tr >
                      <td height="17" valign="top" width="35%" class="boldEleven">State<span class="bolddeepred"> * </span></td>
                      <td  width="65%" align="left" valign="top"><select name="state" id="state" style="width:170" onChange="LoadSelectDistrict()">
                        <option value="0" selected="selected">Select</option><%
						String	stateData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_STATEID = "+data[0][10]);
for(int u=0;u<stateData.length;u++)
	out.println("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+"</option>");%>
                      </select> <script language="javascript">setOptionValue("state","<%=data[0][10]%>") </script></td>
                    </tr>
					<tr >
                      <td height="17" width="35%" valign="top" class="boldEleven">Country<span class="bolddeepred"> * </span></td>
                      <td  width="65%" align="left">
	          <select name="country" id="country" style="width:170" onChange="LoadSelectState()">
                          <option value="0">Select</option>
                          <%
	 		String readData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<readData.length;i++)
				out.println("<option value='"+readData[i][0]+"'>"+readData[i][1]+"</option>");
	 %>
                        </select> 
						<script language="JavaScript" type="text/javascript">
	   						setOptionValue('country',"<%=countryid%>");
			
   		    			</script> </td>
                    </tr>
					<tr >
                      <td height="17" width="35%" valign="top" class="boldEleven">Pincode<span class="bolddeepred"> * </span></td>
                      <td  width="65%" align="left" valign="top" class="bolddeepblue"><input type="text" name="pincode" id="pincode" class="formText135" value="<%=pincode%>" maxlength="6" size="30" onKeyPress="return numeric_only(event,'pincode','7')" readonly />                      </td>
                    </tr>
					<tr >
                      <td width="35%" class="boldEleven">Mobile</td>
                      <td width="65%" class="boldEleven"><input name="mobile1" type="text" class="formText135" id="mobile1" value="<%=mobile%>" size="30" maxlength="10"  onKeyPress="return numeric_only(event,'mobile1','25')">
                        <span class="errormessage">(919865043008)</span></td>
                    </tr>
					<tr >
                      <td width="35%" class="boldEleven">Email<span class="spc"> *</span></td>
                      <td width="65%" class="boldEleven"><input name="email" type="text" class="formText135" id="email" value="<%=email%>" size="30" maxlength="99"  onBlur=" CheckUnique(this,'divunitname','mkt_t_enquiry','CHR_EMAIL')"
				 onKeyUp="CheckUnique(this,'divunitname','mkt_t_enquiry','CHR_EMAIL')">
                          <span class="errormessage">(test@test.net)</span>
                        <div id='divunitname'></div></td>
                    </tr>
					 <tr >
                      <td width="35%" class="boldEleven">Group Name  <span class="spc">*</span></td>
                      <td width="65%" class="boldEleven"><select name="group" class="formText135" id="group" >
                        <option value="0">Select</option>
                        <%
			  String sdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_GROUPID,CHR_GROUPNAME FROM  mkt_m_customergroup ORDER BY CHR_GROUPNAME ");
			  for(int u=0;u<sdata.length;u++)
			  	out.println("<option value='"+sdata[u][0]+"'>"+sdata[u][1]+"</option>");
			  %>
                      </select>	<script language="javascript">setOptionValue('group','<%=groupid%>')</script>	 </td>
                    </tr></table>
					<%
					}
					else
					{
					%>
					<table width="100%">
					<tr>
                      <td width="35%" class="boldEleven">Customer<span class="spc"> *</span></td>
                      <td width="65%" class="boldEleven">
<select name="customer" class="formText135" id="customer" style="width:170" >
<option value="0">Select Customer</option>
<%
String cdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.INT_CUSTOMERID,b.CHR_NAME,FIND_A_MKT_CUSTOMER_ADDRESS(a.INT_CUSTOMERID)    FROM mkt_m_customerinfo a, mkt_m_customername b  WHERE a.INT_CUSTOMERNAMEID =b.INT_CUSTOMERNAMEID  AND  a.CHR_VERIFY='Y'  ORDER BY b.CHR_NAME");
if(cdata.length>0)
for(int u=0;u<cdata.length;u++)
	out.println("<option value='"+cdata[u][0]+"'>"+cdata[u][1]+" / "+cdata[u][2]+"</option>");
%>
</select>   <script language="javascript">setOptionValue('customer','<%=cid%>')</script></td>
                    </tr>
                    
					
                    </table>
					<%
					}
					%> 
					<table width="100%">
					<tr>
                      <td width="35%" class="boldEleven">Subject<span class="spc"> *</span></td>
                      <td width="65%" class="boldEleven"><input name="subject" type="text" class="formText135" id="subject" value="<%=subject%>" size="30" maxlength="100">                          </td>
                    </tr>
					
					<tr>
                      <td width="35%" class="boldEleven">Description<span class="spc"> *</span></td>
                      <td width="65%" class="boldEleven"><textarea name="desc" cols="30" rows="5" class="formText135"
									id="desc" ><%=desc%></textarea></td>
                    </tr>
					
					
					<tr>
                      <td width="35%" class="boldEleven">Assign To <span class="spc">*</span></td>
                      <td width="65%" class="boldEleven"><select name="assignto" class="formText135" id="assignto"   style="width:170">
<option value="0">Select Staff</option>
<%

String officeid =(String)session.getAttribute("OFFICEID");
String cdata1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff where INT_OFFICEID = "+officeid+" ORDER BY CHR_STAFFNAME");
if(cdata1.length>0)
for(int u=0;u<cdata1.length;u++)
	out.println("<option value='"+cdata1[u][0]+"'>"+cdata1[u][0]+" / "+cdata1[u][1]+"</option>");
%>
</select> <script language="javascript">setOptionValue('assignto','<%=assignto%>')</script></td>
                    </tr>
					
					
					</table>
					</td>
					</tr>
                    <tr>
                      <td colspan="2" class="boldEleven">
					  <table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td><input name="Submit"  id="Submit" type="submit" class="buttonbold13" value="Update" ></td>
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
<%
}
catch(Exception e)
{
		out.println(e.getMessage());
}
%>