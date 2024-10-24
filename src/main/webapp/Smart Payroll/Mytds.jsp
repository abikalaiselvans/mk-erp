 
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
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

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 
 
<script language="JavaScript">
function  validate()
{
	try
	{
		if(
			checkNullSelect('year' ,'Select Year','0')
			 
		  )
		  	return true;
		else
			return false;
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}
  </script>
</head>
<form  AUTOCOMPLETE = "off" method="post"   name="a" action="Staff_tdsResponse.jsp" onSubmit="return validate()" >
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
 
<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><%@ include file="index.jsp"%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
      <tbody>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
          <td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
        </tr>
        <tr>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          <td width="6"><spacer height="1" width="1" type="block"></td>
          <td   valign="top"><table width="250" border="0" align="center"  >
              <!--DWLayoutTable-->
              <tr align="center" valign="middle" class="tabledata">
                <td height="32" colspan="2" class="boldEleven"> T D S
                    <input name="empid" type="hidden" id="empid" value="<%=""+session.getAttribute("EMPID")%>"></td>
              </tr>
              <tr align="center" valign="middle">
                <td height="28" align="left" valign="middle"
								class="boldEleven">Year <span class="boldred"> * </span></td>
                <td align="left" valign="middle" class="boldEleven"><select name="year" class="formText135" id="year"   >
                    <option value="0">Select Year</option>
                    <jsp:include page="../JavaScript/accountyears.jsp" flush="true" />    
                </select>
                    <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date();
			var month1=parseInt(d.getMonth() + 1);
			var year1=parseInt(d.getFullYear());
			var m="";
			if(month1<4)
				year1 = year1-1;
			if(month1<10) 
				m="0"+month1;
			
			setOptionValue('year',year1);						
				//-->
                  </script>
                </td>
              </tr>
              <tr>
                <td   height="33" valign="middle" class="bolddeepblue"><span
								class="tabledata"> </span></td>
                <td   align="left" valign="middle"><strong> </strong></td>
              </tr>
              <tr>
                <td height="33" colspan="2" valign="middle" class="bolddeepblue"><table width="100" border="0" align="center" cellpadding="2"
								cellspacing="2">
                    <tr>
                      <td width="56"><input name="Submit" type="submit"
										class="buttonbold" value="Submit"   accesskey="s"   ></td>
                      <td width="56"><input name="Button" type="Button"
										class="buttonbold"  value="Close"   accesskey="c" 
										 onClick="redirect('Userframe.jsp')"></td>
                    </tr>
                  </table>
                    <p class="tabledata">&nbsp;</p></td>
              </tr>
          </table></td>
          <td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
          <td width="1" class="BorderLine"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
          <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div></td>
        </tr>
        <tr>
          <td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
      </tbody>
    </table></td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>



</body>
</form>
</html>
