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
	if(  
		 checkNullSelect( "bank","Select Bank name" ,'0')
		 &&	checkNull( "Name","Enter Bank Branch name" ) 
		 && checkNull( "IFSC","Enter IFSC  " )  
		 && checkNull( "MCR","Enter MCR  " )  
		 && checkNull( "Address","Enter Address  " )  
		 && checkNull( "Contact","Enter Contact  " )  
		 && checkNull( "City","Enter City  " )  
		 && checkNull( "District","Enter District  " )  
		 && checkNull( "State","Enter State  " )  
		 && checkNull( "Country","Enter Country  " )  
		 
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
                <td colspan="2" class="bold1"><div align="center"> BANK BRANCH
				
				    <%
							String action=request.getParameter("action1");
							String id="",Name="",shortname="",actionS="",value="";
							String bank="0";
							String IFSC="",MCR="",Address="",Contact="",City="",District="",State="",Country="";
							String sql="";
							String link="";
							String link1="";
							 
							if("Add".equals(action))
							{
								id="";Name=""; shortname=""; bank="0";
								IFSC="";MCR="";Address="";Contact="0";City="";District="";State="";Country="";
								actionS="GENBankBranchAdd";
								value="Add";
								link=" onBlur=\" CheckUnique(this,'divunitname','com_m_bankbranchname','CHR_IFSC')\"  onKeyUp=\" CheckUnique(this,'divunitname','com_m_bankbranchname','CHR_IFSC')\" ";
								link1=" onBlur=\" CheckUnique(this,'divunitname1','com_m_bankbranchname','CHR_MCR')\"  onKeyUp=\" CheckUnique(this,'divunitname1','com_m_bankbranchname','CHR_MCR')\" ";
								
							}
							else
							{
								id="";Name=""; 
								id=request.getParameter("id");
							 	sql = " SELECT INT_BANKBRANCHID, INT_BANKGROUPID,  CHR_IFSC,CHR_MCR,CHR_BRANCHNAME,CHR_ADDRESS, ";
								sql = sql+ " CHR_CONTACT,CHR_CITY,CHR_DISTRICT,CHR_STATE,CHR_COUNRY  FROM com_m_bankbranchname  ";
								sql = sql+ "  WHERE INT_BANKBRANCHID= "+id; 
 								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];  bank=data[0][1]; 
								IFSC=data[0][2];
								MCR=data[0][3];
								Name=data[0][4];
								Address=data[0][5];
								Contact=data[0][6];
								City=data[0][7];
								District=data[0][8];
								State=data[0][9];
								Country=data[0][10];
								
								 
								actionS="GENBankBranchEdit";
								value="Update";
								link="";
								link1="";
							}
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td class="boldEleven">Bank Name <span class="boldred">*</span></td>
                <td class="boldEleven"><select name="bank" id="bank" style="width:200"  >
                  <option value="0"> Select Bank</option>
                  <%
		 			
	String BData[][]= CommonFunctions.QueryExecute("SELECT INT_BANKGROUPID,CHR_BANKGROUPNAME,CHR_SHORTNAME FROM com_m_bankgroup  ORDER BY CHR_BANKGROUPNAME ");
	if (BData.length>0)
		for (int i=0; i<BData.length; i++) 
			out.println("<option value="+BData[i][0]+">"+BData[i][1] +"</option>");			
	
	
					%>
                </select>
				<script language="javascript">setOptionValue('bank','<%=bank%>')</script>
				</td>
              </tr>
              <tr>
                <td width="31%" class="boldEleven">  Branch Name <span class="boldred">*</span> </td>
                <td width="69%" class="boldEleven"><input name="Name" type="text"     onBlur="upperMe(this)"     class="formText135" id="Name" value="<%=Name%>" size="40" maxlength="50"   >														</td>
              </tr>
              
               
              <tr>
                <td class="boldEleven">IFSC<span class="boldred"> *</span></td>
                <td class="boldEleven"><input name="IFSC" type="text" class="formText135" id="IFSC" value="<%=IFSC%>" <%=link%> size="40"    maxlength="20"   onBlur="upperMe(this)"   >
				<div id='divunitname'></div></td>
              </tr>
              <tr>
                <td class="boldEleven">MCR <span class="boldred">*</span></td>
                <td class="boldEleven"><input name="MCR" type="text" class="formText135" id="MCR" value="<%=MCR%>"  <%=link1%> size="40"    maxlength="20"   onBlur="upperMe(this)"   >
                <div id='divunitname1'></div>
				 </td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Address<span class="boldred"> *</span></td>
                <td class="boldEleven"><textarea name="Address" cols="30" rows="5" id="Address" onKeyPress="textArea('Address','500')"   onBlur="upperMe(this)"   ><%=Address%></textarea></td>
              </tr>
              <tr>
                <td class="boldEleven">Contact <span class="boldred">*</span></td>
                <td class="boldEleven"><input name="Contact" type="text" class="formText135" id="Contact" value="<%=Contact%>" size="40"    maxlength="12"   onBlur="upperMe(this)"  onkeypress="return numeric_only(event,'Contact','15')"   ></td>
              </tr>
              <tr>
                <td class="boldEleven">City <span class="boldred">*</span></td>
                <td class="boldEleven"><input name="City" type="text" class="formText135" id="City" value="<%=City%>" size="40"    maxlength="40"   onBlur="upperMe(this)"   ></td>
              </tr>
              <tr>
                <td class="boldEleven">District <span class="boldred">*</span></td>
                <td class="boldEleven"><input name="District" type="text" class="formText135" id="District" value="<%=District%>" size="40"    maxlength="40"   onBlur="upperMe(this)"   ></td>
              </tr>
              <tr>
                <td class="boldEleven">State<span class="boldred"> *</span></td>
                <td class="boldEleven"><input name="State" type="text" class="formText135" id="State" value="<%=State%>" size="40"    maxlength="40"   onBlur="upperMe(this)"   ></td>
              </tr>
              <tr>
                <td class="boldEleven">Country<span class="boldred"> *</span></td>
                <td class="boldEleven"><input name="Country" type="text" class="formText135" id="Country" value="<%=Country%>" size="40"    maxlength="40"   onBlur="upperMe(this)"   ></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="BankBranch" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('BankBranchView.jsp')"></td>
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
	 
}
catch(Exception e)
{
	System.out.println(e.getMessage());
	out.println(e.getMessage());
}
%>
</body>
</html>
