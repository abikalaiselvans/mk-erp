<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
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


<title> :: COMMON ::</title>





<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/common/addcity_count_state_district_changes.js"> </script>

<script language="JavaScript">

function Validate()
{
	try
	{
		
		
		if( 
			checkNullSelect('country','Select Country' ,'0')
			&& checkNullSelect('state','Select State' ,'0')
			&& checkNullSelect('district','Select District' ,'0')
			&& checkNull('cityname','Enter  Location Name')
			&& checkNull('pincode','Enter Location Pincode') 
			)
			{
				var name=confirm("Confirm to add a location")
				if (name==true)
					return true;
				else
					return false;	
			}
			else
			{
			
				return false;				
			}
	}
	catch(err)
	{
		alert(err.description);
	}	

} 	
</script>

<body  onpaste='return false;'>
<table width="100%" border="0" cellspacing="4" cellpadding="3">
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
                <td height="28" colspan="2" class="BackGround">ADD LOCATION ( CITY )<span class="bold1">
                  <input  id="country" name="country" type="hidden" value="1">
                </span>
                  <%
	
	String cityname,citypincode,cityid;
	String actionStu;
  	String action=""+request.getParameter("action1");
	String sql="";
	String country="";
	String state="";
	String district="";
	cityid="";
	actionStu="GENCityAdds";
	country="";
	state="";
	district="";
	cityname="";
	citypincode="";
		 
	
%>
                </td>
              </tr>
              <tr>
                <td height="19" colspan="3" align="right" valign="top"><span class="bolddeepred">* </span><span class="fairyHead"><span class="changePos">- Mandatory</span> </span> </td>
              </tr>
               
              <tr>
                <td class="boldEleven">State <font color="#ff0000">*</font></td>
                <td class="bold1"><select name="state" class="formText135"  id="state" onChange="LoadSelectDistrict()"  style="width:150">
                    <option value="0">Select</option>
                    
                  </select>
                     
                </td>
              </tr>
              <tr>
                <td class="boldEleven">District <font color="#ff0000">*</font></td>
                <td class="bold1"><select name="district" class="formText135"  id="district"  style="width:150">
                    <option value="0">Select</option>
                     
                  </select>
				  
                    
                </td>
              </tr>
              <tr>
                <td width="150" height="29" valign="middle" class="boldEleven">Location
                  Name <font color="#ff0000">*</font></td>
                <td width="246" valign="middle"><input name="cityname"
								type="text" class="formText135" id="cityname"  
								onChange="upperMe(this)"  size="35"
								maxlength="50">
                   
                  <select name="city" class="formText135"  id="city" style="visibility:hidden"   >
                    <option value="0">Select</option>
                  </select>
                  </span>                    </td>
              </tr>
              <tr>
                <td height="29" valign="top" class="boldEleven">Location Pincode <font color="#ff0000">*</font></td>
                <td valign="middle"><input name="pincode" type="text" class="formText135" id="pincode" value="<%=citypincode%>"   size="25" maxlength="6" onKeyPress="return numeric_only(event,'pincode','7')"/>
                </td>
              </tr>
              <tr>
                <td height="29" colspan="2" valign="top" class="bolddeepblue"><input
								type="HIDDEN" name="filename" value="City">
                    <input
								type="HIDDEN" name="actionS" value="<%=actionStu %>">
                   
                    <table width="129" border="0" align="center" cellpadding="3"
								cellspacing="3">
                      <tr>
                        <td width="51"><input type="SUBMIT" class="buttonbold"
										id="submit" name="Submit"  value="Submit"   accesskey="s"   ></td>
                        <td width="57"><input name="Button" type="button"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="window.close()"></td>
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
</table>
</body>
</html>

<script language="javascript">
LoadSelectState();
</script>
 <%
	 
}
catch(Exception e)
{
}
%>
