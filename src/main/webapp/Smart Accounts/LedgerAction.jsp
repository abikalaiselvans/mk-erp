<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
<html>
<head>

<title>:: ACCOUNTS ::</title>

 
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
</head>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function Validate()
  {
	
 
	//Name,Alias,Name1,acnumber,address,phone,mobile,email,pannumber,tinnumber ,servicetax
	
	if( 
		 checkNull( "Name","Enter  Name" )
		 && checkNull( "Alias","Enter  Alias" )
		 && checkNull( "Name1","Enter  Name" )
		 && checkNull( "acnumber","Enter  Account Number" )
		 && checkNull( "address","Enter  Address" )
		 //&& checkNull( "phone","Enter  Phone" )
		 //&& checkNull( "mobile","Enter  Mobile" )
		// && checkNull( "email","Enter  Email" )
		 //&& checkNull( "pannumber","Enter  PAN/IT Number" )
		 //&& checkNull( "tinnumber","Enter  TIN Number" )
		 //&& checkNull( "servicetax","Enter Service Tax Number" )
		 
	)
		return true;
	else
		return false;				
		
	
 } 	
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="indexacct.jsp"%>
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
    <td><table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
		  <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
		    <table width="400" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center">LEDGER  
                    <%
							String action=request.getParameter("action1");
							String id="", actionS="",value="";
							 
							String Name="",Alias="",Name1="",acnumber="",address="",phone="",mobile="",email="";
							String pannumber="",tinnumber="" ,servicetax="",under="";
							 
							String sql="";
							if("Create".equals(action))
							{
								id="";  Name="";Alias="";Name1="";acnumber="";address="";phone="";mobile="";
								email="";pannumber="";tinnumber ="";servicetax ="";under="";
								actionS="ACCLedgerAdd";
								value="Create";
							}
							else
							{
								id=""; 
								Name="";Alias="";Name1="";acnumber="";address="";phone="";mobile="";
								email="";pannumber="";tinnumber ="";servicetax ="";under="";
								id=request.getParameter("id");
								sql = "SELECT INT_LEDGERID,CHR_NAME,CHR_ALIAS,INT_TYPESUBSIDIARYID,CHR_NAME1,CHR_ACCOUNT,CHR_ADDRESS,CHR_PHONE, CHR_MOBILE,CHR_EMAIL,CHR_PAN,CHR_TIN,CHR_SERVICETAX,DAT_DATE  FROM  accc_m_ledger WHERE INT_LEDGERID= "+id;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								id=data[0][0]; 
								Name=data[0][1];Alias=data[0][2];Name1=data[0][4];acnumber=data[0][5];address=data[0][6].trim();
								phone=data[0][7];mobile=data[0][8];
								email=data[0][9];pannumber=data[0][10];tinnumber=data[0][11];servicetax=data[0][12];
								under=data[0][3];
								actionS="ACCLedgerEdit";
								value="Alter";
							}
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td class="boldEleven">Name</td>
                <td class="boldEleven"><input name="Name" type="text" class="formText135" id="Name" size="40" value="<%=Name%>"></td>
              </tr>
              <tr>
                <td class="boldEleven">Alias Name </td>
                <td class="boldEleven"><input name="Alias" type="text" class="formText135" id="Alias" size="40" value="<%=Alias%>"></td>
              </tr>
              <tr>
                <td class="boldEleven">Under </td>
                <td class="boldEleven">
				<select name="under" size="10" id="under" style="width:auto">
                <%
				sql = " SELECT INT_TYPESUBSIDIARYID, CHR_TYPESUBSIDIARYNAME FROM  accc_m_typesubsidiarygroup ORDER BY CHR_TYPESUBSIDIARYNAME ";
					String underdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					for(int h=0;h<underdata.length;h++)
						out.println("<option value='"+underdata[h][0]+"'>"+underdata[h][1]+"</option>");
					

				%>
				</select>                </td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven">&nbsp;</td>
                </tr>
              <tr>
                <td class="boldEleven">Name</td>
                <td class="boldEleven"><input name="Name1" type="text" class="formText135" id="Name1" size="40" value="<%=Name1%>"></td>
              </tr>
              <tr>
                <td class="boldEleven">A/c Number </td>
                <td class="boldEleven"><input name="acnumber" type="text" class="formText135" id="acnumber" size="40" value="<%=acnumber%>"></td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Address</td>
                <td valign="top" class="boldEleven">
<textarea name="address" cols="40" rows="5" class="formText135" id="address" ><%=address%></textarea></td>
              </tr>
              <tr>
                <td class="boldEleven">Phone</td>
                <td class="boldEleven"><input name="phone" type="text" class="formText135" id="phone" size="40" value="<%=phone%>"></td>
              </tr>
              <tr>
                <td class="boldEleven">Mobile</td>
                <td class="boldEleven"><input name="mobile" type="text" class="formText135" id="mobile" size="40" value="<%=mobile%>"></td>
              </tr>
              <tr>
                <td class="boldEleven">Email</td>
                <td class="boldEleven"><input name="email" type="text" class="formText135" id="email" size="40" value="<%=email%>"></td>
              </tr>
              <tr>
                <td class="boldEleven">PAN / IT Number </td>
                <td class="boldEleven"><input name="pannumber" type="text" class="formText135" id="pannumber" size="40" value="<%=pannumber%>"></td>
              </tr>
              <tr>
                <td class="boldEleven">TIN/Sales Tax Number </td>
                <td class="boldEleven"><input name="tinnumber" type="text" class="formText135" id="tinnumber" size="40" value="<%=tinnumber%>"></td>
              </tr>
              <tr>
                <td class="boldEleven">Service Tax Number </td>
                <td class="boldEleven"><input name="servicetax" type="text" class="formText135" id="servicetax" size="40" value="<%=servicetax%>"></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="Ledger" />
                <input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit"  id="Submit" type="submit" class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close"   type="button"  class="buttonbold13" id="Close"  value="Close"   accesskey="c"  onClick="redirect('LedgerEntry.jsp')"></td>
                  </tr>
                </table></td>
                </tr>
            </table>
		  </form></td>
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
    </table></td>
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
</body>
</html>
<%
}
catch(Exception e)
{
}
%>