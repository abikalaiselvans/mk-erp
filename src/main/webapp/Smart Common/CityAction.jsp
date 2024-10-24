<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

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
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/common/SelectCityAction.js"> </script>

<script language="JavaScript">
function Validate()
{
 	if( 
		checkNullSelect('country','Select Country' ,'0')
		&& checkNullSelect('state','Select State' ,'0')
		&& checkNullSelect('district','Select District' ,'0')
		&& checkNull('cityname','Enter City Name')
		&& checkNull('pincode','Enter Pincode') 
		)
		return true;
	else
		return false;
} 	
</script>


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
	
	 <table class="BackGround" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
       <tbody>
         <tr>
           <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
           <td class="BorderLine" height="0"></td>
           <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
         </tr>
         <tr>
           <td height="6"></td>
         </tr>
         <tr>
           <td class="BorderLine" width="1"></td>
           <td width="6"></td>
           <td width="412"><table width="425" border="0" align="center" cellpadding="2"
						cellspacing="2"  >
               <!--DWLayoutTable-->
               <tr align="center" valign="middle">
                 <td height="28" colspan="2" class="BackGround">CITY
				 
				 <%
	
	String cityname,citypincode,cityid;
	String actionStu;
  	String action=""+request.getParameter("action1");
	String sql="";
	String country="";
	String state="";
	String district="";
	cityid="";
	String value="";
	 
		 
		if(action.equals("Edit"))
		{
			 actionStu="GENCityEdit";
			 cityid=request.getParameter("id");
			  sql = "SELECT INT_COUNTRYID,INT_STATEID,INT_DISTRICTID,INT_CITYID,UPPER(CHR_CITYNAME) , DECODE(CHR_PINCODE,'9865043008')     FROM com_m_city WHERE  INT_CITYID="+	cityid;
			 String readData[][] =  CommonFunctions.QueryExecute(sql);	 
			 country=readData[0][0] ;
			 state=readData[0][1] ;
			 district=readData[0][2] ;
			 cityname=readData[0][4] ;
			 citypincode=readData[0][5] ;
			value="Update";
		}
		else
		{
			actionStu="GENCityAdd";
			country="";
			state="";
			district="";
			cityname="";
			citypincode="";
			value="Add";
		}
	 
%>
				 
				 </td>
               </tr>
               <tr>
                 <td height="19" colspan="3" align="right" valign="top"><span class="bolddeepred">* </span><span class="fairyHead"><span class="changePos">- Mandatory</span> </span> </td>
               </tr>
               <tr>
                 <td class="boldEleven">Country <font color="#ff0000">*</font></td>
                 <td class="bold1"><select name="country" class="formText135"  id="country"  onChange="LoadSelectState()" style="width:150"   >
                     <option value="0">Select</option>
                     <%
				
				String	readData[][]= CommonFunctions.QueryExecute("SELECT INT_COUNTRYID, CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int u=0;u<readData.length;u++)
				out.println("<option value='"+readData[u][0]+"'>"+readData[u][1]+"</option>");
				
				%>
                   </select>
                     <%
  	if(action.equals("Edit"))
	{
%>
                     <script language="javascript">setOptionValue('country','<%=country%>')</script>
                     <%
 }
 else
		{
			%>
                     <script language="javascript">setOptionValue('country','<%=request.getParameter("country")%>')</script>
                     <%
		}
		%>
                 </td>
               </tr>
               <tr>
                 <td class="boldEleven">State <font color="#ff0000">*</font></td>
                 <td class="bold1"><select name="state" class="formText135"  id="state" onChange="LoadSelectDistrict()" style="width:150"   >
                     <option value="0">Select</option>
                     <%
  	if(action.equals("Edit"))
	{
		String	stateData[][]= CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID ="+country+" ORDER BY CHR_STATENAME");
			for(int u=0;u<stateData.length;u++)
				out.println("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+"</option>");
		
	}
	else
		{
			state = ""+request.getParameter("state");
			if(!state.equals(""))
			{
				sql=" SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_STATEID ="+state;
				String	areadData1[][]= CommonFunctions.QueryExecute(sql);
				for(int u=0;u<areadData1.length;u++)
					out.println("<option value='"+areadData1[u][0]+"'>"+areadData1[u][1]+"</option>");
			}	
		}
	%>
                   </select>
                     <%
  	if(action.equals("Edit"))
	{
	
%>
                     <script language="javascript">setOptionValue('state','<%=state%>')</script>
                     <%
 	}
else
		{
		
		%>
                     <script language="javascript">setOptionValue('state','<%=state%>')</script>
                     <%
		}		
		%>
                 </td>
               </tr>
               <tr>
                 <td class="boldEleven">District <font color="#ff0000">*</font></td>
                 <td class="bold1"><select name="district" class="formText135"  id="district" style="width:150"    >
                     <option value="0">Select</option>
                     <%
  	if(action.equals("Edit"))
	{
		String	districtData[][]= CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT  FROM com_m_district WHERE  INT_STATEID="+state+"  ORDER BY CHR_DISTRICT  ");
			for(int u=0;u<districtData.length;u++)
				out.println("<option value='"+districtData[u][0]+"'>"+districtData[u][1]+"</option>");
		
	}
	
	else
		{
			district = ""+request.getParameter("district");
			if(!district.equals(""))
			{
				sql=" SELECT INT_DISTRICTID,CHR_DISTRICT  FROM com_m_district WHERE INT_DISTRICTID="+district;
				String	areadDatas[][]= CommonFunctions.QueryExecute(sql);
				for(int u=0;u<areadDatas.length;u++)
					out.println("<option value='"+areadDatas[u][0]+"'>"+areadDatas[u][1]+"</option>");
			}	
		}
	%>
                   </select>
                     <%
  	if(action.equals("Edit"))
	{
	
%>
                     <script language="javascript">setOptionValue('district','<%=district%>')</script>
                     <%
 	}
else
		{
		
		%>
                     <script language="javascript">setOptionValue('district','<%=district%>')</script>
                     <%
		}		
		%>
                 </td>
               </tr>
               <tr>
                 <td width="150" height="29" valign="middle" class="boldEleven">City
                   Name <font color="#ff0000">*</font></td>
                 <td width="246" valign="middle"><input name="cityname"
								type="text" class="formText135" id="cityname"  
								    onBlur="upperMe(this)"    value="<%= cityname %>" size="35"
								maxlength="30">
                     <div id="UniqueDepart"></div></td>
               </tr>
               <tr>
                 <td height="29" valign="top" class="boldEleven">City Pincode <font color="#ff0000">*</font></td>
                 <td valign="middle"><input name="pincode" type="text" class="formText135" id="pincode" onKeyPress="return numeric_only(event,'pincode','7')" 	  value="<%=citypincode%>"   size="25"
																maxlength="6" />
                 </td>
               </tr>
               <tr>
                 <td height="29" colspan="2" valign="top" class="bolddeepblue"><input
								type="HIDDEN" name="filename" value="City">
                     <input
								type="HIDDEN" name="actionS" value="<%=actionStu %>">
                     <input
								type="HIDDEN" name="cityid" value="<%=cityid %>">
                     <table width="129" border="0" align="center" cellpadding="3"
								cellspacing="3">
                       <tr>
                         <td width="51"><input type="SUBMIT" class="buttonbold"
										id="submit" name="Submit"  value="<%=value%>"></td>
                         <td width="57"><input name="Button" type="button"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="redirect('CityView.jsp')"></td>
                       </tr>
                   </table></td>
               </tr>
           </table></td>
           <td nowrap="nowrap" width="4"></td>
           <td class="BorderLine" width="1"></td>
         </tr>
         <tr>
           <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
           <td height="6"></td>
           <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
         </tr>
         <tr>
           <td class="BorderLine" height="0"></td>
         </tr>
       </tbody>
     </table>
	  </form>
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
</table>
<%@ include file="../footer.jsp"%>

  <%
	 
}
catch(Exception e)
{
}
%>
</body>
</html>
